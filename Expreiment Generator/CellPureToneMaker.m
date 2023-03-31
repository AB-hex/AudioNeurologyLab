function [cell] = CellPureToneMaker(app)
            cell = {'Signal', app.GenerateDropDown.Value; ...
                    [], []; ...
                    'Freq', app.FrequencyHzDropDown.Value; ...
                    'Level', app.LeveldBEditField.Value; ...
                    'phase', app.PhaseDropDown.Value; ...
                    'onset', app.onsetmsecEditField.Value; ...
                    'offset', app.offsetmsecEditField.Value; ...
                    'mod freq',app.ModFreqHzEditField;...
                    [], []; ...
                    'Output Ports', char(join(string(find(1==arrayfun(@(ii)app.("TXFF"+ii).Value,[1:8]))),','))};
            if(app.FMModulationCheckBox.Value)
                 cell = [cell(1:5,:);{'FM',app.ModulationIndexEditField.Value}; cell(6:end,:)];
            end
            if(app.AMModulationCheckBox.Value)
                 cell = [cell(1:5,:); {'AM',app.depth0100EditField.Value}; cell(6:end,:)];
            end
            
            if(app.ActivateRandomSpeakersCheckBox.Value)
                cell{end,3} = 'random';
                cell{end,4} = app.HowmanyspeakerstoselectrandomEditField.Value;
            else
                cell{end,3} = [];
                cell{end,4} = [];
            end
end