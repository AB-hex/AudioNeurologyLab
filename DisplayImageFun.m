function DisplayImageFun()

screenSize = get(0,'screensize');
screenWidth = screenSize(3);
screenHeight = screenSize(4);
hFig = figure('Name','APP',...
    'Numbertitle','off',...
    'Position', [0 0 screenWidth screenHeight],...
    'WindowStyle','modal',...
    'Color',[0.5 0.5 0.5],...
    'Toolbar','none');
img = imread('untitled.bmp');  
fpos = get(hFig,'Position');
axOffset = (fpos(3:4)-[size(img,2) size(img,1)])/2;
ha = axes('Parent',hFig,'Units','pixels',...
            'Position',[axOffset size(img,2) size(img,1)]);
hImshow = imshow(img,'Parent',ha);

end

