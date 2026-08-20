% LiveEEGMonitor.m
% Real-time scrolling EEG + button waveform display.
% Connects to RA16_1 (EEG) and RX8_1 (buttons) directly via RPco.X.
% No OpenWorkbench needed. Run until figure closed or Stop pressed.
%
% Hardware-confirmed rates (DiagnoseRA16 / DiagnoseButtons):
%   EEG  — GetSFreq()/6  = 1017 Hz   (dEEG0~N buffer, sEEG0 counter)
%   BTTN — GetSFreq()/20 = 1221 Hz   (dBTTN~N buffer, sBTTN counter)
%   Both are continuous monotonic counters, same circular-buffer model.
%   Button values: 0 = released, 1 = pressed  (active-HIGH)

% =========================================================================
% Configuration
% =========================================================================
EEG_CIRCUIT     = fullfile(fileparts(mfilename('fullpath')), 'MedusaBaseStation.rcx');
SOUND_CIRCUIT   = fullfile(fileparts(mfilename('fullpath')), 'Copy_of_full_5.rcx');
RA16_DEVICE_NUM = 1;
RX8_DEVICE_NUM  = 1;

EEG_DECIM       = 6;          % dEEG0~N at GetSFreq()/6  = 1017 Hz
BTN_DECIM       = 20;         % dBTTN~N at GetSFreq()/20 = 1221 Hz
NUM_CHANS       = 4;
NUM_BTN_CHANS   = 4;
EEG_WINDOW_S    = 5;          % seconds of EEG visible at once
BTN_WINDOW_S    = 5;          % seconds of button history visible
UPDATE_INTERVAL = 0.1;        % plot refresh period (s) — 10 fps

EEG_BUF_PREFIX  = 'dEEG0~';
EEG_IDX_TAG     = 'sEEG0';
BTN_BUF_PREFIX  = 'dBTTN~';
BTN_IDX_TAG     = 'sBTTN';

% =========================================================================
% Connect to RA16_1 — EEG
% =========================================================================
fprintf('Connecting to RA16_1 (device %d)...\n', RA16_DEVICE_NUM);
RP = actxcontrol('RPco.x', [5 5 26 26]);
if ~RP.ConnectRA16('GB', RA16_DEVICE_NUM)
    delete(RP);
    error('ConnectRA16 failed. Check RA16 power and GB bus cable.');
end
RP.Halt; RP.ClearCOF;
if ~RP.LoadCOF(EEG_CIRCUIT)
    delete(RP);
    error('Failed to load EEG circuit: %s', EEG_CIRCUIT);
end
RP.Run;
st = double(RP.GetStatus);
if ~all(bitget(st, 1:3))
    delete(RP);
    error('RA16 circuit not running (status=%d).', st);
end
eegFs      = RP.GetSFreq() / EEG_DECIM;
eegBufSize = RP.GetTagSize([EEG_BUF_PREFIX '1']);
eegWinSamp = round(EEG_WINDOW_S * eegFs);
fprintf('  RA16_1 ready — buffer %.1f Hz, %d smp (%.0f s)\n', eegFs, eegBufSize, eegBufSize/eegFs);

% =========================================================================
% Connect to RX8_1 — buttons
% =========================================================================
fprintf('Connecting to RX8_1 (device %d)...\n', RX8_DEVICE_NUM);
RP_BTN = actxcontrol('RPco.x', [5 5 26 26]);
if ~RP_BTN.ConnectRX8('GB', RX8_DEVICE_NUM)
    delete(RP); delete(RP_BTN);
    error('ConnectRX8 failed. Check RX8 power and GB bus cable.');
end
RP_BTN.Halt; RP_BTN.ClearCOF;
if ~RP_BTN.LoadCOF(SOUND_CIRCUIT)
    delete(RP); delete(RP_BTN);
    error('Failed to load sound circuit: %s', SOUND_CIRCUIT);
