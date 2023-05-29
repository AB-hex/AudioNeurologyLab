function [success,record,history,Idx,resultSNR,up,bottom] = SNRFinderPhase1Step(app,signalLevel,noiseLevel,...
                                                        record,history,NumOfWords,Idx,playOrder,wordsDir,jump,up,bottom)
     
                                                   
     response = zeros([1 NumOfWords]);
     success = -1;
     SNRLevel = signalLevel - noiseLevel;
     resultSNR = -1;
     
      stats = "[Signal: " + signalLevel+ " dB , Noise: " + noiseLevel+ " dB, SNR: "+SNRLevel+" ]"; 
       ii=1;
       while ii<=NumOfWords
            msg = SNRFinderPlayWord(app,signalLevel,noiseLevel,wordsDir,stats,Idx,ii,NumOfWords,playOrder);
            
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
       switch relativeSuccess
           case 0 
               success=1;
               bottom = SNRLevel;
               up = record{find([record{:,2}]==1,1,'last'),1}; %TODO FIX Index in position 2 exceeds array bounds.
               newSNRLevel = mean([SNRLevel record{find([record{:,2}]~=0,1,'last'),1}]);
               newNoiseLevel = signalLevel - newSNRLevel;
               title = "Increasing the SNR";
               msg = "Zero response of words, increasing the SNR (lowering the noise)."+newline;
                   
                
           otherwise
%                up = SNRLevel; %TODO: check with yossi if I need to add a case to check if success is 1 and then put the up bouandry on 100% success point or 50% success point
               newNoiseLevel = noiseLevel + jump;
               newSNRLevel = signalLevel - newNoiseLevel;
                title = "Decreasing the SNR";
                msg = "There was response of words. decreasing the SNR (inscreasing the noise)."+newline;
                     
       end
        msg = msg +  "new SNR level: "+newSNRLevel+" (noise level: "+newNoiseLevel +" dB).";
        Options = {'Confirm','Repeat last round','Cancel'};
        
          selection = uiconfirm(app.UIFigure,stats+newline+msg,title,'Options', Options);
        switch selection
            case 'Confirm'
                if(0.5~=relativeSuccess)
                    record(end+1,:)={SNRLevel,relativeSuccess};
                    if(length(record(:,1))~=1)
                        record = sortrows(record,1,'descend');
                    end
                end
                if(1 == success)
                    resultSNR = newSNRLevel;
                    return;
                end
                  [success,record,history,Idx,resultSNR,up,bottom] = SNRFinderPhase1Step(app,signalLevel,newNoiseLevel,...
                                                        record,history,NumOfWords,Idx,playOrder,wordsDir,jump,up,bottom);
                
            case 'Repeat last round'
                [success,record,history,Idx,resultSNR,up,bottom] = SNRFinderPhase1Step(app,signalLevel,noiseLevel,...
                                                        record,history,NumOfWords,Idx,playOrder,wordsDir,jump,up,bottom);
            case 'Cancel'
                success=-1;
                return;
                
        end
                
       
end