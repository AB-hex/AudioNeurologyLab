function ErrorMessage(lineNumber,message,title)
    errordlg(strcat("line ",num2str(lineNumber),": ",message),title);
end