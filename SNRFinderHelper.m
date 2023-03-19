function SNRFinderHelper(app) 
    %TODO: Track all data  and output it to output foler
    %TODO: add advanced controllersl
    d = uiprogressdlg(app.UIFigure,'Title','Please Wait',...
    'Message','Starting ','Indeterminate','on');
    pause(2);
    wordsDir = dir(app.ChooseFolderButton.Text+"/*.wav");
    SNRData = struct('SNR',[],'Success',[]);
    history = {};
    
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
    
    playOrder = randperm(length(wordsDir));
    jumpOrder = [10,5,2,1];
    NumOfWordsOrder = [2,4];
    cretionThreshold = 0.5;
    [Idx.jump , Idx.NumOfWords, Idx.currentPlay] = deal(1,1,1);
    beginningStageFlag = 1;%to imply when we are not in the beginning

    mdb.TX1.stimulus.speech.amp = app.SignaldbEditField.Value;
    mdb.TX2.stimulus.noise.amp  = app.NoisedbEditField.Value;
    
    close(d);
    
    while( true)
        if(Idx.currentPlay > length(playOrder))
           uialert(app.UIFigure,'All Words had been played.','Out of words');
            return;
        end
            
        stats = "[Signal: " + mdb.TX1.stimulus.speech.amp + " dB , Noise: " + mdb.TX2.stimulus.noise.amp + " dB]";
        indicatorNextStep = -10; %setting here 1 or -1 will help to know if I need to rise or lower
        NumOfWords = NumOfWordsOrder(Idx.NumOfWords);
        recordedResponse = zeros([1 NumOfWords]);
        ii=1;
        while ii<=NumOfWords
            name = wordsDir(playOrder(Idx.currentPlay)).name;
            filename = fullfile(wordsDir(playOrder(Idx.currentPlay)).folder,name);
            msg = stats+newline+ "Playing "+ii+" word out of "+NumOfWords+newline+name;
            d = uiprogressdlg(app.UIFigure,'Title','Playing',...
                    'Message',msg,'Value',ii/NumOfWords);

            [y,fs] =audioread(filename);
