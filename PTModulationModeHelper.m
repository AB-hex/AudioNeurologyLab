function modulationType = PTModulationModeHelper(FMMode,AMMode)


%     FMMode = app.FMModulationCheckBox.Value;
%     AMMode = app.AMModulationCheckBox.Value;
    if(~FMMode && ~AMMode)
       modulationType = 3;%no modulation
    elseif(FMMode && ~AMMode)
       modulationType = 1;%FM
    elseif(~FMMode && AMMode)
        modulationType = 0;%AM
    elseif(FMMode && AMMode)
         modulationType = 2;%AM and FM
    end

end