function UpdateFF2SpeakerMap( FFNumber, speakerNumber )
global RP;
load mdb; 
mdb.Calibration.FF2SpeakerMap(FFNumber)  = speakerNumber;
RP.SetTagVal(strcat('Gain',num2str(FFNumber)),...
            mdb.Calibration.SpeakersGain(speakerNumber) );
save mdb mdb;

end