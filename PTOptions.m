function varargout = PTOptions(varargin)
% PTOPTIONS M-file for PTOptions.fig
%      PTOPTIONS, by itself, creates a new PTOPTIONS or raises the existing
%      singleton*.
%
%      H = PTOPTIONS returns the handle to a new PTOPTIONS or the handle to
%      the existing singleton*.
%
%      PTOPTIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PTOPTIONS.M with the given input arguments.
%
%      PTOPTIONS('Property','Value',...) creates a new PTOPTIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PTOptions_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PTOptions_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PTOptions

% Last Modified by GUIDE v2.5 29-Dec-2022 14:01:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PTOptions_OpeningFcn, ...
                   'gui_OutputFcn',  @PTOptions_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT



% --- Executes just before PTOptions is made visible.
function PTOptions_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PTOptions (see VARARGIN)

% load parameters
% parameters.Options.SingleTon = 1;
% save parameters

set(handles.TXNumber,'String',varargin{1})

% Choose default command line output for PTOptions
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes PTOptions wait for user response (see UIRESUME)
% uiwait(handles.PTOptionsBackground);


% --- Outputs from this function are returned to the command line.
function varargout = PTOptions_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure


varargout{1} = handles.output;


% --- Executes during object deletion, before destroying properties.
function PTOptionsBackground_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to PTOptionsBackground (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% load parameters
% parameters.Options.SingleTon = 0;
% save parameters



function TxNumberTitle_Callback(hObject, eventdata, handles)
% hObject    handle to TxNumberTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TxNumberTitle as text
%        str2double(get(hObject,'String')) returns contents of TxNumberTitle as a double


% --- Executes during object creation, after setting all properties.
function TxNumberTitle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TxNumberTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function freq_slider_Callback(hObject, eventdata, handles)
% hObject    handle to freq_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value = get(hObject,'Value');
TXNumber = strcat('TX',get(handles.TXNumber,'String'));
set(handles.freq_edit_field,'String',value);
load mdb;
mdb.(TXNumber).stimulus.PT.freq = value;
save mdb mdb;


% --- Executes during object creation, after setting all properties.
function freq_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% TXNumber = strcat('TX',get(handles.TXNumber,'String'));
% load mdb;
% mdb.(TXNumber).stimulus.PT.freq = get(hObject,'Value');
% mdb.(TXNumber).stimulus...
%     .PT.PTFreqSelectSlider_handle = hObject;
% 
% save mdb mdb;



%TODO fix the problem with TX1 and TX2 cannot output 2 different PT,
%something to do with this function


function freq_edit_field_Callback(hObject, eventdata, handles)
% hObject    handle to freq_edit_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freq_edit_field as text
%        str2double(get(hObject,'String')) returns contents of freq_edit_field as a double
user_entry = str2double(get(hObject,'String'));
if isnan(user_entry)
    errordlg('You must enter a numeric value','Bad Input','modal')
    uicontrol(hObject)
    return
end

TXNumber = strcat('TX',get(handles.TXNumber,'String'));
load mdb;
sliderMax = get(mdb.(TXNumber).stimulus.PT.PTFreqSelectSlider_handle,'Max');
sliderMin = get(mdb.(TXNumber).stimulus.PT.PTFreqSelectSlider_handle,'Min');
if(user_entry < sliderMin)
    value = sliderMin;
elseif( user_entry > sliderMax )
    value = sliderMax;
else
    value = user_entry;
end
set(hObject,'String',value);
mdb.(TXNumber).stimulus.PT.freq = value;
set( mdb.(TXNumber).stimulus.PT.PTFreqSelectSlider_handle,'Value',value);
set(handles.freq_slider,'Value',value);
save mdb mdb;
 

% --- Executes during object creation, after setting all properties.
function freq_edit_field_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq_edit_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ModFreq_editText_Callback(hObject, eventdata, handles)
% hObject    handle to ModFreq_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ModFreq_editText as text
%        str2double(get(hObject,'String')) returns contents of ModFreq_editText as a double
user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

TXNumber = strcat('TX',get(handles.TXNumber,'String'));

load mdb;
 mdb.(TXNumber).stimulus.PT.modFreq = user_entry;
 save mdb mdb;

% --- Executes during object creation, after setting all properties.
function ModFreq_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ModFreq_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stimulusModulationAM_checkBox.
function stimulusModulationAM_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to stimulusModulationAM_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of stimulusModulationAM_checkBox

TXNumber = strcat('TX',get(handles.TXNumber,'String'));
load mdb;
if (get(hObject,'Value'))
    if (  mdb.(TXNumber).stimulus.PT.modulationType == 3 )  %no modulation
        mdb.(TXNumber).stimulus.PT.modulationType = 0; %AM
    else  %FM is required too
        mdb.(TXNumber).stimulus.PT.modulationType = 2; %AM and FM
    end
else
    if (  mdb.(TXNumber).stimulus.PT.modulationType == 2 ) %AM and FM
         mdb.(TXNumber).stimulus.PT.modulationType = 1;    %FM
    else
        mdb.(TXNumber).stimulus.PT.modulationType = 3;  %no modulation
    end
end

save mdb mdb;

%TODO finish the modolation am function
function AMModDepth_editText_Callback(hObject, eventdata, handles)
% hObject    handle to AMModDepth_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AMModDepth_editText as text
%        str2double(get(hObject,'String')) returns contents of AMModDepth_editText as a double


% --- Executes during object creation, after setting all properties.
function AMModDepth_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AMModDepth_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stimulusModulationFM_checkBox.
function stimulusModulationFM_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to stimulusModulationFM_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of stimulusModulationFM_checkBox
TXNumber = strcat('TX',get(handles.TXNumber,'String'));
load mdb;
if (get(hObject,'Value'))
    if (  mdb.(TXNumber).stimulus.PT.modulationType == 3 )  %no modulation
        mdb.(TXNumber).stimulus.PT.modulationType = 1; %FM
    else  %AM is required too
        mdb.(TXNumber).stimulus.PT.modulationType = 2; %AM and FM
    end
else
    if (  mdb.(TXNumber).stimulus.PT.modulationType == 2 ) %AM and FM
         mdb.(TXNumber).stimulus.PT.modulationType = 0;    %AM
    else
        mdb.(TXNumber).stimulus.PT.modulationType = 3;  %no modulation
    end
end

save mdb mdb;


function FMModIndex_editText_Callback(hObject, eventdata, handles)
% hObject    handle to FMModIndex_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FMModIndex_editText as text
%        str2double(get(hObject,'String')) returns contents of FMModIndex_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

TXNumber = strcat('TX',get(handles.TXNumber,'String'));
load mdb;
mdb.(TXNumber).stimulus.PT.modIndex = user_entry;
save mdb mdb;


% --- Executes during object creation, after setting all properties.
function FMModIndex_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FMModIndex_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in stimulus_PTPhase_popupmenu.
function stimulus_PTPhase_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to stimulus_PTPhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns stimulus_PTPhase_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stimulus_PTPhase_popupmenu
% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
TXNumber = strcat('TX',get(handles.TXNumber,'String'));

load mdb;

switch str{val}
    case '0 deg'
        mdb.(TXNumber).stimulus.PT.phase = 0; 
    case '90 deg'
        mdb.(TXNumber).stimulus.PT.phase = 90;
    case '180 deg'
        mdb.(TXNumber).stimulus.PT.phase = 180;
    case '270 deg'
        mdb.(TXNumber).stimulus.PT.phase = 270;       
end

 save mdb mdb;

% --- Executes during object creation, after setting all properties.
function stimulus_PTPhase_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimulus_PTPhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function AmpSelect_slider_Callback(hObject, eventdata, handles)
% hObject    handle to AmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
 TXNumber = strcat('TX',get(handles.TXNumber,'String'));
 load mdb;
 value = get(hObject,'Value');
 mdb.(TXNumber).stimulus.PT.amp = value;
 set(handles.AmpValue_editText,'String',value);
 save mdb mdb;

% --- Executes during object creation, after setting all properties.
function AmpSelect_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%  TXNumber = strcat('TX',get(handles.TXNumber,'String'));
% load mdb;
% mdb.(TXNumber).stimulus.PT.PTAmpSelectSlider_handle = hObject;
%  mdb.(TXNumber).stimulus.PT.amp = get(hObject,'Value');
%  save mdb mdb;



function AmpValue_editText_Callback(hObject, eventdata, handles)
% hObject    handle to AmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmpValue_editText as text
%        str2double(get(hObject,'String')) returns contents of AmpValue_editText as a double
user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
    errordlg('You must enter a numeric value','Bad Input','modal')
    uicontrol(hObject)
    return
end

TXNumber = strcat('TX',get(handles.TXNumber,'String'));
propertiesObj = findobj('Tag','AmpSelect_slider');

load mdb;
sliderMax = get(mdb.(TXNumber).stimulus.PT.PTAmpSelectSlider_handle,'Max');
sliderMin = get(mdb.(TXNumber).stimulus.PT.PTAmpSelectSlider_handle,'Min');

if(user_entry < sliderMin)
    value = sliderMin;
elseif( user_entry > sliderMax )
    value = sliderMax;
else
    value = user_entry;
end
set(hObject,'String',value);
mdb.(TXNumber).stimulus.PT.amp = value;
set(mdb.(TXNumber).stimulus.PT.PTAmpSelectSlider_handle,'Value',value);
set(propertiesObj,'Value',value);
% 
% 
% if (user_entry <  sliderMin)
%     set(hObject,'String',sliderMin);
%     set(mdb.(TXNumber).stimulus.PT.PTAmpSelectSlider_handle,'Value',sliderMin);
%     mdb.(TXNumber).stimulus.PT.amp = sliderMin;
% elseif (user_entry > sliderMax )
%     set(hObject,'String',sliderMax);
%     set(mdb.(TXNumber).stimulus.PT.PTAmpSelectSlider_handle,'Value',sliderMax);
%     mdb.(TXNumber).stimulus.PT.amp = sliderMax; 
% else
% set(mdb.(TXNumber).stimulus.PT.PTAmpSelectSlider_handle,'Value',user_entry);
%  mdb.(TXNumber).stimulus.PT.amp = user_entry;
% 
% end
save mdb mdb;




% --- Executes during object creation, after setting all properties.
function AmpValue_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function PTOptionsBackground_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PTOptionsBackground (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on mouse press over figure background.
function PTOptionsBackground_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to PTOptionsBackground (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function PTOptionsBackground_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to PTOptionsBackground (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse motion over figure - except title and menu.
function PTOptionsBackground_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to PTOptionsBackground (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function PTOptionsBackground_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to PTOptionsBackground (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on PTOptionsBackground or any of its controls.
function PTOptionsBackground_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to PTOptionsBackground (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key release with focus on PTOptionsBackground or any of its controls.
function PTOptionsBackground_WindowKeyReleaseFcn(hObject, eventdata, handles)
% hObject    handle to PTOptionsBackground (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was released, in lower case
%	Character: character interpretation of the key(s) that was released
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) released
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on scroll wheel click while the figure is in focus.
function PTOptionsBackground_WindowScrollWheelFcn(hObject, eventdata, handles)
% hObject    handle to PTOptionsBackground (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	VerticalScrollCount: signed integer indicating direction and number of clicks
%	VerticalScrollAmount: number of lines scrolled for each click
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on PTOptionsBackground and none of its controls.
function PTOptionsBackground_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to PTOptionsBackground (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key release with focus on PTOptionsBackground and none of its controls.
function PTOptionsBackground_KeyReleaseFcn(hObject, eventdata, handles)
% hObject    handle to PTOptionsBackground (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was released, in lower case
%	Character: character interpretation of the key(s) that was released
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) released
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when PTOptionsBackground is resized.
function PTOptionsBackground_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to PTOptionsBackground (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close PTOptionsBackground.
function PTOptionsBackground_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to PTOptionsBackground (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in Showtogglebutton.
function Showtogglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to Showtogglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Showtogglebutton
TXNumber = strcat('TX',get(handles.TXNumber,'String'));
strProperties = strcat(TXNumber,'Properties');
propertiesObj = findobj('Tag',strProperties);
load mdb;
if(1==get(hObject,'Value'))
 UpdateProperties(propertiesObj,mdb.(TXNumber).stimulus.PT);
 set(hObject,'String','Hide in Main Screen');
else
 UpdateProperties(propertiesObj,[]);
 set(hObject,'String','Update/Show in Main Screen');
end
    
    


% --- Executes during object creation, after setting all properties.
function TXNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function stimulusModulationFM_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimulusModulationFM_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