end
RP_BTN.Run;
st = double(RP_BTN.GetStatus);
if ~all(bitget(st, 1:3))
    delete(RP); delete(RP_BTN);
    error('RX8 circuit not running (status=%d).', st);
end
btnFs      = RP_BTN.GetSFreq() / BTN_DECIM;
btnBufSize = RP_BTN.GetTagSize([BTN_BUF_PREFIX '1']);
btnWinSamp = round(BTN_WINDOW_S * btnFs);
fprintf('  RX8_1 ready  — buffer %.1f Hz, %d smp (%.0f s)\n', btnFs, btnBufSize, btnBufSize/btnFs);

% =========================================================================
% Build figure
% =========================================================================
TOTAL_ROWS  = NUM_CHANS + 1;
EEG_COLORS  = {'b', 'r', [0 0.55 0], [0.8 0.35 0]};
BTN_COLORS  = {'r', [0 0.72 0], [0 0.45 0.9], [0.85 0.45 0]};
BTN_OFFSET  = 1.5;

hFig = figure('Name', 'Live EEG Monitor + Buttons', 'Color', 'w', ...
              'Position', [80 60 980 740], ...
              'CloseRequestFcn', @(src,~) setappdata(src, 'stop', true));
setappdata(hFig, 'stop', false);

% EEG subplots — scrolling window, x = time relative to now
eegTAxis = linspace(-EEG_WINDOW_S, 0, eegWinSamp);
hLines   = gobjects(NUM_CHANS, 1);
hAxes    = gobjects(NUM_CHANS, 1);
for i = 1:NUM_CHANS
    hAxes(i) = subplot(TOTAL_ROWS, 1, i);
    hLines(i) = plot(eegTAxis, zeros(1, eegWinSamp), ...
        'Color', EEG_COLORS{i}, 'LineWidth', 0.8);
    grid on;
    ylabel(sprintf('Ch %d', i), 'FontSize', 9);
    xlim([-EEG_WINDOW_S 0]);
    set(gca, 'XTickLabel', {});
end
title(hAxes(1), 'Live EEG — waiting for data...', 'FontSize', 10);

% Button waveform subplot — same scrolling window
% Values 0/1 per channel, stacked with BTN_OFFSET gap
btnTAxis  = linspace(-BTN_WINDOW_S, 0, btnWinSamp);
hBtnAx    = subplot(TOTAL_ROWS, 1, TOTAL_ROWS);
hold(hBtnAx, 'on');
hBtnLines = gobjects(NUM_BTN_CHANS, 1);
for b = 1:NUM_BTN_CHANS
    hBtnLines(b) = plot(hBtnAx, btnTAxis, zeros(1, btnWinSamp) + (b-1)*BTN_OFFSET, ...
        'Color', BTN_COLORS{b}, 'LineWidth', 1.2);
end
set(hBtnAx, 'XLim', [-BTN_WINDOW_S 0], ...
    'YLim', [-0.2, NUM_BTN_CHANS * BTN_OFFSET], ...
    'YTick',      (0:NUM_BTN_CHANS-1) * BTN_OFFSET + 0.5, ...
    'YTickLabel', {'Btn1','Btn2','Btn3','Btn4'});
xlabel(hBtnAx, 'Time relative to now (s)');
hBtnTitle = title(hBtnAx, sprintf('Buttons @ %.0f Hz — waiting...', btnFs));
grid(hBtnAx, 'on');

% Stop button
uicontrol('Style', 'pushbutton', 'String', 'Stop', 'FontSize', 11, ...
    'Units', 'normalized', 'Position', [0.43 0.004 0.14 0.030], ...
    'Callback', @(~,~) setappdata(hFig, 'stop', true));

drawnow;

% =========================================================================
% Monitor loop — same circular-buffer read for both EEG and buttons
% =========================================================================
fprintf('Monitoring. Close figure or press Stop to disconnect.\n');
tStart    = tic;
tLastPlot = -UPDATE_INTERVAL;
prevEEG   = 0;
prevBtn   = 0;

