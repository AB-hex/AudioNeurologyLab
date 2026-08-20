function [eegData, eegSampleRate, btnData, btnSampleRate] = RunSoundEEGTanks(soundSignal, circuitPath, tankPath)
% RunSoundEEGTanks: Play sound and record EEG + button box via OpenWorkbench/TTank.
% OpenWorkbench must already be open and idle before calling this function.
% Does NOT use Circuit_Loader — drives all hardware through TDevAcc/TDEV.
%
% Parameters:
%   soundSignal: Sound waveform vector (row or column).
%   circuitPath: Unused — kept for interface compatibility.
%   tankPath:    Absolute path to the Tank directory.
%
% Returns:
%   eegData:       [samples x 4] EEG matrix.
%   eegSampleRate: EEG sampling rate in Hz (RA16_1).
%   btnData:       [samples x 4] Button box matrix (one column per button).
%   btnSampleRate: Button sampling rate in Hz (RX8_1).
%
% NOTE: eegSampleRate and btnSampleRate are different — RA16_1 (EEG) runs at
% a lower rate than RX8_1 (buttons/sound). Always use the correct rate for
% each stream when building time axes:
%   eegTime = (0:size(eegData,1)-1) / eegSampleRate;
%   btnTime = (0:size(btnData,1)-1) / btnSampleRate;

% --- 1. CONFIGURATION ---
TDEV_SDK_PATH     = 'C:\TDT\TDTMatlabSDK\TDTSDK\OpenExLive';
RECORD_DURATION_S = 5;
SOUND_DEVICE      = 'RX8_1';
EEG_DEVICE        = 'RA16_1';
SOUND_BUF_TAG     = 'datain1';
BUFSIZE_TAG       = 'BufSize1';
EEG_STORE_ID      = 'EEG0';
BTN_STORE_ID      = 'BTTN';

% --- 2. Connect via TDEV ---
addpath(TDEV_SDK_PATH);

% TDEV() constructor loops on ConnectServer+GetDeviceName(0) at 0.1 s intervals
% (see TDEV.m lines 158-164). We mirror that exact pattern with a finite
% timeout so we can give a clear error instead of hanging forever.
% ConnectServer must be called on every iteration — not just once — because
% TDevAcc refreshes the device list on each ConnectServer call.
fprintf('Connecting to OpenWorkbench...\n');
checkTD = actxserver('TDevAcc.X');
if checkTD.ConnectServer('Local') ~= 1
    checkTD.CloseConnection; delete(checkTD);
    error('OpenWorkbench is not running. Start it with workbenchconfEEG.xpm before calling this function.');
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
if TT.ConnectServer('Local', 'Me') ~= 1
    error('TTank connection failed.');
end

try

% --- 3. Set Tank ---
if ~exist(tankPath, 'dir'), mkdir(tankPath); end
td.set_tank(tankPath);

% --- 4. Read sample rates and attempt to disable circuit auto-stop ---
eegSampleRate  = td.TD.GetDeviceSF(EEG_DEVICE);
btnSampleRate  = td.TD.GetDeviceSF(SOUND_DEVICE);

% The circuit fires a z-bus auto-stop signal via its periodic z-trigger.
% Read current zSwPeriod values, then set them to a large value so the
% auto-stop timer doesn't fire during the recording window.
LARGE_PERIOD = 1e7;  % ~1638 s at 6103 Hz — effectively disables the timer
try
    origEEGPeriod = td.TD.GetTargetVal([EEG_DEVICE  '.zSwPeriod']);
    origBTNPeriod = td.TD.GetTargetVal([SOUND_DEVICE '.zSwPeriod']);
    td.TD.SetTargetVal([EEG_DEVICE   '.zSwPeriod'], LARGE_PERIOD);
    td.TD.SetTargetVal([SOUND_DEVICE '.zSwPeriod'], LARGE_PERIOD);
    fprintf('zSwPeriod suppressed (EEG was %.0f, BTN was %.0f)\n', origEEGPeriod, origBTNPeriod);
catch e
    fprintf('Note: zSwPeriod not adjustable: %s\n', e.message);
    origEEGPeriod = []; origBTNPeriod = [];
end

% Also disable zCycUse (cycle-based auto-stop) on both devices
try
    td.TD.SetTargetVal([EEG_DEVICE   '.zCycUse'], 0);
    td.TD.SetTargetVal([SOUND_DEVICE '.zCycUse'], 0);
    fprintf('zCycUse disabled on both devices.\n');
catch
end

% --- 5. Load sound into RX8_1 buffer via TDevAcc ---
soundSignal = soundSignal(:)';
fprintf('Loading sound into %s.%s (%d samples)...\n', ...
    SOUND_DEVICE, SOUND_BUF_TAG, length(soundSignal));
