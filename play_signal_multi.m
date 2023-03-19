% Continuous play example using a serial buffer
% This program writes to the rambuffer once it has cyled half way through the buffer

% filePath - set this to wherever the examples are stored
%filePath = 'C:\TDT\ActiveX\ActXExamples\matlab\';

function  [TX1_playMode,TX2_playMode,TX3_playMode] = play_signal_multi(TX1, TX2, TX3)

    

    %bufpts=500000;  % Size of the serial buffer
    bufpts=3000000;  % Size of the serial buffer
    f_samp=24414.0625;
    global RP;
    Update_Calibration(RP);
    
    %snr = 0;  % in dB    min SNR is -6dB
    %add_noise=0;    %0 -> no noise, 1 -> add noise
    %use_2_dac = 1;   % 0-> single DAC   1-> two DACs

    TX1_playMode = 1;
    TX2_playMode = 1;
    TX3_playMode = 1;
                    
 load mdb;

% ************Run Circuit_Loader****************

  %  RP = Circuit_Loader('D:\Users\Adi_Dayan\TDT_multiChannel\full_3.rcx');
   
      
 disp(bitget(RP.GetStatus,1:3));  
 
 if all(bitget(RP.GetStatus,1:3))
    
    if(TX1)  
        % parse data-base and create signals
        [TX1_signal,TX1_playMode] = TX1_create_signal( );
        TX1_sig_len = min(length(TX1_signal), bufpts-1);  %cut signal to fit the buffer size
        TX1_signal = TX1_signal(1:TX1_sig_len);

        if (strcmp(mdb.TX1.transducer.source,'FF'))
            dacVectorEnableArray = {'en_ch1_dac1';'en_ch1_dac2';'en_ch1_dac3';...
            'en_ch1_dac4';'en_ch1_dac5';'en_ch1_dac6';'en_ch1_dac7';'en_ch1_dac8';...
            'en_ch1_dac9';'en_ch1_dac10';'en_ch1_dac11';'en_ch1_dac12';'en_ch1_dac13';...
            'en_ch1_dac14';'en_ch1_dac15';'en_ch1_dac16';'en_ch1_dac17';'en_ch1_dac18'};
            for i=1:1:18
                if (mdb.TX1.transducer.FF.DacVector(i) == 1)
                    RP.SetTagVal(dacVectorEnableArray{i}, 1); 
                else
                    RP.SetTagVal(dacVectorEnableArray{i}, 0);
                end
            end
        end

        RP.SetTagVal('BufSize1', TX1_sig_len-0); 

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
     %   RP.SoftTrg(6);
    end
    
    if(TX2)
        % parse data-base and create signals
        [TX2_signal,TX2_playMode] = TX2_create_signal( );
        TX2_sig_len = min(length(TX2_signal), bufpts-1);  %cut signal to fit the buffer size
        TX2_signal =  TX2_signal(1:TX2_sig_len);

        
        if (strcmp(mdb.TX2.transducer.source,'FF'))
            dacVectorEnableArray = {'en_ch2_dac1';'en_ch2_dac2';'en_ch2_dac3';...
            'en_ch2_dac4';'en_ch2_dac5';'en_ch2_dac6';'en_ch2_dac7';'en_ch2_dac8';...
            'en_ch2_dac9';'en_ch2_dac10';'en_ch2_dac11';'en_ch2_dac12';'en_ch2_dac13';...
            'en_ch2_dac14';'en_ch2_dac15';'en_ch2_dac16';'en_ch2_dac17';'en_ch2_dac18'};
            for i=1:1:18
                if (mdb.TX2.transducer.FF.DacVector(i) == 1)
                    RP.SetTagVal(dacVectorEnableArray{i}, 1); 
                else
                    RP.SetTagVal(dacVectorEnableArray{i}, 0);
                end
            end
        end

        RP.SetTagVal('BufSize2', TX2_sig_len); 

      % set the play mode for all the channels
        switch TX2_playMode
            case 0  %continious
                RP.SetTagVal('single2', 0);
                RP.SetTagVal('cont2', 1); 
                RP.SetTagVal('cont2', 0); 
            case 1  %single
                RP.SetTagVal('cont2', 0);
                RP.SetTagVal('single2', 1);
                RP.SetTagVal('single2', 0);
        end

        % load data
        
        RP.WriteTagV('datain2', 0, TX2_signal);
       % RP.SoftTrg(7);
    end
    
    if(TX3)
        % parse data-base and create signals
        [TX3_signal,TX3_playMode] = TX3_create_signal( );
        TX3_sig_len = min(length(TX3_signal), bufpts-1);  %cut signal to fit the buffer size
        TX3_signal =  TX3_signal(1:TX3_sig_len);

        
        if (strcmp(mdb.TX3.transducer.source,'FF'))
            dacVectorEnableArray = {'en_ch3_dac1';'en_ch3_dac2';'en_ch3_dac3';...
            'en_ch3_dac4';'en_ch3_dac5';'en_ch3_dac6';'en_ch3_dac7';'en_ch3_dac8';...
            'en_ch3_dac9';'en_ch3_dac10';'en_ch3_dac11';'en_ch3_dac12';'en_ch3_dac13';...
            'en_ch3_dac14';'en_ch3_dac15';'en_ch3_dac16';'en_ch3_dac17';'en_ch3_dac18'};
            for i=1:1:18
                if (mdb.TX3.transducer.FF.DacVector(i) == 1)
                    RP.SetTagVal(dacVectorEnableArray{i}, 1);
                else
                    RP.SetTagVal(dacVectorEnableArray{i}, 0);
                end
            end
        end

        RP.SetTagVal('BufSize3', TX3_sig_len); 

      % set the play mode for all the channels
        switch TX3_playMode
            case 0  %continious
                RP.SetTagVal('single3', 0);
                RP.SetTagVal('cont3', 1); 
                RP.SetTagVal('cont3', 0); 
            case 1  %single
                RP.SetTagVal('cont3', 0);
                RP.SetTagVal('single3', 1);
                RP.SetTagVal('single3', 0);
        end

        % load data
        RP.WriteTagV('datain3', 0, TX3_signal);
    end
    
    if(TX1 && TX2 && TX3)
        RP.SoftTrg(4);
        return;
    end
    
    if(TX1 && TX2)
        RP.SoftTrg(6);
    elseif(TX1 && TX3)
        RP.SoftTrg(7);      
    else
        if (TX1)
            RP.SoftTrg(1);
        end
        if (TX2)
            RP.SoftTrg(2);
        end
        if (TX3)
            RP.SoftTrg(3);
        end
    end
        
  end
  
end