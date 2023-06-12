function HandleExpriement(script,Button)
    
   
    Initialize_Selection("TX1");
    Initialize_Selection("TX2");
    Initialize_Selection("TX3");
    TXNumber = 1;
    AMMode = 0;%For Pure Tone
    FMMode = 0;%For Pure Tone
    script = cellfun(@(x) lower(x) ,script ,'UniformOutput' ,false); %uppercase to lowercase
%     app = cellfun(@(x) strtrim(x) ,app ,'UniformOutput' ,false);%trim all spaces 
    %main loop parser
    %Trimming missing cells rows
%     missing_idx = cellfun(@ismissing, script(:,1), 'UniformOutput', false);
%     missing_idx = cell2mat( cellfun(@any,missing_idx, 'UniformOutput', false) );
%     script=script(~missing_idx,:);
    currPath = '';
    currSignal = '';
    folerPath = '';
    load mdb;
    startLineRepeat = 0;
    endLineRepeat = -1;
    repeatCounter = -1;
    durationInSec = 0;
    ii = 1;
    while ii <= length(script)
        if(ismissing(script{ii,1}))
            ii = ii + 1;
            continue;
        end
        %TODO: add random to files in folder + wait
        %TODO: add random by satistics inside folder and speakers
        %TODO: add more options of random for diffenet signals
        %TODO: add noise to signal test (here or seperate function
        %TODO: add mdb state record and output export
        switch script{ii,1}
            case 'signal'
                if( TXNumber > 3 )
                    errordlg('More then 3 different inputs in the same time were detected','Too much stimulations');
                    return;
                else 
                    FMMode = 0;
                    AMMode = 0;
                    switch script{ii,2}
                        case 'pure tone'
                            mdb.master.(strcat('TX',num2str(TXNumber),'_select')) = 1;            
                            currPath = {strcat('TX',num2str(TXNumber));'stimulus';'PT'};
                            mdb.(strcat('TX',num2str(TXNumber))).stimulus.stimulusSelect.pureTone = 1;
                            currSignal = 'Pure Tone';
                            
                        case 'noise'
                            mdb.master.(strcat('TX',num2str(TXNumber),'_select')) = 1;            
                            currPath = {strcat('TX',num2str(TXNumber));'stimulus';'noise'};
                            mdb.(strcat('TX',num2str(TXNumber))).stimulus.stimulusSelect.noise = 1;
                            currSignal = 'Noise';
                            if(strcmp(script{ii,3},'white noise'))
                                mdb = setfield(mdb,currPath{:},'source',1);
                            elseif(strcmp(script{ii,3},'nb noise'))
                                mdb = setfield(mdb,currPath{:},'source',2);
                            else
                                 ErrorMessage(ii,'No noise mod is detected','No noise mode');
                            end
                        case 'file'
                             mdb.master.(strcat('TX',num2str(TXNumber),'_select')) = 1;
                             currPath = {strcat('TX',num2str(TXNumber));'stimulus';'speech'};
                             mdb.(strcat('TX',num2str(TXNumber))).stimulus.stimulusSelect.speech = 1;
                             mdb.(strcat('TX',num2str(TXNumber))).stimulus.speech.source = script{ii,3};
                             currSignal = 'File';
                             
                        case 'folder'
                            mdb.master.(strcat('TX',num2str(TXNumber),'_select')) = 1;
                            currPath = {strcat('TX',num2str(TXNumber));'stimulus';'speech'};
                            mdb.(strcat('TX',num2str(TXNumber))).stimulus.stimulusSelect.speech = 1;
                            folderPath = script{ii,3};
                            currSignal = 'Folder';                            
                        otherwise 
                            ErrorMessage(ii,'Signal was not recognised','Unrecognised Signal');
                            return;  
                    end
                end
            case 'freq'
                if(~isnumeric(script{ii,2}))
                     ErrorMessage(ii,'Frequency have to be numeric number','Not Numeric');
                     return;
                end
                if(script{ii,2}<200 ||script{ii,2}>8200)
                    ErrorMessage(ii,'Frequency value have to be between 200 and 8200 Hz','Outside range frequency');
                     return;
                end
                if(~isfield(getfield(mdb,currPath{:}),'freq'))
                     ErrorMessage(ii,'No frequency option in one of the chosen signals','Invalid option');
                     return;
                end  
                mdb = setfield(mdb,currPath{:},'freq',script{ii,2});
                
            case 'level'
                if(script{ii,2}<-75 ||script{ii,2}>125)
                     ErrorMessage(ii,'Level value have to be between -75 db to 125 db','Outside range level');
                     return;
                end
                  if(~isnumeric(script{ii,2}))
                      ErrorMessage(ii,'level have to be numeric number','Not Numeric');
                   return;
                  end
                 mdb = setfield(mdb,currPath{:},'amp',script{ii,2});
                 
            case 'phase'
                if(strcmp('Pure Tone',currSignal) && ismember(script{ii,2},[0,90,180,270]))
                    mdb = setfield(mdb,currPath{:},'phase',script{ii,2});
                elseif(ismember(script{ii,2},[0,180]))
                    mdb = setfield(mdb,currPath{:},'phase',script{ii,2});
                else
                    ErrorMessage(ii,'phase value is not valid','Error')
                end
                
            case 'FM'
                if(~strcmp(currSignal,'Pure Tone'))
                    ErrorMessage(ii,'FM Modulation not in pure tone signal','Error');
                end
                FMMode = 1;
                modulationType = PTModulationModeHelper(FMMode,AMMode);
                mdb = setfield(mdb,currPath{:},'modulationType',modulationType);
                mdb = setfield(mdb,currPath{:},'modIndex',script{ii,2});
                
            case 'AM'
                if(~strcmp(currSignal,'Pure Tone'))
                    ErrorMessage(ii,'AM Modulation not in pure tone signal','Error');
                    return
                end
                AMMode = 1;
                modulationType = PTModulationModeHelper(FMMode,AMMode);
                mdb = setfield(mdb,currPath{:},'modulationType',modulationType);
                mdb = setfield(mdb,currPath{:},'modDepth',script{ii,2});
            case 'mod freq'
                if(~strcmp(currSignal,'Pure Tone'))
                    ErrorMessage(ii,'mod freq outside pure tone','Error');
                    return;
                end
                mdb = setfield(mdb,currPath{:},'modFreq',script{ii,2});
                
            case 'nb center freq'
                if(~strcmp(currSignalm,'Noise')||getfield(mdb,currPath{:},'source')~= 2)
                   ErrorMessage(ii,'mod center freq outside is not in NB noise','Error');
                   return;
                end 
                mdb = setfield(mdb,currPath{:},'NBCntrFrq',script{ii,2});
            case 'nb bw'
                if(~strcmp(currSignalm,'Noise')||getfield(mdb,currPath{:},'source')~= 2)
                   ErrorMessage(ii,'mod center freq outside is not in NB noise','Error');
                   return;
                end 
                mdb = setfield(mdb,currPath{:},'NBBW',script{ii,2});
            
            case 'onset'
                 mdb.("TX"+TXNumber).stimulus.onset = script{ii,2};
            case 'offset'
                 mdb.("TX"+TXNumber).stimulus.offset = script{ii,2};
            case 'output ports'
                if(isnumeric(script{ii,2}))
                    selectedSpeakers = script{ii,2};
                else 
                    selectedSpeakers = cellfun(@(x) str2double(x),strsplit(script{ii,2},','));
                end
                if(strcmp(script{ii,3},'random')) %for random support
                    random_idx = randi([1 length(selectedSpeakers)] , 1,script{ii,4});
                    selectedSpeakers = selectedSpeakers(random_idx);
                end
                    
                    
                mdb.(strcat('TX',num2str(TXNumber))).transducer.FF.DacVector(selectedSpeakers) = 1;
                TXNumber = TXNumber + 1;
                
                
            case 'duration'
%                   if(~isnumeric(script{ii,2}))
%                    ErrorMessage(ii,'Duration value have to be numeric','Duration Not Numeric');
%                    return;
%                   end
                  
                  if(isnumeric(script{ii,2}))
                    durationInSec =  script{ii,2}/1000; %convert from millisec to seconds
                  elseif(strcmp(script{ii,2},'file'))
                    idxTX = find(arrayfun(@(x) getfield(mdb,strcat('TX',num2str(x)),'stimulus','stimulusSelect','speech'),[1:3]),1);
                    if(isempty(idxTX))
                        ErrorMessage(ii,'no file signal chosen but duration is file','No file signal');
                    end
%                     [y,Fs] = audioread(mdb.(strcat('TX',num2str(idxTX))).stimulus.speech.source);
%                     durationInSec = length(y)/Fs;
                    durationInSec = audioinfo(mdb.(strcat('TX',num2str(idxTX))).stimulus.speech.source).Duration;
                  end

                  mdb.TX1.stimulus.burstDuration =  durationInSec;% durationInSec;
                  mdb.TX2.stimulus.burstDuration =  durationInSec; %durationInSec;
                  mdb.TX3.stimulus.burstDuration =  durationInSec; %durationInSec;

            case 'play'
                if(0 == mdb.TX1.stimulus.burstDuration)
                   ErrorMessage(ii,'Missing duration value parameter','No duration');
                   return;
                end 
                save mdb mdb;
                tic
                [TX1_playMode,TX2_playMode,TX3_playMode] = play_signal_multi(mdb.master.TX1_select,mdb.master.TX2_select,mdb.master.TX3_select); 
                pause(durationInSec + 0.175 );
                TXall_stop_signal();
                
                Initialize_Selection("TX1");
                Initialize_Selection("TX2");
                Initialize_Selection("TX3");
                TXNumber = 1;
                load mdb;
            case 'start repeat'
                 startLineRepeat = ii;
            case 'end repeat'
                if(endLineRepeat == ii) %Make another repeat
                    repeatCounter =  repeatCounter + 1;
                else %first time in repeat - INITILIZE 
                    endLineRepeat = ii;
                    repeatCounter = 0;
                end
                
                if(repeatCounter < script{ii,2})
                    ii = startLineRepeat;
                end
%             case 'folder playing options'
%                 filesDir =  dir(folderPath);
%                 filesDir = filesDir(~[filesDir.isdir]); %remove nonfile entries
%                 switch script{ii,2}
%                     case 'ascending'
%                         playOrder = [1:1:length(filesDir)];
%                     case 'descending'
%                         playOrder = [length(filesDir):-1:1];
%                     case 'random'
%                         playOrder = randperm(length(filesDir));
%                 end
            case 'wait'
                %TODO: add mdb printing 
                uiwait(msgbox('Here will be displayed the mdb state'));
            case 'pause'
                pause(script{ii,2});
            otherwise
                ErrorMessage(ii,strcat('The word "',script{ii,1},'"  is invalid'),'Unrecgonized option');
                return;
                  
        end
        ii = ii + 1;
    end
       save mdb mdb;
       Button.Value = 0;
       Button.Text = "Start";
end