%             sound(y,fs);
            durationInSec = length(y)/fs;
            mdb.TX1.stimulus.speech.source = filename;
            mdb.TX1.stimulus.burstDuration = durationInSec;
            mdb.TX2.stimulus.burstDuration = durationInSec;
            save mdb mdb;
            [TX1_playMode,TX2_playMode,TX3_playMode] = play_signal_multi(mdb.master.TX1_select,mdb.master.TX2_select,mdb.master.TX3_select); 
            pause(durationInSec + 0.175 );
            TXall_stop_signal();
            close(d);
            load mdb;
            msg = msg +newline+ 'The word was repeated this correctly?';
            selection = uiconfirm(app.UIFigure,msg,'Confirm response'...
                                  ,'Options', {'Correct','Wrong','Repeat','Cancel'});
           
            switch selection
                case 'Correct'
                    recordedResponse(ii) = 1;
                    historyEntry = {name, 'Correct'};
                case 'Wrong'
                    recordedResponse(ii) = 0;
                    historyEntry = { name, 'Wrong'};
                case 'Repeat' 
                    continue;
                case 'Cancel'
                    return;
            end
            ii = ii+1;
            Idx.currentPlay = Idx.currentPlay + 1;
            historyEntry{end+1} = stats;
            history(end+1,:) = historyEntry;
        end
       
        relativeSuccess = sum(recordedResponse)/NumOfWords;        
        
        if(beginningStageFlag)
            if( 1 == relativeSuccess )
                indicatorNextStep = 1;
            else
                indicatorNextStep = -1;
            end
            
        else
            % Normal execution of SNR finding
            if(relativeSuccess > cretionThreshold)
                indicatorNextStep = 1;
            elseif(relativeSuccess < cretionThreshold)
                indicatorNextStep = -1;
            else %relativeSuccess == cretionThreshold
                indicatorNextStep = 0;
            end
        end
        msg = "";
        Options = {'Confirm','Repeat last round','Cancel'};
        switch indicatorNextStep
            case 1
                title = "Increasing the Noise";
                msg = "The Noise will be increased by " + jumpOrder(Idx.jump) ...
                     + " dB ";
                 if(~beginningStageFlag)
                     msg = msg + " Because success was more then 50%";
                 end
                 msg = msg +newline+ "New Noise will be "+(jumpOrder(Idx.jump) + mdb.TX2.stimulus.noise.amp)+...
                              " dB.";
            case -1
                title = "Decreasing the Noise";
                msg = "The Noise will be decrease by " + jumpOrder(Idx.jump) ...
                     + " dB";
                if(~beginningStageFlag)
                   msg = msg + " Because success was less then 50%";
                end
                 msg = msg +newline+ "New Noise will be "+ ( mdb.TX2.stimulus.noise.amp - jumpOrder(Idx.jump))+...
                              " dB.";
            case 0 
                title = "The final Threshold";
                msg = "Success was 50% then the final SNR threshold is " +...
                       (mdb.TX1.stimulus.speech.amp - mdb.TX2.stimulus.noise.amp) ;
                   Options = {'Finish the test','Repeat last round','Cancel'};
            otherwise
                title = "Error";
                msg = "Error";
        end
            
        selection = uiconfirm(app.UIFigure,stats+newline+msg,title...
                            ,'Options', Options);
                
                        
                switch selection
                    case 'Confirm'
                        %updating SNR and success data 
                        SNRData.SNR = [SNRData.SNR ( mdb.TX1.stimulus.speech.amp - mdb.TX2.stimulus.noise.amp)];
                        SNRData.Success = [SNRData.Success relativeSuccess];
                        mdb.TX2.stimulus.noise.amp = ...
                            indicatorNextStep*jumpOrder(Idx.jump) + ...
                            mdb.TX2.stimulus.noise.amp;

                        if( beginningStageFlag && (-1 == indicatorNextStep ))
                            Idx.NumOfWords = Idx.NumOfWords + 1;
                            beginningStageFlag = 0 ; %end of begining
                        end
                        if(~beginningStageFlag && (Idx.jump<length(jumpOrder)))
                            Idx.jump = Idx.jump +1;
                        end

                    case 'Repeat last round'
                        continue;
                    case 'Finish the test'
                        SNRData.SNR = [SNRData.SNR ( mdb.TX1.stimulus.speech.amp - mdb.TX2.stimulus.noise.amp)];
                        SNRData.Success = [SNRData.Success relativeSuccess];
                        break;
                    case 'Cancel'
                        return;
                end
    

                    
        
        
    end
    
    personalDetails = {'Name' , app.NameEditField.Value;...
                       'Age' , app.AgeEditField.Value;...
                       'Gender',app.GenderEditField.Value;...
                       'Ear', app.EarEditField.Value;...
                       'Test', app.TestNameEditField.Value };
    history = cell2table(history,'VariableNames',{'Words','Result','Signal and Nosie'});               
    
    outputFile = fullfile(app.CUsersLabDocumentsButton.Text,[app.NameoffiileEditField.Value '.xlsx']);
    writecell(personalDetails,outputFile,'Sheet',1,'Range','A1');
    writetable(history,outputFile,'Sheet',1,'Range','H1');
    writematrix(PrintData(mdb)',outputFile,'Sheet',1,'Range','K1');
    
    t = table(SNRData.SNR',SNRData.Success','VariableNames',{'SNR','SUCCESS'});
    t= sortrows(t);
    writetable(t,outputFile ,'Sheet',1,'Range','D1');
    plot(t.SNR,t.SUCCESS*100 ,'*');
%     title('Summary of the SNR Expreriment');
    xlabel('SNR');
    ylabel('Percentage Of Success');
    ylim([0 100]);
    
    

end