function [eegData, eegSampleRate, btnData, btnSampleRate] = RunSoundAndEEG(soundSignal, circuitPath, tankPath)
% RunSoundAndEEG  Play a sound and record EEG + button box via OpenWorkbench/TTank.
%
% Parameters:
%   soundSignal: Sound waveform vector (row or column).
%   circuitPath: Unused — kept for interface compatibility with old callers.
%   tankPath:    (optional) Tank directory. Defaults to .\Tanks\
%
% Returns:
%   eegData:       [samples x 4] EEG matrix.
%   eegSampleRate: EEG sampling rate in Hz  (RA16_1).
%   btnData:       [samples x 4] Button box matrix.
%   btnSampleRate: Button sampling rate in Hz (RX8_1).
%
% Build time axes with:
%   eegTime = (0:size(eegData,1)-1) / eegSampleRate;
%   btnTime = (0:size(btnData,1)-1) / btnSampleRate;

% --- 1. Configuration ---
TDEV_SDK_PATH = 'C:\TDT\TDTMatlabSDK\TDTSDK\OpenExLive';
RECORD_DURATION_S = 5;
SOUND_DEVICE  = 'RX8_1';
EEG_DEVICE    = 'RA16_1';
EEG_STORE_ID  = 'EEG0';
BTN_STORE_ID  = 'BTTN';

if nargin < 3 || isempty(tankPath)
    tankPath = fullfile(pwd, 'Tanks');
end

% --- 2. Connect ---
addpath(TDEV_SDK_PATH);
fprintf('Connecting to OpenWorkbench...\n');
checkTD = actxserver('TDevAcc.X');
if checkTD.ConnectServer('Local') ~= 1
    checkTD.CloseConnection; delete(checkTD);
    error('OpenWorkbench is not running. Start it with workbenchconfEEG.xpm first.');
end
devName = '';
deadline = tic;
while isempty(devName) && toc(deadline) < 10
    checkTD.ConnectServer('Local');          % refresh device list — mirrors TDEV.m
    devName = checkTD.GetDeviceName(0);
    if isempty(devName), pause(0.1); end
end
curMode = checkTD.GetSysMode();
checkTD.CloseConnection; delete(checkTD);
if isempty(devName)
    modeStr = {'Idle','Standby','Preview','Record'};
    if curMode >= 1 && curMode <= 4
        mStr = modeStr{curMode};
    else
        mStr = sprintf('mode %d', curMode);
    end
    error(['No TDT devices found after 10 s (Workbench is %s). ' ...
           'Click Standby in OpenWorkbench, wait for it to show Standby, ' ...
           'then run this function again.'], mStr);
end
td = TDEV();
fprintf('Connected. Devices: %s | Mode: %s\n', ...
    strjoin(td.DEVICE_NAMES, ', '), td.MODES{td.mode()+1});

TT = actxserver('TTank.X');
if TT.ConnectServer('Local', 'RunSoundEEGClient') ~= 1
    error('TTank connection failed.');
end

try

% --- 3. Tank ---
if ~exist(tankPath, 'dir'), mkdir(tankPath); end
td.set_tank(tankPath);

% --- 4. Try to expand store buffers before going to Standby ---
% TDT Tech Note TN0142: buffer size can be set via size~ tags at runtime.
% Attempt it silently — if the tags don't exist it falls back to circuit defaults.
eegSampleRate = td.TD.GetDeviceSF(EEG_DEVICE);
btnSampleRate = td.TD.GetDeviceSF(SOUND_DEVICE);

targetDuration = RECORD_DURATION_S + 2;   % add headroom
eegBufNeeded   = ceil(targetDuration * eegSampleRate);
btnBufNeeded   = ceil(targetDuration * btnSampleRate);

try
    td.TD.SetTargetVal([EEG_DEVICE  '.size~' EEG_STORE_ID], eegBufNeeded);
    fprintf('EEG0 buffer set to %d samples (%.1f s)\n', eegBufNeeded, targetDuration);
catch
    fprintf('Note: EEG0 buffer size not adjustable via tag — using circuit default.\n');
end

try
    td.TD.SetTargetVal([SOUND_DEVICE '.size~' BTN_STORE_ID], btnBufNeeded);
    fprintf('BTTN buffer set to %d samples (%.1f s)\n', btnBufNeeded, targetDuration);
