RP = actxcontrol('RPco.x', [5 5 26 26]);
m = methods(RP);
fprintf('RPco.X methods:\n');
fprintf('  %s\n', m{:});
delete(RP);
