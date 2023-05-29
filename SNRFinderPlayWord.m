          
function msg = SNRFinderPlayWord(app,signalLevel,noiseLevel,wordsDir,stats,Idx,ii,NumOfWords,playOrder)

           if(Idx.currentPlay>length(playOrder))
                uialert(app.UIFigure,'All Words had been played.','Out of words');
                return;
           end
           load mdb
            name = wordsDir(playOrder(Idx.currentPlay)).name;
            filename = fullfile(wordsDir(playOrder(Idx.currentPlay)).folder,name);
            msg = stats+newline+ "Playing "+ii+" word out of "+NumOfWords+newline+name;
            d = uiprogressdlg(app.UIFigure,'Title','Playing',...
                    'Message',msg,'Value',ii/NumOfWords);
            [y,fs] =audioread(filename);
             durationInSec = length(y)/fs;
            mdb.TX1.stimulus.speech.source = filename;
            mdb.TX1.stimulus.burstDuration = durationInSec;
            mdb.TX2.stimulus.burstDuration = durationInSec;
            mdb.TX1.stimulus.speech.amp = signalLevel; 
            if(~app.noiseFromFileFlag)
                mdb.TX2.stimulus.noise.amp = noiseLevel;
            else
                mdb.TX2.stimulus.speech.amp = noiseLevel;
                noise_list = dir('Noise\*.wav');
                randomNoiseChoice = noise_list(randi(length(noise_list)));
                mdb.TX2.stimulus.speech.source  = fullfile(randomNoiseChoice.folder,randomNoiseChoice.name);
%                 [n,fs_n] = audioread(app.ChoosenoiseaudiofileButton.Text);
%                 noiseDuration = length(n)/fs_n;
%                 possibleInterval = noiseDuration - durationInSec;
%                 randomIntervalNoiseToBePlayed = possibleInterval*rand();
%                 audiowrite("Noise_temp.wav",n(randomIntervalNoiseToBePlayed*fs_n:end),fs_n);
%                 mdb.TX2.stimulus.speech.source  = pwd+"\Noise_temp.wav";
                
            end
            save mdb mdb;
            [~,~,~] = play_signal_multi(mdb.master.TX1_select,mdb.master.TX2_select,mdb.master.TX3_select); 
            pause(durationInSec + 0.175 );
            TXall_stop_signal();
            close(d);
end