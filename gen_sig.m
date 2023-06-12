function [sig] = gen_sig(do_am_fm,f_samp,f_sig,f_mod,duration,mod_depth,phase_deg)
%sig1 = gen_sig(pureToneModType,f_samp,pureToneFreq,pureToneModFreq,playBurst,pureToneModADepth);
% clear all
% close all
% format long 
% format compact

% do_am_fm = 2;   % 0 for AM / 1 for FM / 2 AM+FM
% f_samp = 100e3;  % in Hz    97656.25
% f_sig = 1e3;     % in Hz
% f_mod = 1;      % in Hz
% num_of_cycles = 10e3;
% mod_depth = 100;   % in %

plot_en = 0;
phase_rad = phase_deg / 180 * pi;

if (duration == 0 )  %play in a continious mode
    duration = 1;    %set the duration for the buffer loop to 1 sec (arbitrary)
end


num_of_cycles = duration * f_sig;
num_of_smps = num_of_cycles * f_samp / f_sig;
t = [1:num_of_smps]/f_samp;

if (do_am_fm == 0) %AM
    cw = cos(2*pi*f_sig*t + phase_rad);
    mod_sig = mod_depth/100 * cos(2*pi*f_mod*t);
    sig = (1+mod_sig).*cw;
elseif (do_am_fm == 1)  %FM
    cw = cos(2*pi*f_sig*t);  % just for the plot 
    sig = cos(2*pi*f_sig*t + mod_depth/100*cos(2*pi*f_mod*t) + phase_rad);
elseif (do_am_fm == 2)  %AM and FM
    cw = cos(2*pi*f_sig*t);  % just for the plot 
    mod_sig = mod_depth/100 * cos(2*pi*f_mod*t);
    sig = (1+mod_sig).*cos(2*pi*f_sig*t + mod_depth/100*cos(2*pi*f_mod*t)+ phase_rad);
else %no modulation
    mod_depth = 0;
    cw = sin(2*pi*f_sig*t + phase_rad);
    mod_sig = mod_depth/100 * cos(2*pi*f_mod*t);
    sig = (1+mod_sig).*cw;
end

if (plot_en==1)
    figure()
    plot(t,cw); hold on
    plot(t,sig,'r'); hold off ; grid

    tmp = abs(fft(sig));
    sig_fft = 20*log10(tmp / max(tmp));
    f_vec = [0:1:(num_of_smps/2-1)] * f_samp/num_of_smps;

    figure()
    plot(f_vec,sig_fft(1:[num_of_smps/2])); hold on
    plot(f_vec,sig_fft(1:[num_of_smps/2]),'rx'); hold off; grid
    axis([f_sig-5*f_mod f_sig+5*f_mod -40 0]);
end

%sound(sig,f_samp);

