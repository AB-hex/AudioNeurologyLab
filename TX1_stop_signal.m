

function []=TX1_stop_signal()

    global RP;
    
    % Stop playing
    RP.SoftTrg(8);
   % RP.Halt;
    
  %  RP = Circuit_Loader('D:\Users\Adi_Dayan\TDT_multiChannel\full_3.rcx');
    
end