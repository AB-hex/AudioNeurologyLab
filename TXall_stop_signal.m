

function []=TXall_stop_signal()

    global RP;
    %RP = Circuit_Loader('D:\Users\Adi_Dayan\TDT_proj\full_3.rcx');
    
    % Stop playing
    RP.SoftTrg(5);
    %RP.Halt;
    
end