function varargout = NoiseOptions(varargin)
% NOISEOPTIONS M-file for NoiseOptions.fig
%      NOISEOPTIONS, by itself, creates a new NOISEOPTIONS or raises the existing
%      singleton*.
%
%      H = NOISEOPTIONS returns the handle to a new NOISEOPTIONS or the handle to
%      the existing singleton*.
%
%      NOISEOPTIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOISEOPTIONS.M with the given input arguments.
%
%      NOISEOPTIONS('Property','Value',...) creates a new NOISEOPTIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NoiseOptions_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NoiseOptions_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NoiseOptions

% Last Modified by GUIDE v2.5 29-Dec-2022 15:38:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NoiseOptions_OpeningFcn, ...
                   'gui_OutputFcn',  @NoiseOptions_OutputFcn, ...
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



% --- Executes just before NoiseOptions is made visible.
function NoiseOptions_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NoiseOptions (see VARARGIN)

% load parameters
% parameters.Options.SingleTon = 1;
% save parameters

set(handles.TXNumber,'String',varargin{1})

% Choose default command line output for NoiseOptions
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes NoiseOptions wait for user response (see UIRESUME)
% uiwait(handles.PTOptionsBackground);


% --- Outputs from this function are returned to the command line.
function varargout = NoiseOptions_OutputFcn(hObject, eventdata, handles) 
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
 mdb.(TXNumber).stimulus.noise.amp = value;
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
sliderMax = get(mdb.(TXNumber).stimulus.noise.ampSelectSlider_handle,'Max');
sliderMin = get(mdb.(TXNumber).stimulus.noise.ampSelectSlider_handle,'Min');

if(user_entry < sliderMin)
    value = sliderMin;
elseif( user_entry > sliderMax )
    value = sliderMax;
else
    value = user_entry;
end
set(hObject,'String',value);
mdb.(TXNumber).stimulus.noise.amp = value;
set(mdb.(TXNumber).stimulus.noise.ampSelectSlider_handle,'Value',value);
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
 UpdateProperties(propertiesObj,mdb.(TXNumber).stimulus.noise);
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
function modulationFM_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to modulationFM_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in stimulusNoiseSourceSelect_popupmenu.
function stimulusNoiseSourceSelect_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to stimulusNoiseSourceSelect_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns stimulusNoiseSourceSelect_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stimulusNoiseSourceSelect_popupmenu

TXNumber = strcat('TX',get(handles.TXNumber,'String'));

str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
load mdb;
set(handles.stimulusNoiseSourceFileName_staticText,'Visible','off'); %reset the source file name
set(handles.stimulus_noiseFilter_pannel,'Visible','off');

switch str{val}
    case 'black noise'
        mdb.(TXNumber).stimulus.noise.source = 1; %1=white noise'
    case 'NB noise'
        set(handles.stimulus_noiseFilter_pannel,'Visible','on');
         mdb.(TXNumber).stimulus.noise.source = 2;  %2=NB noise
    case 'from file'
         [FileName,PathName,FilterIndex] = uigetfile('D:\Users\students\*.wav');
         fullfilename = sprintf('%s%s',PathName,FileName);
         disp(fullfilename);
         mdb.(TXNumber).stimulus.noise.source = 3;  %3=from file
          mdb.(TXNumber).stimulus.noise.fileName = fullfilename;
        set(handles.stimulusNoiseSourceFileName_staticText,'String',strcat('File Name: "',FileName,'"'));  
        set(handles.stimulusNoiseSourceFileName_staticText,'Visible','on');        
end

 save mdb mdb;
 

% --- Executes during object creation, after setting all properties.
function stimulusNoiseSourceSelect_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimulusNoiseSourceSelect_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in stimulus_NoisePhase_popupmenu.
function stimulus_NoisePhase_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to stimulus_NoisePhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns stimulus_NoisePhase_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stimulus_NoisePhase_popupmenu

TXNumber = strcat('TX',get(handles.TXNumber,'String'));

str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
load mdb;

switch str{val}
    case '0 deg'
       mdb.(TXNumber).stimulus.noise.phase = 0;
    case '180 deg'
       mdb.(TXNumber).stimulus.noise.phase = 180;   
end

 save mdb mdb;

% --- Executes during object creation, after setting all properties.
function stimulus_NoisePhase_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimulus_NoisePhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stimulus_noiseFilterBW_editText_Callback(hObject, eventdata, handles)
% hObject    handle to stimulus_noiseFilterBW_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stimulus_noiseFilterBW_editText as text
%        str2double(get(hObject,'String')) returns contents of stimulus_noiseFilterBW_editText as a double


% --- Executes during object creation, after setting all properties.
function stimulus_noiseFilterBW_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimulus_noiseFilterBW_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stimulus_noiseFilterCntrFrq_edtiText_Callback(hObject, eventdata, handles)
% hObject    handle to stimulus_noiseFilterCntrFrq_edtiText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stimulus_noiseFilterCntrFrq_edtiText as text
%        str2double(get(hObject,'String')) returns contents of stimulus_noiseFilterCntrFrq_edtiText as a double


% --- Executes during object creation, after setting all properties.
function stimulus_noiseFilterCntrFrq_edtiText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimulus_noiseFilterCntrFrq_edtiText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
