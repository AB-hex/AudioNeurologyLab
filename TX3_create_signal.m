

function  [TX3_signal,playMode] = TX3_create_signal( )

    bufpts=500000;  % Size of the serial buffer
    f_samp=24414.0625;


    load mdb;

    %*****************  parsing TX3 channel data ********
    
    %  stimulus selection
    stimulusSource.pureTone = mdb.TX3.stimulus.stimulusSelect.pureTone; 
    stimulusSource.speech = mdb.TX3.stimulus.stimulusSelect.speech;
    stimulusSource.noise = mdb.TX3.stimulus.stimulusSelect.noise; 

    %create signals only in case channel is required by user
    if ( (stimulusSource.pureTone | stimulusSource.speech | stimulusSource.noise) == 0)
        return;
    end


    % noise parameters
    noiseSource = mdb.TX3.stimulus.noise.source;  % 1 = 'white noise', 2 = 'NB', 3 = 'from file'
    noiseFileName =  mdb.TX3.stimulus.noise.fileName;
    noiseNBCenterFreq =  mdb.TX3.stimulus.noise.NBCntrFrq;
    noiseNBBandWidth = mdb.TX3.stimulus.noise.NBBW;
    noiseAmp =  mdb.TX3.stimulus.noise.amp;
    noisePhase = mdb.TX3.stimulus.noise.phase;

    % pure-tone parameters
    pureToneFreq = mdb.TX3.stimulus.PT.freq;
    pureToneAmp = mdb.TX3.stimulus.PT.amp;  
    pureToneModType = mdb.TX3.stimulus.PT.modulationType;  % ,0='AM', 1='FM', 2='AM and FM', 3='no modulation'
    pureToneModADepth = mdb.TX3.stimulus.PT.modDepth;  %default AM depth = 100%, default FM index = 1
    pureToneModFreq = mdb.TX3.stimulus.PT.modFreq;
    pureTonePhase = mdb.TX3.stimulus.PT.phase;

    % speech parameters
    speechSource =  mdb.TX3.stimulus.speech.source;
    speechAmp = mdb.TX3.stimulus.speech.amp;  
    speechPhase = mdb.TX3.stimulus.speech.phase;

    % stimulus burst
    playBurst = mdb.TX3.stimulus.burstDuration;   %case 0 - countinues play or end of wav file;
    if( (playBurst == 0) )
        playMode = 0; %continious
    else
        playMode = 1;  %single
    end


    %******** Generate Signals ******************************
    sig1 = 0;
    sig2 = 0;
    sig_noise = 0;


    % check if pure-tone signal is requird
    if stimulusSource.pureTone
        sig1 = gen_sig(pureToneModType,f_samp,pureToneFreq,pureToneModFreq,playBurst,pureToneModADepth,pureTonePhase);
        sig1 = setSignalAmp(pureToneAmp,sig1)*sig1;   %amplify the signal
    end

    % check if speech signal is requird
    if stimulusSource.speech
        gen_wav(speechSource,speechPhase);
        [sig_tmp , fs_wav , nbits] = wavread('wav_file_mod.wav','double');
        sig2 = setSignalAmp(speechAmp,sig_tmp)*sig_tmp.'; % amplify the wav amplitude and change vector type
    end

    % check if noise is requird
    if stimulusSource.noise  
        %determind the noise signal length
        if( stimulusSource.pureTone  || stimulusSource.speech )
             noiseSigLength =  max(length(sig1), length(sig2));  %noise signal length is equal to the maxial signal length
        else
          noiseSigLength = f_samp*playBurst;
        end

        switch noiseSource
            case 1   % 'white noise'
                sig_noise = gen_noise(1,f_samp,noiseSigLength,0,0,noisePhase);   %   [noise] = gen_noise(is_white, f_samp, num_of_points, fltr_cntr_freq, fltr_bw)
            case 2   % NB
                sig_noise = gen_noise(0,f_samp,noiseSigLength,noiseNBCenterFreq,noiseNBBandWidth,noisePhase);
            case 3   %from file
                gen_wav(noiseFileName,noisePhase);
                [sig_tmp , fs_wav , nbits] = wavread('wav_file_mod.wav','double');
                sig_noise = sig_tmp.';
                
                %determind the noise signal length
                if( stimulusSource.pureTone  || stimulusSource.speech )
                    sigLength = max(length(sig1), length(sig2));
                    if(length(sig_noise) > sigLength)
                        sig_noise = sig_noise(1:sigLength);
                    end
                end
        end
        
         % set noise signal amplitude
        sig_noise = setSignalAmp(noiseAmp,sig_noise)*sig_noise; % amplify the wav amplitude and change vector type

    end


     %  in case more than one siganl is required - mix them all
     sigSizeArray = [length(sig1),length(sig2),length(sig_noise)]; 
     maxSigLen = max(sigSizeArray);
     sig1_new = zeros(1,maxSigLen);
     sig2_new = zeros(1,maxSigLen);
     sig3_new = zeros(1,maxSigLen);
     
     sig1_new(1:length(sig1)) = sig1;
     sig1 = sig1_new;

     sig2_new(1:length(sig2)) = sig2;
     sig2 = sig2_new;

     sig3_new(1:length(sig_noise)) = sig_noise;
     sig_noise = sig3_new;
     
     
     [sig1,sig2,sig_noise] = CuttingOnsetOffset(sig1,sig2,sig_noise,f_samp,mdb.TX3.stimulus.onset  ,mdb.TX3.stimulus.offset  );
     TX3_signal = sig1 + sig2 + sig_noise;
     
end
        