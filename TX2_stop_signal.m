

function []=TX2_stop_signal()

    global RP;
    
    % Stop playing
    RP.SoftTrg(9);
  %  RP.Halt;
    
end