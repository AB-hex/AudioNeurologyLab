function   OptionsMenuOpenerHelper(app,TXNumberDouble)
       switch app.(strcat("InputSignal",num2str(TXNumberDouble),"TX",num2str(TXNumberDouble),"DropDown")).Value
       case 'Pure Tune'
         PureTuneOptions(TXNumberDouble);
       case 'Noise'
         NoiseOptionsApp(TXNumberDouble);
       case 'From File'
         FileOptions(TXNumberDouble);
       end
end