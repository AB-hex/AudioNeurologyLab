function bttn_data = capture_bttn_data(block_path)
% This script captures and displays data from a 'BTTN' store in a TDT block.

% Check if the directory exists
if ~isfolder(block_path)
    error('Error: The specified block path does not exist: %s', block_path);
end

% Define the store name
store_name = 'BTTN';

% Use TDTbin2mat to read the data from the specified store
try
    % fprintf('Reading data from store \'%s\' in block: %s\n', store_name, block_path);
    data = TDTbin2mat(block_path, 'STORE', store_name);
    
    % Check if the store was found and data was extracted
    if isfield(data, 'streams') && isfield(data.streams, store_name)
        bttn_data = data.streams.(store_name);
        fprintf('Successfully extracted BTTN data.\n');
        
        % Display some information about the data
        fprintf('Data size: %d x %d\n', size(bttn_data.data, 1), size(bttn_data.data, 2));
        fprintf('Sampling rate: %.2f Hz\n', bttn_data.fs);
        
        % Display the first 10 samples
        disp('First 10 samples:');
        disp(bttn_data.data(1:min(10, end)));
        
    elseif isfield(data, 'epocs') && isfield(data.epocs, store_name)
        bttn_data = data.epocs.(store_name);
        fprintf('Successfully extracted BTTN data.\n');
        
        % Display some information about the epoc data
        fprintf('Number of events: %d\n', length(bttn_data.onset));
        disp('Onset times (first 10):');
        disp(bttn_data.onset(1:min(10, end)));

    elseif isfield(data, 'scalars') && isfield(data.scalars, store_name)
        bttn_data = data.scalars.(store_name);
        fprintf('Successfully extracted BTTN data.\n');
        
        % Display some information about the scalar data
        fprintf('Number of events: %d\n', length(bttn_data.data));
        disp('Scalar values (first 10):');
        disp(bttn_data.data(1:min(10, end)));
        disp('Timestamps (first 10):');
        disp(bttn_data.ts(1:min(10, end)));

    else
        % warning('Could not find store \'%s\' in the block, or the store is empty.', store_name);
        bttn_data = [];
    end
    
catch ME
    error('An error occurred while reading the TDT data: %s', ME.message);
end

end