function PrepareBehavioralMdb(app)
    % This function reads the static settings from the 'Behavioral' tab 
    % and saves them to the mdb.mat file.

    % Load the existing mdb.mat file
    load mdb.mat;

    % --- General Behavioral Settings ---
    mdb.behavioral.mode = app.ModesDropDown_Behavioral.Value;
    mdb.behavioral.interactive = app.CheckBox_Behavioral.Value;
    mdb.behavioral.folderPath = app.ChooseFolderButton_Behavioral.Text;

    % --- Patient Details ---
    mdb.behavioral.patient.name = app.NameEditField_Behavioral.Value;
    mdb.behavioral.patient.age = app.AgeEditField_Behavioral.Value;
    mdb.behavioral.patient.gender = app.GenderEditField_Behavioral.Value;
    mdb.behavioral.patient.ear = app.EarEditField_Behavioral.Value;
    mdb.behavioral.patient.testName = app.TestNameEditField_Behavioral.Value;

    % --- Output Settings ---
    mdb.behavioral.output.folder = app.CUsersLabDocumentsButton_Behavioral.Text;
    mdb.behavioral.output.fileName = app.NameoffolderEditField_Behavioral.Value;

    % --- Channel 1 (TX1) Configuration for Speech ---
    mdb.TX1.stimulus.stimulusSelect.pureTone = 0;
    mdb.TX1.stimulus.stimulusSelect.noise = 0;
    mdb.TX1.stimulus.stimulusSelect.speech = 1;
    mdb.TX1.stimulus.speech.amp = app.SignaldBEditField_Behavioral.Value;
    
    selectedSpeakers_TX1 = [];
    for i = 1:8
        checkboxName = sprintf('SNRSignalOutput%d_Behavioral', i);
        if app.(checkboxName).Value
            selectedSpeakers_TX1(end+1) = i;
        end
    end
    mdb.TX1.transducer.FF.DacVector = zeros(1, 18);
    mdb.TX1.transducer.FF.DacVector(selectedSpeakers_TX1) = 1;
    
    % --- Handle Different Modes ---
    noiseModes = {'Noise - 0 or 90', 'Noise - 0 or 90 - EEG'};
    if ismember(mdb.behavioral.mode, noiseModes)
        % --- Channel 2 (TX2) Configuration for Noise ---
        mdb.TX2.stimulus.stimulusSelect.pureTone = 0;
        mdb.TX2.stimulus.stimulusSelect.noise = 1; % White Noise (Default)
        mdb.TX2.stimulus.stimulusSelect.speech = 0;
        mdb.TX2.stimulus.noise.amp = app.NoisedBEditField_2.Value;
        
        % Check for custom noise file
        noiseFile = app.ChooseFolderButton_Behavioral_2.Text;
        if ~strcmp(noiseFile, 'Choose Noise Soruce') && exist(noiseFile, 'file')
            mdb.behavioral.noiseFilePath = noiseFile;
            mdb.TX2.stimulus.stimulusSelect.noise = 0;
            mdb.TX2.stimulus.stimulusSelect.speech = 1;
            % Note: We don't set TX2 source to 3 here yet; we'll handle the segment generation in BehavioralMain
        else
            if isfield(mdb.behavioral, 'noiseFilePath')
                mdb.behavioral = rmfield(mdb.behavioral, 'noiseFilePath');
            end
             mdb.TX2.stimulus.noise.source = 1; % Revert to White Noise if no file
        end

        selectedSpeakers_TX2 = [];
        for i = 1:8
            checkboxName = sprintf('SNRNoiseOutput%d_2', i);
            if app.(checkboxName).Value
                selectedSpeakers_TX2(end+1) = i;
            end
        end
        mdb.TX2.transducer.FF.DacVector = zeros(1, 18);
        mdb.TX2.transducer.FF.DacVector(selectedSpeakers_TX2) = 1;
        
        % Set master selection to use both TX1 and TX2
        mdb.master.TX1_select = 1;
        mdb.master.TX2_select = 1;
        mdb.master.TX3_select = 0;
        
    else % For "Baseline - quite" and any other modes
        % Ensure TX2 is disabled
        mdb.master.TX1_select = 1;
        mdb.master.TX2_select = 0;
        mdb.master.TX3_select = 0;
        mdb.TX2.stimulus.stimulusSelect.noise = 0;
    end

    % Save the updated mdb structure back to mdb.mat
    save('mdb.mat', 'mdb');

    end
