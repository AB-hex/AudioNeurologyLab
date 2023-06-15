function SpatialHearingTestHelper(app) 

%TODO Add support for words and custom noise, and options for choosing
%where noise will come from direction
    d = uiprogressdlg(app.UIFigure,'Title','Please Wait',...
    'Message','Starting ','Indeterminate','on');
    pause(2);
    
    Initialize_Selection("TX1");
    Initialize_Selection("TX2");
    Initialize_Selection("TX3");

    OutputSelection =  arrayfun(@(ii) app.("SpatialSignalOutput"+ii).Value, [1:8]);
    
    
    %TODO: for custom words signal you will need to change both the quite
    %functino and noise function 
    
    if(sum(OutputSelection)<=2)
        uialert(app.UIFigure,'select at least 3 outputs','Error');
        return;
    end
    VariableHistoryNames={'# Speaker','Angle','Result','Level'};
    
    if(app.WordsFolderButton.Value)
         if(strcmp(app.ChoosesignalwordsfolderButtonSpatialHearing.Text,"Choose signal words folder"))
                uialert(app.UIFigure,"No signal folder selected, Please choose signal folder","Choose a signal folder");
                return;
         end
       signalType = "speech";
       signalTypeStimulusSelect = "speech";
       VariableHistoryNames(end+1) = {'Word'};
    else
       signalType = "PT";
       signalTypeStimulusSelect = "pureTone";
       mdb.TX1.stimulus.PT.freq = str2double(app.SignalFrequencyHzDropDown.Value);
    end
    
     
    load mdb
    [mdb.master.TX1_select , mdb.TX1.stimulus.stimulusSelect.(signalTypeStimulusSelect)]=deal(1,1);
    mdb.TX1.stimulus.(signalType).amp = app.SpatialSignaldbEditField.Value;
    mdb.TX1.stimulus.burstDuration = app.DurationsecEditField.Value;
    history = {};
    if(app.NoiseIncreasingNoiseButton.Value)
               
        if(~app.noiseFromFileFlag)
            typeNoise = "noise";
        else
            typeNoise = "speech";
        end
        
        if(app.FixedSpeakersnoiseoutputButton.Value)
           TXModeNoise = "TX2";%Seperated Channels for noise
           OutputNoiseSelection = arrayfun(@(ii) app.("SpatialSignalOutput"+ii+"Noise").Value,[1:8]);
           if(sum(OutputNoiseSelection) == 0)
                uialert(app.UIFigure,'Please choose fixed noise speakers','No Speakers For Noise');
                return;
           end 
            mdb.TX2.transducer.FF.DacVector(1:8) = OutputNoiseSelection;
            mdb.master.TX2_select = 1;
        else
            TXModeNoise = "TX1"; %Same Channel with signal
        end
        
        mdb.(TXModeNoise).stimulus.stimulusSelect.(typeNoise) = 1;
        mdb.(TXModeNoise).stimulus.(typeNoise).amp = app.SpatialNoisedbEditField.Value;
    end
    record = {};
    result = -1;
    OutputSelection = find(1 == OutputSelection);
    
    
    
    close(d);
    save mdb mdb
    if(app.quiteNoNoisedecreasingsignalButton.Value)
    [success,record,history,result] = SptialHearingTestQuiteStep(app,...
                                                      signalType,app.SpatialSignaldbEditField.Value,...
                                                      OutputSelection,...
                                                      record,history,app.DurationsecEditField.Value);

    elseif(app.NoiseIncreasingNoiseButton.Value)
        if(app.noiseFromFileFlag)
            if(strcmp(app.ChoosenoiseaudiofileButtonSpatialHearing.Text,"Choose noise audio file"))
                uialert(app.UIFigure,"No noise file selected, Please choose noise file","Choose a noise file");
                return;
            end
            PrepareNoiseSegments(app.ChoosenoiseaudiofileButtonSpatialHearing.Text,3.5);
        end
        noiseDetails.typeNoise = typeNoise;
        noiseDetails.TXModeNoise = TXModeNoise;
        
        [success,record,history,result] = SpatialHearingTestNoiseStep(app,...
                                                      app.SpatialSignaldbEditField.Value,...
                                                      app.SpatialNoisedbEditField.Value,...
                                                      OutputSelection,noiseDetails,...
                                                      record,history,app.DurationsecEditField.Value);
              VariableHistoryNames(end+1)={'Noise Speakers'};
        

    end
                                                  
     if(-1 == success)
         return;
     end
    if(app.quiteNoNoisedecreasingsignalButton.Value)
        titlePlot = "Spatial hearing test result-Quite";
        xlabelText = "'Level (dB)'";
        recordVariableNames = {'Level','# of successfully located speakers','# speakers','angle of speakers'};
    else %noise
         titlePlot = "Spatial hearing test result-Noise";
         xlabelText = "SNR";
         recordVariableNames = {'SNR','# of successfully located speakers','# speakers','angle of speakers'};
    end
    
    result = (8-result)*45;
    x = [record{:,1}];
    y = [record{:,2}];
    xx = linspace(min(x),max(x),500);
    yy = interp1(x, y, xx, 'pchip');
    f=figure;
    plot(xx,yy);
    title(titlePlot+" - Final Direction Result: "+result+"°");
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
  
                   
    if(app.NoiseIncreasingNoiseButton.Value)               
        if(app.noiseFromFileFlag)
          personalDetails(end+1,:) = {'Noise Source:',app.ChoosenoiseaudiofileButtonSpatialHearing.Text}; 
        else
          personalDetails(end+1,:) = {'Noise Source:','White Noise'};             
        end
    end
                       
