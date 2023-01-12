

function  init_dataBase( )

load mdb;

% ********** TX1 ***********

    %  stimulus selection
    mdb.TX1.stimulus.stimulusSelect.pureTone = 0; 
    mdb.TX1.stimulus.stimulusSelect.speech = 0;
    mdb.TX1.stimulus.stimulusSelect.noise = 0; 

    % noise parameters
    mdb.TX1.stimulus.noise.source = 0;
    mdb.TX1.stimulus.noise.fileName = 0;
    mdb.TX1.stimulus.noise.NBCntrFrq = 0;
    mdb.TX1.stimulus.noise.NBBW = 0;
    mdb.TX1.stimulus.noise.amp = 0;
    mdb.TX1.stimulus.noise.phase = 0;

    % pure-tone parameters
    mdb.TX1.stimulus.PT.freq = 0;
    mdb.TX1.stimulus.PT.amp = 0;  
    mdb.TX1.stimulus.PT.modulationType = 0;  
    mdb.TX1.stimulus.PT.modDepth = 0;  
    mdb.TX1.stimulus.PT.modFreq = 0;
    mdb.TX1.stimulus.PT.phase = 0;

    % speech parameters
    mdb.TX1.stimulus.speech.source = 0;
    mdb.TX1.stimulus.speech.amp = 0;  
    mdb.TX1.stimulus.speech.phase = 0;


    % transducer parameters
    mdb.TX1.transducer.source = 0;

% ********** TX2 ***********

    %  stimulus selection
    mdb.TX2.stimulus.stimulusSelect.pureTone = 0; 
    mdb.TX2.stimulus.stimulusSelect.speech = 0;
    mdb.TX2.stimulus.stimulusSelect.noise = 0; 

    % noise parameters
    mdb.TX2.stimulus.noise.source = 0;
    mdb.TX2.stimulus.noise.fileName = 0;
    mdb.TX2.stimulus.noise.NBCntrFrq = 0;
    mdb.TX2.stimulus.noise.NBBW = 0;
    mdb.TX2.stimulus.noise.amp = 0;
    mdb.TX2.stimulus.noise.phase = 0;

    % pure-tone parameters
    mdb.TX2.stimulus.PT.freq = 0;
    mdb.TX2.stimulus.PT.amp = 0;  
    mdb.TX2.stimulus.PT.modulationType = 0;  
    mdb.TX2.stimulus.PT.modDepth = 0;  
    mdb.TX2.stimulus.PT.modFreq = 0;
    mdb.TX2.stimulus.PT.phase = 0;

    % speech parameters
    mdb.TX2.stimulus.speech.source = 0;
    mdb.TX2.stimulus.speech.amp = 0;  
    mdb.TX2.stimulus.speech.phase = 0;
    
    % transducer parameters
    mdb.TX2.transducer.source = 0;
    
    
    
    % ********** TX3 ***********

    %  stimulus selection
    mdb.TX3.stimulus.stimulusSelect.pureTone = 0; 
    mdb.TX3.stimulus.stimulusSelect.speech = 0;
    mdb.TX3.stimulus.stimulusSelect.noise = 0; 

    % noise parameters
    mdb.TX3.stimulus.noise.source = 0;
    mdb.TX3.stimulus.noise.fileName = 0;
    mdb.TX3.stimulus.noise.NBCntrFrq = 0;
    mdb.TX3.stimulus.noise.NBBW = 0;
    mdb.TX3.stimulus.noise.amp = 0;
    mdb.TX3.stimulus.noise.phase = 0;

    % pure-tone parameters
    mdb.TX3.stimulus.PT.freq = 0;
    mdb.TX3.stimulus.PT.amp = 0;  
    mdb.TX3.stimulus.PT.modulationType = 0;  
    mdb.TX3.stimulus.PT.modDepth = 0;  
    mdb.TX3.stimulus.PT.modFreq = 0;
    mdb.TX3.stimulus.PT.phase = 0;

    % speech parameters
    mdb.TX3.stimulus.speech.source = 0;
    mdb.TX3.stimulus.speech.amp = 0;  
    mdb.TX3.stimulus.speech.phase = 0;
    
    % transducer parameters
    mdb.TX3.transducer.source = 0;
    


    save mdb mdb;

 