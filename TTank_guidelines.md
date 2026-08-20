# TTank Integration & Block Parsing Guidelines

## 1. Initialization and "Closed Loop" Workflow

Always follow the "closed loop" access pattern to ensure server resources are managed correctly.

### Core Workflow
```matlab
TT = actxserver('TTank.X');                  % use actxserver, not actxcontrol
TT.ConnectServer('Local', 'MyClient');        % connect to database engine
TT.OpenTank('C:\path\to\Tank', 'R');         % MUST be called before GetHotBlock
TT.SelectBlock('~Block-1');                   % ~ prefix triggers Epoch Indexing
% ... access data ...
TT.CloseTank;
TT.ReleaseServer;
```

**Critical**: `OpenTank` must be called **before** `GetHotBlock()`. Without it, `CurBlockName` is uninitialized and `GetHotBlock()` returns empty string.

---

## 2. Getting the Active Block Name

```matlab
TT.OpenTank(tankPath, 'R');
pause(0.5);                      % give WorkEngine time to register the block
blockName = TT.GetHotBlock();

% Fallback if GetHotBlock still returns empty:
if isempty(blockName)
    blockDirs = dir(fullfile(tankPath, 'Block-*'));
    [~, idx] = max([blockDirs.datenum]);
    blockName = blockDirs(idx).name;
end
```

---

## 3. Known Store IDs (this project)

| Store ID | Device | Content | Channels |
|---|---|---|---|
| `EEG0` | RA16_1 | Medusa EEG stream | 4 (dEEG0~1 … dEEG0~4) |
| `BTTN` | RX8_1 | 4-button response box | 4 (dBTTN~1 … dBTTN~4) |

**Note**: The store ID is derived from the `s`-prefixed tag name: `sEEG0` → `'EEG0'`, `sBTTN` → `'BTTN'`. The wrong store ID causes `ReadWavesV` to return `NaN`, not an error.

---

## 4. Reading Stream Data

```matlab
TT.SelectBlock(['~' blockName]);
TT.SetGlobalV('Channel', 0);              % 0 = all channels
TT.SetGlobalStringV('Options', 'ALL');

eegData = TT.ReadWavesV('EEG0');          % [samples x 4]
btnData = TT.ReadWavesV('BTTN');          % [samples x 4], values 0 or 1

% Sample rates — use TDevAcc, NOT TTank (WaveSF does not exist on TTank.X)
eegFs = td.TD.GetDeviceSF('RA16_1');      % EEG sample rate
btnFs = td.TD.GetDeviceSF('RX8_1');       % Button box sample rate
```

**`WaveSF` does not exist on `COM.TTank_X`** — calling it throws an error. Use `td.TD.GetDeviceSF(deviceName)` from the TDEV object instead.

---

## 5. Block Parsing and Event Retrieval

```matlab
% Read events into cache
N = TT.ReadEventsV(MaxRet, 'StoreID', Chan, Sort, T1, T2, 'Options');

% Extract metadata from cache
Timestamps = TT.ParseEvInfoV(0, N, 6);   % item code 6 = timestamp
Channels   = TT.ParseEvInfoV(0, N, 4);   % item code 4 = channel

% Extract waveform data from cache
Waveforms  = TT.ParseEvV(0, N);          % columns = events
```

---

## 6. Epochs and Filtering

```matlab
TT.CreateEpocIndexing;                              % must call before epoch queries
TT.ResetFilters;
TT.SetFilterWithDescEx('Freq=2000 and Levl=70');
N = TT.ReadEventsV(1000, 'StoreID', 0, 0, 0, 0, 'FILTERED');
```

---

## 7. Global Parameters

```matlab
TT.SetGlobalV('Channel', 0);                        % numeric
TT.SetGlobalStringV('Options', 'ALL');              % string
TT.SetGlobals('Channel=1; Options=FILTERED; T2=10'); % multiple at once
```

---

## 8. Critical Constraints

- **`OpenTank` before `GetHotBlock`** — always, or block name returns empty.
- **`WaveSF` does not exist** on `COM.TTank_X` — use `td.TD.GetDeviceSF(device)`.
- **Wrong store ID** → `ReadWavesV` returns `NaN` silently, not an error. Verify store name with `ListDeviceTags.m`.
- **Large Block Bug**: `ReadEventsV` may miss events in long blocks — read in 100-second intervals instead of T1=0, T2=0.
- **Store ID naming**: `SetFilterArray` fails if store ID starts with a number, symbol, bracket, or space.
- **Memory**: `WavesMemLimit` defaults to ~32 MB — chunk large reads.
- **`~` prefix on `SelectBlock`**: triggers Epoch Indexing automatically (`TT.SelectBlock(['~' blockName])`).
