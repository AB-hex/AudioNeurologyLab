function  [sig1,sig2,sig_noise] = CuttingOnsetOffset(sig1,sig2,sig_noise,f_samp,onset,offset)
         if(~(0==onset && 0==offset))
         selection = zeros([sig1 1]);
         if(strcmp(offset,'end'))
            selection(onset*f_samp+1:end)=1;
         else
            selection(onset*f_samp+1:offset*f_samp)=1;
         end
         sig1(~selection)=0;
         sig2(~selection)=0;
         sig_noise(~selection)=0;
end