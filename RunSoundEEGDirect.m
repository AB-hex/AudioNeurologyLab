function [eegData, eegSampleRate, btnData, btnSampleRate] = RunSoundEEGDirect(soundSignal, saveDir)
% RunSoundEEGDirect  Play sound and record EEG + button box via direct RPco.X.
% No OpenWorkbench or TDEV required.  Connects to RX8 and RA16 independently.
%
% Parameters:
%   soundSignal: Sound waveform vector at 24414.0625 Hz (row or column).
%   saveDir:     Directory to save .mat output.  Auto-creates Block-N subfolders.
%                Defaults to .\Tanks\Direct\
%
% Returns:
%   eegData:       [samples x 4]  EEG matrix (4 channels from RA16_1).
%   eegSampleRate: Effective EEG buffer rate in Hz.
%                  NOTE: GetSFreq() on the RA16 returns the DSP process rate
%                  (6103 Hz), but the RPco.X dEEG0~N buffers are written at
%                  GetSFreq()/6 = 1017 Hz.  This is the rate returned here
%                  and used for all time axes.
%   btnData:       [samples x 4]  Button box matrix (event-based, 4 channels).
%   btnSampleRate: RX8_1 DSP rate (24414 Hz) — only meaningful if buttons pressed.
%
% EEG buffer capacity: 30528 entries / 1017 Hz = ~30 seconds max recording.

% =========================================================================
% 1. Configuration
% =========================================================================
RX8_DEVICE_NUM    = 1;    % GB bus device number for RX8_1
RA16_DEVICE_NUM   = 1;    % GB bus device number for RA16_1

SOUND_CIRCUIT     = fullfile(fileparts(mfilename('fullpath')), 'Copy_of_full_5.rcx');
EEG_CIRCUIT       = fullfile(fileparts(mfilename('fullpath')), 'MedusaBaseStation.rcx');

RECORD_DURATION_S = 5;

% Tag names confirmed from ListDeviceTags / DiagnoseRA16
SOUND_BUF_TAG  = 'datain1';
BUFSIZE_TAG    = 'BufSize1';
EEG_BUF_PREFIX = 'dEEG0~';   % dEEG0~1 … dEEG0~4 on RA16
EEG_IDX_TAG    = 'sEEG0';    % buffer write index (in buffer-rate samples)
BTN_BUF_PREFIX = 'dBTTN~';   % dBTTN~1 … dBTTN~4 on RX8
BTN_IDX_TAG    = 'sBTTN';    % button event index
NUM_EEG_CHANS  = 4;
NUM_BTN_CHANS  = 4;

% The RA16 circuit's dEEG0~N buffers are written at GetSFreq()/EEG_DECIM.
% DiagnoseRA16 confirmed: zTime ticks at GetSFreq(), sEEG0 increments every
% 6 zTime ticks → EEG_DECIM = 6 → effective buffer rate = 6103/6 = 1017 Hz.
EEG_DECIM = 6;

if nargin < 2 || isempty(saveDir)
    saveDir = fullfile(pwd, 'Tanks', 'Direct');
end

% =========================================================================
% 2. Connect to RX8_1 — sound output + button box
% =========================================================================
fprintf('Connecting to RX8_1 (device %d)...\n', RX8_DEVICE_NUM);
RP_SND = actxcontrol('RPco.x', [5 5 26 26]);
if ~RP_SND.ConnectRX8('GB', RX8_DEVICE_NUM)
    delete(RP_SND);
    error('Could not connect to RX8 device %d.', RX8_DEVICE_NUM);
end
RP_SND.Halt;
RP_SND.ClearCOF;
if ~RP_SND.LoadCOF(SOUND_CIRCUIT)
    delete(RP_SND);
    error('Failed to load sound circuit: %s', SOUND_CIRCUIT);
end
RP_SND.Run;
st = double(RP_SND.GetStatus);
if ~all(bitget(st, 1:3))
    delete(RP_SND);
    error('RX8 circuit not running. Status = %d', st);
end
fprintf('  RX8_1 ready (status=%d, %.4f Hz)\n', st, RP_SND.GetSFreq());

% =========================================================================
% 3. Connect to RA16_1 — EEG recording
% =========================================================================
fprintf('Connecting to RA16_1 (device %d)...\n', RA16_DEVICE_NUM);
RP_EEG = actxcontrol('RPco.x', [5 5 26 26]);
if ~RP_EEG.ConnectRA16('GB', RA16_DEVICE_NUM)
    delete(RP_SND); delete(RP_EEG);
    error('Could not connect to RA16 device %d.', RA16_DEVICE_NUM);
end
RP_EEG.Halt;
RP_EEG.ClearCOF;
if ~RP_EEG.LoadCOF(EEG_CIRCUIT)
    delete(RP_SND); delete(RP_EEG);
    error('Failed to load EEG circuit: %s', EEG_CIRCUIT);
end
RP_EEG.Run;
st = double(RP_EEG.GetStatus);
if ~all(bitget(st, 1:3))
    delete(RP_SND); delete(RP_EEG);
    error('RA16 circuit not running. Status = %d', st);
end

