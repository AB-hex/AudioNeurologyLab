function SNRFinderHelper2(app) 
    d = uiprogressdlg(app.UIFigure,'Title','Please Wait',...
    'Message','Starting ','Indeterminate','on');
    pause(2);
    wordsDir = dir(app.ChooseFolderButton.Text+"/*.wav");
    SNRData = struct('SNR',[],'Success',[]);
    history = {};
    record = {};

    if(length(wordsDir)<25)
        uialert(app.UIFigure,'Too little .wav files. Has to be 25 at least','Error');
        return;
    end
    
    
    if(isempty(app.NameoffiileEditField.Value))
        uialert(app.UIFigure,'No output folder name','Error');
        return;
    end
    
    Initialize_Selection("TX1");
    Initialize_Selection("TX2");
    Initialize_Selection("TX3");
    
    load mdb;
    NoiseSelection =  arrayfun(@(ii) app.(strcat('SNRNoiseOutput',num2str(ii))).Value, [1:8]);
    SignalSelection =  arrayfun(@(ii) app.(strcat('SNRSignalOutput',num2str(ii))).Value, [1:8]);
    
    if(~any(NoiseSelection)||~any(SignalSelection))
        uialert(app.UIFigure,'Signal or Noise was not selected','Error');
        return;
    end
    
    mdb.TX1.transducer.FF.DacVector(1:8) = SignalSelection;
    mdb.TX2.transducer.FF.DacVector(1:8) = NoiseSelection;
    
    [mdb.master.TX1_select,mdb.master.TX2_select ] = deal(1,1);
    [mdb.TX1.stimulus.stimulusSelect.speech, mdb.TX2.stimulus.stimulusSelect.noise ] = deal(1,1);
  save mdb mdb;
     playOrder = randperm(length(wordsDir));
%     jumpOrder = [10,5,3,2];
    NumOfWordsOrder = [2,6];
    stopThreshold = 0.5;
%     [Idx.jump , Idx.NumOfWords, Idx.currentPlay] = deal(1,1,1);
    [Idx.NumOfWords, Idx.currentPlay] = deal(1,1);
    beginningStageFlag = 1;%to imply when we are not in the beginning
    
    signalLevel = app.SignaldbEditField.Value;
    noiseLevel = app.NoisedbEditField.Value;
    
    close(d);
    
    NumOfWords = NumOfWordsOrder(Idx.NumOfWords);
    
    
    [success,record,history,Idx,resultSNR,bottom,up] = SNRFinderPhase1Step(app,...
                                           signalLevel,noiseLevel,...
                                           record,history,NumOfWords,...
                                           Idx,playOrder,wordsDir,jump);
    if(-1 == success)
        return;
    end
    Idx.NumOfWords = Idx.NumOfWords + 1;
    NumOfWords = NumOfWordsOrder(Idx.NumOfWords);
        [success,record,history,Idx,resultSNR] = SNRFinderPhase2Step(app,...
                                           signalLevel,signalLevel-resultSNR,...
                                           record,history,NumOfWords,...
                                           Idx,playOrder,wordsDir,bottom,up);
                                       
        if(-1 == success)
            return;
        end
        
        
         
    x = [record{:,1}];
    y = [record{:,2}];
    xx = linspace(min(x),max(x),500);
    yy = interp1(x, y, xx, 'pchip');
    f=figure;
    plot(xx,yy);
    title("SNR Result Test");
    xlabel("SNR");
    ylabel('# of succesfully words');
    
    ax = gca;
    ax.XDir='reverse';
    
   hold on
    plot(x,y,'x');
    hold off
    
    title1 = "Export";
    txt = "Do you want export the result to excel?";
    selection = uiconfirm(app.UIFigure,txt,title1,...
                           'Options',{'Export','Cancel'});
    
    
     personalDetails = {'Name' , app.NameEditField.Value;...
                       'Age' , app.AgeEditField.Value;...
                       'Gender',app.GenderEditField.Value;...
                       'Ear', app.EarEditField.Value;...
                       'Test', app.TestNameEditField.Value };
       switch selection
        case 'Cancel'
            return;     
       end               
    
      outputExcel =  fullfile(app.CUsersLabDocumentsButton.Text,[app.NameoffiileEditField.Value '.xlsx']);
      outputFolder = fullfile(app.CUsersLabDocumentsButton.Text,app.NameoffiileEditField.Value);
      mkdir(outputFolder);
      writecell(personalDetails,outputExcel,'Sheet',1,'Range','A1');%export personal data
      
       history = cell2table(history,'VariableNames',{'Words','Result','Signal,Nosie and SNR'});%change  history to table
       writetable(history,outputExcel,'Sheet',1,'Range','H1');%write history to excel
       
       writematrix(PrintData(mdb)',outputFile,'Sheet',1,'Range','L1');

       record  = cell2table(record,'VariableNames',{'SNR','SUCCESS'});
        
        writetable(record,outputExcel ,'Sheet',1,'Range','D1');
        
        exportgraphics(ax,fullfile(outputFolder,"PlotFinalResult.jpg")); % save the axes as a JPEG file
        
         xdata = get(ax.Children, 'XData');
         ydata = get(ax.Children, 'YData');
         save(fullfile(outputFolder,'LinePlot.mat'), 'xdata', 'ydata');
        
end