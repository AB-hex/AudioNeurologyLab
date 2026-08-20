% DiagnoseButtons.m
% Diagnose RX8_1 button box: sample rate, data format, active-high vs active-low.
% Run this and press buttons during the polling window.

SOUND_CIRCUIT  = fullfile(fileparts(mfilename('fullpath')), 'Copy_of_full_5.rcx');
BTN_BUF_PREFIX = 'dBTTN~';
BTN_IDX_TAG    = 'sBTTN';

fprintf('=== Button Box Diagnostic ===\n\n');

RP = actxcontrol('RPco.x', [5 5 26 26]);
if ~RP.ConnectRX8('GB', 1)
    delete(RP); error('ConnectRX8 failed.');
end
RP.Halt; RP.ClearCOF; RP.LoadCOF(SOUND_CIRCUIT); RP.Run;
st = double(RP.GetStatus);
fprintf('RX8 status=%d  DSP=%.4f Hz\n\n', st, RP.GetSFreq());

% --- Tag inventory ---
fprintf('--- Tag types ---\n');
chkTags = {BTN_IDX_TAG, 'dBTTN~1','dBTTN~2','dBTTN~3','dBTTN~4'};
for i = 1:numel(chkTags)
    t = chkTags{i};
    try
        fprintf('  %-14s  type=%-4s  size=%6d  val=%g\n', ...
            t, RP.GetTagType(t), RP.GetTagSize(t), RP.GetTagVal(t));
    catch ex
        fprintf('  %-14s  ERROR: %s\n', t, ex.message);
    end
end

% --- Poll for 5 s — PRESS BUTTONS NOW ---
fprintf('\n--- Polling every 0.1 s for 5 s  (PRESS BUTTONS!) ---\n');
fprintf('  t(s)   sBTTN   Ch1_last  Ch2_last  Ch3_last  Ch4_last\n');
bufSize = RP.GetTagSize([BTN_BUF_PREFIX '1']);
tStart  = tic;
prevS   = 0;
for k = 1:50
    pause(0.1);
    s = double(RP.GetTagVal(BTN_IDX_TAG));
    nAvail = min(s, bufSize);

    % Read the very last sample in each channel buffer
    vals = nan(1, 4);
    if nAvail > 0
        lastIdx = nAvail - 1;   % 0-based
        for ch = 1:4
            try
                vals(ch) = RP.ReadTagV([BTN_BUF_PREFIX num2str(ch)], lastIdx, 1);
            catch, end
        end
    end

    mark = '';
    if s ~= prevS, mark = sprintf('  << +%d', s - prevS); end
    fprintf('  %5.2f  %6.0f   %8.4f  %8.4f  %8.4f  %8.4f%s\n', ...
        toc(tStart), s, vals(1), vals(2), vals(3), vals(4), mark);
    prevS = s;
end
elapsed = toc(tStart);

% --- Buffer content analysis ---
fprintf('\n--- Buffer analysis after polling ---\n');
s = double(RP.GetTagVal(BTN_IDX_TAG));
nAvail = min(s, bufSize);
fprintf('  sBTTN = %d  bufSize = %d  nAvail = %d\n', s, bufSize, nAvail);

if nAvail > 0
    d1 = RP.ReadTagV([BTN_BUF_PREFIX '1'], 0, nAvail);
    uVals = unique(d1);
    fprintf('  dBTTN~1 unique values: '); fprintf('%g ', uVals); fprintf('\n');
    fprintf('  dBTTN~1 first 20: ');
    fprintf('%g ', d1(1:min(20,end))); fprintf('\n');

    % Estimate rate
    fprintf('\n--- Rate estimate ---\n');
    fprintf('  sBTTN=%d over %.2f s  →  %.2f Hz effective\n', s, elapsed, s/elapsed);
    fprintf('  RX8 DSP (%.2f Hz) / sBTTN rate = decimation factor ≈ %.1f\n', ...
        RP.GetSFreq(), RP.GetSFreq() / (s/elapsed));
else
    fprintf('  No data (sBTTN=0) — circuit may not be writing button buffers yet.\n');
    fprintf('  Try pressing a button or check that the circuit has dBTTN tags.\n');
end

fprintf('\n--- Cleanup ---\n');
RP.Halt; delete(RP);
fprintf('Done.\n');
