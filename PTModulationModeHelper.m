function PTModulationModeHelper(app,TXNumber)

    load mdb;
    FMMode = app.FMModulationCheckBox.Value;
    AMMode = app.AMModulationCheckBox.Value;
    if(~FMMode && ~AMMode)
        mdb.(TXNumber).stimulus.PT.modulationType = 3;%no modulation
    elseif(FMMode && ~AMMode)
       mdb.(TXNumber).stimulus.PT.modulationType = 1;%FM
    elseif(~FMMode && AMMode)
        mdb.(TXNumber).stimulus.PT.modulationType = 0;%AM
    elseif(FMMode && AMMode)
         mdb.(TXNumber).stimulus.PT.modulationType = 2;%AM and FM
    end

    save mdb mdb;
end