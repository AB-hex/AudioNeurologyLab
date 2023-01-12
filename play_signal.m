% Continuous play example using a serial buffer
% This program writes to the rambuffer once it has cyled half way through the buffer

% filePath - set this to wherever the examples are stored
%filePath = 'C:\TDT\ActiveX\ActXExamples\matlab\';

function  [] = play_signal()


    %filePath = 'D:\Users\Adi_Dayan\TDT_proj';

    bufpts=500000;  % Size of the serial buffer
    f_samp=24414.0625;

    %snr = 0;  % in dB    min SNR is -6dB
    %add_noise=0;    %0 -> no noise, 1 -> add noise
    %use_2_dac = 1;   % 0-> single DAC   1-> two DACs

    load mdb;

    %*****************  parsing TX1 channel data ********
    %  stimulus selection
    stimulusSource.pureTone = mdb.TX1.stimulus.stimulusSelect.pureTone; 
    stimulusSource.speech = mdb.TX1.stimulus.stimulusSelect.speech;
    stimulusSource.noise = mdb.TX1.stimulus.stimulusSelect.noise; 

    %create signals only in case channel is required by user
    if ( (stimulusSource.pureTone | stimulusSource.speech | stimulusSource.noise) == 0)
        return;
    end


    % noise parameters
    noiseSource = mdb.TX1.stimulus.noise.source;  % 1 = 'white noise', 2 = 'NB', 3 = 'from file'
    noiseFileName =  mdb.TX1.stimulus.noise.fileName;
    noiseNBCenterFreq =  mdb.TX1.stimulus.noise.NBCntrFrq;
    noiseNBBandWidth = mdb.TX1.stimulus.noise.NBBW;
    noiseAmp =  mdb.TX1.stimulus.noise.amp;

    % pure-tone parameters
    pureToneFreq = mdb.TX1.stimulus.PT.freq;
    pureToneAmp = mdb.TX1.stimulus.PT.amp;  
    pureToneModType = mdb.TX1.stimulus.PT.modulationType;  % ,0='AM', 1='FM', 2='AM and FM', 3='no modulation'
    pureToneModADepth = mdb.TX1.stimulus.PT.modDepth;  %default AM depth = 100%, default FM index = 1
    pureToneModFreq = mdb.TX1.stimulus.PT.modFreq;
 %   pureTonePhase = mdb.TX1.stimulus.PT.phase;

    % speech parameters
    speechSource =  mdb.TX1.stimulus.speech.source;
    speechAmp = mdb.TX1.stimulus.speech.amp;  
  %  speechPhase = mdb.TX1.stimulus.speech.phase;

    % stimulus burst
    playBurst = mdb.TX1.stimulus.burstDuration;   %case 0 - countinues play or end of wav file;




    %******** Generate Signals ******************************
    sig1 = 0;
    sig2 = 0;
    sig_noise = 0;


    % check if pure-tone signal is requird
    if stimulusSource.pureTone
        sig1 = gen_sig(pureToneModType,f_samp,pureToneFreq,pureToneModFreq,playBurst,pureToneModADepth);
        sig1 = setSignalAmp(pureToneAmp,sig1)*sig1;   %amplify the signal
    end

    % check if speech signal is requird
    if stimulusSource.speech
        gen_wav(speechSource);
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
                sig_noise = gen_noise(1,f_samp,noiseSigLength,0,0);   %   [noise] = gen_noise(is_white, f_samp, num_of_points, fltr_cntr_freq, fltr_bw)
            case 2   % NB
                sig_noise = gen_noise(0,f_samp,noiseSigLength,noiseNBCenterFreq,noiseNBBandWidth);
            case 3   %from file
                gen_wav(noiseFileName);
                [sig_tmp , fs_wav , nbits] = wavread('wav_file_mod.wav','double');
                sig_noise = sig_tmp.';
        end
        
         % set noise signal amplitude
        sig_noise = setSignalAmp(noiseAmp,sig_noise)*sig_noise; % amplify the wav amplitude and change vector type

    end


     %  in case more than one siganl is required - mix them all
     sigSizeArray = [length(sig1),length(sig2)]; 
     maxSigLen = max(sigSizeArray);
     sig_new = zeros(1,maxSigLen);
     
     sig_new(1:length(sig1)) = sig1;
     sig1 = sig_new;

     sig_new(1:length(sig2)) = sig2;
     sig2 = sig_new;
     
     if(length(sig_noise) > maxSigLen)
         sig_noise = sig_noise(1:maxSigLen);
     else
        sig_new(1:length(sig_noise)) = sig_noise;
        sig_noise = sig_new;
     end
          
     sig = sig1 + sig2 + sig_noise;
         

%sig = gen_sig(1,25e3,250,5,1e3,100); %gen_sig(do_am_fm,f_samp,f_sig,f_mod,num_of_cycles,mod_depth);
 %[sig,fs,nbits] = wavread('wavFiles\NFalse145MSp1.wav','double');
%sig = 0.001*sig;

%gen_wav('wavFiles\NFalse145MSp1.wav');
%gen_wav('wavFiles\yalda.wav');
%gen_wav('wavFiles\qwe.wav');

%[sig_tmp , fs_wav , nbits] = wavread('wav_file_mod.wav','double');
%sig = 10*sig_tmp.'; %amplify the wav amplitude, and change vector type

%*******************************************************

%******** Generate Noise *******************************

%noise = randn(1,length(sig));
% call noise = noise_gen()
% noise_rms =  sqrt(sum(noise.^2)/length(noise));
%snr_lin = 10^(snr/20);
%sig_rms = sqrt(sum(sig.^2)/length(sig));
%noise = noise /  noise_rms * sig_rms / snr_lin;
%*******************************************************

%if ( (use_2_dac==0) && (add_noise==1) )  %mix signal with noise when using same output
 %   sig = sig + noise;
%end




% ************Run Circuit_Loader****************
RP = Circuit_Loader('D:\Users\Adi_Dayan\TDT_proj\Continuous_Play_wav_2.rcx'); 
 

if all(bitget(RP.GetStatus,1:3))
    
    sig_len = min(length(sig), bufpts-1);  %cut signal to fit the buffer size
    sig =  sig(1:sig_len);
    sig_zero = zeros(1,length(sig));
   % s1 =  sig(1:sig_len);
   % n1 =  noise(1:sig_len);
   
   RP.WriteTagV('datain9', 0, sig_zero);
   datain_array = {'datain9','datain10','datain11','datain12','datain13','datain14','datain15','datain16'}; 
    for i=1:1:8
        if (mdb.TX1.transducer.FF.DacVector(i) == 1)
            datain = datain_array{i};
             RP.WriteTagV(datain, 0, sig);
        end
    end
    
  %  RP.WriteTagV('datain9', 0, s1);
   % RP.WriteTagV('datain10', 0, n1);

    % Start Playing
    RP.SoftTrg(1);
    for j=1:1:8
        if (mdb.TX1.transducer.FF.DacVector(j) == 1)
             RP.SoftTrg(j);
        end
    end
    
    
    
   % RP.SoftTrg(1);
    %if ( (use_2_dac==1) && (add_noise==1) )
      %  RP.SoftTrg(2); %start datain10
    %end
    
    curindex=RP.GetTagVal('index');
    while(curindex < sig_len)
            curindex=RP.GetTagVal('index');
    end
    
    % Stop playing
    RP.SoftTrg(9);
    RP.Halt;
end