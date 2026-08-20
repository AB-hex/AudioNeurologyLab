# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Full-stack MATLAB platform for spatial hearing research at Haifa University's Audio Neurology Lab. Drives TDT (Tucker-Davis Technologies) RX8 hardware for multi-channel audio stimulus delivery across 18 speakers, with simultaneous Medusa 32-channel EEG recording via OpenWorkbench.

## Running the System

```matlab
% Launch the GUI
TDT_GUI_v3_App

% Sound-only (behavioral experiments — no EEG)
RP = Circuit_Loader('GB', 1, 'Copy_of_full_5.rcx');

% EEG recording — use RunSoundEEGTanks (never Circuit_Loader for EEG)
% OpenWorkbench must be open first with WorkBench.xpm
RunSoundEEGTanks(soundSignal, circuitPath, tankPath)
```

Offline (no hardware): place a file named `OFFLINE` in the script directory — `Circuit_Loader` returns a `MockRP()` stub.

Sampling rate is fixed at **24414.0625 Hz** (TDT hardware constant).

## Architecture

```
GUI (TDT_GUI_v3_App_exported.m)
  └─ PrepareBehavioralMdb.m / PrepareMdb.m  → writes mdb.mat
       └─ BehavioralMain.m / SNRFinderHelper.m / SpatialHearingTestHelper.m
            └─ TX1/TX2/TX3_create_signal.m  (gen_sig, gen_noise, gen_wav)
                 └─ play_signal_multi.m
                      └─ Circuit_Loader.m → RX8 ActiveX (SetTagVal / WriteTagV / SoftTrg)

EEG path (separate from above):
  OpenWorkbench (WorkBench.xpm) — manages RA16_1 + RX8_1 + PA5_1
       └─ RunSoundEEGTanks.m → TDEV (TDevAcc) + TTank.X
```

## `mdb.mat` — Master Database

Central state shared between every layer. Must be loaded at top and saved at bottom of any routine that modifies it. Missing `save mdb mdb` causes silent state loss.

```matlab
mdb.TX1.transducer.FF.DacVector  % [1×18] speaker-selection bitmask
mdb.TX1.stimulus.stimulusSelect  % {speech, noise, pureTone} boolean flags
mdb.TX1.stimulus.speech.source   % path to .wav file
mdb.TX1.stimulus.speech.amp      % dB level
mdb.TX1.stimulus.burstDuration   % 0 = continuous, >0 = single-shot (seconds)
mdb.TX2 / mdb.TX3                % same structure (noise/masker, optional 3rd ch)
mdb.master.TX1_select            % enable/disable channel
mdb.master.TX1_playMode          % 0 = continuous, 1 = single
mdb.Calibration.FF2SpeakerMap    % [1×8] logical → physical DAC mapping
mdb.Calibration.GainTable        % [18 structs] frequency-dependent gains per speaker
mdb.behavioral.mode              % 'Baseline - quite' | 'Noise - 0 or 90'
mdb.behavioral.folderPath        % directory of numbered .wav word files
mdb.behavioral.patient           % {name, age, gender, ear, testName}
mdb.behavioral.output            % {folder, fileName}
```

## Experiment Workflows

### Behavioral (BehavioralMain.m)
Words are `.wav` files numbered `01 - word.wav`, `02 - word.wav`, … in `mdb.behavioral.folderPath`. For each word:
1. TX1 ← word file + duration
2. TX2 ← noise (white by default; or segment of custom `.wav` trimmed to match word length)
3. `play_signal_multi(TX1, TX2, TX3)` triggers playback
4. Waits for duration + 0.2 s
5. If `mdb.behavioral.interactive`: prompts Pass/Fail
6. Saves Excel report on completion

### SNR Finder (SNRFinderHelper.m)
Adaptive staircase (starts at 2-word blocks, then 6-word blocks). Increases noise on >50% success, decreases on <50%, saves SNR threshold to Excel when converged.

### EEG Recording (RunSoundEEGTanks.m)
Uses OpenWorkbench + TDEV class — **do not use Circuit_Loader for EEG**. See `GEMINI.md § OpenWorkbench + EEG Integration` for full device/tag/API reference.

```matlab
% Requires OpenWorkbench open with WorkBench.xpm
[eegData, fs, btnData] = RunSoundEEGTanks(soundSignal, circuitPath, tankPath);
```

### EEG Buffer-only (RunSoundEEGBuffers.m)
No OpenWorkbench needed. Reads directly from RX8 RAM buffers. Saves `.mat` files with auto Block-N naming.

```matlab
[eegData, fs] = RunSoundEEGBuffers(soundSignal, circuitPath, saveDir);
```

## Hardware Playback API (Circuit_Loader / behavioral path only)

`SoftTrg(N)` sends trigger N (1–10) to the RX8. Different N values activate different TX channel combinations — see `play_signal_multi.m` for the mapping.

```matlab
RP.SetTagVal('tagName', value)   % set scalar parameter on RX8
RP.WriteTagV('tagName', 0, vec)  % write sample buffer to RX8
RP.SoftTrg(N)                    % fire trigger N
RP.ReadTagV('tagName', 0, N)     % read N samples from RX8 RAM
```

## Key Constraints

- **DacVector indices 1–8** = logical speakers (mapped through `FF2SpeakerMap`); indices 9–18 are direct physical outputs.
- **burstDuration = 0** means continuous streaming; any positive value creates a single-shot burst of exactly that many seconds.
- Noise source field `mdb.TX*.stimulus.noise.source`: `1` = white noise, `2` = narrow-band, `3` = load from file.
- Custom noise `.wav` is trimmed/looped to match word duration, saved to a temp file per trial, then deleted.
- **Never call `Circuit_Loader` while OpenWorkbench is running** — it clears the RX8 COF and destroys the Workbench recording session.

## Documentation Files

| File | Content |
|---|---|
| `GEMINI.md` | Detailed reference: mdb spec, GUI flow, OpenWorkbench/EEG integration, device tags |
| `RPvdsExGuidelines.md` | Rules for editing `.rcx` circuit files in RPvdsEx |
| `TTank_guidelines.md` | TTank/OpenEx database integration, store IDs, block parsing |
| `TDTHelp/` | TDT SDK PDF manuals |
