function SpatialHearingTestHelper(app)
    %TODO add export excel 
    d = uiprogressdlg(app.UIFigure,'Title','Please Wait',...
    'Message','Starting ','Indeterminate','on');
    pause(2);
    
    Initialize_Selection("TX1");
    Initialize_Selection("TX2");
    Initialize_Selection("TX3");

    OutputSelection =  arrayfun(@(ii) app.("SpatialSignalOutput"+ii).Value, [1:8]);
    
    if(sum(OutputSelection)<=2)
        uialert(app.UIFigure,'select at least 3 outputs','Error');
        return;
    end
    load mdb
    [mdb.master.TX1_select,mdb.TX1.stimulus.stimulusSelect.PT]=deal(1,1);
    mdb.TX1.stimulus.PT.freq = app.SignalFrequencyHzDropDown.Value;
    mdb.TX1.stimulus.PT.amp = app.SpatialSignaldbEditField.Value;
    history = {};
    if(app.NoiseIncreasingNoiseButton.Value)
        mdb.TX1.stimulus.stimulusSelect.Noise = 1;
        mdb.TX1.stimulus.noise.amp = app.SpatialNoisedbEditField.Value;
    else
        record = {};
    end
    
    result = -1;
    OutputSelection = find(1 == OutputSelection);

    
    close(d);
    save mdb mdb
    [success,record,history,result] = SptialHearingTestQuiteStep(app,...
                                                      app.SpatialSignaldbEditField.Value,...
                                                      OutputSelection,...
                                                      record,history,app.DurationsecEditField.Value);
      
      
    

end