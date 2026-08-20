% DiagnoseRA16.m
% Deep diagnostic: what exactly happens with the RA16 z-switch and buffer
% during a direct RPco.X recording, step by step.

EEG_CIRCUIT = 'C:\Users\Lab\Desktop\TDT_multiChannelv4 with EEG Integration\MedusaBaseStation.rcx';

fprintf('=== RA16 Deep Diagnostic ===\n\n');

RP = actxcontrol('RPco.x', [5 5 26 26]);
if ~RP.ConnectRA16('GB', 1)
    delete(RP); error('ConnectRA16 failed.');
end

RP.Halt;
RP.ClearCOF;
RP.LoadCOF(EEG_CIRCUIT);

% --- Tag types for every z-switch related tag ---
fprintf('--- Tag types (before Run) ---\n');
tags = {'sEEG0','zSwCount','zSwPeriod','zTime','zSwNum','zSwDone','zCycUse', ...
        'dEEG0~1','dEEG0~2','dEEG0~3','dEEG0~4'};
for i = 1:numel(tags)
    tname = tags{i};
    try
        ttype = RP.GetTagType(tname);
        tsize = RP.GetTagSize(tname);
        tval  = RP.GetTagVal(tname);
        fprintf('  %-14s  type=%-4s  size=%6d  val=%g\n', tname, ttype, tsize, tval);
    catch ex
        fprintf('  %-14s  ERROR: %s\n', tname, ex.message);
    end
end

fprintf('\n--- Attempting SetTagVal(zSwPeriod, 1e9) BEFORE Run ---\n');
before = RP.GetTagVal('zSwPeriod');
fprintf('  zSwPeriod before set: %g\n', before);
RP.SetTagVal('zSwPeriod', 1e9);
afterSet = RP.GetTagVal('zSwPeriod');
fprintf('  zSwPeriod after  set: %g\n', afterSet);
if afterSet == before
    fprintf('  ** SetTagVal had NO effect — tag is read-only or value was reset\n');
elseif afterSet ~= 1e9
    fprintf('  ** SetTagVal changed value but NOT to 1e9 (got %g) — likely overflow/type limit\n', afterSet);
else
    fprintf('  ** SetTagVal succeeded — value is now 1e9\n');
end

fprintf('\n--- Calling Run ---\n');
RP.Run;
afterRun = RP.GetTagVal('zSwPeriod');
fprintf('  zSwPeriod after Run: %g\n', afterRun);
if afterRun == before
    fprintf('  ** Run RESET zSwPeriod back to compiled default (%g)\n', before);
end

fprintf('\n--- Polling every 0.1 s for 2.5 s ---\n');
fprintf('  t(s)   sEEG0   zSwCount  zSwNum  zSwDone  zTime\n');
tStart = tic;
prevEEG = 0;
for k = 1:25
    pause(0.1);
    s   = RP.GetTagVal('sEEG0');
    cnt = RP.GetTagVal('zSwCount');
    num = RP.GetTagVal('zSwNum');
    don = RP.GetTagVal('zSwDone');
    zt  = RP.GetTagVal('zTime');
    fprintf('  %5.2f  %6.0f  %9.0f  %6.0f  %7.0f  %g\n', toc(tStart), s, cnt, num, don, zt);
    if s == prevEEG && s > 0
        fprintf('  ** sEEG0 STOPPED incrementing at %d samples (%.3f s)\n', s, s/6103.515625);
    end
    prevEEG = s;
end

fprintf('\n--- Buffer content check after 2.5 s ---\n');
buf1 = RP.ReadTagV('dEEG0~1', 0, RP.GetTagSize('dEEG0~1'));
nz = sum(buf1 ~= 0);
lastNZ = find(buf1 ~= 0, 1, 'last');
if isempty(lastNZ), lastNZ = 0; end
fprintf('  dEEG0~1: %d non-zero samples out of %d total\n', nz, numel(buf1));
fprintf('  Last non-zero at index %d (%.3f s @ 6103 Hz)\n', lastNZ, lastNZ/6103.515625);

fprintf('\n--- Cleanup ---\n');
RP.Halt;
delete(RP);
fprintf('Done.\n');
