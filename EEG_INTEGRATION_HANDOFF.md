# EEG + Button Integration — Handoff

Status as of this session: acoustic stimuli play, EEG hardware connects, and
per-word EEG segments are being created and saved during a `'quite - EEG'`
run. A live-view performance bug was fixed but the fix has not yet been
soak-tested through a full multi-word session — see "Not yet verified".

## What this feature does

Selecting `'quite - EEG'` or `'Noise - 0 or 90 - EEG'` in the Behavioral
tab's Modes dropdown and pressing Start now:
1. Plays each word exactly as the normal behavioral flow does
   (`play_signal_multi.m`, unchanged).
2. Captures that trial's EEG (4 ch) + button (4 ch) segment by reading the
   RA16/RX8 sample counters immediately before and after the trial window,
   and pulling exactly that span out of the circular buffers.
3. Saves one `.mat` file per word to `<output folder>/EEGSegments/`.
4. Shows a live scrolling EEG + button monitor window for the whole session.
5. Writes the usual per-trial CSV log and end-of-session Excel report.

## Architecture — direct RPco.X, no OpenWorkbench

An earlier version of this went through OpenWorkbench + a `TDEVProxy`
wrapper class + TTank block reads. **That was fully replaced** this session
per explicit direction — the current architecture talks to both TDT devices
directly:

- `TDT_GUI_v3_App_exported.m` → `startupFcn`: connects `global RP` to RX8_1
  via the plain `Circuit_Loader(path)` (unchanged from the original
  behavioral-only flow), then separately connects `global RP_EEG` to RA16_1
  directly (`actxcontrol` + `ConnectRA16('GB',1)` + `MedusaBaseStation.rcx`).
  The RA16 connection is **non-fatal** — if it fails (RA16 unpowered/not
  connected), a `warning` is issued and `RP_EEG` stays empty; plain
  behavioral/SNR-finder sessions are unaffected either way.
- `BehavioralMainEEG.m`: per word, captures `sEEG0`/`sBTTN` baseline, plays
  the stimulus via unmodified `play_signal_multi.m` (fires on `RP`, exactly
  like the non-EEG path), captures the final counters, and reads the exact
  `[baseline, final)` span via `ReadEEGSegment.m`.
- `ReadEEGSegment.m` (new): reusable wraparound-safe circular-buffer read,
  parameterized by explicit `[startIdx, endIdx)` rather than "last N ending
  now" — this generalizes to both the per-trial delta read *and* the live
  monitor's "last 5 seconds" read (call it with
  `startIdx = counter - windowSamples`).
- `Circuit_Loader.m`: reverted to the plain `(connectionType, deviceNumber,
  circuitPath)` / `(circuitPath)` forms only — no `mode` argument, no `'eeg'`
  branch. `TDEVProxy.m` is deleted; nothing references it anymore.

## Live monitor window (inside `BehavioralMainEEG.m`)

Two bugs were found and fixed while building this — both worth knowing
about if the live view ever misbehaves again:

1. **Timer-based refresh corrupted the RX8 COM connection.** First attempt
   used a MATLAB `timer` object ticking independently in the background.
   TDT's RPco.X ActiveX object is not safe for that kind of reentrant call —
   the live view froze at the exact moment `play_signal_multi` fired
   `SoftTrg`, because the timer's `RP.GetTagVal('sBTTN')` call landed mid
   buffer-write on the same COM object. **Fixed by removing the timer
   entirely** — all `RP`/`RP_EEG` calls now happen sequentially on the main
   thread only, via a `waitAndUpdate(waitSeconds)` polling loop plus explicit
   `updateLivePlot()` calls bookending `play_signal_multi`.

2. **Un-throttled polling overloaded the ActiveX channel.** The first
   version of `waitAndUpdate` called the expensive `updateLivePlot()` (up to
   16 `ReadTagV` COM calls per invocation, reading up to a 5-second window)
   on every 20ms tick — 50×/sec. `LiveEEGMonitor.m` (the proven reference
   implementation) only does this real work once every ~100ms, using a cheap
   20ms tick just for wait-timing responsiveness. The un-throttled version
   caused a progressive backlog that looked like the live view "running for
   a few seconds, then freezing." **Fixed by adding the same
   `UPDATE_INTERVAL = 0.1` throttle** `LiveEEGMonitor.m` already uses.

