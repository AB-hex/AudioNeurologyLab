
function gen_wav(source_wav_file,phase_deg)


%clear all
%close all
format long
format compact

%f_samp = 48828.125;
f_samp=24414.0625;


%[sig_tmp,fs,nbits] = wavread(source_wav_file,'double');
[sig_tmp,fs,nbits] = wavread(source_wav_file);
%figure(); plot(sig_tmp); grid

sig_tmp = (sig_tmp(:,1)); %choose mono in case of stereo audio file

t_max = length(sig_tmp)/fs;
t_old = [1:length(sig_tmp)]/fs;
t_new = [0:1/f_samp:t_max];

sig = interp1(t_old,sig_tmp,t_new,'linear','extrap');

n_samps = length(sig);
%n_new = ceil(n_samps/100e3) * 100e3 +20e3;

%sig_mod = zeros(1,n_new);
%sig_mod(1:n_samps) = sig;
sig_mod = sig;

sig_quant = round(sig_mod*2^nbits) / 2^nbits;

 if (phase_deg == 180)
    sig_quant = (-1)*sig_quant;
 end
    
%figure(); plot(sig_quant); grid

% wavwrite(sig_quant,f_samp,nbits,'wav_file_mod.wav');
audiowrite('wav_file_mod.wav',sig_quant,round(f_samp));
%figure(); plot(sig_quant); grid
 
%sound(sig_quant,f_samp);