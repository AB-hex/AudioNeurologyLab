# GEMINI.md — Detailed Technical Reference

See `CLAUDE.md` for the concise project overview, architecture, and key constraints.
This file contains detailed specifications, API references, and integration notes.

## MATLAB Offline Analysis Tools

The provided URL[1] contains an overview of MATLAB Offline Analysis Tools from Tucker-Davis Technologies (TDT). These tools are designed for reading and analyzing data from TDT hardware.

Key MATLAB tools described include:
*   **TDTbin2mat**: This function reads TDT data from block files or SEV files into MATLAB. It can filter data by event types, specific data stores (e.g., streaming events like 'Wav1'), channels, and time ranges[1].
*   **TDTfilter**: This tool applies advanced epoch filtering to extracted data. It can filter by time relative to an epoch event, by specific epoch values, or by modifiers to find data when a behavioral response occurs within a time range[1].
*   **SEV2mat**: This function reads SEV files, which contain single-channel data, into a MATLAB structure. `TDTbin2mat` automatically calls `SEV2mat` if SEV files are present[1].
*   **TDTfft**: This tool performs frequency analysis on data streams. It can specify frequency ranges, smooth plots using `NUMAVG`, and display spectrograms[1].
*   **TDTdigitalfilter**: This function mimics hardware digital filters, applying specified filters (e.g., bandpass, notch) to streaming data stores[1].
*   **TDTthresh**: This tool applies thresholding algorithms to continuous data to extract snippets. It supports 'manual' and 'auto' modes for thresholding and can organize snippets by groups of channels (tetrodes)[1].

