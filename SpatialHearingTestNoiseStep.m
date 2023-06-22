function  [success,record,history,result] = SpatialHearingTestNoiseStep(app,signalLevel,noiseLevel,speakers,noiseDetails,record,history,duration)
        playOrder = randperm(length(speakers));    
        ii=1;
        load mdb;
        mdb.(noiseDetails.TXModeNoise).stimulus.(noiseDetails.typeNoise).amp = noiseLevel; 
        response = zeros([1 length(speakers)]);
        result = -1;        
        SNRLevel = signalLevel - noiseLevel;

  while(ii <= length(speakers))
      currSpeaker = speakers(playOrder(ii));
      stats = "[Signal: " + signalLevel +" dB, Noise: "+noiseLevel+" dB, SNR: "+ SNRLevel+"]";
      currAngle = (8-currSpeaker)*45 +"°";
      msg = stats + newline+ "Current Signal Speaker: "+ currSpeaker + " with angle of " +currAngle; ;
%       if(strcmp(noiseDetails.TXModeNoise,"TX2"))
      if(app.FixedSpeakersnoiseoutputButton.Value)
          noiseOutput = 1:8;
          noiseOutput = noiseOutput(mdb.TX2.transducer.FF.DacVector);
          if(length(noiseOutput)>1)
            noiseOutput = regexprep(num2str(noiseOutput),'\s+',',');
          end
        
      else
        mdb.TX2.transducer.FF.DacVector(currSpeaker) = 1;%Noise TX2 selection need to be same as TX1
        noiseOutput = currSpeaker;
      end
      msg = msg + " Noise Speakers: "+ noiseOutput;
%       d = uiprogressdlg(app.UIFigure,'Title','Playing',...
%                 'Message',msg,'Value',ii/length(speakers));
      mdb.TX1.transducer.FF.DacVector(currSpeaker) = 1;
      if(app.noiseFromFileFlag)
          noise_list = dir('Noise\*.wav');
          randomNoiseChoice = noise_list(randi(length(noise_list)));
          mdb.(noiseDetails.TXModeNoise).stimulus.speech.source  = fullfile(randomNoiseChoice.folder,randomNoiseChoice.name); 
      end
      if(app.WordsFolderButton.Value)
        wordsDir = dir(app.ChoosesignalwordsfolderButtonSpatialHearing.Text+"\*.wav"); 
        currWordIdx = randi(length(wordsDir));
        filename = fullfile(wordsDir(currWordIdx).folder,wordsDir(currWordIdx).name);
        
%         [y,fs] =audioread(filename);
%         duration = length(y)/fs;
        duration = audioinfo(filename).Duration;
        mdb.TX1.stimulus.speech.source = filename;
        mdb.TX1.stimulus.burstDuration = duration;
        msg = msg + newline + wordsDir(currWordIdx).name;
      end
        d = uiprogressdlg(app.UIFigure,'Title','Playing',...
            'Message',msg,'Value',ii/length(speakers));
      save mdb mdb;
     [~,~,~] = play_signal_multi(mdb.master.TX1_select,mdb.master.TX2_select,mdb.master.TX3_select); 
      pause(duration + 0.175 );  
      TXall_stop_signal();
      mdb.TX1.transducer.FF.DacVector(currSpeaker) = 0;
      if(~app.FixedSpeakersnoiseoutputButton.Value)
        mdb.TX2.transducer.FF.DacVector(currSpeaker) = 0;
      end
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
      
     ii=ii+1;
     historyLine = {currSpeaker,currAngle, selection,stats};
     if(app.WordsFolderButton.Value)
        historyLine(end+1) = {wordsDir(currWordIdx).name};
     end
     historyLine(end+1) = {noiseOutput};
     history(end+1,:)= historyLine;
  end
  
    successSpeakers = sort(speakers(playOrder(response==1)));  
    
     switch length(successSpeakers)
        case 0
            title = "Increasing the SNR";
            msg = "No response from each speaker, reducing the noise level."
            newSNR = mean([SNRLevel record{find([record{:,2}]~=0,1,'last'),1}]);
            newLevel = signalLevel - newSNR; 
            msg =msg +newline+"New SNR will be "+ newSNR+ " (Noise: "+newLevel + " dB)."; 
            
            Options = {'Confirm','Repeat last round','Cancel'};
         case 1
            title = "FINAL RESULT";
            msg = "Speaker " + successSpeakers ...
                 + " is last that left with SNR at "+SNRLevel;
            Options = {'Finish the test','Repeat last round','Cancel'};
            result = successSpeakers;
%          case 2
%          title = "FINAL RESULT";
%          msg = "2 Speakers left: " +successSpeakers(1)+", "+ successSpeakers(2)+...
%          newline+ "Final result is will be the average: " + mean(successSpeakers)+...
%           " at SNR: "+ SNRLevel;
%          Options = {'Finish the test','Repeat last round','Cancel'};
%          result = mean(successSpeakers);
         otherwise 
            title = "Decreasing SNR";
            msg = "Speakers: " + regexprep(num2str(successSpeakers),'\s+',',') + " was responded correctly.";
            zero_response_idx=-1;
            if(~isempty(record))
                zero_response_idx = find([record{:,2}]==0,1);
                if(~isempty(zero_response_idx))
                    newSNR = mean([SNRLevel record{zero_response_idx,1}]);
                    newLevel = signalLevel - newSNR;
                end
            end
            if(isempty(record)||isempty(zero_response_idx))
                    newLevel = noiseLevel + 10;
                    newSNR = signalLevel - newLevel;
            end
            msg =msg +newline+"New SNR will be "+ newSNR+ " (Noise: " +newLevel+" dB)."; 
            
            Options = {'Confirm','Repeat last round','Cancel'};
            
     end

       selection = uiconfirm(app.UIFigure,stats+newline+msg,title...
                            ,'Options', Options);
                
    switch selection 
        case 'Confirm'
            
            record(end+1,:) = {SNRLevel,length(successSpeakers),regexprep(num2str(successSpeakers),'\s+',','),...
                                 regexprep(regexprep(num2str(successSpeakers),'\d(?=\s|$)','$0°,'),',$','')};
            if(length(record(:,1))~=1)
                record = sortrows(record,1,'descend');
            end
            if(0==length(successSpeakers))
            [success,record,history,result] = SpatialHearingTestNoiseStep(app,signalLevel,newLevel,speakers,noiseDetails,record,history,duration);
            else
              [success,record,history,result] = SpatialHearingTestNoiseStep(app,signalLevel,newLevel,successSpeakers,noiseDetails,record,history,duration);
            end
        case 'Repeat last round'
            [success,record,history,result] = SpatialHearingTestNoiseStep(app,signalLevel,noiseLevel,speakers,noiseDetails,record,history,duration);
        case 'Finish the test'
                record(end+1,:) = {SNRLevel,length(successSpeakers),regexprep(num2str(successSpeakers),'\s+',','),...
                                 regexprep(regexprep(num2str((8-successSpeakers).*45),'\d(?=\s|$)','$0°,'),',$','')};
                record = sortrows(record,1,'descend');
                success=1;
                return;
        case 'Cancel'
            success=-1;
            return;
    end  
        
        
        
end