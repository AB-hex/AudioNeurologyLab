function [success,record,history,result] = SptialHearingTestQuiteStep(app,signalType,signalLevel,speakers,record,history,duration)

    playOrder = randperm(length(speakers));
    ii=1;
    load mdb;
    mdb.TX1.stimulus.(signalType).amp = signalLevel;
    
    response = zeros([1 length(speakers)]);
    result = -1;
    
%playing speakers and record responses    
    while(ii <= length(speakers))
      currSpeaker = speakers(playOrder(ii));
      stats = "[Signal: " + signalLevel +" dB]";
      currAngle = (8-currSpeaker)*45 +"°";
      msg = stats + newline+ "Current Speaker: "+ currSpeaker + " with angle of " +currAngle;
    
      mdb.TX1.transducer.FF.DacVector(currSpeaker) = 1;
      
      if(app.WordsFolderButton.Value)
        
        wordsDir = dir(app.ChoosesignalwordsfolderButtonSpatialHearing.Text+"\*.wav"); 
        currWordIdx = randi(length(wordsDir));
        filename = fullfile(wordsDir(currWordIdx).folder,wordsDir(currWordIdx).name);
        
%         [y,fs] =audioread(filename);
%         duration = length(y)/fs;
        duration = audioinfo(filename).Duration;
        mdb.TX1.stimulus.speech.source = filename;
        mdb.TX1.stimulus.burstDuration = duration;
        
        msg = msg + newline +  wordsDir(currWordIdx).name;
      end
      
        d = uiprogressdlg(app.UIFigure,'Title','Playing',...
                'Message',msg,'Value',ii/length(speakers));
      save mdb mdb;
     [~,~,~] = play_signal_multi(mdb.master.TX1_select,mdb.master.TX2_select,mdb.master.TX3_select); 
      pause(duration + 0.175 );  
      TXall_stop_signal();
      mdb.TX1.transducer.FF.DacVector(currSpeaker) = 0;
      close(d);
      
      msg = msg +newline+ 'The speaker was located correctly?';
      selection = uiconfirm(app.UIFigure,msg,'Confirm response'...
                  ,'Options', {'Correct','Wrong','Repeat','Cancel'});
      switch selection
        case 'Correct'
            response(ii) = 1;
        case 'Wrong'
            response(ii) = 0;
        case 'Repeat' 
            continue;
        case 'Cancel'
            success = -1;
            return;
      end
      ii = ii+1;
      historyLine= {currSpeaker,currAngle, selection,stats};
      
      if(app.WordsFolderButton.Value)
         historyLine(end+1) = {wordsDir(currWordIdx).name};
      end
      history(end+1,:) = historyLine;
      
    end
      
    successSpeakers = sort(speakers(playOrder(response==1)));
    switch length(successSpeakers)
        case 0
            title = "Increasing the level";
            msg = "No response on each speaker, increasing the level signal."
            newLevel = mean([signalLevel record{find([record{:,2}]~=0,1,'last'),1}]); 
            msg =msg +newline+"New level will be "+ newLevel + " dB."; 
            
            Options = {'Confirm','Repeat last round','Cancel'};
        case 1
            title = "FINAL RESULT";
            msg = "Speaker " + successSpeakers ...
                 + " is last that left with signal at "+signalLevel;
            Options = {'Finish the test','Repeat last round','Cancel'};
            result = successSpeakers;
%         case 2
%              title = "FINAL RESULT";
%              msg = "2 Speakers left: " +successSpeakers(1)+", "+ successSpeakers(2)+...
%              newline+ "Final result is will be the average: " + mean(successSpeakers)+...
%               " at level: "+ signalLevel+" dB.";
%              Options = {'Finish the test','Repeat last round','Cancel'};
%              result = mean(successSpeakers);
        otherwise 
            title = "Decreasing the level";
            msg = "Speakers: " + regexprep(num2str(successSpeakers),'\s+',',') + " was responded correctly.";
            zero_response_idx=-1;
            if(~isempty(record))
                zero_response_idx = find([record{:,2}]==0,1);
                if(~isempty(zero_response_idx))
                    newLevel = mean([signalLevel record{zero_response_idx,1}]);
                end
            end
            if(isempty(record)||isempty(zero_response_idx))
                if(signalLevel - 10 > 0)
                    newLevel = signalLevel - 10;
                else
                    newLevel = signalLevel - signalLevel/2;
                end
            end
            msg =msg +newline+"New level will be "+ newLevel + " dB."; 
            
            Options = {'Confirm','Repeat last round','Cancel'};
            
    end
    
     selection = uiconfirm(app.UIFigure,stats+newline+msg,title...
                            ,'Options', Options);
                
    switch selection 
        case 'Confirm'
            
            record(end+1,:) = {signalLevel,length(successSpeakers),regexprep(num2str(successSpeakers),'\s+',','),...
                regexprep(regexprep(num2str((8-successSpeakers).*45),'\d(?=\s|$)','$0°,'),',$','')};
            if(length(record(:,1))~=1)
                record = sortrows(record,1,'descend');
            end
            if(0==length(successSpeakers))
            [success,record,history,result] = SptialHearingTestQuiteStep(app,signalType,newLevel,speakers,record,history,duration);
            else
              [success,record,history,result] = SptialHearingTestQuiteStep(app,signalType,newLevel,successSpeakers,record,history,duration);
            end
        case 'Repeat last round'
            [success,record,history,result] = SptialHearingTestQuiteStep(app,signalType,signalLevel,speakers,record,history,duration);
        case 'Finish the test'
                record(end+1,:) = {signalLevel,length(successSpeakers),regexprep(num2str(successSpeakers),'\s+',','),...
                    regexprep(regexprep(num2str((8-successSpeakers).*45),'\d(?=\s|$)','$0°,'),',$','')};
                record = sortrows(record,1,'descend');
                success=1;
                return;
        case 'Cancel'
            success=-1;
            return;
    end
    
    


end