function varargout = TDT_GUI_v2(varargin)
% TDT_GUI_V2 M-file for TDT_GUI_v2.fig
%      TDT_GUI_V2, by itself, creates a new TDT_GUI_V2 or raises the existing
%      singleton*.
%
%      H = TDT_GUI_V2 returns the handle to a new TDT_GUI_V2 or the handle to
%      the existing singleton*.
%
%      TDT_GUI_V2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TDT_GUI_V2.M with the given input arguments.
%
%      TDT_GUI_V2('Property','Value',...) creates a new TDT_GUI_V2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TDT_GUI_v2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TDT_GUI_v2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TDT_GUI_v2

% Last Modified by GUIDE v2.5 30-Nov-2022 18:12:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TDT_GUI_v2_OpeningFcn, ...
                   'gui_OutputFcn',  @TDT_GUI_v2_OutputFcn, ...
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


% --- Executes just before TDT_GUI_v2 is made visible.
function TDT_GUI_v2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TDT_GUI_v2 (see VARARGIN)

% Choose default command line output for TDT_GUI_v2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TDT_GUI_v2 wait for user response (see UIRESUME)
% uiwait(handles.mainFigure);


% --- Outputs from this function are returned to the command line.
function varargout = TDT_GUI_v2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%TODO You may consider a special case when noise and speech to the same
%speaker will require a calculation of the SNR data like in noise previous
%in the original version

% TODO you may check if there is need for NOISE+SPEECH/PT

% --- Executes on selection change in TX1.
function TX1_Callback(hObject, eventdata, handles)

load mdb;
% reset mdb.TX1.stimulus.stimulusSelect struct to 0
fieldNames = fieldnames(mdb.TX1.stimulus.stimulusSelect);
for ii=1:length(fieldNames) 
    mdb.TX1.stimulus.stimulusSelect.(fieldNames{ii}) = 0;
end
mdb.TX1.transducer.source = 'FF';


contents = get(hObject,'String');
value = contents{get(hObject,'Value')};

if(~strcmp(value,'None'))
    set(handles.Output1Panel,'Visible','On');
    set(handles.OptionsButton1,'Visible','On');
    mdb.master.TX1_select = 1;
else
    set(handles.Output1Panel,'Visible','Off');
    set(handles.OptionsButton1,'Visible','Off');
    mdb.master.TX1_select = 0;
end

if (strcmp(value,'Tune'))
    mdb.TX1.stimulus.stimulusSelect.pureTone = 1;
%     set(handles.TX1_AmpSelect_slider,'Max',150);
%     set(handles.TX1_AmpSelect_slider,'Min',-75);
    
elseif(strcmp(value,'Noise'))
    mdb.TX1.stimulus.stimulusSelect.noise = 1;
%     set(handles.TX1_AmpSelect_slider,'Max',125);
%     set(handles.TX1_AmpSelect_slider,'Min',0);
elseif(strcmp(value,'Speech'))
    mdb.TX1.stimulus.stimulusSelect.speech = 1;

end
save mdb mdb;

% --- Executes during object creation, after setting all properties.
function TX1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in TX1FF1.
function TX1FF1_Callback(hObject, eventdata, handles)
   
    load mdb;
    mdb.TX1.transducer.FF.DacVector(1) =  get(hObject,'Value');
    save mdb mdb ;

% --- Executes on button press in startPauseButton.
function startPauseButton_Callback(hObject, eventdata, handles)
load mdb;

value = get(hObject,'Value');
if(1 == value )
    set(hObject,'String','Pause');
    [TX1_playMode,TX2_playMode,TX3_playMode] = play_signal_multi(mdb.master.TX1_select,mdb.master.TX2_select,mdb.master.TX3_select); 

    
%TODO: check if needed    
%     if (TX1_playMode &&  TX2_playMode &&  TX3_playMode)  %single shot
%         set(hObject,'String','start'); %reset button
%         set(hObject,'Value',0);
%     end