% =========================================================================
% 4. Sample rates
% =========================================================================
% GetSFreq() returns the DSP process rate, not the RPco.X buffer write rate.
% Buffer is written at GetSFreq()/EEG_DECIM (= 1017 Hz for RA16).
dspRate       = RP_EEG.GetSFreq();   % 6103 Hz
eegSampleRate = dspRate / EEG_DECIM; % 1017 Hz — true rate of dEEG0~N entries
btnSampleRate = RP_SND.GetSFreq();   % 24414 Hz
fprintf('  RA16_1 ready (DSP=%.4f Hz, buffer=%.4f Hz)\n', dspRate, eegSampleRate);

eegBufSize = RP_EEG.GetTagSize([EEG_BUF_PREFIX '1']);
eegMaxSec  = eegBufSize / eegSampleRate;
fprintf('EEG buffer: %d entries = %.1f s @ %.2f Hz\n', eegBufSize, eegMaxSec, eegSampleRate);
if RECORD_DURATION_S > eegMaxSec
    warning('EEG buffer (%.1f s) < RECORD_DURATION_S (%d s).', eegMaxSec, RECORD_DURATION_S);
end

% =========================================================================
% 5. Auto-name output block
% =========================================================================
if ~exist(saveDir, 'dir'), mkdir(saveDir); end
existingBlocks = dir(fullfile(saveDir, 'Block-*'));
blockName = sprintf('Block-%d', numel(existingBlocks) + 1);
blockDir  = fullfile(saveDir, blockName);
mkdir(blockDir);
fprintf('Block: %s\n', blockDir);

% =========================================================================
% 6. Load sound
% =========================================================================
soundSignal = soundSignal(:)';
RP_SND.SetTagVal(BUFSIZE_TAG, length(soundSignal));
RP_SND.WriteTagV(SOUND_BUF_TAG, 0, soundSignal);
fprintf('Sound loaded (%d samples).\n', length(soundSignal));

% =========================================================================
% 7. Record — with live EEG + button waveform
% =========================================================================
% DiagnoseButtons confirmed: sBTTN is a continuous sample counter at
% GetSFreq()/20 = 1220.7 Hz.  Values are 0 (released) / 1 (pressed).
% Same circular-buffer model as sEEG0 — NOT an event counter.
LIVE_UPDATE_INTERVAL = 0.2;
TOTAL_LIVE_ROWS      = NUM_EEG_CHANS + 1;
BTN_DECIM  = 20;
btnRate    = RP_SND.GetSFreq() / BTN_DECIM;           % ~1220.7 Hz
btnBufSz   = RP_SND.GetTagSize([BTN_BUF_PREFIX '1']); % 36608 samples
BTN_OFFSET = 1.5;   % vertical gap between stacked channels
BTN_COLORS = {'r', [0 0.72 0], [0 0.45 0.9], [0.85 0.45 0]};

% --- EEG subplots ---
hLiveFig   = figure('Name', 'Live EEG + Buttons', 'Color', 'w', ...
                    'Position', [100 100 900 700]);
hLiveLines = gobjects(NUM_EEG_CHANS, 1);
hLiveAxes  = gobjects(NUM_EEG_CHANS, 1);
for i = 1:NUM_EEG_CHANS
    hLiveAxes(i) = subplot(TOTAL_LIVE_ROWS, 1, i);
    hLiveLines(i) = plot(NaN, NaN, 'b');
    grid on;  ylabel(['Ch' num2str(i)]);
    xlim([0 RECORD_DURATION_S]);
    set(gca, 'XTickLabel', {});
    if i == 1
        title(sprintf('Live EEG — 0.0 / %d s  (waiting for trigger)', RECORD_DURATION_S));
    end
end

% --- Button waveform subplot (5th row) ---
hBtnAx    = subplot(TOTAL_LIVE_ROWS, 1, TOTAL_LIVE_ROWS);
hold(hBtnAx, 'on');
hBtnLines = gobjects(NUM_BTN_CHANS, 1);
for b = 1:NUM_BTN_CHANS
    hBtnLines(b) = plot(hBtnAx, NaN, NaN, 'Color', BTN_COLORS{b}, 'LineWidth', 1.2);
end
set(hBtnAx, 'XLim', [0 RECORD_DURATION_S], ...
    'YLim', [-0.2, NUM_BTN_CHANS * BTN_OFFSET], ...
    'YTick',      (0:NUM_BTN_CHANS-1) * BTN_OFFSET + 0.5, ...
    'YTickLabel', {'Btn1','Btn2','Btn3','Btn4'});
xlabel(hBtnAx, 'Time (s)');
hBtnTitle = title(hBtnAx, sprintf('Buttons @ %.0f Hz', btnRate));
grid(hBtnAx, 'on');

drawnow;

fprintf('Recording %d s...\n', RECORD_DURATION_S);
triggerTime  = now;
RP_SND.SetTagVal('cont1', 1);

tStart     = tic;
lastUpdate = -LIVE_UPDATE_INTERVAL;

