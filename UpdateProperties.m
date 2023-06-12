function UpdateProperties(obj,struct)
    newline = char(10);%newline
    text = ['Properties:' newline];
   if(~isempty(struct))
    fields = fieldnames(struct);
    for ii=1:length(fields)
%         text = strcat(text,'\n',fields{ii},': ',struct.(fields{ii}));
%         text = strcat(text,newline ,fields{ii},': ',num2str(struct.(fields{ii})));

          text = [text fields{ii} ': ' num2str(struct.(fields{ii})) '                 '];
          if(mod(ii,3)==0)
              text = [text newline];
          end
          
    end
   end
    set(obj,'String',text);
end