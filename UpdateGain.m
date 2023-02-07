function UpdateGain(speakerNumber, gain)

load mdb;
mdb.Calibration.SpeakersGain(speakerNumber) = gain;
if(ismember(speakerNumber,mdb.Calibration.FF2SpeakerMap))
    global RP;
    FFidx = find( mdb.Calibration.FF2SpeakerMap == speakerNumber );    
    RP.SetTagVal(strcat('Gain',num2str(FFidx)),gain);    
end
save mdb mdb;

end