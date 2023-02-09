function UpdateGain(speakerNumber, gain)

load mdb;
mdb.Calibration.SpeakersGain(speakerNumber) = gain;
if(ismember(speakerNumber,mdb.Calibration.FF2SpeakerMap))
    global RP;
    FFidx = find( mdb.Calibration.FF2SpeakerMap == speakerNumber );    
    RP.SetTagVal(strcat('Gain',num2str(FFidx)),10^(gain/20));    
end
save mdb mdb;

end