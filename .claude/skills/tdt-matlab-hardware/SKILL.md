---
name: tdt-matlab-hardware
description: TDT (Tucker-Davis Technologies) RPco.X hardware patterns, gotchas, and debugging playbook for this MATLAB spatial-hearing/EEG codebase. Use this skill whenever working with Circuit_Loader.m, global RP, RX8/RA16 devices, actxcontrol('RPco.x',...), .rcx circuit files, mdb.mat, OpenWorkbench/TDEV/TTank, or any EEG recording script (RunSoundEEGTanks/Buffers/Direct.m, LiveEEGMonitor.m). Also trigger this for MATLAB errors mentioning 'handle.handle', SetTagVal, GetStatus, ConnectRX8, ConnectRA16, or ActiveX/COM object issues in this project — these are almost always the hardware-state bugs documented here, not generic MATLAB bugs. Push to use this even if the user just describes symptoms ("GUI crashed when I hit Start", "EEG monitor won't connect", "status=70") without naming the file.
---

# TDT MATLAB Hardware Patterns

This project drives TDT RX8 (audio, 18 speakers) and RA16 (32-ch EEG) hardware
from MATLAB via the `RPco.X` ActiveX/COM interface. The hardware layer behaves
in ways that look like bugs but are actually documented quirks — check here
before assuming the MATLAB code is wrong.

## Why this matters

Most "weird" errors in this codebase (`'handle.handle'` has no `SetTagVal`,
status checks failing, EEG connect failing) are **hardware state problems**,
not logic bugs. Guessing at the MATLAB code wastes time; running the existing
diagnostic scripts and knowing the two or three real gotchas below resolves
these fast.

## The RPco.X interface

```matlab
RP = actxcontrol('RPco.x', [5 5 26 26]);   % [5 5 26 26] = hidden window geometry, irrelevant
RP.ConnectRX8('GB', N)     % or RP.ConnectRA16('GB', N) — N = device number on GB bus
RP.Halt; RP.ClearCOF;
RP.LoadCOF('circuit.rcx');
RP.Run;
RP.SetTagVal('tagName', value)      % scalar
RP.WriteTagV('tagName', 0, vector)  % write buffer
RP.ReadTagV('tagName', offset, N)   % read N samples from a tag/circular buffer
RP.GetTagVal('tagName')             % read scalar (e.g. a running counter)
RP.SoftTrg(N)                       % fire trigger N
RP.GetStatus / RP.GetSFreq / RP.GetTagSize / RP.GetTagType
```

`actxcontrol` prints a Windows deprecation warning every time — that's normal
noise, not an error.

## Gotcha #1: `GetStatus` bit 1 = real connection state — check power/cable first

`GetStatus` returns a bitfield. The standard pattern, used identically for
both RX8 and RA16:

```matlab
st = double(RP.GetStatus);
bitget(st, 1:3)   % [connected, loaded, running]
```

**All three bits (1–3) must be 1 for either device**, and bit 1 is a genuine,
trustworthy "connected" signal — not a driver quirk to work around. A status
like `status=70` (`bitget(70,1:3)` = `[0 1 1]`, bit 1 unset) means the device
really isn't connected: check that the RA16/Medusa base station is powered
on and the GB bus cable is seated, *before* touching the code. In the one
case this was investigated, the fix was plugging in power — nothing in
`LiveEEGMonitor.m`/`DiagnoseRA16.m` needed to change.

If you need to confirm whether data is flowing despite a status failure
(e.g. to tell a power issue apart from something else), `DiagnoseRA16.m`
bypasses the status check and polls `sEEG0`/buffer tags directly — useful
for diagnosis, but don't use it as a reason to loosen the status check
itself in real scripts. Decode any status error with `bitget(N, 1:8)` and
go check the physical connection first.

## Gotcha #2: `global RP` (RX8) and `global RP_EEG` (RA16) are separate handles

The EEG path in this codebase went through two designs. **The current one
(as of this session) is direct RPco.X, no OpenWorkbench, matching
`LiveEEGMonitor.m`/`RunSoundEEGDirect.m` exactly:**

- `startupFcn` connects `global RP` to RX8_1 via `Circuit_Loader.m` (always
  classic RPco.X, no mode argument), and separately connects `global RP_EEG`
  to RA16_1 directly (`actxcontrol` + `ConnectRA16('GB',1)` +
  `MedusaBaseStation.rcx`) — **non-fatally**, since plain behavioral/SNR
  sessions don't need the RA16 present. If RA16 isn't powered, `RP_EEG` is
  left empty and only EEG-mode experiments (`BehavioralMainEEG.m`) refuse
  to run; the rest of the app is unaffected.
- `BehavioralMainEEG.m` uses both handles simultaneously: `RP` to fire the
  stimulus via the unmodified `play_signal_multi.m`, `RP_EEG` to read
  `sEEG0`/`dEEG0~N`. No proxy layer, no Tank, no Workbench dependency.
- An earlier design routed EEG through OpenWorkbench + a `TDEVProxy` wrapper
  class + TTank block reads (`Circuit_Loader('path','eeg')` →
  `TDEVProxy.createWithTDEV()`). **This was fully replaced and removed** —
  `TDEVProxy.m` is deleted and `Circuit_Loader.m` no longer takes a mode
  argument. If you find references to `TDEVProxy`, `RP.td`, `RP.record()`/
  `RP.idle()`, or `TT.GetHotBlock()` in code or docs, they're stale —
  don't resurrect that pattern without the user explicitly asking for
  Workbench again.

**Never call `Circuit_Loader` while OpenWorkbench happens to be running for
some other reason** — it still clears the RX8 COF and kills any active
Workbench session, even though this codebase itself no longer depends on
Workbench.