while ishandle(hFig) && ~getappdata(hFig, 'stop')
    elapsed = toc(tStart);

    if elapsed - tLastPlot >= UPDATE_INTERVAL

        % --- EEG scrolling window ---
        rawEEG = RP.GetTagVal(EEG_IDX_TAG);
        if rawEEG > prevEEG
            nRead    = min(rawEEG, eegWinSamp);
            startIdx = mod(rawEEG - nRead, eegBufSize);
            eegWin   = zeros(nRead, NUM_CHANS);
            if startIdx + nRead <= eegBufSize
                for ch = 1:NUM_CHANS
                    eegWin(:,ch) = RP.ReadTagV([EEG_BUF_PREFIX num2str(ch)], startIdx, nRead);
                end
            else
                nTail = eegBufSize - startIdx;
                for ch = 1:NUM_CHANS
                    tail = RP.ReadTagV([EEG_BUF_PREFIX num2str(ch)], startIdx, nTail);
                    head = RP.ReadTagV([EEG_BUF_PREFIX num2str(ch)], 0, nRead-nTail);
                    eegWin(:,ch) = [tail; head];
                end
            end
            if nRead < eegWinSamp
                eegWin = [zeros(eegWinSamp-nRead, NUM_CHANS); eegWin];
            end
            for i = 1:NUM_CHANS
                set(hLines(i), 'YData', eegWin(:,i));
            end
            title(hAxes(1), sprintf('Live EEG — %.1f s  |  total %d smp @ %.0f Hz', ...
                elapsed, rawEEG, eegFs), 'FontSize', 10);
            prevEEG = rawEEG;
        end

        % --- Button scrolling window ---
        rawBtn = double(RP_BTN.GetTagVal(BTN_IDX_TAG));
        if rawBtn > prevBtn && ishandle(hBtnAx)
            nRead    = min(rawBtn, btnWinSamp);
            startIdx = mod(rawBtn - nRead, btnBufSize);
            btnWin   = zeros(nRead, NUM_BTN_CHANS);
            if startIdx + nRead <= btnBufSize
                for b = 1:NUM_BTN_CHANS
                    btnWin(:,b) = RP_BTN.ReadTagV([BTN_BUF_PREFIX num2str(b)], startIdx, nRead);
                end
            else
                nTail = btnBufSize - startIdx;
                for b = 1:NUM_BTN_CHANS
                    tail = RP_BTN.ReadTagV([BTN_BUF_PREFIX num2str(b)], startIdx, nTail);
                    head = RP_BTN.ReadTagV([BTN_BUF_PREFIX num2str(b)], 0, nRead-nTail);
                    btnWin(:,b) = [tail; head];
                end
            end
            if nRead < btnWinSamp
                btnWin = [zeros(btnWinSamp-nRead, NUM_BTN_CHANS); btnWin];
            end
            for b = 1:NUM_BTN_CHANS
                set(hBtnLines(b), 'YData', (1 - btnWin(:,b)) + (b-1)*BTN_OFFSET);
            end
            cs = 1 - btnWin(end,:);   % invert: raw 0=pressed → display 1=pressed
            title(hBtnAx, sprintf('Buttons @ %.0f Hz — 1:%d  2:%d  3:%d  4:%d', ...
                btnFs, cs(1), cs(2), cs(3), cs(4)));
            prevBtn = rawBtn;
        end

        drawnow limitrate;
        tLastPlot = elapsed;
    end

    pause(0.02);
end

% =========================================================================
% Cleanup
% =========================================================================
fprintf('Stopping monitor (%.1f s elapsed).\n', toc(tStart));
RP.Halt;     delete(RP);
RP_BTN.Halt; delete(RP_BTN);
fprintf('RA16_1 and RX8_1 disconnected.\n');
if ishandle(hFig), delete(hFig); end
