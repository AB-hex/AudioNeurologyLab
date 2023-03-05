
function [FM,AM] = ModulationTypeToFmAmModes(modulationType)
    switch(modulationType)
        case 0
            FM = 0;
            AM = 1;
        case 1
            FM = 1;
            AM = 0;
        case 2
            FM = 1;
            AM = 1;
        case 3
            FM = 0;
            AM = 0;
    end
end