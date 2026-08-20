function BehavioralMainEEG(app)
% BehavioralMainEEG  Behavioral word experiment with simultaneous EEG + button recording.
%
% Identical experiment flow to BehavioralMain, with these additions:
%   - One EEG recording block per word (OpenWorkbench Tank)
%   - 500 ms pre-stimulus baseline before each word trigger
%   - 2.5 s post-stimulus window to capture patient response
%   - Metadata CSV written per trial (block_name → word file, trigger offset, pass/fail)
%
% Requires: global RP must be a TDEVProxy (startupFcn auto-launches Workbench).
% Call from StartButton_BehavioralPushed after PrepareBehavioralMdb(app).

    PRE_STIMULUS_S  = 0.5;   % pre-stimulus baseline (seconds)
    POST_STIMULUS_S = 2.5;   % post-word response window (seconds)

    global RP;

    if ~isa(RP, 'TDEVProxy')
        uialert(app.UIFigure, ...
            'EEG mode requires OpenWorkbench to be running. Check startup.', ...
            'EEG Not Available');
        return;
    end

    % ------------------------------------------------------------------
    % 1. Load config and discover word files
    % ------------------------------------------------------------------
    load mdb.mat;

    if ~(isfield(mdb, 'behavioral') && isfield(mdb.behavioral, 'mode'))
        uialert(app.UIFigure, 'No behavioral config found in mdb.', 'Config Error');
        return;
    end

    folderPath = mdb.behavioral.folderPath;
    fileList   = dir(fullfile(folderPath, '*.wav'));
    expression = '^(\d+)\s-\s.*\.wav$';
    filesToPlay = {};

    for i = 1:length(fileList)
        [tokens, ~] = regexp(fileList(i).name, expression, 'tokens', 'match');
        if ~isempty(tokens)
            order = str2double(tokens{1}{1});
            filesToPlay{end+1} = struct('name', fileList(i).name, 'order', order);
        end
    end

    if isempty(filesToPlay)
        errordlg('No correctly named .wav files found in the selected folder.', 'File Error');
        return;
    end

    orderArray = cellfun(@(s) s.order, filesToPlay);
    [~, sortIdx] = sort(orderArray);
    filesToPlay = filesToPlay(sortIdx);

    % ------------------------------------------------------------------
    % 2. Output folders — Tank lives inside the session output folder
    % ------------------------------------------------------------------
    outputDir = fullfile(mdb.behavioral.output.folder, mdb.behavioral.output.fileName);
    if ~exist(outputDir, 'dir'), mkdir(outputDir); end

    tankPath = fullfile(outputDir, 'Tank');
    if ~exist(tankPath, 'dir'), mkdir(tankPath); end

    % Set Workbench tank (once per session)
    RP.td.set_tank(tankPath);

    % Open TTank connection (kept open for the whole session)
    TT = actxserver('TTank.X');
    if TT.ConnectServer('Local', 'BehavEEGClient') ~= 1
        uialert(app.UIFigure, 'TTank server connection failed.', 'TTank Error');
        return;
    end
    if TT.OpenTank(tankPath, 'R') ~= 1
        uialert(app.UIFigure, sprintf('Could not open tank:\n%s', tankPath), 'TTank Error');
        TT.ReleaseServer;
        return;
    end

    % ------------------------------------------------------------------
    % 3. Metadata CSV — written incrementally so partial runs are saved
    % ------------------------------------------------------------------
    metaFile = fullfile(outputDir, [mdb.behavioral.patient.testName '_eeg_meta.csv']);
    fid = fopen(metaFile, 'w');
    fprintf(fid, 'block_name,word_file,word_order,trigger_offset_s,word_duration_s,pass_fail,timestamp\n');
    fclose(fid);

    % ------------------------------------------------------------------
    % 4. Custom noise setup (mirrors BehavioralMain)
    % ------------------------------------------------------------------
    use_custom_noise = isfield(mdb.behavioral, 'noiseFilePath');
    if use_custom_noise
        try
            noise_info        = audioinfo(mdb.behavioral.noiseFilePath);
            fs_noise_master   = noise_info.SampleRate;
            total_noise_samples = noise_info.TotalSamples;
        catch
            uialert(app.UIFigure, 'Failed to read custom noise file. Reverting to standard noise.', 'File Error');
            use_custom_noise = false;
        end
    end

    % ------------------------------------------------------------------
    % 5. Main experiment loop
    % ------------------------------------------------------------------
    results      = {};
    noise_active = isfield(mdb, 'master') && mdb.master.TX2_select;
    cancelled    = false;

    for i = 1:length(filesToPlay)

        fileName = filesToPlay{i}.name;
        filePath = fullfile(folderPath, fileName);

        % --- 5a. Update mdb for this word ---
        [~, ~, file_ext] = fileparts(filePath);
        audio_info = audioinfo(filePath);

        mdb.TX1.stimulus.speech.source    = filePath;
        mdb.TX1.stimulus.speech.file_ext  = file_ext;
        mdb.TX1.stimulus.burstDuration    = audio_info.Duration;

        if use_custom_noise
            samples_needed = ceil(audio_info.Duration * fs_noise_master);
            if total_noise_samples > samples_needed
                start_sample    = randi(total_noise_samples - samples_needed + 1);
                noise_range     = [start_sample, start_sample + samples_needed - 1];
                [y_seg, ~]      = audioread(mdb.behavioral.noiseFilePath, noise_range);
            else
                [y_full, ~]     = audioread(mdb.behavioral.noiseFilePath);
                repeats         = ceil(samples_needed / total_noise_samples);
                y_seg           = repmat(y_full, repeats, 1);
                y_seg           = y_seg(1:samples_needed, :);
            end
            if size(y_seg, 2) > 1, y_seg = y_seg(:, 1); end
            temp_noise_file = fullfile(tempdir, ['temp_noise_eeg_' fileName]);
            audiowrite(temp_noise_file, y_seg, fs_noise_master);
            mdb.TX2.stimulus.stimulusSelect.noise  = 0;
            mdb.TX2.stimulus.stimulusSelect.speech = 1;
            mdb.TX2.stimulus.speech.source         = temp_noise_file;
            mdb.TX2.stimulus.speech.amp            = mdb.TX2.stimulus.noise.amp;
            mdb.TX2.stimulus.burstDuration         = audio_info.Duration;
        elseif noise_active
            mdb.TX2.stimulus.burstDuration = audio_info.Duration;
        end

        save('mdb.mat', 'mdb');

        % --- 5b. EEG recording window ---
        RP.record();                           % standby → record (new block starts)
        block_timer = tic;

        pause(PRE_STIMULUS_S);                 % pre-stimulus baseline

        % Fire word — capture actual elapsed time as the trigger offset
        t_trigger = toc(block_timer);
        play_signal_multi(mdb.master.TX1_select, mdb.master.TX2_select, mdb.master.TX3_select);

        pause(audio_info.Duration + POST_STIMULUS_S);   % word + response window

        RP.idle();                             % stop recording
        pause(0.5);                            % let block finalise on disk

        % --- 5c. Identify the block that was just recorded ---
        blockName = '';
        try
            blockName = TT.GetHotBlock();
        catch
        end
        if isempty(blockName)
            % Filesystem fallback: most-recently-modified Block-* directory
            blockDirs = dir(fullfile(tankPath, 'Block-*'));
            if ~isempty(blockDirs)
                [~, idx] = max([blockDirs.datenum]);
                blockName = blockDirs(idx).name;
            else
                blockName = sprintf('Block-%d', i);
            end
        end

        fprintf('Trial %d/%d — block: %s, trigger at %.3f s\n', ...
            i, length(filesToPlay), blockName, t_trigger);

        % --- 5d. Append one row to metadata CSV immediately ---
        fid = fopen(metaFile, 'a');
        fprintf(fid, '%s,%s,%d,%.4f,%.4f,%s,%s\n', ...
            blockName, fileName, filesToPlay{i}.order, ...
            t_trigger, audio_info.Duration, ...
            'pending', char(datetime('now')));
        fclose(fid);

        % --- 5e. Pass/Fail dialog (after recording — operator can take their time) ---
        pass_fail_status = 'N/A';
        if mdb.behavioral.interactive
            selection = uiconfirm(app.UIFigure, ...
                ['Word played: ' fileName newline 'Block: ' blockName], ...
                'Response', 'Options', {'Pass', 'Fail', 'Cancel'}, 'DefaultOption', 1);
            switch selection
                case 'Pass', pass_fail_status = 'Pass';
                case 'Fail', pass_fail_status = 'Fail';
                case 'Cancel'
                    uialert(app.UIFigure, 'Experiment cancelled.', 'Cancelled');
                    cancelled = true;
            end
        end

        % Update the pass/fail in the last CSV row (rewrite the pending value)
        lines = strsplit(fileread(metaFile), '\n');
        for ln = length(lines):-1:2
            if contains(lines{ln}, [blockName ','])
                lines{ln} = strrep(lines{ln}, ',pending,', [',' pass_fail_status ',']);
                break;
            end
        end
        fid = fopen(metaFile, 'w');
        fprintf(fid, '%s\n', lines{:});
        fclose(fid);

        results{i, 1} = fileName;
        results{i, 2} = blockName;
        results{i, 3} = t_trigger;
        results{i, 4} = pass_fail_status;

        if cancelled, break; end
    end

    % ------------------------------------------------------------------
    % 6. Cleanup
    % ------------------------------------------------------------------
    TT.CloseTank;
    TT.ReleaseServer;

    % ------------------------------------------------------------------
    % 7. Excel report
    % ------------------------------------------------------------------
    outputExcelFile = fullfile(outputDir, [mdb.behavioral.patient.testName '_eeg.xlsx']);

    patientInfo = {
        'Patient Name',             mdb.behavioral.patient.name;
        'Patient Age',              mdb.behavioral.patient.age;
        'Patient Gender',           mdb.behavioral.patient.gender;
        'Tested Ear',               mdb.behavioral.patient.ear;
        'Test Name',                mdb.behavioral.patient.testName;
        'Test Date',                char(datetime('now'));
        'Mode',                     mdb.behavioral.mode;
        'Tank Path',                tankPath;
        'Pre-stimulus window (s)',  PRE_STIMULUS_S;
        'Post-stimulus window (s)', POST_STIMULUS_S;
    };
    writecell(patientInfo, outputExcelFile, 'Sheet', 'General Info', 'Range', 'A1');

    configSummary = PrintData(mdb);
    writecell(configSummary, outputExcelFile, 'Sheet', 'Configuration');

    if ~isempty(results)
        resultsHeader = {'Word File', 'EEG Block', 'Trigger Offset (s)', 'Status'};
        resultsTable  = cell2table(results, 'VariableNames', resultsHeader);
        writetable(resultsTable, outputExcelFile, 'Sheet', 'Results');
    end

    if ~cancelled
        uialert(app.UIFigure, ...
            sprintf('EEG experiment complete.\nReport: %s\nMetadata: %s', ...
                outputExcelFile, metaFile), ...
            'Complete');
    end

end
