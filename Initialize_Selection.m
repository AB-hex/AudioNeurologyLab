function Initialize_Selection(TXString)
load mdb;
mdb.master.(strcat(TXString,"_select")) = 0;

mdb.(TXString).transducer.FF.DacVector = zeros([1 18]);

stimulusSelectFieldNames = fieldnames(mdb.(TXString).stimulus.stimulusSelect);

for ii = 1:numel(stimulusSelectFieldNames)
    mdb.(TXString).stimulus.stimulusSelect.(stimulusSelectFieldNames{ii})=0;
end
%Initialize Pure tone settings
mdb.(TXString).stimulus.PT.modulationType = 3;
mdb.(TXString).stimulus.PT.amp = 35;
mdb.(TXString).stimulus.PT.freq = 1000;
mdb.(TXString).stimulus.PT.modDepth = 100;
mdb.(TXString).stimulus.PT.modFreq = 10;
mdb.(TXString).stimulus.PT.modIndex = 1;
mdb.(TXString).stimulus.PT.phase = 0;

%Initialize noise settings
mdb.(TXString).stimulus.noise.fileName = 0;
mdb.(TXString).stimulus.noise.phase = 0;
mdb.(TXString).stimulus.noise.amp=30;
mdb.(TXString).stimulus.noise.source=1;
mdb.(TXString).stimulus.noise.NBBW=100;
mdb.(TXString).stimulus.noise.NBCntrFrq=1000;

%Initialize noise settings
mdb.(TXString).stimulus.speech.source='';
mdb.(TXString).stimulus.speech.amp=30;
mdb.(TXString).stimulus.speech.phase = 0;

mdb.(TXString).stimulus.burstDuration = 0;
save mdb mdb;

end