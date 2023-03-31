function status = PrepareMdb(app)
load mdb
    for Num = 1:3
        TXNumber = "TX"+Num;
        fieldNames = fieldnames(mdb.(TXNumber).stimulus.stimulusSelect);
        mdb.master.(strcat(TXNumber,"_select")) = 0;
        for ii=1:length(fieldNames) 
            mdb.(TXNumber).stimulus.stimulusSelect.(fieldNames{ii}) = 0;
        end
        if(~strcmp(app.("InputSignal"+Num+TXNumber+"DropDown").Value,"None"))
            mdb.(TXNumber).transducer.source = 'FF';
            mdb.master.(strcat(TXNumber,"_select")) = 1;
            mdb.(TXNumber).transducer.FF.DacVector(1:8) = arrayfun(@(ii) app.(TXNumber+"FF"+ii).Value , [1:8]);
            if(isempty(app.(TXNumber+"Options"))||~isvalid(app.(TXNumber+"Options")))
                uialert(app.UIFigure, "Options is missing please click the options button","Missing Options");
                status = -1;
                return
            end
        end
        AppOptions = app.(TXNumber+"Options");
        switch app.("InputSignal"+Num+TXNumber+"DropDown").Value
               
               case 'Pure Tune'

                   mdb.(TXNumber).stimulus.stimulusSelect.pureTone = 1;
                   mdb.(TXNumber).stimulus.PT.freq = AppOptions.freqEditField.Value;
                   mdb.(TXNumber).stimulus.PT.amp = AppOptions.amplitudeEditField.Value;
                   mdb.(TXNumber).stimulus.PT.phase = AppOptions.phasedegDropDown.Value;
                   mdb.(TXNumber).stimulus.PT.modulationType = PTModulationModeHelper(AppOptions.FMModulationCheckBox.Value,AppOptions.AMModulationCheckBox.Value);
                   mdb.(TXNumber).stimulus.PT.modIndex = AppOptions.ModulationIndexEditField.Value;
                   mdb.(TXNumber).stimulus.PT.modDepth = AppOptions.depth0100EditField.Value;
                   mdb.(TXNumber).stimulus.PT.modFreq = AppOptions.ModFreqHzEditField.Value;
                case 'Noise'
                     mdb.(TXNumber).stimulus.stimulusSelect.noise = 1;
                     mdb.(TXNumber).stimulus.noise.amp = AppOptions.amplitudeEditField.Value;
                     mdb.(TXNumber).stimulus.noise.phase = str2double(AppOptions.phasedegDropDown.Value);
                     switch  AppOptions.ChooseDropDown.Value
                         case 'White Noise' 
                             mdb.(TXNumber).stimulus.noise.source = 1;
                         case 'NB Noise'
                             mdb.(TXNumber).stimulus.noise.source = 2; 
                             mdb.(TXNumber).stimulus.noise.NBCntrFrq = AppOptions.cntrfreqHzEditField.Value;
                             mdb.(TXNumber).stimulus.noise.NBBW = AppOptions.BWHzEditField.Value;
                     end

                case 'From File'
                     mdb.(TXNumber).stimulus.stimulusSelect.speech = 1;
                     mdb.(TXNumber).stimulus.speech.amp = AppOptions.amplitudeEditField.Value;
                     mdb.(TXNumber).stimulus.speech.phase = AppOptions.phasedegDropDown.Value;
                     mdb.(TXNumber).stimulus.speech.source = AppOptions.FullPath;
        end
        
    end
save mdb mdb;
status =1;
return;
end