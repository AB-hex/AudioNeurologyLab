          
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
            mdb.TX2.stimulus.noise.amp = noiseLevel;
            save mdb mdb;
            [~,~,~] = play_signal_multi(mdb.master.TX1_select,mdb.master.TX2_select,mdb.master.TX3_select); 
            pause(durationInSec + 0.175 );
            TXall_stop_signal();
            close(d);
end