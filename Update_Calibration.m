
%Update Calibration numbers into RP circuit
function Update_Calibration(RP,mdb)
load mdb;
map = mdb.Calibration.FF2SpeakerMap;
table = mdb.Calibration.GainTable;

arrayfun(@(ii)CalibrateTX(RP,mdb,map,table,ii),[1:3]);

    function CalibrateTX(RP,mdb,map,table,TXNum)
        TXStr = "TX"+TXNum;
        selection = find(mdb.(TXStr).transducer.FF.DacVector);
        if(mdb.master.(TXStr+"_select"))
           if(mdb.(TXStr).stimulus.stimulusSelect.pureTone)
               coloumnGain = table.(num2str(mdb.(TXStr).stimulus.PT.freq)+"Hz");
               arrayfun(@(ii) RP.SetTagVal(("gain_ch"+TXNum+"_dac"+ii),...
                   10^( coloumnGain(map(ii))/20 )), ...
                   selection...
                    );
           elseif(mdb.(TXStr).stimulus.stimulusSelect.noise)
                coloumnGain = table.Noise;
                %TODO: check if RMS of the signal is reaally needed
                % 10^(db/20 - log10(RMS))

                 arrayfun(@(ii) RP.SetTagVal(("gain_ch"+TXNum+"_dac"+ii),...
                   10^( coloumnGain(map(ii))/20 )), ...
                   selection...
                    );
           elseif(mdb.TX1.stimulus.stimulusSelect.speech)
               for ii=selection 
                %TODO: check if RMS of the signal is reaally needed
                % 10^(db/20 - log10(RMS))
                %do the mean not on dB but on the mult scalar
                    gains = mean(table2array(table(map(ii),1:5)));
                    mult_factor = mean(10.^((gains)./20));
                    RP.SetTagVal(("gain_ch"+TXNum+"_dac"+ii),...
                    mult_factor );
               end
           end

        end
        
    end

% arrayfun(@(ii) RP.SetTagVal(strcat('Gain',num2str(ii)),10^(gain(map(ii)))/20),...
%         [1:8]);
end