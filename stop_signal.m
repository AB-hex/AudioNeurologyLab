

function []=stop_signal()

    RP = Circuit_Loader('D:\Users\Adi_Dayan\TDT_proj\full_2.rcx');
    
    % Stop playing
    RP.SoftTrg(9);
    RP.Halt;