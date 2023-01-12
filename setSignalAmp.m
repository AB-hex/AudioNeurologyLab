

function  [signalAmp] = setSignalAmp(entry_dBSPL,sig)

factor_1 = 10^( (entry_dBSPL-73)/20 );

signal_RMS = sqrt(sum(sig.^2)/length(sig));
factor_2 = (2^0.5/2) / signal_RMS;

signalAmp = factor_1 * factor_2;

end