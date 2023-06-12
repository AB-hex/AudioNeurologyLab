% Continuous play example using a serial buffer
% This program writes to the rambuffer once it has cyled half way through the buffer

% filePath - set this to wherever the examples are stored
%filePath = 'C:\TDT\ActiveX\ActXExamples\matlab\';

function  [TX1_playMode] = TX1_prepare_signal( )



    bufpts=500000;  % Size of the serial buffer
    f_samp=24414.0625;

    %snr = 0;  % in dB    min SNR is -6dB
    %add_noise=0;    %0 -> no noise, 1 -> add noise
    %use_2_dac = 1;   % 0-> single DAC   1-> two DACs


  
    % parse data-base and create signals
      [TX1_signal,TX1_playMode] = TX1_create_signal( );
        
 

% ************Run Circuit_Loader****************
%RP = Circuit_Loader('D:\Users\Adi_Dayan\TDT_proj\full_2.rcx');
RP = Circuit_Loader('D:\Users\Adi_Dayan\TDT_multiChannel\Copy_of_full_3.rcx'); 
 


    
    
    
        
    if all(bitget(RP.GetStatus,1:3))
    
    TX1_sig_len = min(length(TX1_signal), bufpts-1);  %cut signal to fit the buffer size
    TX1_signal = TX1_signal(1:TX1_sig_len);
   
    
    load mdb;
    %RP.SetTagVal('en_ch1_dac1', 1);
    if (mdb.TX1.transducer.source == 'FF')
        dacVectorEnableArray = {'en_ch1_dac1';'en_ch1_dac2';'en_ch1_dac3';...
        'en_ch1_dac4';'en_ch1_dac5';'en_ch1_dac6';'en_ch1_dac7';'en_ch1_dac8';...
        'en_ch1_dac9';'en_ch1_dac10';'en_ch1_dac11';'en_ch1_dac12';'en_ch1_dac13';...
        'en_ch1_dac14';'en_ch1_dac15';'en_ch1_dac16';'en_ch1_dac17';'en_ch1_dac18'};
        for i=1:1:18
            if (mdb.TX1.transducer.FF.DacVector(i) == 1)
                RP.SetTagVal(dacVectorEnableArray{i}, 1); 
            end
        end
    end
    
   
    
    RP.SetTagVal('BufSize1', TX1_sig_len); 
    
    
   % RP.SetTagVal('en_ch1_dac1', 1); 
  %  RP.SetTagVal('BufSize1', sig_len); 
    
  
  % set the play mode for all the channels
    switch TX1_playMode
        case 0  %continious
            RP.SetTagVal('single1', 0);
            RP.SetTagVal('cont1', 1); 
            RP.SetTagVal('cont1', 0); 
        case 1  %single
            RP.SetTagVal('cont1', 0);
            RP.SetTagVal('single1', 1);
            RP.SetTagVal('single1', 0);
    end
    
  
    
    % load data
    RP.WriteTagV('datain1', 0, TX1_signal);
   
 
    RP.SoftTrg(1);
    
  
end