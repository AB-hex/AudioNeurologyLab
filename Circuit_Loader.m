function [RP,varargout] = Circuit_Loader(varargin)
% CIRCUIT_LOADER Loads a *.rcx circuit onto a RX8, returns ActiveX control object
% RP = CIRCUIT_LOADER(connectionType, deviceNumber, circuitPath)
% RP = CIRCUIT_LOADER(connectionType, deviceNumber, circuitPath, mode)
%
%   mode (optional, default 'auto'):
%     'auto'  — use RPco.X (old behaviour). If Workbench is open, warn but
%               still proceed — old scripts are unaffected.
%     'eeg'   — require Workbench; return TDEVProxy instead of RPco.X so
%               all RP.* calls route through TDevAcc while Workbench keeps
%               hardware ownership. Use this for EEG recording sessions.
%
%   connectionType: 'GB' (default) or 'USB'
%   deviceNumber:   defaults to 1
%   circuitPath:    .rcx extension optional

    eegMode = false;   % default: old RPco.X behaviour

    if nargin == 4

        connectionType = varargin{1};
        deviceNumber   = varargin{2};
        circuitPath    = varargin{3};
        eegMode        = strcmpi(varargin{4}, 'eeg');

    elseif nargin == 3

        connectionType = varargin{1};
        deviceNumber = varargin{2};
        circuitPath = varargin{3};

    elseif nargin == 1

        connectionType = 'GB';
        deviceNumber = 1;
        circuitPath = varargin{1};

    elseif nargin == 0

        % path - set this to wherever the examples are stored
        %path = 'C:\TDT\ActiveX\ActXExamples\RP_files\';
        path = pwd;

        connectionType = input('Enter the type of connection (USB or GB):  ','s');
        connectionType = upper(connectionType);

        % Error check for correct connection
        if ~(strcmp(connectionType,'USB')||strcmp(connectionType,'GB'))
            connectionType = 'GB';
            disp('   Device connection = GB');
        end

        deviceNumber = input('Enter the device number:  ');

        % Error check for correct device number
        if (~isnumeric(deviceNumber) || deviceNumber < 1)
            deviceNumber = 1;
            disp('   Device number = 1');
        end

        % Show available circuits
        disp(' ');
        disp(['path: ' path]);
        dir(path)
        
        circuitPath = input('Enter the name of the circuit:  ','s');
        circuitPath = strcat(path,circuitPath);
        
    else
        error('Invalid number of arguments.');
    end
    
    % Error check circuit file path
    if size(strfind(circuitPath,'.rcx')) == 0
        circuitPath = strcat(circuitPath,'.rcx');
    end

    % Error check for existing file
    fileExists=(exist(circuitPath,'file'));
    if fileExists==0
        disp('   File doesnt exist'); return;
    end

    % --- Workbench detection ---
    try
        DA = actxserver('TDevAcc.X');
        wbRunning = (DA.ConnectServer('Local') == 1);
        DA.CloseConnection;
        delete(DA);
    catch
        wbRunning = false;
    end

    if eegMode
        % Explicitly requested EEG/TDEVProxy mode.
        if ~wbRunning
            error(['Circuit_Loader: mode=''eeg'' requires OpenWorkbench to be ' ...
                   'running. Open WorkBench.xpm first.']);
        end
        disp('Circuit_Loader: EEG mode — returning TDEVProxy (TDevAcc).');
        addpath('C:\TDT\TDTMatlabSDK\TDTSDK\OpenExLive');
        [RP, td] = TDEVProxy.createWithTDEV();  %#ok<NASGU>
        varargout{1} = 7;
        varargout{2} = 'Circuit loaded and running (TDEVProxy mode)';
        return;
    end

    if wbRunning
        warning(['Circuit_Loader: OpenWorkbench is open. Proceeding with RPco.X ' ...
                 '(sound only). For EEG recording pass mode=''eeg''.']);
    end

    % --- RPco.X path (old behaviour, unchanged) ---
    % Load circuit onto device and run
    RP = actxcontrol('RPco.x',[5 5 26 26]);
    
    %RP.ConnectRP2(connectionType, deviceNumber); % Connects RP2 via USB or GB given the proper device number
    RP.ConnectRX8(connectionType, deviceNumber);
    RP.Halt; % Stops any processing chains running on RP2
    RP.ClearCOF; % Clears all the buffers and circuits on that RP2
    disp(['Loading ' circuitPath]);
    RP.LoadCOF(circuitPath); % Loads circuit
    RP.Run; % Starts circuit

    status=double(RP.GetStatus); % Gets the status
    varargout{1} = status;
    if bitget(status,1)==0; % Checks for connection
        message = 'Error connecting to RP2';
        disp(message); 
    elseif bitget(status,2)==0; % Checks for errors in loading circuit
        message = 'Error loading circuit';
        disp(message); 
    elseif bitget(status,3)==0 % Checks for errors in running circuit
        message = 'Error running circuit';
        disp(message);
    else
        message = 'Circuit loaded and running';
        disp(message);
    end
    varargout{2} = message;
end