%     switch selection
%         case 'Cancel'
%             return;     
%     end
    
% TODO: add seperated tracking to noise speakers and noies type to the report
    
    outputExcel = fullfile(app.CUsersLabDocumentsButton_2.Text,app.NameoffiileEditField_2.Value,string(personalDetails{1,2})+app.NameoffiileEditField_2.Value+".xlsx");
    outputFolder = fullfile(app.CUsersLabDocumentsButton_2.Text,app.NameoffiileEditField_2.Value);
    mkdir(outputFolder);
%     writecell(personalDetails,outputExcel,'Sheet',1,'Range','A1');%export personal data
%     history = cell2table(history,'VariableNames',{'# Speaker','Result','Level','Noise Speakers'});%change  history to table
      history = cell2table(history,'VariableNames',VariableHistoryNames);
%     writetable(history,outputExcel,'Sheet',1,'Range','H1');%write history to excel
%     writematrix(PrintData(mdb)',outputExcel,'Sheet',1,'Range','L1');
    map = table([1:8]',mdb.Calibration.FF2SpeakerMap','VariableNames',{'#FFout','#speaker'})
%     writetable(map,outputExcel,'Sheet',1,'Range','N1');
    
    record  = cell2table(record,'VariableNames',recordVariableNames);
    
    
    range = 'A1';
    writecell(personalDetails,outputExcel,'Sheet',1,'Range',range);%export personal data
    [~,width] = size(personalDetails);
    range(1) = char(range(1)+width+2);
    writetable(record,outputExcel ,'Sheet',1,'Range',range);
    [~,width] = size(record);
    range(1) = char(range(1)+width+2);
    writetable(history,outputExcel,'Sheet',1,'Range',range);%write history to excel
    [~,width] = size(history);
    range(1) = char(range(1)+width+2);
    writematrix(PrintData(mdb)',outputExcel,'Sheet',1,'Range',range);

    range(1) = char(range(1)+3);
    writetable(map,outputExcel,'Sheet',1,'Range',range);
    exportgraphics(ax,fullfile(outputFolder,"PlotFinalResult.jpg")); % save the axes as a JPEG file
    
    xdata = get(ax.Children, 'XData');
    ydata = get(ax.Children, 'YData');
    save(fullfile(outputFolder,'LinePlot.mat'), 'xdata', 'ydata');
end