else
    set(hObject,'String','Start');
    TXall_stop_signal();
end
% set(handles.startPauseButton,'Value',1);


% --- Executes during object creation, after setting all properties.
function mainFigure_CreateFcn(hObject, eventdata, handles)

global RP;
global whiteNoise_vector;
% global parameters;
   
% parameters.Options.SingleTon = 0;
% save parameters;



path = strcat(pwd,'\Copy_of_full_3.rcx');
[RP,status,message] = Circuit_Loader(path);
statusNumbers = bitget(status,[1 2 3]);
if(  any(0 == statusNumbers ) )
   idx = find(0==statusNumbers);
   numOfError = idx(1);
   if(1 == numOfError)
      message = strcat(message,sprintf('\nPlease restart the DTD system'));
   end
   uiwait(msgbox(message,'Error','error'));
   close all force;

end

whiteNoise_vector = randn(1,3000000);


% --- Executes during object creation, after setting all properties.
function TX1_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load mdb;
mdb.main.transducer.newSource = 'NULL';
mdb.TX1.transducer.source = 'NULL';
mdb.TX2.transducer.source = 'NULL';
mdb.TX3.transducer.source = 'NULL';
    


% --- Executes on slider movement.
function TX1_AmpValue_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_AmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
    errordlg('You must enter a numeric value','Bad Input','modal')
    uicontrol(hObject)
    return
end

load mdb;
%TODO: add support for noise, don't forget to change the mdb right flags
%based on the choise option in input Signals. need to check if it has
%effect.
% TODO: Add Options support
%check if entered value is in frequency range
sliderMax = get(mdb.TX1.stimulus.PT.PTAmpSelectSlider_handle,'Max');
sliderMin = get(mdb.TX1.stimulus.PT.PTAmpSelectSlider_handle,'Min');
if (user_entry <  sliderMin)
    set(hObject,'String',sliderMin);
    set(mdb.TX1.stimulus.PT.PTAmpSelectSlider_handle,'Value',sliderMin);
    mdb.TX1.stimulus.PT.amp = sliderMin;
elseif (user_entry > sliderMax )
    set(hObject,'String',sliderMax);
    set(mdb.TX1.stimulus.PT.PTAmpSelectSlider_handle,'Value',sliderMax);
    mdb.TX1.stimulus.PT.amp = sliderMax; 
else
set(mdb.TX1.stimulus.PT.PTAmpSelectSlider_handle,'Value',user_entry);
 mdb.TX1.stimulus.PT.amp = user_entry;

end
save mdb mdb;



