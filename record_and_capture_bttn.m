function record_and_capture_bttn(recording_duration_s)
% This script initiates a recording session using TDevAcc, creates a new data block,
% and then captures and displays data from a 'BTTN' store in the new block.

% --- 1. Setup ---
CIRCUIT_PATH = 'C:\Users\Lab\Desktop\TDT_multiChannelv4 with EEG Integration\Copy_of_full_5.rcx';
TANK_PATH = 'C:\Users\Lab\Desktop\TDT_multiChannelv4 with EEG Integration\Tanks';
STORE_NAME = 'BTTN';

if nargin < 1
    recording_duration_s = 10; % Default recording duration in seconds
end

% --- 2. Initialize ActiveX controls ---
RP = actxserver('RPco.X');
DA = actxserver('TDevAcc.X');
TT = actxserver('TTank.X');

% --- 3. Connect to servers ---
if RP.ConnectRX8('GB', 1) == 0
    error('Failed to connect to RX8 device.');
end
if DA.ConnectServer('Local') == 0
    error('Failed to connect to TDevAcc server. Make sure OpenWorkbench is running.');
end
if TT.ConnectServer('Local', 'Me') == 0
    DA.CloseConnection;
    error('Failed to connect to TTank server.');
end

% % --- 4. Set tank name ---
% fprintf('Setting tank to: %s...\n', TANK_PATH);
% if DA.SetTankName(TANK_PATH) == 0
%     error('Failed to set tank name.');
% end

% --- 5. Load Circuit ---
RP.Halt;
RP.ClearCOF;
if RP.LoadCOF(CIRCUIT_PATH) == 0
    error('Failed to load circuit: %s', CIRCUIT_PATH);
end

% --- 6. Set record mode and run ---
fprintf('Putting system into Record mode...\n');
if DA.SetSysMode(3) == 0 % 3 = Record
    error('Failed to set system to Record mode.');
end

RP.Run;

% --- 7. Get the latest block name ---
  d = dir(TANK_PATH);
 isub = [d(:).isdir];
 nameFolds = {d(isub).name}';
 nameFolds(ismember(nameFolds,{'.','..'})) = [];

 blockNumbers = cellfun(@(s) sscanf(s, 'Block-%d'), nameFolds, 'UniformOutput', false);
 emptyCells = cellfun(@isempty, blockNumbers);
 blockNumbers(emptyCells) = {-inf};
 blockNumbers = cell2mat(blockNumbers);

 [~, maxIdx] = max(blockNumbers);
 latest_block_name = nameFolds{maxIdx};
 disp(latest_block_name);

TT.SelectBlock(latest_block_name)
if isempty(latest_block_name)
    warning('Could not find any blocks in the tank.');
    DA.SetSysMode(0); % Stop recording
    RP.Halt;
    DA.CloseConnection;
    TT.CloseTank();
    TT.ReleaseServer();
    delete(DA);
    delete(TT);
    delete(RP);
    return;
end


fprintf('New block created: %s\n', latest_block_name);

% --- 8. Wait for recording to finish ---
fprintf('Recording for %d seconds...\n', recording_duration_s);
pause(recording_duration_s);

% --- 9. Stop recording ---
fprintf('Stopping recording...\n');
DA.SetSysMode(0); % 0 = Idle
RP.Halt;

% --- 10. Read data from the new block ---
block_path = fullfile(TANK_PATH, latest_block_name);

if ~isfolder(block_path)
    error('Could not find the new block path: %s', block_path);
end

capture_bttn_data(block_path);

% --- 11. Cleanup ---
DA.CloseConnection;
TT.CloseTank();
TT.ReleaseServer();
delete(DA);
delete(TT);
delete(RP);

fprintf('Script finished.\n');

end