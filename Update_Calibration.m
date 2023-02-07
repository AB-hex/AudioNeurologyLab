
%Update Calibration numbers into RP circuit
function Update_Calibration(RP)
load mdb;
map = mdb.Calibration.FF2SpeakerMap;
gain = mdb.Calibration.SpeakersGain;

arrayfun(@(ii) RP.SetTagVal(strcat('Gain',num2str(ii)),gain(map(ii))),...
        [1:8]);
end