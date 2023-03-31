function OpenPureTone(app,cell)
            app.LeveldBEditField.Value = cell{find(strcmp(cell(:,1),'Level'),1),2};
             app.FrequencyHzDropDown.Value = cell{find(strcmp(cell(:,1),'Freq'),1),2};
             app.onsetmsecEditField.Value = cell{find(strcmp(cell(:,1),'onset'),1),2};
             app.offsetmsecEditField.Value = cell{find(strcmp(cell(:,1),'offset'),1),2};
             app.PhaseDropDown.Value = cell{find(strcmp(cell(:,1),'phase'),1),2};
             app.ModFreqHzEditField = cell{find(strcmp(cell(:,1),'mod freq'),1),2};
             arrayfun(@(ii) setfield(app.("TXFF"+ii),'Value',1) ,str2num(cell{find(strcmp(cell(:,1),'Output Ports'),1),2}) );
             if(strcmp(cell{find(strcmp(cell(:,1),'Output Ports'),1),3},'random'))
                 app.ActivateRandomSpeakersCheckBox.Value = 1;
                 ActivateRandomSpeakersCheckBoxValueChanged(app,event);
                 app.HowmanyspeakerstoselectrandomEditField.Value = cell{find(strcmp(cell(:,3),'random'),1),4};
             end
             if(~isempty(find(strcmp(cell(:,1),'AM'),1)))
                 app.AMModulationCheckBox.Value=1;
                 AMModulationCheckBoxValueChanged(app,event);
                 app.depth0100EditField.Value = cell{find(strcmp(cell(:,1),'AM'),1),2};
             end
             if(~isempty(find(strcmp(cell(:,1),'FM'),1)))
                 app.FMModulationCheckBox.Value=1;
                 FMModulationCheckBoxValueChanged(app,event);
                 app.ModulationIndexEditField.Value = cell{find(strcmp(cell(:,1),'FM'),1),2};
             end
             
end