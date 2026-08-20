function [eegData, eegSampleRate] = RunSoundEEGBuffers(soundSignal, circuitPath, saveDir)
% RunSoundEEGBuffers: Play sound and record EEG via direct hardware buffer.
% No OpenWorkbench or TDevAcc required — uses RPco.X buffers only.
%
% Parameters:
%   soundSignal:  Sound waveform vector (at 24414.0625 Hz).
%   circuitPath:  Absolute path to .rcx file (must expose EEGData/EEGIndex tags).
%   saveDir:      Directory to save .mat files (auto-creates Block-N subfolders).
%
% Returns:
%   eegData:       [samples x channels] EEG matrix.
%   eegSampleRate: Hardware sampling rate (Hz).

% --- 1. Configuration ---
RECORD_DURATION_S  = 5;
SOUND_BUFFER_TAG   = 'datain1';
EEG_BUFFER_TAG     = 'EEGData';
EEG_INDEX_TAG      = 'EEGIndex';
START_TRIGGER      = 1;
NUM_CHANNELS       = 32;
EEG_CIRCUIT_PATH   = 'C:\Users\Lab\Downloads\Alon2\RCOCircuits\MedusaBaseStation.rcx';
EEG_DEVICE_NUM     = 2;   % RX8 device number for Medusa — change if different

% --- 2. Connect to Hardware ---
% Load sound circuit on device 1
fprintf('Loading sound circuit: %s\n', circuitPath);
RP = Circuit_Loader(circuitPath);
if ~all(bitget(RP.GetStatus, 1:3))
    error('Sound hardware not ready or circuit failed to load.');
end

% Load EEG (Medusa) circuit on its device
fprintf('Loading EEG circuit: %s (device %d)\n', EEG_CIRCUIT_PATH, EEG_DEVICE_NUM);
RP_EEG = Circuit_Loader('GB', EEG_DEVICE_NUM, EEG_CIRCUIT_PATH);
if ~all(bitget(RP_EEG.GetStatus, 1:3))
    error('EEG hardware not ready or Medusa circuit failed to load.');
end
fprintf('Both circuits loaded.\n');

% Wait for hardware tags to initialize
pause(1.5);

eegSampleRate    = RP_EEG.GetSFreq();
max_buffer_size  = RP_EEG.GetTagSize(EEG_BUFFER_TAG);
fprintf('Sample rate: %.2f Hz | Buffer size: %d samples\n', eegSampleRate, max_buffer_size);

if max_buffer_size <= 0
    error('Buffer "%s" not found or size 0. Check your RCX file.', EEG_BUFFER_TAG);
end

% Overflow check
max_pts_per_chan = floor(max_buffer_size / NUM_CHANNELS);
requested_pts   = ceil(RECORD_DURATION_S * eegSampleRate);
if requested_pts > max_pts_per_chan
    error('Buffer too small: max %.2f s at %d Hz. Reduce RECORD_DURATION_S or enlarge buffer in RCX.', ...
        max_pts_per_chan / eegSampleRate, round(eegSampleRate));
end

% --- 3. Auto-name Block (mirrors TTank Block-N convention) ---
if ~exist(saveDir, 'dir'), mkdir(saveDir); end
existingBlocks = dir(fullfile(saveDir, 'Block-*'));
blockNum  = numel(existingBlocks) + 1;
blockName = sprintf('Block-%d', blockNum);
blockDir  = fullfile(saveDir, blockName);
mkdir(blockDir);
fprintf('Saving to: %s\n', blockDir);

% --- 4. Load Sound Stimulus ---
RP.SetTagVal('BufSize1', length(soundSignal));
RP.WriteTagV(SOUND_BUFFER_TAG, 0, soundSignal);

% --- 5. Trigger and Record ---
fprintf('Triggering stimulus | Recording %d s...\n', RECORD_DURATION_S);
triggerTime = now;
RP.SoftTrg(START_TRIGGER);
pause(RECORD_DURATION_S + 0.1);

% --- 6. Read Buffer ---
final_index = RP_EEG.GetTagVal(EEG_INDEX_TAG);

if final_index > max_buffer_size
    warning('BUFFER OVERFLOW: index %d > buffer %d. Early samples lost.', ...
        final_index, max_buffer_size);
    read_count = max_buffer_size;
else
    read_count = final_index;
end

fprintf('Reading %d interleaved samples (%d channels)...\n', read_count, NUM_CHANNELS);
raw_vector = RP_EEG.ReadTagV(EEG_BUFFER_TAG, 0, read_count);

% --- 7. Reshape: TDT interleaves [Ch1_S1, Ch2_S1, ..., ChN_S1, Ch1_S2, ...] ---
nComplete = floor(length(raw_vector) / NUM_CHANNELS) * NUM_CHANNELS;
eegData   = reshape(raw_vector(1:nComplete), NUM_CHANNELS, [])';  % [samples x channels]

% --- 8. Save ---
save(fullfile(blockDir, 'eegData.mat'), 'eegData', 'eegSampleRate', ...
    'blockName', 'triggerTime', 'NUM_CHANNELS', 'RECORD_DURATION_S');
fprintf('Saved %d samples x %d channels to %s\n', size(eegData,1), size(eegData,2), blockDir);

% --- 9. Visualization (4-channel preview) ---
if ~isempty(eegData)
    timeVec     = (0:size(eegData,1)-1) / eegSampleRate;
    chansToPlot = min(4, size(eegData, 2));
    figure('Name', ['EEG Preview: ' blockName], 'Color', 'w');
    for i = 1:chansToPlot
        subplot(chansToPlot, 1, i);
        plot(timeVec, eegData(:, i));
        ylabel(['Ch ' num2str(i)]);
        grid on;
        if i == 1, title(['Buffer: ' EEG_BUFFER_TAG ' | ' blockName]); end
    end
    xlabel('Time (s)');
else
    warning('No EEG data retrieved.');
end

% --- 10. Cleanup ---
RP.Halt;
RP_EEG.Halt;
fprintf('Session complete: %s\n', blockName);

end
