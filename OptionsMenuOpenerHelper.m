function   OptionsMenuOpenerHelper(app,TXNumberDouble)
       switch app.(strcat("InputSignal",num2str(TXNumberDouble),"TX",num2str(TXNumberDouble),"DropDown")).Value
       case 'Pure Tune'
        appOptions = PureTuneOptions(TXNumberDouble);
       case 'Noise'
         appOptions = NoiseOptionsApp(TXNumberDouble);
       case 'From File'
         appOptions = FileOptions(TXNumberDouble);
       end
        app.("TX"+TXNumberDouble+"Options") = appOptions;
end