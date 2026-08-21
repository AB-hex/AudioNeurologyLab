function seg = ReadEEGSegment(RP, bufPrefix, numChans, bufSize, startIdx, endIdx)
% READEEGSEGMENT Read samples [startIdx, endIdx) from a set of circular
% buffer tags named [bufPrefix '1'] .. [bufPrefix numChans], handling
% wraparound. startIdx/endIdx are free-running counter values (e.g. from
% sEEG0/sBTTN), not buffer-relative offsets.
%
% seg = ReadEEGSegment(RP, 'dEEG0~', 4, eegBufSize, eegBaseline, eegFinal)

    nRead = endIdx - startIdx;
    if nRead <= 0
        seg = zeros(0, numChans);
        return;
    end
    if nRead > bufSize
        warning('ReadEEGSegment: trial (%d smp) exceeds buffer capacity (%d smp) — clipped.', ...
            nRead, bufSize);
        nRead = bufSize;
    end

    readStart = mod(startIdx, bufSize);
    seg = zeros(nRead, numChans);
    if readStart + nRead <= bufSize
        for ch = 1:numChans
            seg(:,ch) = RP.ReadTagV([bufPrefix num2str(ch)], readStart, nRead);
        end
    else
        nTail = bufSize - readStart;
        for ch = 1:numChans
            tail = RP.ReadTagV([bufPrefix num2str(ch)], readStart, nTail);
            head = RP.ReadTagV([bufPrefix num2str(ch)], 0, nRead - nTail);
            seg(:,ch) = [tail; head];
        end
    end
end
