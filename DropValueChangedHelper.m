function DropValueChangedHelper(app,TXNumber,value)
    delete(app.(TXNumber+"Options"));
%     load mdb;
%     fieldNames = fieldnames(mdb.(TXNumber).stimulus.stimulusSelect);
%     for ii=1:length(fieldNames) 
%         mdb.(TXNumber).stimulus.stimulusSelect.(fieldNames{ii}) = 0;
%     end
%     mdb.(TXNumber).transducer.source = 'FF';
    
    if(~(value=="None"))
       app.(strcat("Options",TXNumber,"Button")).Enable = 1;
%        mdb.master.(strcat(TXNumber,"_select")) = 1;
    else
       app.(strcat("Options",TXNumber,"Button")).Enable = 0;
%        mdb.master.(strcat(TXNumber,"_select")) = 0;
    end
%     
%     switch value
%         case 'Pure Tune'
%            mdb.(TXNumber).stimulus.stimulusSelect.pureTone = 1;
%         case 'Noise'
%              mdb.(TXNumber).stimulus.stimulusSelect.noise = 1;
% %         case 'Speech'
% %              mdb.(TXNumber).stimulus.stimulusSelect.speech = 1;
%         case 'From File'
%              mdb.(TXNumber).stimulus.stimulusSelect.speech = 1;
%     end
        

%     save mdb mdb;
end