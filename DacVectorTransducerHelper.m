function DacVectorTransducerHelper(app,TXNumber,FFNumber,value)
    load mdb;
    mdb.(TXNumber).transducer.FF.DacVector(FFNumber) =  value;
    save mdb mdb;
    
end