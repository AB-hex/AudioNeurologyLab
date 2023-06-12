% Continuous play example using a serial buffer
% This program writes to the rambuffer once it has cyled half way through the buffer

% filePath - set this to wherever the examples are stored
%filePath = 'C:\TDT\ActiveX\ActXExamples\matlab\';
filePath = 'D:\Users\Adi_Dayan\TDT_proj';

TDT_GUI_v1;

npts=100000;  % Size of the serial buffer
bufpts = npts/2; % Number of points to write to buffer

snr = 0;  % in dB    min SNR is -6dB
add_noise=0;    %0 -> no noise, 1 -> add noise
use_2_dac = 1;   % 0-> single DAC   1-> two DACs




%******** Generate Signal ******************************
%sig = gen_sig(2,50e3,6e3,70,50e3,100); %gen_sig(do_am_fm,f_samp,f_sig,f_mod,num_of_cycles,mod_depth);
%[sig,fs,nbits] = wavread('wavFiles\NFalse145MSp1.wav','double');


gen_wav('wavFiles\NFalse145MSp1.wav');

[sig_tmp , fs_wav , nbits] = wavread('wav_file_mod.wav','double');
sig = 100*sig_tmp.'; %amplify the wav amplitude, and change vector type

%*******************************************************




%******** Generate Noise *******************************

noise = randn(1,length(sig));
snr_lin = 10^(snr/20);

sig_rms = sqrt(sum(sig.^2)/length(sig));
noise = noise * sig_rms / snr_lin;
%*******************************************************

if ( (use_2_dac==0) && (add_noise==1) )  %mix signal with noise when using same output
    sig = sig + noise;
end

% Runs Circuit_Loader
RP = Circuit_Loader('D:\Users\Adi_Dayan\TDT_proj\Continuous_Play_wav_2.rcx'); 
 

if all(bitget(RP.GetStatus,1:3))
    
    % Generate two tone signals to play out in MATLAB
    
    s1 =  sig(1:bufpts);
    s2 =  sig((bufpts+1):(2*bufpts));
    n1 =  noise(1:bufpts);
    n2 =  noise((bufpts+1):(2*bufpts));
    
    %s1 =  sig((30e3+1):(30e3+bufpts));
    %s2 =  sig((30e3+bufpts+1):(30e3+(2*bufpts)));
        
    % Serial Buffetr will be divided into two Buffers A & B
    % Load up entire buffer with Segments A and B
    
    RP.WriteTagV('datain9', 0, s1);
    RP.WriteTagV('datain9', bufpts-1, s2);
    RP.WriteTagV('datain10', 0, n1);
    RP.WriteTagV('datain10', bufpts-1, n2);

    % Start Playing
    RP.SoftTrg(1);
    if ( (use_2_dac==1) && (add_noise==1) )
        RP.SoftTrg(3); %start datain10
    end
    curindex=RP.GetTagVal('index');
  
    % Main Looping Section
    for cntr = 2:2:(floor(length(sig)/bufpts)-2),
         
    
        % Wait until done playing A
        while(curindex<bufpts) % Checks to see if it has played from half the buffer
            curindex=RP.GetTagVal('index');
        end

        % Loads the next signal segment
        %s1=sig1;
        s1 =  sig((cntr*bufpts+1):((cntr+1)*bufpts));
        RP.WriteTagV('datain9', 0, s1);
        n1 =  noise((cntr*bufpts+1):((cntr+1)*bufpts));
        RP.WriteTagV('datain10', 0, n1);
        

        % Checks to see if the data transfer rate is fast enough
        curindex=RP.GetTagVal('index');
        if(curindex<bufpts)
            disp('Transfer rate is too slow');
        end

        % Wait until start playing A
        while(curindex>bufpts)
            curindex=RP.GetTagVal('index');
        end

        % Load B
        %s2=sig2;
        s2 =  sig(((cntr+1)*bufpts+1):((cntr+2)*bufpts));
        RP.WriteTagV('datain9', bufpts,s2);
        n2 =  noise(((cntr+1)*bufpts+1):((cntr+2)*bufpts));
        RP.WriteTagV('datain10', bufpts,n2);
        

        % Make sure still playing A
        curindex=RP.GetTagVal('index');
        if(curindex>bufpts)
            disp('Transfer rate is too slow');
        end
        
        % Loop back to wait until done playing A
    end

    % Stop playing
    RP.SoftTrg(2);
    if ((use_2_dac==1) && (add_noise==1))
        RP.SoftTrg(4); %disable datain10
    end

    RP.Halt;
end