catch
    fprintf('Note: BTTN buffer size not adjustable via tag — using circuit default.\n');
end

% --- 5. Load sound ---
soundSignal = soundSignal(:)';
fprintf('Loading sound (%d samples)...\n', length(soundSignal));
td.TD.SetTargetVal([SOUND_DEVICE '.BufSize1'],  length(soundSignal));
td.TD.WriteTargetVEX([SOUND_DEVICE '.datain1'], 0, 'F32', soundSignal);

% --- 6. Record ---
fprintf('Going to Standby...\n');
td.standby();
fprintf('Going to Record...\n');
td.record();
fprintf('In Record mode.\n');

if TT.OpenTank(tankPath, 'R') ~= 1
    error('Could not open tank: %s', tankPath);
end
pause(0.5);
blockName = TT.GetHotBlock();
if isempty(blockName)
    blockDirs = dir(fullfile(tankPath, 'Block-*'));
    if ~isempty(blockDirs)
        [~, idx] = max([blockDirs.datenum]);
        blockName = blockDirs(idx).name;
    else
        error('Cannot determine block name.');
    end
end
fprintf('Recording into block: %s\n', blockName);

% --- 7. Trigger ---
fprintf('Triggering stimulus (%d s)...\n', RECORD_DURATION_S);
td.TD.SetTargetVal([SOUND_DEVICE '.single1'], 1);
pause(RECORD_DURATION_S + 0.5);
td.TD.SetTargetVal([SOUND_DEVICE '.single1'], 0);

% --- 8. Stop ---
td.idle();
pause(1);

% --- 9. Read data ---
fprintf('Reading data from block %s...\n', blockName);
TT.SelectBlock(['~' blockName]);
TT.SetGlobalV('Channel', 0);
TT.SetGlobalStringV('Options', 'ALL');

eegData = TT.ReadWavesV(EEG_STORE_ID);
if isempty(eegData) || (isscalar(eegData) && isnan(eegData))
    warning('No EEG data in store "%s".', EEG_STORE_ID);
    eegData = [];
end

btnData = TT.ReadWavesV(BTN_STORE_ID);
if isempty(btnData) || (isscalar(btnData) && isnan(btnData))
    warning('No button data in store "%s".', BTN_STORE_ID);
    btnData = [];
end

fprintf('--- Data summary ---\n');
fprintf('EEG:     %d samples @ %.2f Hz = %.3f s\n', size(eegData,1), eegSampleRate, size(eegData,1)/eegSampleRate);
fprintf('Buttons: %d samples @ %.2f Hz = %.3f s\n', size(btnData,1), btnSampleRate, size(btnData,1)/btnSampleRate);

% --- 10. Plot ---
hasEEG = ~isempty(eegData);
hasBtn = ~isempty(btnData);

if hasEEG || hasBtn
    eegChans   = 0; btnChans = 0;
    if hasEEG, eegChans = min(4, size(eegData,2)); end
    if hasBtn, btnChans = min(4, size(btnData,2)); end
    totalPlots = eegChans + btnChans;

    figure('Name', ['Session: ' blockName], 'Color', 'w');
    plotIdx = 1;

    if hasEEG
        eegTime = (0:size(eegData,1)-1) / eegSampleRate;
        for i = 1:eegChans
            subplot(totalPlots, 1, plotIdx);
            plot(eegTime, eegData(:,i), 'b'); ylabel(['EEG ' num2str(i)]); grid on;
            if plotIdx == 1, title(['Block: ' blockName]); end
            plotIdx = plotIdx + 1;
        end
    end

    if hasBtn
        btnTime = (0:size(btnData,1)-1) / btnSampleRate;
        for i = 1:btnChans
            subplot(totalPlots, 1, plotIdx);
            plot(btnTime, btnData(:,i), 'r'); ylabel(['Btn ' num2str(i)]); grid on;
            ylim([-0.5 1.5]);
            plotIdx = plotIdx + 1;
        end
    end
    xlabel('Time (s)');
end

catch ME
    fprintf('ERROR: %s\n', ME.message);
    rethrow(ME);
end

% --- 11. Cleanup ---
TT.CloseTank;
TT.ReleaseServer;
try, td.idle(); catch, end
delete(td);
fprintf('Session complete.\n');

end
