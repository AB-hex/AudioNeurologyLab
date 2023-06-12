function [RP] = bla()

    RP1 = Circuit_Loader('D:\Users\Adi_Dayan\TDT_multiChannel\Copy_of_full_3.rcx');
    load mdb;
    mdb.RP = RP1;
    save mdb mdb;
    
    %load mdb;
    RP = mdb.RP;
end