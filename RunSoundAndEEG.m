function [eegData, eegSampleRate] = RunSoundAndEEG(soundSignal, circuitPath)
% This function triggers a sound and simultaneously records EEG data for a
% specified duration, then downloads the EEG data.
%
% Parameters:
%   soundSignal: The sound waveform to play (a vector of numbers).
%   circuitPath: The absolute path to the .rcx file configured for sound and EEG.
%
% Returns:
%   eegData: A matrix of the recorded EEG data.
%   eegSampleRate: The sampling rate of the EEG data.

% --- 1. Constants and Setup ---
RECORD_DURATION_S = 10; % Duration to record EEG in seconds.
SOUND_BUFFER_TAG = 'datain1';
EEG_BUFFER_TAG = 'EEGData';
EEG_INDEX_TAG = 'EEGIndex';
START_TRIGGER = 1; % Software trigger to start sound and EEG
STOP_TRIGGER = 9;  % Software trigger to stop everything

% --- 2. Connect to Hardware and Load Circuit ---
% This uses your existing Circuit_Loader function to get the ActiveX object.
fprintf('Loading circuit: %s...\n', circuitPath);
RP = Circuit_Loader(circuitPath);
if ~all(bitget(RP.GetStatus,1:3))
    error('Failed to connect to TDT hardware or load circuit.');
end
fprintf('Circuit loaded successfully.\n');

% Get the sampling frequency for the EEG data from the device
eegSampleRate = RP.GetSFreq();
max_eeg_points = floor(RECORD_DURATION_S * eegSampleRate);

% --- 3. Prepare and Load Sound Stimulus ---
sound_len = length(soundSignal);
% Ensure buffer size in circuit is large enough for the sound signal
RP.SetTagVal('BufSize1', sound_len);
% Write the sound data to the buffer
RP.WriteTagV(SOUND_BUFFER_TAG, 0, soundSignal);
fprintf('Sound stimulus loaded.\n');

% --- 4. Trigger Sound and EEG Recording ---
fprintf('Starting sound and EEG recording for %d seconds...\n', RECORD_DURATION_S);
RP.SoftTrg(START_TRIGGER); % Trigger number 1 starts both sound and EEG

% --- 5. Wait for Recording to Finish ---
pause(RECORD_DURATION_S);

% --- 6. Stop Recording and Retrieve EEG Data ---
fprintf('Recording finished. Downloading data...\n');
% Optional: Trigger a stop, or just halt. Halting is simpler if stopping everything.
% RP.SoftTrg(STOP_TRIGGER);

% Get the number of points recorded from the index tag
points_recorded = RP.GetTagVal(EEG_INDEX_TAG);

% Make sure we don't try to read more points than are available
if points_recorded > max_eeg_points
    points_to_read = max_eeg_points;
else
    points_to_read = points_recorded;
end

% Read the data from the EEG buffer
% Note: This reads a single vector. If you have multiple channels, you will
% need to know the number of channels and reshape the vector accordingly.
eegData_vector = RP.ReadTagV(EEG_BUFFER_TAG, 0, points_to_read);
fprintf('%d EEG data points read.\n', points_to_read);

% --- 7. Reshape Data and Cleanup ---
% Get channel count (assuming it's exposed as a tag, otherwise it's a known number)
% If the tag 'NumEEGChannels' doesn't exist, you must replace this with the
% known number of channels from your Medusa setup (e.g., 32, 64).
try
    num_channels = RP.GetTagVal('NumEEGChannels');
    if num_channels > 0
        eegData = reshape(eegData_vector, [], num_channels);
    else
        eegData = eegData_vector; % Keep as a vector if channel count is 0 or 1
    end
catch
    warning('Could not find \'NumEEGChannels\' tag. Returning a single vector. You may need to reshape the data manually.');
    eegData = eegData_vector;
end

% Halt the processor
RP.Halt;
fprintf('Experiment stopped and connection halted.\n');

end
