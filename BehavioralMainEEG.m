function BehavioralMainEEG(app)
% BehavioralMainEEG  Behavioral word experiment with simultaneous EEG + button recording.
%
% Identical experiment flow to BehavioralMain, with these additions:
%   - Direct RPco.X connection to RA16_1 (EEG) alongside the existing RX8_1
%     (sound) connection — no OpenWorkbench required
%   - 500 ms pre-stimulus baseline before each word trigger
%   - 2.5 s post-stimulus window to capture patient response
%   - One EEG + button segment saved per trial (EEGSegments/<trialId>.mat),
%     read via a baseline->final sample-counter delta around the trigger
%   - Metadata CSV written per trial (trial_id, word file, trigger offset, pass/fail)
%
% Requires: global RP_EEG must be a valid RPco.X connection to RA16_1
% (startupFcn connects it directly; non-fatal if RA16 isn't powered).
% Call from StartButton_BehavioralPushed after PrepareBehavioralMdb(app).

    PRE_STIMULUS_S  = 0.5;   % pre-stimulus baseline (seconds)
    POST_STIMULUS_S = 2.5;   % post-word response window (seconds)

    global RP;
    global RP_EEG;

    if isempty(RP_EEG)
        uialert(app.UIFigure, ...
            'EEG hardware not connected. Check RA16 power and restart the app.', ...
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
    % 2. Output folders
    % ------------------------------------------------------------------
    outputDir = fullfile(mdb.behavioral.output.folder, mdb.behavioral.output.fileName);
    if ~exist(outputDir, 'dir'), mkdir(outputDir); end

    segDir = fullfile(outputDir, 'EEGSegments');
    if ~exist(segDir, 'dir'), mkdir(segDir); end

    % ------------------------------------------------------------------
    % 2b. EEG/button circular buffer parameters (read once per session)
    % ------------------------------------------------------------------
    eegBufSize    = RP_EEG.GetTagSize('dEEG0~1');
    btnBufSize    = RP.GetTagSize('dBTTN~1');
    eegSampleRate = RP_EEG.GetSFreq() / 6;    % confirmed 1017 Hz (dEEG0~N write rate)
    btnSampleRate = RP.GetSFreq() / 20;       % confirmed ~1221 Hz (dBTTN~N write rate)

    % ------------------------------------------------------------------
    % 2c. Live EEG/button monitor window — purely visual, scrolling 5s
    % window, same layout as LiveEEGMonitor.m. Closing it does not cancel
    % the experiment (see waitAndUpdate/updateLivePlot below).
    % ------------------------------------------------------------------
    EEG_WINDOW_S = 5;
    BTN_WINDOW_S = 5;
    BTN_OFFSET   = 1.5;
    EEG_COLORS   = {'b', 'r', [0 0.55 0], [0.8 0.35 0]};
    BTN_COLORS   = {'r', [0 0.72 0], [0 0.45 0.9], [0.85 0.45 0]};

    eegWinSamp = round(EEG_WINDOW_S * eegSampleRate);
    btnWinSamp = round(BTN_WINDOW_S * btnSampleRate);
    prevEEG = 0;
    prevBtn = 0;

    hFig  = figure('Name', 'Live EEG Monitor — Behavioral Session', 'Color', 'w', ...
                   'Position', [80 60 980 740]);
    hAxes  = gobjects(4, 1);
    hLines = gobjects(4, 1);
    eegTAxis = linspace(-EEG_WINDOW_S, 0, eegWinSamp);
    for ch = 1:4
        hAxes(ch) = subplot(5, 1, ch);
        hLines(ch) = plot(eegTAxis, zeros(1, eegWinSamp), 'Color', EEG_COLORS{ch}, 'LineWidth', 0.8);
        grid on;
        ylabel(sprintf('Ch %d', ch), 'FontSize', 9);
        xlim([-EEG_WINDOW_S 0]);
        set(gca, 'XTickLabel', {});
    end
    title(hAxes(1), 'Live EEG — waiting for data...', 'FontSize', 10);

    btnTAxis  = linspace(-BTN_WINDOW_S, 0, btnWinSamp);
    hBtnAx    = subplot(5, 1, 5);
    hold(hBtnAx, 'on');
    hBtnLines = gobjects(4, 1);
    for b = 1:4
        hBtnLines(b) = plot(hBtnAx, btnTAxis, zeros(1, btnWinSamp) + (b-1)*BTN_OFFSET, ...
            'Color', BTN_COLORS{b}, 'LineWidth', 1.2);
    end
    set(hBtnAx, 'XLim', [-BTN_WINDOW_S 0], ...
        'YLim', [-0.2, 4 * BTN_OFFSET], ...
        'YTick', (0:3) * BTN_OFFSET + 0.5, ...
        'YTickLabel', {'Btn1','Btn2','Btn3','Btn4'});
    xlabel(hBtnAx, 'Time relative to now (s)');
    title(hBtnAx, sprintf('Buttons @ %.0f Hz — waiting...', btnSampleRate));
    grid(hBtnAx, 'on');
    drawnow;

    % NOTE: refresh is driven by waitAndUpdate() below (sequential polling
    % from the main thread), NOT a timer. A timer's callback fires from a
    % background tick independent of the main code, and TDT's RPco.X COM
    % object is not safe for that kind of reentrant access — a timer-driven
    % RP.GetTagVal() landing while play_signal_multi() is mid-SoftTrg/buffer
    % write corrupted the connection in testing (live view froze the moment
    % playback started). Keep all RP/RP_EEG calls on the single main thread.

    % ------------------------------------------------------------------
    % 3. Metadata CSV — written incrementally so partial runs are saved
    % ------------------------------------------------------------------
    metaFile = fullfile(outputDir, [mdb.behavioral.patient.testName '_eeg_meta.csv']);
    fid = fopen(metaFile, 'w');
    fprintf(fid, 'trial_id,word_file,word_order,trigger_offset_s,word_duration_s,pass_fail,timestamp\n');
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
        trialId  = sprintf('Trial-%03d_%s', i, matlab.lang.makeValidName(fileName));

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

        % --- 5b. EEG recording window (baseline -> trigger -> final) ---
        eegBaseline = RP_EEG.GetTagVal('sEEG0');
        btnBaseline = RP.GetTagVal('sBTTN');
        block_timer = tic;

        waitAndUpdate(PRE_STIMULUS_S);          % pre-stimulus baseline (updates live plot)

        % Fire word — capture actual elapsed time as the trigger offset
        t_trigger = toc(block_timer);
        updateLivePlot();      % refresh right before the blocking call below
        play_signal_multi(mdb.master.TX1_select, mdb.master.TX2_select, mdb.master.TX3_select);
        updateLivePlot();      % refresh immediately after — minimizes the visible gap

        waitAndUpdate(audio_info.Duration + POST_STIMULUS_S);   % word + response window

        eegFinal = RP_EEG.GetTagVal('sEEG0');
        btnFinal = RP.GetTagVal('sBTTN');

        fprintf('Trial %d/%d — %s, trigger at %.3f s\n', ...
            i, length(filesToPlay), trialId, t_trigger);

        % --- 5c. Read back this trial's EEG + button segment and save it ---
        eegData = []; btnData = [];
        try
            eegData = ReadEEGSegment(RP_EEG, 'dEEG0~', 4, eegBufSize, eegBaseline, eegFinal);
            btnData = ReadEEGSegment(RP, 'dBTTN~', 4, btnBufSize, btnBaseline, btnFinal);
        catch segErr
            fprintf(2, 'EEG segment read failed for %s: %s\n', trialId, segErr.message);
        end

        segFile = fullfile(segDir, [trialId '.mat']);
        wordFile = fileName; %#ok<NASGU>
        wordOrder = filesToPlay{i}.order; %#ok<NASGU>
        triggerOffset = t_trigger; %#ok<NASGU>
        wordDuration = audio_info.Duration; %#ok<NASGU>
        pass_fail_status_atSave = 'pending'; %#ok<NASGU>
        save(segFile, 'eegData', 'btnData', 'eegSampleRate', 'btnSampleRate', ...
            'wordFile', 'wordOrder', 'triggerOffset', 'wordDuration', 'pass_fail_status_atSave');

        % --- 5d. Append one row to metadata CSV immediately ---
        fid = fopen(metaFile, 'a');
        fprintf(fid, '%s,%s,%d,%.4f,%.4f,%s,%s\n', ...
            trialId, fileName, filesToPlay{i}.order, ...
            t_trigger, audio_info.Duration, ...
            'pending', char(datetime('now')));
        fclose(fid);

        % --- 5e. Pass/Fail dialog (after recording — operator can take their time) ---
        pass_fail_status = 'N/A';
        if mdb.behavioral.interactive
            selection = uiconfirm(app.UIFigure, ...
                ['Word played: ' fileName newline 'Trial: ' trialId], ...
                'Response', 'Options', {'Pass', 'Fail', 'Cancel'}, 'DefaultOption', 1);
            switch selection
                case 'Pass', pass_fail_status = 'Pass';
                case 'Fail', pass_fail_status = 'Fail';
                case 'Cancel'
                    uialert(app.UIFigure, 'Experiment cancelled.', 'Cancelled');
                    cancelled = true;
            end
        end

        % Record the operator's response into this trial's saved EEG segment
        if isfile(segFile)
            pass_fail_status_atSave = pass_fail_status; %#ok<NASGU>
            save(segFile, 'pass_fail_status_atSave', '-append');
        end

        % Update the pass/fail in the last CSV row (rewrite the pending value)
        lines = strsplit(fileread(metaFile), '\n');
        for ln = length(lines):-1:2
            if contains(lines{ln}, [trialId ','])
                lines{ln} = strrep(lines{ln}, ',pending,', [',' pass_fail_status ',']);
                break;
            end
        end
        fid = fopen(metaFile, 'w');
        fprintf(fid, '%s\n', lines{:});
        fclose(fid);

        results{i, 1} = fileName;
        results{i, 2} = trialId;
        results{i, 3} = t_trigger;
        results{i, 4} = pass_fail_status;

        if cancelled, break; end
    end

    % ------------------------------------------------------------------
    % 6. Excel report
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
        'EEG Segments Folder',      segDir;
        'Pre-stimulus window (s)',  PRE_STIMULUS_S;
        'Post-stimulus window (s)', POST_STIMULUS_S;
    };
    writecell(patientInfo, outputExcelFile, 'Sheet', 'General Info', 'Range', 'A1');

    configSummary = PrintData(mdb);
    writecell(configSummary, outputExcelFile, 'Sheet', 'Configuration');

    if ~isempty(results)
        resultsHeader = {'Word File', 'Trial ID', 'Trigger Offset (s)', 'Status'};
        resultsTable  = cell2table(results, 'VariableNames', resultsHeader);
        writetable(resultsTable, outputExcelFile, 'Sheet', 'Results');
    end

    if ~cancelled
        uialert(app.UIFigure, ...
            sprintf('EEG experiment complete.\nReport: %s\nMetadata: %s', ...
                outputExcelFile, metaFile), ...
            'Complete');
    end

    % ------------------------------------------------------------------
    % Nested functions — live monitor window. Share this function's
    % workspace (RP, RP_EEG, hFig, hLines, ... ) so no arguments needed.
    % ------------------------------------------------------------------
    function waitAndUpdate(waitSeconds)
        % Waits waitSeconds while refreshing the live plot, all sequentially
        % on this same thread — no timer, no reentrant RP calls. Same total
        % wait as a plain pause(waitSeconds); does not affect stimulus/
        % trigger timing, only what's shown on screen meanwhile.
        %
        % updateLivePlot() does several ReadTagV COM calls over up to a
        % 5-second window — throttled to ~10/s (matching LiveEEGMonitor.m's
        % UPDATE_INTERVAL) rather than every 20ms tick, which overloads the
        % ActiveX channel and was the actual cause of the live view freezing
        % a few seconds into a session.
        UPDATE_INTERVAL = 0.1;
        tWait     = tic;
        tLastPlot = -UPDATE_INTERVAL;
        while toc(tWait) < waitSeconds
            elapsed = toc(tWait);
            if elapsed - tLastPlot >= UPDATE_INTERVAL
                updateLivePlot();
                tLastPlot = elapsed;
            end
            pause(0.02);
        end
    end

    function updateLivePlot()
        % Errors are logged (not silently swallowed) so a real problem is
        % visible instead of just making the live view quietly stop.
        try
            if ~ishandle(hFig)
                return;
            end

            % EEG channels — last EEG_WINDOW_S seconds ending now
            rawEEG = RP_EEG.GetTagVal('sEEG0');
            if rawEEG > prevEEG
                nRead  = min(rawEEG, eegWinSamp);
                eegWin = ReadEEGSegment(RP_EEG, 'dEEG0~', 4, eegBufSize, rawEEG - nRead, rawEEG);
                if nRead < eegWinSamp
                    eegWin = [zeros(eegWinSamp - nRead, 4); eegWin];
                end
                for ch = 1:4
                    set(hLines(ch), 'YData', eegWin(:,ch));
                end
                if ishandle(hAxes(1))
                    title(hAxes(1), sprintf('Live EEG — total %d smp @ %.0f Hz', rawEEG, eegSampleRate), 'FontSize', 10);
                end
                prevEEG = rawEEG;
            end

            % Button channels — last BTN_WINDOW_S seconds ending now
            rawBtn = double(RP.GetTagVal('sBTTN'));
            if rawBtn > prevBtn && ishandle(hBtnAx)
                nReadB = min(rawBtn, btnWinSamp);
                btnWin = ReadEEGSegment(RP, 'dBTTN~', 4, btnBufSize, rawBtn - nReadB, rawBtn);
                if nReadB < btnWinSamp
                    btnWin = [zeros(btnWinSamp - nReadB, 4); btnWin];
                end
                for b = 1:4
                    set(hBtnLines(b), 'YData', (1 - btnWin(:,b)) + (b-1)*BTN_OFFSET);
                end
                cs = 1 - btnWin(end,:);   % invert: raw 0=pressed -> display 1=pressed
                title(hBtnAx, sprintf('Buttons @ %.0f Hz — 1:%d  2:%d  3:%d  4:%d', ...
                    btnSampleRate, cs(1), cs(2), cs(3), cs(4)));
                prevBtn = rawBtn;
            end

            drawnow limitrate;
        catch plotErr
            fprintf(2, 'Live plot update failed: %s\n', plotErr.message);
        end
    end

end
