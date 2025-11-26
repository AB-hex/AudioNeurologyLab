% Create a new figure and an ActiveX control for the TDT device
h = figure('Visible', 'off');
RP = actxcontrol('RPco.x', [0 0 0 0], h);

% Connect to the TDT device
if RP.ConnectRX8('GB', 1) == 0
    error('Could not connect to RX8 device');
end

% Prompt the user for the .rcx file path
rcx_file = input('Enter the full path to your .rcx file: ', 's');

% Load the .rcx file
RP.Halt; % Stops any processing chains running on the device
RP.ClearCOF; % Clears all the buffers and circuits on the device
if RP.LoadCOF(rcx_file) == 0
    error('Could not load .rcx file');
end
RP.Run; % Starts circuit

% Get the number of parameter tags
num_tags = RP.GetNumOf('ParTag');

if num_tags > 0
    fprintf('Found %d parameter tags:\n', num_tags);
    % Loop through the parameter tags and get their names
    for i = 1:num_tags
        tag_name = RP.GetNameOf('ParTag', i);
        fprintf('  - %s\n', tag_name);
    end
else
    fprintf('No parameter tags found in the circuit.\n');
end

% Clean up
RP.Halt;
close(h);