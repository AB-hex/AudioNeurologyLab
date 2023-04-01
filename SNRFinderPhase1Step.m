function [success,record,history,Idx,resultSNR,upBoundary,bottomBoundary] = SNRFinderPhase1Step(app,signalLevel,noiseLevel,...
                                                        record,history,NumOfWords,Idx,playOrder,wordsDir,jump)
     
                                                   
     response = zeros([1 NumOfWordsOrder(Idx.NumOfWords)]);
     success = -1;
     SNRLevel = signalLevel - noiseLevel;
     [resultSNR,upBoundary,bottomBoundary] = deal(-1,-1,-1);
      stats = "[Signal: " + signalLevel+ " dB , Noise: " + noiseLevel+ " dB, SNR: "+SNRLevel+" ]"; 
     ii=1
       while ii<=NumOfWords
            msg = SNRFinderPlayWord(app,wordsDir,stats,Idx,ii,NumOfWords,playOrder);
            
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
            history(end+1,:)={name,selection,stats};      
            
       end
       
       relativeSuccess = sum(recordedResponse)/NumOfWords;
       switch relativeSuccess
           case 0 
               success=1;
               bottomBoundary = SNRLevel;
               newSNRLevel = mean([SNRLevel record{find([record{:,2}]~=0,1,'last'),1}]);
               newNoiseLevel = signalLevel - newSNRLevel;
               title = "Increasing the SNR";
               msg = "Zero response of words, increasing the SNR (lowering the noise)."+newline;
                   
                
           otherwise
               upBoundary = SNRLevel; %TODO: check with yossi if I need to add a case to check if success is 1 and then put the up bouandry on 100% success point or 50% success point
               newNoiseLevel = noiseLevel + jump;
               newSNRLevel = signalLevel - noiseLevel;
                title = "Decreasing the SNR";
                msg = "There was response of words. decreasing the SNR (inscreasing the noise)."+newline;
                     
       end
        msg = msg +  "new SNR level: "+newSNRLevel+" (noise level: "+newNoiseLevel +" dB).";
        Options = {'Confirm','Repeat last round','Cancel'};
        
          selection = uiconfirm(app.UIFigure,stats+newline+msg,title,'Options', Options);
        switch selection
            case 'Confirm'
                record(end+1,:)={SNRLevel,relativeSuccess};
                if(length(record(:,1))~=1)
                    record = sortrows(record,1,'descend');
                end
                if(1 == success)
                    resultSNR = newSNRLevel;
                    return;
                end
                  [success,record,history,Idx,resultSNR] = SNRFinderPhase1Step(app,signalLevel,newNoiseLevel,...
                                                        record,history,NumOfWords,Idx,playOrder,wordsDir,jump);
                
            case 'Repeat last round'
                [success,record,history,Idx,resultSNR] = SNRFinderPhase1Step(app,signalLevel,noiseLevel,...
                                                        record,history,NumOfWords,Idx,playOrder,wordsDir,jump);
            case 'Cancel'
                success=-1;
                return;
                
        end
                
       
end