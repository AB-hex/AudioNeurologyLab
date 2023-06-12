

function []=TX3_stop_signal()

    global RP;
    
    % Stop playing
    RP.SoftTrg(10);
  %  RP.Halt;
    
end