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
    [mdb.master.TX1_select , mdb.TX1.stimulus.stimulusSelect.pureTone]=deal(1,1);
    mdb.TX1.stimulus.PT.freq = str2double(app.SignalFrequencyHzDropDown.Value);
    mdb.TX1.stimulus.PT.amp = app.SpatialSignaldbEditField.Value;
    mdb.TX1.stimulus.burstDuration = app.DurationsecEditField.Value;
    history = {};
    if(app.NoiseIncreasingNoiseButton.Value)
        mdb.TX1.stimulus.stimulusSelect.Noise = 1;
        mdb.TX1.stimulus.noise.amp = app.SpatialNoisedbEditField.Value;    
    end
    record = {};
    result = -1;
    OutputSelection = find(1 == OutputSelection);

    
    close(d);
    save mdb mdb
    if(app.quiteNoNoisedecreasingsignalButton.Value)
    [success,record,history,result] = SptialHearingTestQuiteStep(app,...
                                                      app.SpatialSignaldbEditField.Value,...
                                                      OutputSelection,...
                                                      record,history,app.DurationsecEditField.Value);
    elseif(app.NoiseIncreasingNoiseButton.Value)
        [success,record,history,result] = SpatialHearingTestNoiseStep(app,...
                                                      app.SpatialSignaldbEditField.Value,...
                                                      app.SpatialNoisedbEditField.Value,...
                                                      OutputSelection,...
                                                      record,history,app.DurationsecEditField.Value);
        

    end
                                                  
     if(-1 == success)
         return;
     end
    if(app.quiteNoNoisedecreasingsignalButton.Value)
        titlePlot = "Spatial hearing test result-Quite";
        xlabelText = "'Level (dB)'";
        recordVariableNames = {'Level','# of successfully located speakers','# speakers'};
    else %noise
         titlePlot = "Spatial hearing test result-Noise";
         xlabelText = "SNR";
         recordVariableNames = {'SNR','# of successfully located speakers','# speakers'};
    end
        
     
    
    x = [record{:,1}];
    y = [record{:,2}];
    xx = linspace(min(x),max(x),500);
    yy = interp1(x, y, xx, 'pchip');
    f=figure;
    plot(xx,yy);
    title(titlePlot+" - Final Direction Result: "+result);
    xlabel(xlabelText);
    ylabel("# of succesfully located speakers");
    
    ax = gca;
    ax.XDir='reverse';
    
    hold on
    plot(x,y,'x');
    hold off
    
%     title1 = "Export";
%     txt = "Do you want export the result to excel?";
%     selection = uiconfirm(app.UIFigure,txt,title1,...
%                            'Options',{'Export','Cancel'});
%                        
    personalDetails = {'Name' , app.NameEditField_2.Value;...
                       'Age' , app.AgeEditField_2.Value;...
                       'Gender',app.GenderEditField_2.Value;...
                       'Ear', app.EarEditField_2.Value;...
                       'Test', app.TestNameEditField_2.Value };
                       
%     switch selection
%         case 'Cancel'
%             return;     
%     end
    
    
    outputExcel = fullfile(app.CUsersLabDocumentsButton_2.Text,app.NameoffiileEditField_2.Value,string(personalDetails{1,2})+app.NameoffiileEditField_2.Value+".xlsx");
    outputFolder = fullfile(app.CUsersLabDocumentsButton_2.Text,app.NameoffiileEditField_2.Value);
    mkdir(outputFolder);
    writecell(personalDetails,outputExcel,'Sheet',1,'Range','A1');%export personal data
    
    history = cell2table(history,'VariableNames',{'# Speaker','Result','Level'});%change  history to table
    writetable(history,outputExcel,'Sheet',1,'Range','H1');%write history to excel
    writematrix(PrintData(mdb)',outputExcel,'Sheet',1,'Range','L1');
    map = table([1:8]',mdb.Calibration.FF2SpeakerMap','VariableNames',{'#FFout','#speaker'})
    writetable(map,outputExcel,'Sheet',1,'Range','N1');
    
    record  = cell2table(record,'VariableNames',recordVariableNames);
    
    writetable(record,outputExcel ,'Sheet',1,'Range','D1');
    
    exportgraphics(ax,fullfile(outputFolder,"PlotFinalResult.jpg")); % save the axes as a JPEG file
    
    xdata = get(ax.Children, 'XData');
    ydata = get(ax.Children, 'YData');
    save(fullfile(outputFolder,'LinePlot.mat'), 'xdata', 'ydata');
end