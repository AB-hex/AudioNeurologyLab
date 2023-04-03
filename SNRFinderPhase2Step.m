function [success,record,history,Idx,resultSNR]=SNRFinderPhase2Step(app,...
                                           signalLevel,noiseLevel,...
                                           record,history,NumOfWords,...
                                           Idx,playOrder,wordsDir,bottom,up)
                                       
    response = zeros([1 NumOfWords]);
     success = -1;
     SNRLevel = signalLevel - noiseLevel;
     resultSNR = -1;
     stats = "[Signal: " + signalLevel+ " dB , Noise: " + noiseLevel+ " dB, SNR: "+SNRLevel+" ]"; 
    
    if(abs(up-bottom) < 2)
        success = 1;
        record(end+1,:)={SNRLevel,0.5};
        record = sortrows(record,1,'descend');
        resultSNR = SNRLevel;
        selection = uiconfirm(app.UIFigure,stats+newline+"Resolution is less then 2dB, average will be taken."+...
            newline+ "Final SNR is: " + resultSNR,"FINAL RESULT");
        
        return;
        
    end
     
   ii=1;
   while ii<=NumOfWords
      msg = SNRFinderPlayWord(app,signalLevel,noiseLevel,   wordsDir,stats,Idx,ii,NumOfWords,playOrder);
      
      msg = msg +newline+ 'The word was repeated this correctly?';
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
                return;
      end
        ii = ii+1;
        Idx.currentPlay = Idx.currentPlay + 1;
        history(end+1,:)={wordsDir(playOrder(Idx.currentPlay)).name,selection,stats}; 
        
       
      end
   
      relativeSuccess = sum(response)/NumOfWords;
      if( relativeSuccess > 0.5 )
               newSNRLevel = mean([SNRLevel bottom]);
               newNoiseLevel = signalLevel - newSNRLevel;
               newBottom = bottom;
               newUp = SNRLevel;
               title = "Increasing the SNR";
               msg = "More the 50% of the words responded correctly, lowering the SNR (increasing the noise)."+newline+...
                             "new SNR level: "+newSNRLevel+" (noise level: "+newNoiseLevel +" dB).";
                
               Options = {'Confirm','Repeat last round','Cancel'};
      elseif( relativeSuccess < 0.5 )
               newSNRLevel = mean([SNRLevel up]);
               newNoiseLevel = signalLevel - newSNRLevel;
               newBottom = SNRLevel;
               newUp = up;
               title = "Increasing the SNR";
               msg = "Less the 50% of the words responded correctly, increasing the SNR (lowering the noise)."+newline+...
                             "new SNR level: "+newSNRLevel+" (noise level: "+newNoiseLevel +" dB).";
                
               Options = {'Confirm','Repeat last round','Cancel'};
      else %relativeSuccess == 0.5 
         title = "FINAL RESULT";
         msg = "50% of the words were responeded correct, Then the final SNR threshold is " +...
                       SNRLevel;
         Options = {'Finish the test','Repeat last round','Cancel'};
          
      end

       selection = uiconfirm(app.UIFigure,stats+newline+msg,title,'Options', Options);
        switch selection
            case 'Confirm'
                record(end+1,:)={SNRLevel,relativeSuccess};
                if(length(record(:,1))~=1)
                    record = sortrows(record,1,'descend');
                end

                  [success,record,history,Idx,resultSNR] = SNRFinderPhase2Step(app,signalLevel,newNoiseLevel,...
                                                        record,history,NumOfWords,Idx,playOrder,wordsDir,newBottom,newUp);
                
            case 'Repeat last round'
                [success,record,history,Idx,resultSNR] = SNRFinderPhase2Step(app,signalLevel,noiseLevel,...
                                                        record,history,NumOfWords,Idx,playOrder,wordsDir,bottom,up);
            case 'Finish the test'
                success = 1;
                record(end+1,:)={SNRLevel,relativeSuccess};
                record = sortrows(record,1,'descend');
                resultSNR = SNRLevel;
                return;
            
            case 'Cancel'
                success=-1;
                return;
                
        end
end