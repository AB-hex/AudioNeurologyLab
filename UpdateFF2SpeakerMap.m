function UpdateFF2SpeakerMap( FFNumber, speakerNumber )
global RP;
load mdb; 
mdb.Calibration.FF2SpeakerMap(FFNumber)  = speakerNumber;
RP.SetTagVal(strcat('Gain',num2str(FFNumber)),...
           10^( mdb.Calibration.SpeakersGain(speakerNumber)/20) );
save mdb mdb;

end