% 
% % --- Executes on slider movement.
% function TX1_AmpSelect_slider_Callback(hObject, eventdata, handles)
% % hObject    handle to TX1_AmpSelect_slider (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%  load mdb;
%  value = get(hObject,'Value');
%  mdb.TX1.stimulus.PT.amp = value;
%  set(handles.TX1_AmpValue_editText,'String',value);
%  save mdb mdb;
% 
%     
% % --- Executes during object creation, after setting all properties.
% function TX1_AmpSelect_slider_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to TX1_AmpSelect_slider (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: slider controls usually have a light gray background.
% if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor',[.9 .9 .9]);
% end
% load mdb;
% mdb.TX1.stimulus.PT.PTAmpSelectSlider_handle = hObject;
%  mdb.TX1.stimulus.PT.amp = get(hObject,'Value');
%  save mdb mdb;


% --- Executes on button press in TX1FF2.
function TX1FF2_Callback(hObject, eventdata, handles)
% hObject    handle to TX1FF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1FF2
    load mdb;
    mdb.TX1.transducer.FF.DacVector(2) =  get(hObject,'Value');
    save mdb mdb ;

% --- Executes on button press in TX1FF3.
function TX1FF3_Callback(hObject, eventdata, handles)
% hObject    handle to TX1FF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1FF3
    load mdb;
    mdb.TX1.transducer.FF.DacVector(3) =  get(hObject,'Value');
    save mdb mdb ;

% --- Executes on button press in TX1FF4.
function TX1FF4_Callback(hObject, eventdata, handles)
% hObject    handle to TX1FF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1FF4
    load mdb;
    mdb.TX1.transducer.FF.DacVector(4) =  get(hObject,'Value');
    save mdb mdb ;

% --- Executes on button press in TX1FF5.
function TX1FF5_Callback(hObject, eventdata, handles)
% hObject    handle to TX1FF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1FF5
    load mdb;
    mdb.TX1.transducer.FF.DacVector(5) =  get(hObject,'Value');
    save mdb mdb ;

% --- Executes on button press in TX1FF6.
function TX1FF6_Callback(hObject, eventdata, handles)
% hObject    handle to TX1FF6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1FF6
    load mdb;
    mdb.TX1.transducer.FF.DacVector(6) =  get(hObject,'Value');
    save mdb mdb ;

% --- Executes on button press in TX1FF7.
function TX1FF7_Callback(hObject, eventdata, handles)
% hObject    handle to TX1FF7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1FF7
    load mdb;
    mdb.TX1.transducer.FF.DacVector(7) =  get(hObject,'Value');
    save mdb mdb ;

% --- Executes on button press in TX1FF8.
function TX1FF8_Callback(hObject, eventdata, handles)
% hObject    handle to TX1FF8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1FF8
    load mdb;
    mdb.TX1.transducer.FF.DacVector(8) =  get(hObject,'Value');
    save mdb mdb ;


% --- Executes on button press in SpeakersMapButton.
function SpeakersMapButton_Callback(hObject, eventdata, handles)
% hObject    handle to SpeakersMapButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = imread('Maps/PP16Map.jpg');
figure();
imshow(I);



% --- Executes on button press in mapSpeakers.
function mapSpeakers_Callback(hObject, eventdata, handles)
% hObject    handle to mapSpeakers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
top = imread('Maps/SpeakersTop.jpg');
horizontal = imread('Maps/SpeakersLow.jpg');
figure();
subplot(1,2,1);
imshow(top);
title('Speakers Numbers in top level');
subplot(1,2,2);
imshow(horizontal);
title('Speakers Numbers in horizontal level');

%TODO add ceses depends on the value in TX1 pop menu
% --- Executes on button press in OptionsButton1.
function OptionsButton1_Callback(hObject, eventdata, handles)
% hObject    handle to OptionsButton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% load parameters
% if(0 == parameters.Options.SingleTon)
%     parameters.Options.TxNumber = 1;
%     save parameters

   SignalChoices = get(handles.TX1,'String');
   switch SignalChoices{get(handles.TX1,'Value')}
       case 'Tune'
         PTOptions(1);
       case 'Noise'
         NoiseOptions(1);
       case 'Speech'
         SpeechOptions(1);
   end
%    if( value == 2 )
%     PTOptions(1);
%    elseif( value == 3 )
%        NoiseOptions(1);
%    elseif( value == 4 )
%    end
%     
% else
%     message = sprintf('\nFirst Close the other option window');
%     uiwait(msgbox(message,'Warning','warning'));
% end

% --- Executes on key press with focus on TX1 and none of its controls.
function TX1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to TX1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function mainFigure_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to mainFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over figure background.
function mainFigure_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to mainFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function TX1_title_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to TX1_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in TX2FF1.
function TX2FF1_Callback(hObject, eventdata, handles)
% hObject    handle to TX2FF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX2FF1
    load mdb;
    mdb.TX2.transducer.FF.DacVector(1) =  get(hObject,'Value');
    save mdb mdb ;

% --- Executes on button press in TX2FF2.
function TX2FF2_Callback(hObject, eventdata, handles)
% hObject    handle to TX2FF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX2FF2
    load mdb;
    mdb.TX2.transducer.FF.DacVector(2) =  get(hObject,'Value');
    save mdb mdb ;


% --- Executes on button press in TX2FF3.
function TX2FF3_Callback(hObject, eventdata, handles)
% hObject    handle to TX2FF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX2FF3
    load mdb;
    mdb.TX2.transducer.FF.DacVector(3) =  get(hObject,'Value');
    save mdb mdb ;


% --- Executes on button press in TX2FF4.
function TX2FF4_Callback(hObject, eventdata, handles)
% hObject    handle to TX2FF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX2FF4
    load mdb;
    mdb.TX2.transducer.FF.DacVector(4) =  get(hObject,'Value');
    save mdb mdb ;


% --- Executes on button press in TX2FF5.
function TX2FF5_Callback(hObject, eventdata, handles)
% hObject    handle to TX2FF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX2FF5
    load mdb;
    mdb.TX2.transducer.FF.DacVector(5) =  get(hObject,'Value');
    save mdb mdb ;


% --- Executes on button press in TX2FF6.
function TX2FF6_Callback(hObject, eventdata, handles)
% hObject    handle to TX2FF6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX2FF6
    load mdb;
    mdb.TX2.transducer.FF.DacVector(6) =  get(hObject,'Value');
    save mdb mdb ;


% --- Executes on button press in TX2FF7.
function TX2FF7_Callback(hObject, eventdata, handles)
% hObject    handle to TX2FF7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX2FF7
    load mdb;
    mdb.TX2.transducer.FF.DacVector(7) =  get(hObject,'Value');
    save mdb mdb ;


% --- Executes on button press in TX2FF8.
function TX2FF8_Callback(hObject, eventdata, handles)
% hObject    handle to TX2FF8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX2FF8
    load mdb;
    mdb.TX2.transducer.FF.DacVector(8) =  get(hObject,'Value');
    save mdb mdb ;


% --- Executes on button press in OptionsButton2.
function OptionsButton2_Callback(hObject, eventdata, handles)
% hObject    handle to OptionsButton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

   SignalChoices = get(handles.TX2,'String');
   switch SignalChoices{get(handles.TX2,'Value')}
       case 'Tune'
         PTOptions(2);
       case 'Noise'
         NoiseOptions(2);
       case 'Speech'
         SpeechOptions(2);
   end

% --- Executes on selection change in TX2.
function TX2_Callback(hObject, eventdata, handles)
% hObject    handle to TX2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns TX2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TX2

load mdb;
% reset mdb.TX1.stimulus.stimulusSelect struct to 0
fieldNames = fieldnames(mdb.TX2.stimulus.stimulusSelect);
for ii=1:length(fieldNames) 
    mdb.TX2.stimulus.stimulusSelect.(fieldNames{ii}) = 0;
end
mdb.TX2.transducer.source = 'FF';


contents = get(hObject,'String');
value = contents{get(hObject,'Value')};

if(~strcmp(value,'None'))
    set(handles.Output2Panel,'Visible','On');
    set(handles.OptionsButton2,'Visible','On');
    mdb.master.TX2_select = 1;
else
    set(handles.Output2Panel,'Visible','Off');
    set(handles.OptionsButton2,'Visible','Off');
    mdb.master.TX2_select = 0;
end

if (strcmp(value,'Tune'))
    mdb.TX2.stimulus.stimulusSelect.pureTone = 1;
%     set(handles.TX1_AmpSelect_slider,'Max',150);
%     set(handles.TX1_AmpSelect_slider,'Min',-75);
    
elseif(strcmp(value,'Noise'))
    mdb.TX2.stimulus.stimulusSelect.noise = 1;
%     set(handles.TX1_AmpSelect_slider,'Max',125);
%     set(handles.TX1_AmpSelect_slider,'Min',0);
elseif(strcmp(value,'Speech'))
    mdb.TX2.stimulus.stimulusSelect.speech = 1;

end
save mdb mdb;

% --- Executes during object creation, after setting all properties.
function TX2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


