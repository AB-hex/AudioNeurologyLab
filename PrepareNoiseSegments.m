function PrepareNoiseSegments(path,interval)

    rmdir('Noise','s');
    mkdir('Noise');
    [y,Fs] = audioread(path);
%     noiseTrackTime = length(y)/Fs;
    noiseTrackTime = audioinfo(path).Duration;
%     interval = 4; %Seconds
    intervalNumber = floor(noiseTrackTime/interval);
    arrayfun(@(ii) audiowrite("Noise/Noise"+ii+".wav",y((ii)*interval*Fs:(ii+1)*interval*Fs),Fs),[1:intervalNumber-1]);
    
end