td.TD.SetTargetVal([SOUND_DEVICE '.' BUFSIZE_TAG], length(soundSignal));
td.TD.WriteTargetVEX([SOUND_DEVICE '.' SOUND_BUF_TAG], 0, 'F32', soundSignal);

% --- 6. Transition to Record ---
fprintf('Going to Standby...\n');
td.standby();
fprintf('Going to Record...\n');
td.record();
fprintf('In Record mode.\n');

% Open tank first so TTank is attached, then get hot block
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
        fprintf('GetHotBlock empty — using latest from disk: %s\n', blockName);
    else
        error('Cannot determine block name. Check tank path: %s', tankPath);
    end
end
fprintf('Recording into block: %s\n', blockName);

% --- 6. Fire trigger using cont1 (avoids circuit auto-stop signal) ---
% single1 causes the circuit to send a z-bus "done" signal when playback
% finishes, which drops Workbench to Idle immediately. cont1 plays the
% buffer without triggering that auto-stop, so we control the stop time.
fprintf('Triggering stimulus (%d s)...\n', RECORD_DURATION_S);
td.TD.SetTargetVal([SOUND_DEVICE '.cont1'], 1);   % start continuous play
pause(RECORD_DURATION_S);
td.TD.SetTargetVal([SOUND_DEVICE '.cont1'], 0);   % stop playback

% --- 7. Stop recording ---
try
    td.idle();
catch
    fprintf('Note: Workbench already in Idle (circuit auto-stopped).\n');
end

% Restore original zSwPeriod values
if ~isempty(origEEGPeriod)
    try
        td.TD.SetTargetVal([EEG_DEVICE   '.zSwPeriod'], origEEGPeriod);
        td.TD.SetTargetVal([SOUND_DEVICE '.zSwPeriod'], origBTNPeriod);
    catch
    end
end
pause(1);

% --- 8. Read EEG and button data from tank ---
fprintf('Reading data from block %s...\n', blockName);
TT.SelectBlock(['~' blockName]);
TT.SetGlobalV('Channel', 0);
TT.SetGlobalStringV('Options', 'ALL');

% EEG — RA16_1 runs at a different (lower) rate than RX8_1
eegData = TT.ReadWavesV(EEG_STORE_ID);
if isempty(eegData) || (isscalar(eegData) && isnan(eegData))
    warning('No EEG data in store "%s".', EEG_STORE_ID);
    eegData = [];
end

% Button box — RX8_1 runs at 24414.0625 Hz (DSP clock)
btnData = TT.ReadWavesV(BTN_STORE_ID);
if isempty(btnData) || (isscalar(btnData) && isnan(btnData))
    warning('No button data in store "%s".', BTN_STORE_ID);
    btnData = [];
end

% Diagnostic — print sample counts and durations so mismatches are visible
fprintf('--- Data summary ---\n');
fprintf('EEG:     %d samples @ %.2f Hz = %.3f s\n', size(eegData,1), eegSampleRate, size(eegData,1)/eegSampleRate);
fprintf('Buttons: %d samples @ %.2f Hz = %.3f s\n', size(btnData,1), btnSampleRate, size(btnData,1)/btnSampleRate);

% --- 9. Visualization ---
hasEEG = ~isempty(eegData);
hasBtn = ~isempty(btnData);

if hasEEG || hasBtn
    eegChans = 0; btnChans = 0;
    if hasEEG, eegChans = min(4, size(eegData,2)); end
    if hasBtn, btnChans = min(4, size(btnData,2)); end
    totalPlots = eegChans + btnChans;

    figure('Name', ['Session: ' blockName], 'Color', 'w');
    plotIdx = 1;

    % EEG subplots
    if hasEEG
        eegTime = (0:size(eegData,1)-1) / eegSampleRate;
        for i = 1:eegChans
            subplot(totalPlots, 1, plotIdx);
            plot(eegTime, eegData(:, i), 'b');
            ylabel(['EEG ' num2str(i)]); grid on;
            if plotIdx == 1, title(['Block: ' blockName]); end
            plotIdx = plotIdx + 1;
        end
    end

    % Button subplots
    if hasBtn
        btnTime = (0:size(btnData,1)-1) / btnSampleRate;
        for i = 1:btnChans
            subplot(totalPlots, 1, plotIdx);
            plot(btnTime, btnData(:, i), 'r');
            ylabel(['Btn ' num2str(i)]); grid on;
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

% --- 10. Cleanup ---
TT.CloseTank;
TT.ReleaseServer;
try, td.idle(); catch, end
delete(td);
fprintf('Session complete.\n');

end
