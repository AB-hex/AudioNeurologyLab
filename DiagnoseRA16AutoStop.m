% DiagnoseRA16AutoStop.m
% Observes RA16 behavior across the default zSwPeriod (~16.4s) boundary
% WITHOUT suppressing it, to find out what the z-switch auto-stop actually
% does to sEEG0 / circuit status when it fires naturally.
%
% Does NOT modify zSwPeriod — leaves it at the compiled default so the
% auto-stop event happens naturally partway through the poll window.

EEG_CIRCUIT = 'C:\Users\Lab\Desktop\TDT_multiChannelv4 with EEG Integration\MedusaBaseStation.rcx';
POLL_DURATION_S = 25;   % > default zSwPeriod (~16.4 s) so we see the boundary
POLL_INTERVAL_S = 0.1;

fprintf('=== RA16 Auto-Stop Boundary Diagnostic ===\n\n');

RP = actxcontrol('RPco.x', [5 5 26 26]);
if ~RP.ConnectRA16('GB', 1)
    delete(RP); error('ConnectRA16 failed.');
end
RP.Halt;
RP.ClearCOF;
RP.LoadCOF(EEG_CIRCUIT);

zSwPeriod = RP.GetTagVal('zSwPeriod');
fprintf('zSwPeriod (left untouched): %g ticks = %.2f s @ 6103.5 Hz\n\n', ...
    zSwPeriod, zSwPeriod/6103.515625);

RP.Run;
st = double(RP.GetStatus);
fprintf('Status after Run: %d  (bits 1:3 = [%d %d %d])\n\n', st, bitget(st,1), bitget(st,2), bitget(st,3));

fprintf('Polling every %.1f s for %d s — watch for a glitch near t=%.1f s...\n\n', ...
    POLL_INTERVAL_S, POLL_DURATION_S, zSwPeriod/6103.515625);
fprintf('  t(s)    sEEG0   zSwDone  zSwNum  zSwCount   status  bits[1:3]\n');

tStart   = tic;
prevEEG  = -1;
sawDrop  = false;
sawStatusChange = false;
firstStatus = st;

while toc(tStart) < POLL_DURATION_S
    t   = toc(tStart);
    s   = RP.GetTagVal('sEEG0');
    don = RP.GetTagVal('zSwDone');
    num = RP.GetTagVal('zSwNum');
    cnt = RP.GetTagVal('zSwCount');
    stNow = double(RP.GetStatus);
    bits  = bitget(stNow,1:3);

    fprintf('  %5.2f  %7.0f  %7.0f  %6.0f  %8.0f   %6d  [%d %d %d]\n', ...
        t, s, don, num, cnt, stNow, bits(1), bits(2), bits(3));

    if prevEEG >= 0 && s < prevEEG
        sawDrop = true;
        fprintf('  ** sEEG0 DECREASED (%.0f -> %.0f) at t=%.2f s — counter was reset\n', prevEEG, s, t);
    end
    if stNow ~= firstStatus
        sawStatusChange = true;
        fprintf('  ** STATUS CHANGED (%d -> %d) at t=%.2f s\n', firstStatus, stNow, t);
    end

    prevEEG = s;
    pause(POLL_INTERVAL_S);
end

fprintf('\n--- Summary ---\n');
if sawDrop
    fprintf('sEEG0 was reset/decreased during the poll — the auto-stop DOES reset the EEG sample counter.\n');
else
    fprintf('sEEG0 never decreased — counter kept incrementing monotonically through the period boundary.\n');
end
if sawStatusChange
    fprintf('GetStatus changed during the poll — the auto-stop DOES affect circuit run/connected/loaded state.\n');
else
    fprintf('GetStatus never changed — circuit stayed in the same state throughout.\n');
end

RP.Halt;
delete(RP);
fprintf('\nDone.\n');
