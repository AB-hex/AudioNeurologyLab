function HandleExpriement(script,Button)
    
   
    Initialize_Selection("TX1");
    Initialize_Selection("TX2");
    Initialize_Selection("TX3");
    TXNumber = 1;
    script = cellfun(@(x) lower(x) ,script ,'UniformOutput' ,false); %uppercase to lowercase
%     app = cellfun(@(x) strtrim(x) ,app ,'UniformOutput' ,false);%trim all spaces 
    %main loop parser
    %Trimming missing cells rows
%     missing_idx = cellfun(@ismissing, script(:,1), 'UniformOutput', false);
%     missing_idx = cell2mat( cellfun(@any,missing_idx, 'UniformOutput', false) );
%     script=script(~missing_idx,:);
    currPath = '';
    currSignal = '';
    load mdb;
    for ii = 1:length(script)
        if(ismissing(script{ii,1}))
            continue;
        end
        switch script{ii,1}
            case 'signal'
                if( TXNumber > 3 )
                    errordlg('More then 3 different inputs in the same time were detected','Too much stimulations');
                    return;
                else 
                    switch script{ii,2}
                        case 'pure tone'
                            mdb.master.(strcat('TX',num2str(TXNumber),'_select')) = 1;            
                            currPath = mdb.(strcat('TX',num2str(TXNumber))).stimulus.PT;
                            mdb.(strcat('TX',num2str(TXNumber))).stimulus.stimulusSelect.pureTone = 1;
                            currSignal = 'Pure Tone';
                        case 'noise'
                            mdb.master.(strcat('TX',num2str(TXNumber),'_select')) = 1;            
                            currPath = mdb.(strcat('TX',num2str(TXNumber))).noise;
                            mdb.(strcat('TX',num2str(TXNumber))).stimulus.stimulusSelect.noise = 1;
                            currSignal = 'Noise';
                        %TODO add file selection path support
                        otherwise 
                            ErrorMessage(ii,'Signal was not recognised','Unrecognised Signal');
%                             errordlg(strcat('line ',ii,': Signal was not recognised'),'Unrecognised Signal');
                            return;  
                    end
                end
            case 'freq'
                if(~isnumeric(script{ii,2}))
%                      errordlg('Frequency have to be numeric number','Not Numeric');
                     ErrorMessage(ii,'Frequency have to be numeric number','Not Numeric');
                     return;
                end
                if(script{ii,2}<200 ||script{ii,2}>8200)
%                     errordlg('Frequency value have to be between 200 and 8200 Hz','Outside range frequency');
                    ErrorMessage(ii,'Frequency value have to be between 200 and 8200 Hz','Outside range frequency');
                     return;
                end
                if(~isfield(currPath,'freq'))
%                     errordlg('No frequency option in one of the chosen signals','Invalid option');
                     ErrorMessage(ii,'No frequency option in one of the chosen signals','Invalid option');
                     return;
                end
                currPath.freq = script{ii,2};    
            case 'level'
                if(script{ii,2}<-75 ||script{ii,2}>125)
%                     errordlg('Level value have to be between -75 db to 125 db','Outside range level');
                     ErrorMessage(ii,'Level value have to be between -75 db to 125 db','Outside range level');
                     return;
                end
                  if(~isnumeric(script{ii,2}))
%                      errordlg('level have to be numeric number','Not Numeric');
                      ErrorMessage(ii,'level have to be numeric number','Not Numeric');
                   return;
                  end
                  %TODO fix the issue with currPath which do not update the
                  %correct fields in mdb but in the sub copy of it in
                  %currPath. maybe redesign the variable.
                  currPath.amp  = script{ii,2};
            case 'output ports'
                if(isnumeric(script{ii,2}))
                    selectedSpeakers = script{ii,2};
                else 
                    selectedSpeakers = cellfun(@(x) str2double(x),strsplit(script{ii,2},','));
                end
                mdb.(strcat('TX',num2str(TXNumber))).transducer.FF.DacVector(selectedSpeakers) = 1;
                TXNumber = TXNumber + 1;
                
            case 'duration'
                  if(~isnumeric(script{ii,2}))
%                    errordlg('Duration value have to be numeric','Duration Not Numeric');
                   ErrorMessage(ii,'Duration value have to be numeric','Duration Not Numeric');
                   return;
                  end
                  durationInSec =  script{ii,2}/1000;
                  mdb.TX1.stimulus.burstDuration =   durationInSec;
                  mdb.TX2.stimulus.burstDuration =   durationInSec;
                  mdb.TX3.stimulus.burstDuration =   durationInSec;  
            case 'play'
                if(0 == mdb.TX1.stimulus.burstDuration)
%                    errordlg('Missing duration value parameter','No duration');
                   ErrorMessage(ii,'Missing duration value parameter','No duration');
                   return;
                end 
                save mdb mdb;
                [TX1_playMode,TX2_playMode,TX3_playMode] = play_signal_multi(mdb.master.TX1_select,mdb.master.TX2_select,mdb.master.TX3_select); 
                pause(mdb.TX1.stimulus.burstDuration);
                TXall_stop_signal();
                
                Initialize_Selection("TX1");
                Initialize_Selection("TX2");
                Initialize_Selection("TX3");
                TX = 1;
                load mdb;
            otherwise
%                 if(ismissing(script{ii,1}))
%                     continue;
%                 end
                ErrorMessage(ii,strcat('The word "',script{ii,1},'"  is invalid'),'Unregonized option');
%                 errordlg(strcat('The word ',app{ii,1},' is invalid'),'Unregonized option');
                return;
                  
        end
    end
       save mdb mdb;
       Button.Value = 0;
       Button.Text = "Start";
end