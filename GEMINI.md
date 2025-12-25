# Project Context

This is the main project context. Always refer to the following documents for technical specifications and guidelines.

## Key Documents:

 This document is an ActiveX reference manual for Tucker-Davis Technologies (TDT) hardware. It provides a guide for using ActiveX controls to interface with TDT devices from common programming languages such as
 MATLAB, Visual Basic, and Visual C++. The manual covers the RPcoX real-time processor control, PA5 programmable attenuator, and zBUS device control, including methods for device connection, program control, and
 data manipulation.
 <!-- Import failed: C:\Users\Lab\Desktop\TDT_multiChannelv4 - Path traversal attempt --> with EEG Integration\TDTHelp\ActiveX_User_Reference.pdf
 
 This is the OpenDeveloper Reference Manual, which details a suite of ActiveX controls for developing custom applications that interface with TDT's OpenEx software. It describes the TTankX control for accessing                           
 data tanks and the TDevAcc control for real-time access to hardware. The manual provides information on the available methods, properties, and events for these controls, along with examples.
 <!-- Import failed: C:\Users\Lab\Desktop\TDT_multiChannelv4 - Path traversal attempt --> with EEG Integration\TDTHelp\OpenDeveloper_Manual.pdf
 
 This is the user guide for OpenEx, a software suite for designing and running experiments with TDT hardware. The guide covers the main applications in the suite: OpenProject for managing projects, OpenWorkbench                           
 for controlling hardware and data storage, OpenController for real-time control of experiment parameters, OpenScope for data visualization, and OpenBrowser for data export. It includes tutorials and reference   
 sections for each application.
 <!-- Import failed: C:\Users\Lab\Desktop\TDT_multiChannelv4 - Path traversal attempt --> with EEG Integration\TDTHelp\OpenEx_User_Guide.pdf 
 
 This is the manual for RPvdsEx, TDT's software for visually designing and compiling circuits for their real-time digital signal processors (DSPs). The manual covers the basics of DSPs and System 3, the RPvdsEx   
 environment, fundamentals of circuit design, and provides a comprehensive reference for all the available components and macros.                                                                                
 <!-- Import failed: C:\Users\Lab\Desktop\TDT_multiChannelv4 - Path traversal attempt --> with EEG Integration\TDTHelp\RPvdsEx_Manual.pdf
 
 This is the hardware manual for TDT's System 3. It contains detailed information about the various processors (RZ, RX, RP, and RM series), preamplifiers, headstages, stimulus isolators, and other accessories.
 It
includes technical specifications, architecture diagrams, pinouts, and instructions for connecting the hardware.
 <!-- Import failed: C:\Users\Lab\Desktop\TDT_multiChannelv4 - Path traversal attempt --> with EEG Integration\TDTHelp\TDTSys3_Manual.pdf

## Hardware Connection

The project uses the `Circuit_Loader.m` script to establish a connection with the TDT hardware. It is configured to connect to an **RX8** device, not an RP2. The relevant code snippet from `Circuit_Loader.m` is:

```matlab
    % Load circuit onto device and run
    RP = actxcontrol('RPco.x',[5 5 26 26]);
    
    %RP.ConnectRP2(connectionType, deviceNumber); % Connects RP2 via USB or GB given the proper device number
    RP.ConnectRX8(connectionType, deviceNumber);
```
 
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
OpenBridge is a utility that facilitates data export and acts as a bridge between TTank data tanks and Plexon's Offline Sorter. It supports exporting data to NEX v100, DDT v103, EDF+ EDF, and PLX v103 file formats. Key functionalities include selecting specific events, sorts, and channels for export, handling large datasets by splitting them into multiple files, and automating the launch of Offline Sorter. It also ensures consistent channel numbering and can import sorted data back into the tank. The guide details the user interface, including the Tank Navigator Panel for selecting tanks and blocks, the Selector Panel for choosing export formats and data, and the Activity Log for tracking operations. It also covers setting export preferences and using batch processing for multiple blocks.[1]

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
[1] OpenBridge User Guide - Offline Data Analysis Tools (https://www.tdt.com/docs/sdk/offline-data-analysis/openbridge/)
[2] Overview of MATLAB Offline Analysis Tools - Offline Data Analysis ... (https://www.tdt.com/docs/sdk/offline-data-analysis/offline-data-matlab/#tdtfft)
[3] TDT Data Storage - Offline Data Analysis Tools (https://www.tdt.com/docs/sdk/offline-data-analysis/tdt-data-storage/#tdt-data-types)

## TTankX ActiveX Control Methods

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
    *   `folderPath`: Directory containing stimulus files.
    *   `patient`: Participant metadata.
    *   `output`: Results directory.

### Experiment Workflow

1.  **Preparation**: GUI updates `mdb` with user settings (e.g., patient info, start levels) and saves `mdb.mat`.
2.  **Loop**: Experiment script (e.g., `BehavioralMain.m`, `SNRFinderHelper.m`) iterates through trials.
    *   Updates `mdb` with current trial parameters (e.g., specific .wav file path, current SNR level).
    *   Saves `mdb.mat`.
3.  **Signal Creation**: `play_signal_multi.m` loads `mdb.mat`.
    *   Calls `TX1_create_signal.m` (and TX2/TX3 versions).
    *   These functions read the `source` path and `amp` from `mdb` to generate digital samples.
4.  **Hardware Interaction**: `play_signal_multi.m` uploads samples and speaker selection (`DacVector`) to the TDT hardware via ActiveX.
5.  **Trigger**: System triggers playback and waits for duration.
