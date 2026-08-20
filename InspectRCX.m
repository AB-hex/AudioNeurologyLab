function InspectRCX(rcxPath)
    try
        RP = actxcontrol('RPco.x', [5 5 26 26]);
        RP.ConnectRX8('GB', 1);
        RP.ClearCOF();
        RP.LoadCOF(rcxPath);
        RP.Run();
        pause(1);
        
        categories = {'Tag', 'DataTag', 'Component', 'Processor'};
        
        for c = 1:length(categories)
            cat = categories{c};
            n = RP.GetNumOf(cat);
            fprintf('\nCategory: %s (%d found)\n', cat, n);
            for i = 1:n
                name = RP.GetNameOf(cat, i);
                fprintf('  [%d] %s\n', i, name);
            end
        end
        
        RP.Halt();
        delete(RP);
    catch ME
        fprintf('Error: %s\n', ME.message);
    end
end