while toc(tStart) < RECORD_DURATION_S
    elapsed = toc(tStart);
    if elapsed - lastUpdate >= LIVE_UPDATE_INTERVAL && ishandle(hLiveFig)

        % --- EEG update ---
        nLive = min(RP_EEG.GetTagVal(EEG_IDX_TAG), eegBufSize);
        if nLive > 0
            liveTime = (0:nLive-1) / eegSampleRate;
            for i = 1:NUM_EEG_CHANS
                liveData = RP_EEG.ReadTagV([EEG_BUF_PREFIX num2str(i)], 0, nLive);
                set(hLiveLines(i), 'XData', liveTime, 'YData', liveData);
            end
            title(hLiveAxes(1), sprintf('Live EEG — %.1f / %d s  |  %d smp @ %.0f Hz', ...
                elapsed, RECORD_DURATION_S, nLive, eegSampleRate));
        end

        % --- Button waveform update ---
        % sBTTN is monotonically increasing; read from 0 up to current count.
        rawBtn = double(RP_SND.GetTagVal(BTN_IDX_TAG));
        if rawBtn > 0 && ishandle(hBtnAx)
            nBtnRead = min(rawBtn, btnBufSz);
            btnWin   = zeros(nBtnRead, NUM_BTN_CHANS);
            for b = 1:NUM_BTN_CHANS
                btnWin(:,b) = RP_SND.ReadTagV([BTN_BUF_PREFIX num2str(b)], 0, nBtnRead);
            end
            btnTimeArr = (0:nBtnRead-1) / btnRate;
            for b = 1:NUM_BTN_CHANS
                set(hBtnLines(b), 'XData', btnTimeArr, ...
                    'YData', (1 - btnWin(:,b)) + (b-1)*BTN_OFFSET);
            end
            cs = 1 - btnWin(end,:);   % invert: raw 0=pressed → display 1=pressed
            title(hBtnAx, sprintf('Buttons @ %.0f Hz — 1:%d  2:%d  3:%d  4:%d', ...
                btnRate, cs(1), cs(2), cs(3), cs(4)));
        end

        drawnow limitrate;
        lastUpdate = elapsed;
    end
    pause(0.05);
end

RP_SND.SetTagVal('cont1', 0);
fprintf('Done.\n');

% =========================================================================
% 8. Read EEG — sEEG0 is the correct write index in buffer-rate samples
% =========================================================================
nEEG = RP_EEG.GetTagVal(EEG_IDX_TAG);
fprintf('sEEG0 = %d samples (%.3f s @ %.2f Hz)\n', nEEG, nEEG/eegSampleRate, eegSampleRate);

if nEEG <= 0
    warning('sEEG0 = 0 — no EEG data. Check RA16 hardware.');
    eegData = [];
else
    nEEG = min(nEEG, eegBufSize);
    eegData = zeros(nEEG, NUM_EEG_CHANS);
    for ch = 1:NUM_EEG_CHANS
        eegData(:, ch) = RP_EEG.ReadTagV([EEG_BUF_PREFIX num2str(ch)], 0, nEEG);
    end
    fprintf('EEG read: %d x %d  (%.3f s)\n', nEEG, NUM_EEG_CHANS, nEEG/eegSampleRate);
end

% =========================================================================
% 9. Read buttons — event-based, sBTTN = 0 if no buttons pressed
% =========================================================================
nBtn = min(RP_SND.GetTagVal(BTN_IDX_TAG), RP_SND.GetTagSize([BTN_BUF_PREFIX '1']));
if nBtn <= 0
    btnData = [];
else
    btnData = zeros(nBtn, NUM_BTN_CHANS);
    for ch = 1:NUM_BTN_CHANS
        btnData(:, ch) = RP_SND.ReadTagV([BTN_BUF_PREFIX num2str(ch)], 0, nBtn);
    end
    fprintf('BTTN read: %d x %d\n', nBtn, NUM_BTN_CHANS);
end

% =========================================================================
% 10. Save
% =========================================================================
save(fullfile(blockDir, 'session.mat'), ...
    'eegData', 'eegSampleRate', 'btnData', 'btnSampleRate', ...
    'blockName', 'triggerTime', 'RECORD_DURATION_S', 'EEG_DECIM');
fprintf('Saved: %s\n', blockDir);

% =========================================================================
% 11. Plot
% =========================================================================
if ~isempty(eegData)
    eegTime = (0:size(eegData,1)-1) / eegSampleRate;
    figure('Name', ['EEG: ' blockName], 'Color', 'w');
    for i = 1:min(4, NUM_EEG_CHANS)
        subplot(NUM_EEG_CHANS, 1, i);
        plot(eegTime, eegData(:,i), 'b'); grid on;
        ylabel(['Ch' num2str(i)]);
        if i == 1
            title(sprintf('%s  |  %d smp @ %.0f Hz = %.2f s', ...
                blockName, nEEG, eegSampleRate, nEEG/eegSampleRate));
        end
    end
    xlabel('Time (s)');
end

% =========================================================================
% 12. Cleanup
% =========================================================================
RP_SND.Halt; RP_EEG.Halt;
delete(RP_SND); delete(RP_EEG);
fprintf('Session complete: %s\n', blockName);

end
