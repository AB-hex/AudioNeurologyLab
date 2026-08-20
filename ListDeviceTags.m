addpath('C:\TDT\TDTMatlabSDK\TDTSDK\OpenExLive');
td = TDEV();
td.standby();

fid = fopen('C:\Users\Lab\Desktop\tags_output.txt', 'w');
for i = 1:numel(td.DEVICE_NAMES)
    fprintf(fid, '\n--- Device: %s ---\n', td.DEVICE_NAMES{i});
    tags = td.PARTAG{i};
    for j = 1:numel(tags)
        t = tags{j};
        if t.tag_size > 1
            fprintf(fid, '  %s\t%s\t[%d]\n', t.tag_type, t.tag_name, t.tag_size);
        else
            fprintf(fid, '  %s\t%s\n', t.tag_type, t.tag_name);
        end
    end
end
fclose(fid);
fprintf('Saved to C:\\Users\\Lab\\Desktop\\tags_output.txt\n');

td.idle();