If you see `Undefined function 'SetTagVal' for input arguments of type
'handle.handle'`, `global RP` (or `RP_EEG`) is holding an invalid/degraded
COM handle — usually a previous session's handle going stale, or the device
being disconnected/reconnected without re-running `Circuit_Loader`/restarting
the app. Diagnose with:

```matlab
global RP
class(RP)      % should be 'COM.RPco_x' or similar, NOT 'handle.handle'
isvalid(RP)
```

Fix is almost always: close everything, restart the GUI's `startupFcn` to
get fresh handles for both `RP` and `RP_EEG` before starting an experiment
— don't reuse a handle left over from a previous session.

### Per-trial EEG segmentation: baseline→final delta, not "read from 0"

`RunSoundEEGDirect.m`'s pattern of reading `[0, finalIndex)` from `sEEG0`
only works for a single one-shot recording. A behavioral session with many
trials keeps the RA16 circuit running continuously across all of them —
`sEEG0` free-runs into the ~30s circular buffer (`dEEG0~N`, 30528 samples
@ 1017 Hz) and wraps around. To isolate one trial's segment: capture
`sEEG0`/`sBTTN` immediately before the trigger and again immediately after
the post-stimulus wait, then read exactly `[baseline, final)` with
wraparound handling — use `ReadEEGSegment.m` (baseline/final delta version
of the "circular buffer read pattern" below) rather than re-deriving this
or reading from 0.

## Gotcha #3: mdb.mat save discipline

`mdb.mat` is the shared state file read/written across nearly every layer
(GUI → PrepareBehavioralMdb → BehavioralMain → TX*_create_signal →
Circuit_Loader). Any function that modifies `mdb` must:

```matlab
load mdb        % at the top
...              % modify mdb.*
save mdb mdb    % at the bottom — NOT optional
```

A missing `save mdb mdb` causes silent state loss — the GUI looks like it
accepted a change but the next script run reads stale data. If behavior
doesn't match what the GUI shows, check for a missing save first.

Also: `mdb.mat` and `wav_file_mod.wav` are rewritten continuously by a live
GUI session. If you're doing git operations (stash, checkout) while MATLAB
is running, expect these two files to show spurious diffs/conflicts that
have nothing to do with your actual code changes — see the git workflow note
below.

## EEG buffer rates (measured, not nominal)

Confirmed empirically via `DiagnoseRA16.m` / `DiagnoseButtons.m` — do not
trust the circuit's nominal sample rate for buffer indexing:

| Signal | Buffer tag | Counter tag | Actual rate |
|---|---|---|---|
| EEG (4 ch) | `dEEG0~1..4` | `sEEG0` | `GetSFreq()/6` ≈ 1017 Hz |
| Buttons (4 ch) | `dBTTN~1..4` | `sBTTN` | `GetSFreq()/20` ≈ 1221 Hz |

Both counters are continuous monotonic sample counts into a circular buffer
(not resettable per-block). Button values are active-HIGH is backwards in
raw form: **0 = pressed, 1 = released** at the tag level — code that displays
button state typically inverts it (`1 - rawValue`) for a human-readable
"1 = pressed" display. Check `LiveEEGMonitor.m` for the reference
implementation.

### Circular buffer read pattern

Reading a window of the most recent N samples from these circular buffers
needs wraparound handling — this exact pattern appears in
`RunSoundEEGBuffers.m` and `LiveEEGMonitor.m`:

```matlab
counter  = RP.GetTagVal(idxTag);          % total samples written so far
nRead    = min(counter, windowSamples);
startIdx = mod(counter - nRead, bufSize);
if startIdx + nRead <= bufSize
    data = RP.ReadTagV(bufTag, startIdx, nRead);
else
    nTail = bufSize - startIdx;
    tail  = RP.ReadTagV(bufTag, startIdx, nTail);
    head  = RP.ReadTagV(bufTag, 0, nRead - nTail);
    data  = [tail; head];
end
```

Reuse this rather than re-deriving it — it's easy to get the wraparound math
wrong and read garbage or stale samples.

## Diagnose before guessing

When hardware behaves unexpectedly, run the existing diagnostic scripts
before hypothesizing about the MATLAB code — they were built for exactly
this:

| Script | Use when |
|---|---|
| `DiagnoseRA16.m` | RA16/EEG connection, status, or z-switch issues; polls counters/buffers directly, bypasses status-bit check |
| `DiagnoseButtons.m` | Button buffer/counter not incrementing as expected |
| `ListDeviceTags.m` | Need to confirm a tag name/type/size exists on a connected device |
| `InspectRCX.m` | Need to see all tags in a `.rcx` circuit file before it's loaded |
| `ListRPcoMethods.m` | Unsure what COM methods `RPco.X` actually exposes |
| `LiveEEGMonitor.m` | Want a live visual sanity check of EEG + button signal before running a real experiment |
| `ReadEEGSegment.m` | Need to pull one trial's EEG/button segment out of the running circular buffer (baseline→final delta, wraparound-safe) — used by `BehavioralMainEEG.m` |

`OFFLINE` file (empty, in script directory) forces `Circuit_Loader` to return
a `MockRP()` stub for testing without hardware attached.

## Git workflow note for this repo

Tank recording data (`Tanks/`, `Tanks2/`, `*.Tbk/.Tdx/.tev/.tnt/.tsq`) is
binary TDT output and should be committed separately from code changes, in
its own commit — don't mix data drops into a feature commit. When stashing
or popping changes while a MATLAB session is live, expect `mdb.mat` and
`wav_file_mod.wav` to conflict (see Gotcha #3) — check `git diff` on those
two files specifically before resolving, since a real conflict there usually
just means "which snapshot of GUI state do we keep," not a code problem.