Sources:
[1] Overview of MATLAB Offline Analysis Tools - Offline Data Analysis ... (https://www.tdt.com/docs/sdk/offline-data-analysis/offline-data-matlab/)

## Additional TDT Documentation

### OpenBridge User Guide
OpenBridge is a utility that facilitates data export and acts as a bridge between TTank data tanks and Plexon's Offline Sorter. It supports exporting data to NEX v100, DDT v103, EDF+ EDF, and PLX v103 file formats. Key functionalities include selecting specific events, sorts, and channels for export, handling large datasets by splitting them into multiple files, and automating the launch of Offline Sorter. It also ensures consistent channel numbering and can import sorted data back into the tank. The guide details the user interface, including the Tank Navigator Panel for selecting tanks and blocks, the Selector Panel for choosing export formats and data, and the Activity Log for tracking operations. It also covers setting export preferences and using batch processing for multiple blocks.[4]

### TDTfft (MATLAB Offline Analysis Tools)
`TDTfft` is a MATLAB function used for performing frequency analysis on data streams. It takes stream data from `TDTbin2mat` and a channel number as input. Users can define the frequency range for analysis using the 'FREQ' parameter. To reduce noise in frequency plots, the 'NUMAVG' input allows for averaging FFTs from multiple data chunks. Additionally, the 'SPECPLOT' option can generate a spectrogram of the data stream, though for very long datasets, it might be necessary to process smaller time segments using `TDTbin2mat`'s 'T1' and 'T2' parameters to manage memory usage.[2]

### TDT Data Types
TDT software stores data in "tanks," which are directories containing "blocks" created during recording sessions. Within these blocks, various "stores" record different types of events. The primary data types are:
*   **Epocs**: Values with onset and offset timestamps, useful for creating time-based filters. These can originate from various gizmos like Epoch Data Storage, Logic, and Stimulation. Runtime Notes are also stored as epocs.
*   **Streams**: Continuous single or multi-channel recordings, typically from Stream Data Storage or Fiber Photometry gizmos, including the data array and sampling rate.
*   **Snips**: Short data segments captured on a trigger, such as action potentials from Spike Sorting or fixed-duration snippets from the Strobe Store gizmo. This data type includes waveforms, channel numbers, sort codes, trigger timestamps, and sampling rate.
*   **Scalars**: Similar to epocs but can be single or multi-channel and only record an onset timestamp when triggered, often from the Strobe Store gizmo.
Each data structure also contains an `info` field with details like block start/stop times, duration, and experiment metadata. The document also mentions `TankManager.exe` for merging and splitting blocks.[3]

Sources:
[4] OpenBridge User Guide - Offline Data Analysis Tools (https://www.tdt.com/docs/sdk/offline-data-analysis/openbridge/)
[2] Overview of MATLAB Offline Analysis Tools - Offline Data Analysis ... (https://www.tdt.com/docs/sdk/offline-data-analysis/offline-data-matlab/#tdtfft)
[3] TDT Data Storage - Offline Data Analysis Tools (https://www.tdt.com/docs/sdk/offline-data-analysis/tdt-data-storage/#tdt-data-types)

## TTankX ActiveX Control Methods

Below is a list of methods available for the `COM.TTank_X` ActiveX object in MATLAB.

```
AboutBox               GetCodeSpecs           GetTankItem            ResetFilters           StartRecord
AddClient              GetCodeSpecsLazy       GetValidTimeRanges     ResetGlobals           StopRecord
AddServer              GetDebug               GetValidTimeRangesV    ResetTank              StringToEvCode
AddTank                GetEnumServer          IndexEvent             SaveSortCodes          SwitchClient
AppendNote             GetEnumTank            InitializeTank         SelectBlock            TTank_X
BuildEpocEv            GetEpocCode            OpenTank               SetBuildHead           ToTTD
BuildFilterDesc        GetEpocs               ParseEv                SetEpocTimeFilter      WriteEvents
BuildScalar            GetEpocsEx             ParseEvInfoV           SetEpocTimeFilterB     addproperty
BuildSnipEv            GetEpocsExV            ParseEvV               SetEpocTimeFilterV     delete
BuildSnipEvV           GetEpocsV              ParseFilterDesc        SetFilter              deleteproperty
BuildStreamEv          GetError               QryEpocAt              SetFilterArray         eventlisteners
BuildStreamEvV         GetEvTsqIdx            QryEpocAtV             SetFilterTolerance     events
CheckTank              GetEventCodes          QueryBlockName         SetFilterWithDesc      get
ClearEpocIndexing      GetFilterTolerance     ReadEvents             SetFilterWithDescEx    interfaces
CloseTank              GetGlobal              ReadEventsSimple       SetGlobal              invoke
CodeToString           GetGlobalB             ReadEventsV            SetGlobalB             isevent
ConnectServer          GetGlobalStringB       ReadWaves              SetGlobalStringB       load
CreateEpocIndexing     GetGlobalStringV       ReadWavesOnTimeRange   SetGlobalStringV       move
DFromToString          GetGlobalV             ReadWavesOnTimeRangeB  SetGlobalV             propedit
DeleteClient           GetHotBlock            ReadWavesOnTimeRangeV  SetGlobals             registerevent
DeleteSortCode         GetNPer                ReadWavesV             SetGlobalsB            release
DisableTankDebug       GetNote                ReleaseServer          SetNoteIndex           save
EnableTankDebug        GetServerItem          RemoveBlock            SetRefEpoc             send
EvTypeToString         GetSortChanMap         RemoveEvents           SetRefEpocB            set
FancyTime              GetSortCondition       RemoveServer           SetRefEpocV            unregisterallevents
FromTTD                GetSortName            RemoveTank             SetRefTime             unregisterevent
GetClientID            GetStatus              ReplaceNote            SetUseSortName
```

## Configuration Structure (mdb.mat)

The `mdb.mat` file contains a structure named `mdb` (Master Database) that serves as the central configuration state for the experiment. It bridges the MATLAB GUI and the TDT hardware.

### Structure Overview

*   **Signal Channels (`TX1`, `TX2`, `TX3`)**: Independent signal generators.
    *   **`transducer`**: Routes audio to specific outputs.
        *   `DacVector`: Boolean array (1-18) mapping to physical speakers.
        *   `source`: Output type (e.g., 'FF' for Free Field speakers).
    *   **`stimulus`**: Defines the audio content.
        *   `stimulusSelect`: Boolean flags for `speech`, `noise`, `pureTone`.
        *   `speech`: Contains `source` (path to .wav), `amp` (dB), and `phase`.
        *   `burstDuration`: Duration of the stimulus in seconds. Essential for determining playback mode (0 = Continuous, >0 = Single Shot).
        *   `noise` / `PT`: Parameters for synthetic sounds (Freq, Amp, Modulation).
*   **Master Control (`master`)**:
    *   `TX1_select`, `TX2_select`, `TX3_select`: Global enable/disable switches for channels.
    *   `TX_playMode`: Playback mode (1 = Single Shot, 0 = Continuous).
*   **Calibration (`Calibration`)**:
    *   `FF2SpeakerMap`: Maps logical channels (1-8) to physical hardware ports.
    *   `GainTable`: Frequency-dependent gain adjustments for flat response.
    *   `reference`: Baseline dB level (e.g., 70).
*   **Behavioral Logic (`behavioral`)**:
    *   `folderPath`: Directory containing stimulus (word) files.
    *   `noiseFilePath`: Path to a custom noise audio file.
    *   `patient`: Participant metadata.
    *   `output`: Results directory.
```json
{
  "TX1": {
    "transducer": {
      "FF": {
        "DacVector": [
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ]
      },
      "source": "FF",
      "AC": {
        "outputVector": [
          0,
          0
        ]
      },
      "BC": {
        "outputVector": [
          0,
          0
        ]
      }
    },
    "stimulus": {
      "stimulusSelect": {
        "noise": 0,
        "pureTone": 0,
        "speech": 1
      },
      "PT": {
        "modulationType": 3,
        "amp": 35,
        "freq": 1000,
        "modDepth": 100,
        "modFreq": 10,
        "modIndex": 1,
        "phase": 0
      },
      "speech": {
        "amp": 60,
        "phase": 0,
        "source": "",
        "file": "C:\\Users\\Lab\\Documents\\CVC Words\\Testing\\31 - אגרוף.wav",
        "file_ext": ".wav"
      },
      "burstDuration": 0,
      "noise": {
        "NBCntrFrq": 1000,
        "NBBW": 100,
        "amp": 30,
        "source": 1,
        "phase": 0,
        "fileName": 0
      },
      "onset": 0,
      "offset": 0
    }
  },
  "main": {
    "transducer": {
      "newSource": "NULL",
      "BC": {
        "newOutputVector": [
          0,
          0
        ]
      },
      "AC": {
        "newOutputVector": [
          0,
          0
        ]
      },
      "FF": {
        "newDacVector": [
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ]
      }
    }
  },
  "TX2": {
    "transducer": {
      "source": "FF",
      "FF": {
        "DacVector": [
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ]
      },
      "AC": {
        "outputVector": 0
      },
      "BC": {
        "outputVector": 0
      }
    },
    "stimulus": {
      "burstDuration": 0,
      "noise": {
        "source": 1,
        "NBCntrFrq": 1000,
        "NBBW": 100,
        "amp": 30,
        "phase": 0,
        "fileName": 0
      },
      "stimulusSelect": {
        "noise": 0,
        "speech": 0,
        "pureTone": 0
      },
      "PT": {
        "modDepth": 100,
        "modIndex": 1,
        "modulationType": 3,
        "modFreq": 10,
        "amp": 35,
        "freq": 1000,
        "phase": 0
      },
      "speech": {
        "amp": 30,
        "phase": 0,
        "source": ""
      },
      "onset": 0,
      "offset": 0
    }
  },
  "TX3": {
    "transducer": {
      "source": "FF",
      "FF": {
        "DacVector": [
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ]
      },
      "AC": {
        "outputVector": 0
      },
      "BC": {
        "outputVector": 0
      }
    },
    "stimulus": {
      "burstDuration": 0,
      "noise": {
        "source": 1,
        "NBCntrFrq": 1000,
        "NBBW": 100,
        "amp": 30,
        "phase": 0,
        "fileName": 0
      },
      "stimulusSelect": {
        "noise": 0,
        "speech": 0,
        "pureTone": 0
      },
      "PT": {
        "modDepth": 100,
        "modIndex": 1,
        "modulationType": 3,
        "modFreq": 10,
        "amp": 35,
        "freq": 1000,
        "phase": 0
      },
      "speech": {
        "amp": 30,
        "phase": 0,
        "source": ""
      },
      "onset": 0,
      "offset": 0
    }
  },
  "master": {
    "TX1_select": 1,
    "TX2_select": 0,
    "TX3_select": 0,
    "TX1_playMode": 1,
    "TX2_playMode": 1,
    "TX3_playMode": 1
  },
  "Calibration": {
    "SpeakersGain": [
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1
    ],
    "FF2SpeakerMap": [
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18
    ],
    "GainTable": [
      {
        "x250Hz": 12,
        "x500Hz": 13,
        "x1000Hz": 1,
        "x2000Hz": 1,
        "x4000Hz": 1,
        "Noise": 2
      },
      {
        "x250Hz": 13,
        "x500Hz": 14,
        "x1000Hz": 4,
        "x2000Hz": 2,
        "x4000Hz": -2,
        "Noise": 1
      },
      {
        "x250Hz": 17,
        "x500Hz": 20,
        "x1000Hz": 1,
        "x2000Hz": -1,
        "x4000Hz": 2,
        "Noise": 1
      },
      {
        "x250Hz": 17,
        "x500Hz": 9,
        "x1000Hz": 9,
        "x2000Hz": 2,
        "x4000Hz": 1,
        "Noise": 6
      },
      {
        "x250Hz": 1,
        "x500Hz": 1,
        "x1000Hz": 1,
        "x2000Hz": 1,
        "x4000Hz": 1,
        "Noise": 1
      },
      {
        "x250Hz": 23,
        "x500Hz": 8,
        "x1000Hz": 5,
        "x2000Hz": 12,
        "x4000Hz": 12,
        "Noise": 6
      },
      {
        "x250Hz": 15,
        "x500Hz": 13,
        "x1000Hz": 3,
        "x2000Hz": 1,
        "x4000Hz": 6,
        "Noise": 4
      },
      {
        "x250Hz": 13,
        "x500Hz": 14,
        "x1000Hz": 5,
        "x2000Hz": 3,
        "x4000Hz": 1,
        "Noise": 3
      },
      {
        "x250Hz": 1,
        "x500Hz": 1,
        "x1000Hz": 1,
        "x2000Hz": 1,
        "x4000Hz": 1,
        "Noise": 1
      },
      {
        "x250Hz": 7,
        "x500Hz": 7,
        "x1000Hz": 8,
        "x2000Hz": 1,
        "x4000Hz": 1,
        "Noise": 4
      },
      {
        "x250Hz": 12,
        "x500Hz": 5,
        "x1000Hz": 1,
        "x2000Hz": 2,
        "x4000Hz": 1,
        "Noise": 1
      },
      {
        "x250Hz": 8,
        "x500Hz": 5,
        "x1000Hz": -2,
        "x2000Hz": -2,
        "x4000Hz": 2,
        "Noise": 2
      },
      {
        "x250Hz": 14,
        "x500Hz": 3,
        "x1000Hz": -1,
        "x2000Hz": 1,
        "x4000Hz": 3,
        "Noise": 1
      },
      {
        "x250Hz": 18,
        "x500Hz": 10,
        "x1000Hz": 1,
        "x2000Hz": 1,
        "x4000Hz": 3,
        "Noise": 5
      },
      {
        "x250Hz": 11,
        "x500Hz": 5,
        "x1000Hz": 2,
        "x2000Hz": 1,
        "x4000Hz": 1,
        "Noise": 3
      },
      {
        "x250Hz": 8,
        "x500Hz": 5,
        "x1000Hz": 1,
        "x2000Hz": 3,
        "x4000Hz": 12,
        "Noise": 3
      },
      {
        "x250Hz": 12,
        "x500Hz": 5,
        "x1000Hz": 4,
        "x2000Hz": 5,
        "x4000Hz": 1,
        "Noise": 4
      },
      {
        "x250Hz": 15,
        "x500Hz": 6,
        "x1000Hz": 4,
        "x2000Hz": 4,
        "x4000Hz": 8,
        "Noise": 8
      }
    ],
    "reference": 70
  },
  "behavioral": {
    "mode": "Baseline - quite",
    "interactive": false,
    "folderPath": "C:\\Users\\Lab\\Documents\\CVC Words\\Testing",
    "patient": {
      "name": "A",
      "age": "a",
      "gender": "A",
      "ear": "a",
      "testName": "a"
    },
    "output": {
      "folder": "C:\\Users\\Lab\\Documents",
      "fileName": "A"
    }
  }
}
```
### The GUI
  In MATLAB App Designer applications like TDT_GUI_v3_App (`TDT_GUI_v3_App.mlapp`), the GUI serves as the interface for the user to define the experiment's parameters. However, the actual experiment logic often runs in separate scripts or functions (e.g.,
  BehavioralMain.m, PrepareBehavioralMdb.m) that do not have direct access to the app object.

  Therefore, Parsing is the critical bridge between the UI and the backend logic.

   1. State Synchronization (`mdb` Structure): Parsing ensures that the values the user sees and sets on the screen (like dB levels or file paths) are accurately updated in
      mdb before the experiment starts. If this step fails, the experiment might run with stale or default data.
   2. Hardware Control: Variables such as SNRSignalOutput directly map to hardware channels (TDT bitmasks). Incorrect parsing here can lead to sounds playing from the wrong speakers or hardware silence.
   3. Data Integrity: Metadata fields (Name, Age, Test Name) determine how and where data is saved. accurate parsing prevents data overwrites or unidentifiable result files.
   4. Dynamic Flow: Settings like ModesDropDown_Behavioral change the logic path (e.g., switching between "Baseline" and "Noise"). The parsing logic must capture this state to decide which functions to call.

  ---
Example from Behaviorual Tab
If the user clicks Start on Behaviorual Tab, which will call the callback: StartButton_BehavioralPushed
  Based on TDT_GUI_v3_App_exported.m, here are the components belonging to the Behavioral Tab, categorized by their function.

  1. User Input (Text & Numbers)
  These fields require validation/parsing to ensure data types (string vs double) are correct for the `mdb` structure.
   * NameEditField_Behavioral (Subject Name)
   * AgeEditField_Behavioral (Subject Age)
   * GenderEditField_Behavioral (Subject Gender)
   * TestNameEditField_Behavioral (Experiment Identifier)
   * EarEditField_Behavioral (Target Ear)
   * SignaldBEditField_Behavioral (Signal Level in dB)
   * NoisedBEditField_2 (Noise Level in dB - visible only in specific modes)
   * NameoffolderEditField_Behavioral (Output folder name)

  2. User Input (Selection, Boolean & Configuration)
  These control logic flow and hardware routing.
   * Mode Selection:
       * ModesDropDown_Behavioral (Selects between 'Baseline - quite' or 'Noise - 0 or 90')
       * CheckBox_Behavioral ('Stop after each word')
   * Signal Output Routing (Checkbox Array):
       * SNRSignalOutput1_Behavioral through SNRSignalOutput8_Behavioral
   * Noise Output Routing (Checkbox Array):
       * SNRNoiseOutput1_2 through SNRNoiseOutput8_2 (Visible in Noise mode)

  3. Action Buttons
  Triggers that initiate parsing or file dialogs.
   * StartButton_Behavioral (Triggers PrepareBehavioralMdb and starts BehavioralMain)
   * ChooseFolderButton_Behavioral (Selects input words directory)
   * ChooseFolderButton_Behavioral_2 (Selects noise source file)
   * CUsersLabDocumentsButton_Behavioral (Selects output root directory)

  4. Layout & Containers
  Structural elements that hold the specific controls.
   * BehaviorualTab (The main tab)
   * Panel_Behavioral (Main container panel)
   * SignalOutputSelectionPanel_Behavioral (Groups signal routing checkboxes)
   * NoiseOutputSelectionPanel_2 (Groups noise routing checkboxes)
   * OutputPortsFFPanel_4 (Visual reference for ports)

  5. Static Labels (Display Only)
  Generally do not need parsing, but provide context.
   * BehavioralShadenLabel, Behavioral_description
   * PersonalDetailsLabel_Behavioral
   * StartingConditionsLabel_2, OutputSettingsLabel_Behavioral
   * ModesDropDownLabel
   * Field Labels: NameEditField_3Label, AgeEditField_3Label, SignaldBEditField_2Label, etc.          
        
---

## OpenWorkbench + EEG Integration (RunSoundEEGTanks)

This section documents everything learned during debugging of the OpenWorkbench/TTank EEG pipeline.

### Hardware Devices (as seen by OpenWorkbench)

When OpenWorkbench is running with `WorkBench.xpm`, three devices are enumerated:

| Name | Type | Role |
|---|---|---|
| `RA16_1` | RA16 Medusa Base Station | 32-ch EEG recording |
| `RX8_1` | RX8 | Sound stimulus playback |
| `PA5_1` | PA5 | Programmable attenuator |

All three are managed by OpenWorkbench. **Never use `Circuit_Loader` while Workbench is running** — it calls `ConnectRX8('GB', 1)` + `ClearCOF` + `LoadCOF` which destroys the Workbench recording session and forces it back to Idle.

### Available Tags Per Device

**RA16_1 (EEG):**
- `dEEG0~1` … `dEEG0~4` — EEG data buffers [30528 samples, 4 channels]
- `sEEG0` — EEG TTank store name → use `'EEG0'` in `ReadWavesV`
- `dTick/`, `tTick/`, `sTick/` — timing stores

**RX8_1 (Sound):**
- `datain1`, `datain2`, `datain3` — sound input buffers [3,000,000 samples]
- `BufSize1`, `BufSize2`, `BufSize3` — buffer size tags
- `single1`, `single2`, `single3` — single-shot playback triggers (set 1 to fire, reset to 0)
- `cont1`, `cont2`, `cont3` — continuous playback mode triggers
- `en_ch1_dac1` … `en_ch3_dac18` — per-channel/DAC enable flags
- `gain_ch1_dac1` … `gain_ch3_dac18` — per-channel/DAC gain

**PA5_1 (Attenuator):**
- `Atten` — attenuation level in dB

### Correct Connection Pattern

Use TDT's own **TDEV wrapper class** (`C:\TDT\TDTMatlabSDK\TDTSDK\OpenExLive\TDEV.m`) instead of raw `TDevAcc.X`. Raw `TDevAcc.X` calls `SetSysMode` before hardware is enumerated and always returns 0 (rejected). TDEV's constructor loops on `GetDeviceName(0)` until a real device is returned before allowing any mode changes.

```matlab
addpath('C:\TDT\TDTMatlabSDK\TDTSDK\OpenExLive');
td = TDEV();               % connects and enumerates devices
td.standby();              % mode 1
td.record();               % mode 3
td.idle();                 % mode 0
```

**OpenWorkbench must already be open and idle before calling TDEV().** Auto-launching Workbench from MATLAB and immediately calling SetSysMode fails because WorkEngine hasn't finished loading the project hardware.

### Writing to Hardware via TDevAcc (No Circuit_Loader)

```matlab
% Write sound buffer to RX8_1
td.TD.SetTargetVal('RX8_1.BufSize1', length(soundSignal));
td.TD.WriteTargetVEX('RX8_1.datain1', 0, 'F32', soundSignal(:)');

% Fire single-shot trigger
td.TD.SetTargetVal('RX8_1.single1', 1);
pause(duration);
td.TD.SetTargetVal('RX8_1.single1', 0);

% Get EEG sample rate
fs = td.TD.GetDeviceSF('RA16_1');
```

### TTank Connection and Block Name

TTank must open the tank **before** calling `GetHotBlock()`, otherwise `CurBlockName` is empty and `GetHotBlock()` returns `''`.

```matlab
TT = actxserver('TTank.X');
TT.ConnectServer('Local', 'Me');
TT.OpenTank(tankPath, 'R');   % must be before GetHotBlock
pause(0.5);                    % give WorkEngine time to register block
blockName = TT.GetHotBlock();
```

The correct TTank **EEG store ID is `'EEG0'`** (not `'EEG1'`). Using the wrong store causes `ReadWavesV` to return `NaN`.

```matlab
TT.SelectBlock(['~' blockName]);
TT.SetGlobalV('Channel', 0);
TT.SetGlobalStringV('Options', 'ALL');
eegData = TT.ReadWavesV('EEG0');   % [samples x 4 channels]
```

### Mode Transition Rules

- Valid modes: `0=Idle`, `1=Standby`, `2=Preview`, `3=Record/Run`
- Always go `Idle → Standby → Record` (never skip Standby)
- Always go `Record → Idle` to stop (TDEV's `idle()` handles this)
- `SetTankName` must be called while in Idle or Standby (not during Record)
- `SetSysMode` returning `0` means rejected — most common cause is no device enumerated yet

### Button Box (4-Button Response Box on RX8_1)

The 4-button response box is connected to the RX8 and configured in the XPM project. Its data is recorded automatically alongside EEG.

**TTank store ID: `'BTTN'`** (derived from `sBTTN` tag on RX8_1)

**Tags on RX8_1:**
- `dBTTN~1` … `dBTTN~4` — one data buffer per button [36608 samples]
- `sBTTN` — TTank store name

**Reading from tank:**
```matlab
TT.SetGlobalV('Channel', 0);
TT.SetGlobalStringV('Options', 'ALL');
btnData = TT.ReadWavesV('BTTN');   % [samples x 4], one column per button
btnSampleRate = td.TD.GetDeviceSF('RX8_1');
```

Button values are 0 (released) or 1 (pressed). Sample rate comes from the RX8 (`GetDeviceSF('RX8_1')`), not the RA16.

### Key Files

| File | Role |
|---|---|
| `C:\TDT\TDTMatlabSDK\TDTSDK\OpenExLive\TDEV.m` | TDT's official TDevAcc wrapper — use this instead of raw ActiveX |
| `C:\Users\Lab\Downloads\Alon2\WorkBench.xpm` | OpenWorkbench project file — open manually before running scripts |
| `RunSoundEEGTanks.m` | Full EEG recording session via Workbench (no Circuit_Loader) |
| `ListDeviceTags.m` | Lists all TDevAcc tags per device to `Desktop\tags_output.txt` |

---

### Experiment Workflow
0.  *The user clicks start*: On the proper callback function, all the related variables of the same tab needs to be parsed logic
1.  **Preparation**: GUI updates `mdb` with user settings (e.g., patient info, start levels) and saves `mdb.mat`.
    * We load the mdb file `load mdb`
    * We also need to reset the mdb state: `Initialize_Selection('TX1`) for all the TX1-TX3. (This saves a new clean mdb files) don't forget to load it again after calling the function.
    * We synchronize with the GUI realted app variables with the proper mdb state. 
    * **Validation**: When creating or modifying MATLAB scripts, always run `checkcode('filename.m')` to verify syntax and potential errors before execution.
2.  **Loop**: Experiment script (e.g., `BehavioralMain.m`, `SNRFinderHelper.m`) iterates through trials.
    *   **Speech (TX1)**: Updates `mdb.TX1.stimulus.speech.source=filePath` with the current word path.
        * **Duration**: also update the duration of the signal: `mdb.TX1.stimulus.burstDuration = audio_info.Duration`
    *   **Noise (TX2)**: 
        *   If a custom noise file is provided, TX2 is switched to `speech` mode (`stimulusSelect.speech = 1`, `noise = 0`) and `mdb.TX2.stimulus.speech.source` is set to the noise file path.
        *   The amplitude is set from the GUI's noise level setting.
        *   Also we need to set the duration so that it will wait the proper time `mdb.TX2.stimulus.burstDuration = audio_info.Duration`
    *   **Synchronization**: `burstDuration` is updated across all active channels to match the primary stimulus duration, ensuring consistent 'Single' playback mode.
    *   Saves `mdb.mat`.
3.  **Signal Creation**: `play_signal_multi.m` loads `mdb.mat`.
    *   Calls `TX1_create_signal.m` (and TX2/TX3 versions).
    *   These functions read the `source` path and `amp` from `mdb` to generate digital samples.
4.  **Hardware Interaction**: `play_signal_multi.m` uploads samples and speaker selection (`DacVector`) to the TDT hardware via ActiveX.
5.  **Trigger**: System triggers playback and waits for duration.
