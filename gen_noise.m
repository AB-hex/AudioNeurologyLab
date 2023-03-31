function [noise] = gen_noise(is_white, f_samp, num_of_points, fltr_cntr_freq, fltr_bw,phase_deg)

%is_white = 0;
%f_samp = 25e3;
%num_of_points = 100e3;
%fltr_cntr_freq = 2e3;
%fltr_bw = 100;

global whiteNoise_vector;

use_figure = 0;

if (num_of_points == 0)   % continious play
    num_of_points = f_samp*1; %set the duration for the buffer loop to 1 sec (arbitrary)
end

noise_tmp = whiteNoise_vector(1:num_of_points);

if is_white == 1
    %noise = randn(1,num_of_points);
    noise = noise_tmp;
    
    if (phase_deg == 180)
        noise = (-1)*noise;
    end
    
    
else
    %noise_tmp = randn(1,num_of_points);
    A = [0,0,1,1,0,0];
    f_low = (fltr_cntr_freq - fltr_bw / 2)/(f_samp / 2);
    f_high = (fltr_cntr_freq + fltr_bw / 2)/(f_samp / 2);
    F = [0 , f_low*0.8 , f_low, f_high, f_high*1.20, 1];
    B=firpm(128,F,A);
    
    noise = filter(B,1,noise_tmp);
    
    if (phase_deg == 180)
        noise = (-1)*noise;
    end
    
    if use_figure==1,
        figure()
        plot(B,'+-');
        grid
        
        [H,W] = freqz(B,1,512,f_samp);
        figure()
        plot(W,20*log10(abs(H)));
        grid
        
        noise_fft = fft(noise);
        figure()
        plot(20*log10(abs(noise_fft)));
        grid
    end
       
    
end

%figure()
%plot(noise); hold on;



    
    
    