Note throughout both bugs: the actual EEG **recording** (the per-trial
baseline→final save path) was never affected — it only does two quick
`GetTagVal` calls at trial boundaries, completely separate from the live
view's heavier windowed reads. Segments kept saving correctly even while the
display was broken.

## Files touched this session

| File | Change |
|---|---|
| `ReadEEGSegment.m` | **New.** Wraparound-safe circular buffer segment read. |
| `BehavioralMainEEG.m` | Rewritten: direct RPco.X (no Workbench/TDEVProxy), per-trial delta capture, live monitor window. |
| `Circuit_Loader.m` | Reverted to plain form — no `mode` argument. |
| `TDEVProxy.m` | **Deleted** — unused after the Workbench path was replaced. |
| `TDT_GUI_v3_App_exported.m` | `startupFcn`: direct RX8+RA16 connect, no Workbench launch. `ModesDropDown_BehavioralValueChanged`: noise controls now also show for the EEG+noise mode. |
| `TDT_GUI_v3_App.mlapp` | Re-synced from App Designer so its embedded code matches the above (see note below). |
| `DiagnoseRA16AutoStop.m` | New diagnostic (not part of the app) — confirmed the RA16's z-switch auto-stop mechanism is inert for this direct connection (see Verified section). |

## `.mlapp` / `_exported.m` sync discipline

**Important for whoever touches the GUI next:** `TDT_GUI_v3_App.mlapp` is
the authoritative source; `TDT_GUI_v3_App_exported.m` is a generated
artifact. Editing the `_exported.m` file directly does **not** persist —
the next time someone opens the `.mlapp` in App Designer and saves, it will
silently regenerate `_exported.m` from whatever is embedded in the
`.mlapp`, discarding any out-of-band edits to the `.m` file. This actually
happened once this session (a Workbench-launch block was resurrected this
way). Any future GUI callback change must be made inside App Designer's
Code View, not by editing `TDT_GUI_v3_App_exported.m` directly.

## Verified this session

- `DiagnoseRA16AutoStop.m` (25s poll, `zSwPeriod` left untouched): `sEEG0`
  never stalled or reset; `zSwCount`/`zSwNum`/`zSwDone` never changed at
  all (the z-switch auto-stop never fired). A separate, unrelated status
  bit (bit 7) flips briefly every ~5.3s but does not affect `sEEG0` or the
  connected/loaded/running bits — confirmed benign.
- Live GUI test: `'quite - EEG'` mode connects RA16 without Workbench,
  plays words, and creates one `EEGSegments/<trialId>.mat` per word.
- RA16 `GetStatus` bit 1 is a real, trustworthy connected-flag (see project
  skill `tdt-matlab-hardware`, Gotcha #1) — a `status=70` earlier this
  session was a genuine power/cable issue, not a driver quirk.

## Not yet verified / open items

- The 10Hz-throttle fix for the live view (last change made) has **not**
  been confirmed fixed by the user yet through a full multi-word session —
  re-test before considering this closed.
- No hardware-in-the-loop confirmation yet that a *long* word list (many
  trials, session spanning multiple RA16 buffer wraparounds) reads back
  correct, non-overlapping segments per trial.
- `startupFcn`'s non-fatal RA16 connect has not been explicitly re-tested
  with the RA16 unplugged to confirm plain (non-EEG) behavioral/SNR-finder
  sessions are unaffected.
- No live MATLAB session was available to this assistant all session for
  `mcp__matlab__check_matlab_code` static checking — all verification was
  manual code review plus the user's own hardware testing.

## Reference

See the project skill `.claude/skills/tdt-matlab-hardware/SKILL.md` for the
underlying hardware gotchas (status bits, `global RP`/`RP_EEG` model,
mdb.mat discipline, circular buffer read pattern) this work relies on.
