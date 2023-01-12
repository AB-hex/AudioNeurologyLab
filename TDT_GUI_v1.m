function varargout = TDT_GUI_v1(varargin)
%TDT_GUI_V1 M-file for TDT_GUI_v1.fig
%      TDT_GUI_V1, by itself, creates a new TDT_GUI_V1 or raises the existing
%      singleton*.
%
%      H = TDT_GUI_V1 returns the handle to a new TDT_GUI_V1 or the handle to
%      the existing singleton*.
%
%      TDT_GUI_V1('Property','Value',...) creates a new TDT_GUI_V1 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to TDT_GUI_v1_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      TDT_GUI_V1('CALLBACK') and TDT_GUI_V1('CALLBACK',hObject,...) call the
%      local function named CALLBACK in TDT_GUI_V1.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TDT_GUI_v1

% Last Modified by GUIDE v2.5 15-Aug-2022 11:11:58

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;

%init_dataBase();

gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TDT_GUI_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @TDT_GUI_v1_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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



% --- Executes just before TDT_GUI_v1 is made visible.
function TDT_GUI_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for TDT_GUI_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes TDT_GUI_v1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TDT_GUI_v1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function master_addFreqSelect_slider_Callback(hObject, eventdata, handles)
% hObject    handle to master_addFreqSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function master_addFreqSelect_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to master_addFreqSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function master_addAmpSelect_slider_Callback(hObject, eventdata, handles)
% hObject    handle to master_addAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function master_addAmpSelect_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to master_addAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in master_start_toggleButton.
function master_start_toggleButton_Callback(hObject, eventdata, handles)
% hObject    handle to master_start_toggleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of master_start_toggleButton


button_state = get(hObject,'Value');
load mdb;
if button_state == get(hObject,'Max')
    % Toggle button is pressed, take appropriate action
    set(hObject,'String','stop');
   % play_signal();  %play the required stimulus
   % playMode = TX1_prepare_signal( );
    %TX1_play_signal( );
    [TX1_playMode,TX2_playMode,TX3_playMode] = play_signal_multi(mdb.master.TX1_select,mdb.master.TX2_select,mdb.master.TX3_select);
    
    if (TX1_playMode &&  TX2_playMode &&  TX3_playMode)  %single shot
        set(hObject,'String','start'); %reset button
        set(hObject,'Value',0);
    end
        
    
elseif button_state == get(hObject,'Min')
    % Toggle button is not pressed, take appropriate action
    set(hObject,'String','start');
    TXall_stop_signal();
    set(hObject,'String','start'); %reset button
    set(hObject,'Value',0);
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in master_pause_toggleButton.
function master_pause_toggleButton_Callback(hObject, eventdata, handles)
% hObject    handle to master_pause_toggleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of master_pause_toggleButton


%function selcbk(source,eventdata)
%    val = get(eventdata.NewValue,'Tag') % Get Tag of selected object
  %  disp(val);
   % switch get(eventdata.NewValue,'Tag') % Get Tag of selected object
     %   case 'TX1_transducer_FF'
       %     load mdb;
         %set(mdb.TX1.FF_Speakers_panel_handle,'Visible','on');
       % case 'TX1_transducer_AC'
      %      load mdb;
            %set(mdb.TX1.AC_Source_panel_handle,'Visible','on'); 
       % case 'TX1_transducer_BC'
          %   load mdb;
           % set(mdb.TX1.BC_Source_panel_handle,'Visible','on');
   % end;

    
% --- Executes when selected object is changed in TX1_transducer_panel.
function TX1_transducer_panel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in TX1_transducer_panel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

  val = get(eventdata.NewValue,'Tag') % Get Tag of selected object
    disp(val);
    switch get(eventdata.NewValue,'Tag') % Get Tag of selected object
        case 'TX1_transducer_FF'
            load mdb;
            set(mdb.TX1.FF_Speakers_panel_handle,'Visible','on');
        case 'TX1_transducer_AC'
            load mdb;
            set(mdb.TX1.AC_Source_panel_handle,'Visible','on'); 
        case 'TX1_transducer_BC'
             load mdb;
            set(mdb.TX1.BC_Source_panel_handle,'Visible','on');
    end;


% --- Executes during object creation, after setting all properties.
function TX1_transducer_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_transducer_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    load mdb;
    for i=1:18
         mdb.TX1.transducer.FF.DacVector(i) = 0;
    end
    
    for j=1:2
        mdb.TX1.transducer.AC.outputVector(j) = 0;
    end
    
    for k=1:2
        mdb.TX1.transducer.BC.outputVector(k) = 0;
    end
    
    save mdb mdb;


    

% --- Executes during object deletion, before destroying properties.
function TX1_transducer_panel_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to TX1_transducer_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in TX1_pause_toggleButton.
function TX1_pause_toggleButton_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_pause_toggleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_pause_toggleButton


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over TX1_transducer_FF.
function TX1_transducer_FF_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to TX1_transducer_FF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load mdb;
mdb.ch1Tx.Transducer = FF;
save mdb mdb;



% --- Executes during object creation, after setting all properties.
function TX1_stimulusSpeechSelect_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusSpeechSelect_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on selection change in TX1_stimulus_SpeechPhase_popupmenu.
function TX1_stimulus_SpeechPhase_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_stimulus_SpeechPhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TX1_stimulus_SpeechPhase_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TX1_stimulus_SpeechPhase_popupmenu

% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
load mdb;

switch str{val}
    case '0 deg'
        mdb.TX1.stimulus.speech.phase = 0;
    case '180 deg'
      mdb.TX1.stimulus.speech.phase = 180;   
end

 save mdb mdb;
 


% --- Executes during object creation, after setting all properties.
function TX1_stimulus_SpeechPhase_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulus_SpeechPhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
 mdb.TX1.stimulus.speech.phase = 0;
 save mdb mdb;


% --- Executes on selection change in TX1_stimulus_NoisePhase_popupmenu.
function TX1_stimulus_NoisePhase_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_stimulus_NoisePhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TX1_stimulus_NoisePhase_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TX1_stimulus_NoisePhase_popupmenu

% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
load mdb;

switch str{val}
    case '0 deg'
        mdb.TX1.stimulus.noise.phase = 0;
    case '180 deg'
       mdb.TX1.stimulus.noise.phase = 180;   
end

 save mdb mdb;
 


% --- Executes during object creation, after setting all properties.
function TX1_stimulus_NoisePhase_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulus_NoisePhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
 mdb.TX1.stimulus.noise.phase = 0;
 save mdb mdb;



% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on selection change in TX1_stimulus_PTPhase_popupmenu.
function TX1_stimulus_PTPhase_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_stimulus_PTPhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TX1_stimulus_PTPhase_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TX1_stimulus_PTPhase_popupmenu

% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
load mdb;

switch str{val}
    case '0 deg'
        mdb.TX1.stimulus.PT.phase = 0; 
    case '90 deg'
        mdb.TX1.stimulus.PT.phase = 90;
    case '180 deg'
        mdb.TX1.stimulus.PT.phase = 180;
    case '270 deg'
        mdb.TX1.stimulus.PT.phase = 270;       
end

 save mdb mdb;
 

% --- Executes during object creation, after setting all properties.
function TX1_stimulus_PTPhase_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulus_PTPhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
mdb.TX1.stimulus.PT.phase = 0;
save mdb mdb;




function TX1_FMModIndex_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_FMModIndex_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX1_FMModIndex_editText as text
%        str2double(get(hObject,'String')) returns contents of TX1_FMModIndex_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
mdb.TX1.stimulus.PT.modIndex = user_entry;
save mdb mdb;










% --------------------------------------------------------------------
function vvvvvv_1_Callback(hObject, eventdata, handles)
% hObject    handle to vvvvvv_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function askldjlsdkjf_Callback(hObject, eventdata, handles)
% hObject    handle to askldjlsdkjf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over TX1_transducer_BC.
function TX1_transducer_BC_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to TX1_transducer_BC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over TX1_transducer_AC.
function TX1_transducer_AC_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to TX1_transducer_AC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over TX1_stimulusSelectPT_checkBox.
function TX1_stimulusSelectPT_checkBox_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusSelectPT_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function TX1_transducer_panel_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to TX1_transducer_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
display "XXX";




% --- Executes during object creation, after setting all properties.
function TX1_FF_speaker_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_FF_speaker_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    h=hObject;
    load mdb;
    mdb.TX1.FF_Speakers_panel_handle=h;
    save mdb mdb;
    
    set(h,'Visible','off');


% --- Executes on button press in TX1_BC_rightEar_checkBox.
function TX1_BC_rightEar_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_BC_rightEar_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_BC_rightEar_checkBox


% --- Executes on button press in TX1_BC_leftEar_checkBox.
function TX1_BC_leftEar_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_BC_leftEar_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_BC_leftEar_checkBox


% --- Executes on button press in TX1_BC_dualEar_checkBox.
function TX1_BC_dualEar_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_BC_dualEar_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_BC_dualEar_checkBox


% --- Executes on button press in TX1_AC_rightEar_checkBox.
function TX1_AC_rightEar_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_AC_rightEar_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_AC_rightEar_checkBox


% --- Executes on button press in TX1_AC_leftEar_checkBox.
function TX1_AC_leftEar_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_AC_leftEar_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_AC_leftEar_checkBox


% --- Executes on button press in TX1_AC_dualEar_checkBox.
function TX1_AC_dualEar_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_AC_dualEar_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_AC_dualEar_checkBox




% --- Executes during object creation, after setting all properties.
function TX1_AC_Source_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_AC_Source_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    h=hObject;
    load mdb;
    mdb.TX1.AC_Source_panel_handle=h;
    save mdb mdb;
    
    set(h,'Visible','off');


% --- Executes on button press in TX1_BC_Source_Set_pushbutton.
function TX1_BC_Source_Set_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_BC_Source_Set_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     load mdb 
    
    % --- Executes on button press in TX1_BC_closePanel_pushButton.
function TX1_BC_closePanel_pushButton_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_BC_closePanel_pushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 load mdb 
 set(mdb.TX1.BC_Source_panel_handle,'Visible','off');
 

% --- Executes on button press in TX1_AC_Source_Set_pushbutton.
function TX1_AC_Source_Set_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_AC_Source_Set_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     load mdb 
    
    
% --- Executes on button press in TX1_AC_closePanel_pushButton.
function TX1_AC_closePanel_pushButton_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_AC_closePanel_pushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 load mdb 
 set(mdb.TX1.AC_Source_panel_handle,'Visible','off');
    


% --- Executes during object creation, after setting all properties.
function TX1_BC_Source_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_BC_Source_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    h=hObject;
    load mdb;
    mdb.TX1.BC_Source_panel_handle=h;
    save mdb mdb;
    
    set(h,'Visible','off');


% ************* CREATE FUNCTIONS *******

% --- Executes during object creation, after setting all properties.
function TX1_selectedTransducer_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_selectedTransducer_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    handle=hObject;    
    set(hObject,'String','no selection');
    load mdb;
    mdb.TX1.SelectedTranducer_staticText_handle=handle;
    save mdb mdb;
    
    
       
    % --- Executes during object creation, after setting all properties.
function TX1_stimulusSelectPT_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusSelectPT_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    load mdb;
    mdb.TX1.stimulus.stimulusSelect.pureTone = 0;
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX1_stimulusSelectSpeech_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusSelectSpeech_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    load mdb;
    mdb.TX1.stimulus.stimulusSelect.speech = 0;
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX1_stimulusSelectNoise_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusSelectNoise_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    load mdb;
    mdb.TX1.stimulus.stimulusSelect.noise = 0;
    save mdb mdb;
    
    
 % --- Executes during object creation, after setting all properties.
function TX1_PTFreqSelect_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_PTFreqSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

load mdb;
mdb.TX1.stimulus.PT.PTFreqSelectSlider_handle = hObject;
 mdb.TX1.stimulus.PT.freq = get(hObject,'Value');
 save mdb mdb;
 
 

% --- Executes during object creation, after setting all properties.
function TX1_PTFreqValue_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_PTFreqValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
mdb.TX1.stimulus.PT.freqEditText_handle = hObject;
save mdb mdb;

% --- Executes during object creation, after setting all properties.
function TX1_PTAmpSelect_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_PTAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

load mdb;
mdb.TX1.stimulus.PT.PTAmpSelectSlider_handle = hObject;
 mdb.TX1.stimulus.PT.amp = get(hObject,'Value');
 save mdb mdb;
 

% --- Executes during object creation, after setting all properties.
function TX1_PTAmpValue_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_PTAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
mdb.TX1.stimulus.PT.ampEditText_handle = hObject;
save mdb mdb;

% --- Executes during object creation, after setting all properties.
function TX1_stimulusModulationFM_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusModulationFM_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load mdb;
 mdb.TX1.stimulus.PT.modulationType = 3;  %no modulation
 save mdb mdb;
 
 % --- Executes during object creation, after setting all properties.
function TX1_FMModIndex_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_FMModIndex_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX1.stimulus.PT.modIndex = init_entry;
save mdb mdb;

% --- Executes during object creation, after setting all properties.
function TX1_AMModDepth_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_AMModDepth_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX1.stimulus.PT.modDepth = init_entry;
save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX1_ModFreq_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_ModFreq_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX1.stimulus.PT.modFreq = init_entry;
save mdb mdb;



% --- Executes during object creation, after setting all properties.
function TX1_stimulusSpeechSourceSelect_pushButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusSpeechSourceSelect_pushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 load mdb;
 mdb.TX1.stimulus.speech.sourceSelectPushButton_handle = hObject;
 save mdb mdb;

    
    % --- Executes during object creation, after setting all properties.
function TX1_speechAmpValue_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_speechAmpValue_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load mdb;
mdb.TX1.stimulus.speech.ampStaticText_handle = hObject;
save mdb mdb;

% --- Executes during object creation, after setting all properties.
function TX1_speechAmpSelect_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_speechAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

load mdb;
mdb.TX1.stimulus.speech.ampSelectSlider_handle = hObject;
 mdb.TX1.stimulus.speech.amp = get(hObject,'Value');
 save mdb mdb;
 
 
 
 % --- Executes during object creation, after setting all properties.
function TX1_burstDuration_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_burstDuration_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX1.stimulus.burstDuration = init_entry;
save mdb mdb;

 
% --- Executes during object creation, after setting all properties.
function TX1_stimulusNoiseSourceSelect_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusNoiseSourceSelect_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Determine the selected data set.
str = get(hObject, 'String');
% Set initial data to the first data set.
load mdb;
switch str{1}
    case 'white noise'
       mdb.TX1.stimulus.noise.source = 1; %1=white noise
    case 'NB noise'
       mdb.TX1.stimulus.noise.source = 2;  %2=NB noise
    case 'from file'
       mdb.TX1.stimulus.noise.source = 3;  %3=from file 
    case 'reveresed speech'
       mdb.TX1.stimulus.noise.source = 4; %4=reveresed speech 
end

mdb.TX1.stimulus.noise.fileName = 0;

save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX1_stimulusNoiseSourceFileName_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusNoiseSourceFileName_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load mdb;
mdb.TX1.stimulus.noise.sourceFileName_staticText_handle = hObject;
save mdb mdb;
set(hObject,'Visible','off');

% --- Executes during object creation, after setting all properties.
function TX1_noiseAmpSelect_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_noiseAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

load mdb;
mdb.TX1.stimulus.noise.ampSelectSlider_handle = hObject;
 mdb.TX1.stimulus.noise.amp = get(hObject,'Value');
 save mdb mdb;
 

% --- Executes during object creation, after setting all properties.
function TX1_noiseAmpValue_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_noiseAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
mdb.TX1.stimulus.noise.ampEditText_handle = hObject;
save mdb mdb;

% --- Executes during object creation, after setting all properties.
function TX1_noiseSnrPT_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_noiseSnrPT_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load mdb;
mdb.TX1.stimulus.noise.snrPT_staticText_handle = hObject;
save mdb mdb;

% --- Executes during object creation, after setting all properties.
function TX1_noiseSnrSpeech_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_noiseSnrSpeech_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load mdb;
mdb.TX1.stimulus.noise.snrSpeech_staticText_handle = hObject;
save mdb mdb;

% --- Executes during object creation, after setting all properties.
function TX1_speechAmpValue_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_speechAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
mdb.TX1.stimulus.speech.ampEditText_handle = hObject;
save mdb mdb;

% --- Executes during object creation, after setting all properties.
function TX1_stimulus_noiseFilter_pannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulus_noiseFilter_pannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load mdb;
mdb.TX1.stimulus.noise.filterPannel_handle = hObject;
save mdb mdb;

set(hObject,'Visible','off');

% --- Executes during object creation, after setting all properties.
function TX1_stimulus_noiseFilterCntrFrq_edtiText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulus_noiseFilterCntrFrq_edtiText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX1.stimulus.noise.NBCntrFrq = init_entry;
save mdb mdb;

% --- Executes during object creation, after setting all properties.
function TX1_stimulus_noiseFilterBW_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulus_noiseFilterBW_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX1.stimulus.noise.NBBW = init_entry;
save mdb mdb;



    % ************************* CALLBACKS *************

        
% --- Executes on button press in TX1_FF_DacA.
function TX1_FF_DacA_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_FF_DacA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_FF_DacA
    load mdb;
    mdb.TX1.transducer.FF.DacVector(1)=get(hObject,'Value');
    save mdb mdb;


% --- Executes on button press in TX1_FF_DacB.
function TX1_FF_DacB_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_FF_DacB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_FF_DacB
    load mdb;
    mdb.TX1.transducer.FF.DacVector(2)=get(hObject,'Value');
    save mdb mdb;


% --- Executes on button press in TX1_FF_DacC.
function TX1_FF_DacC_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_FF_DacC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_FF_DacC
    load mdb;
   mdb.TX1.transducer.FF.DacVector(3)=get(hObject,'Value');
    save mdb mdb;
    
    
% --- Executes on button press in TX1_FF_DacD.
function TX1_FF_DacD_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_FF_DacD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_FF_DacD
    load mdb;
   mdb.TX1.transducer.FF.DacVector(4)=get(hObject,'Value');
    save mdb mdb;


% --- Executes on button press in TX1_FF_DacE.
function TX1_FF_DacE_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_FF_DacE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_FF_DacE
    load mdb;
    mdb.TX1.transducer.FF.DacVector(5)=get(hObject,'Value');
    save mdb mdb;

% --- Executes on button press in TX1_FF_DacF.
function TX1_FF_DacF_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_FF_DacF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_FF_DacF
    load mdb;
   mdb.TX1.transducer.FF.DacVector(6)=get(hObject,'Value');
    save mdb mdb;


% --- Executes on button press in TX1_FF_DacG.
function TX1_FF_DacG_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_FF_DacG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_FF_DacG
    load mdb;
    mdb.TX1.transducer.FF.DacVector(7)=get(hObject,'Value');
    save mdb mdb;


% --- Executes on button press in TX1_FF_DacH.
function TX1_FF_DacH_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_FF_DacH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_FF_DacH
    load mdb;
    mdb.TX1.transducer.FF.DacVector(8)=get(hObject,'Value');
    save mdb mdb;
    
    
    % --- Executes on button press in TX1_FF_Speakers_Set_pushbutton.
function TX1_FF_Speakers_Set_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_FF_Speakers_Set_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    load mdb;
     
    % find-out what DAC's to use - disply as text on the GUI
    j=1;
    dac_array=['A__';'B__';'C__';'D__';'E__';'F__';'G__';'H__'];
 
    for i=1:1:8
        if (mdb.TX1.transducer.FF.DacVector(i) == 1)
            gui_staticText(j) = dac_array(i);
            j=j+1;
        end
    end
    set(mdb.TX1.SelectedTranducer_staticText_handle,'String',gui_staticText');
    
   % set(mdb.TX1.FF_Speakers_panel_handle,'Visible','off');
    
    % --- Executes on button press in TX1_FF_closePanel_pushButton.
function TX1_FF_closePanel_pushButton_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_FF_closePanel_pushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    load mdb;
    set(mdb.TX1.FF_Speakers_panel_handle,'Visible','off');

    
    
    % --- Executes on button press in TX1_stimulusSelectPT_checkBox.
function TX1_stimulusSelectPT_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusSelectPT_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of
% TX1_stimulusSelectPT_checkBox
    load mdb;
    mdb.TX1.stimulus.stimulusSelect.pureTone = get(hObject,'Value');
    save mdb mdb ;
    
      %update the SNR
 if (  mdb.TX1.stimulus.stimulusSelect.pureTone )   % only if noise stimulus is checked
     if ( mdb.TX1.stimulus.stimulusSelect.noise )
         snr =  mdb.TX1.stimulus.PT.amp -  mdb.TX1.stimulus.noise.amp;
         set(mdb.TX1.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
 else
        set(mdb.TX1.stimulus.noise.snrPT_staticText_handle,'String','null');
 end

% --- Executes on button press in TX1_stimulusSelectSpeech_checkBox.
function TX1_stimulusSelectSpeech_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusSelectSpeech_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of
    load mdb;
    mdb.TX1.stimulus.stimulusSelect.speech = get(hObject,'Value');
    save mdb mdb;
    
      %update the SNR
 if (  mdb.TX1.stimulus.stimulusSelect.speech )   % only if noise stimulus is checked
     if ( mdb.TX1.stimulus.stimulusSelect.noise )
         snr =  mdb.TX1.stimulus.speech.amp -  mdb.TX1.stimulus.noise.amp;
         set(mdb.TX1.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 else
        set(mdb.TX1.stimulus.noise.snrSpeech_staticText_handle,'String','null');
 end


% --- Executes on button press in TX1_stimulusSelectNoise_checkBox.
function TX1_stimulusSelectNoise_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusSelectNoise_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   
% Hint: get(hObject,'Value') returns toggle state of    
    load mdb;
    mdb.TX1.stimulus.stimulusSelect.noise = get(hObject,'Value');
    save mdb mdb;
    
    %update the SNR
 if (  mdb.TX1.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX1.stimulus.stimulusSelect.pureTone )
         snr =  mdb.TX1.stimulus.PT.amp -  mdb.TX1.stimulus.noise.amp;
         set(mdb.TX1.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
     if ( mdb.TX1.stimulus.stimulusSelect.speech )
         snr =  mdb.TX1.stimulus.speech.amp -  mdb.TX1.stimulus.noise.amp;
         set(mdb.TX1.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 else
        set(mdb.TX1.stimulus.noise.snrPT_staticText_handle,'String','null');
        set(mdb.TX1.stimulus.noise.snrSpeech_staticText_handle,'String','null');
 end
    
    
    % --- Executes on slider movement.
function TX1_PTFreqSelect_slider_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_PTFreqSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load mdb;
 mdb.TX1.stimulus.PT.freq = get(hObject,'Value');
 save mdb mdb;
 
 %write the slider value to the ststic text
 set(mdb.TX1.stimulus.PT.freqEditText_handle,'String',get(hObject,'Value') );
 
 % --- Executes on slider movement.
function TX1_PTAmpSelect_slider_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_PTAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load mdb;
 mdb.TX1.stimulus.PT.amp = get(hObject,'Value');
 save mdb mdb;
 
 %write the slider value to the ststic text
 set(mdb.TX1.stimulus.PT.ampEditText_handle,'String',get(hObject,'Value') );
 
  %update the SNR
 if (  mdb.TX1.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX1.stimulus.stimulusSelect.pureTone )
         snr =  mdb.TX1.stimulus.PT.amp -  mdb.TX1.stimulus.noise.amp;
         set(mdb.TX1.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
 end
 
 
 % --- Executes on button press in TX1_stimulusModulationFM_checkBox.
function TX1_stimulusModulationFM_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusModulationFM_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_stimulusModulationFM_checkBox
load mdb;
if (get(hObject,'Value'))
    if (  mdb.TX1.stimulus.PT.modulationType == 3 )  %no modulation
        mdb.TX1.stimulus.PT.modulationType = 1; %FM
    else  %AM is required too
        mdb.TX1.stimulus.PT.modulationType = 2; %AM and FM
    end
else
    if (  mdb.TX1.stimulus.PT.modulationType == 2 ) %AM and FM
         mdb.TX1.stimulus.PT.modulationType = 0;    %AM
    else
        mdb.TX1.stimulus.PT.modulationType = 3;  %no modulation
    end
end

save mdb mdb;

% --- Executes on button press in TX1_stimulusModulationAM_checkBox.
function TX1_stimulusModulationAM_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusModulationAM_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of
% TX1_stimulusModulationAM_checkBox
load mdb;
if (get(hObject,'Value'))
    if (  mdb.TX1.stimulus.PT.modulationType == 3 )  %no modulation
        mdb.TX1.stimulus.PT.modulationType = 0; %AM
    else  %FM is required too
        mdb.TX1.stimulus.PT.modulationType = 2; %AM and FM
    end
else
    if (  mdb.TX1.stimulus.PT.modulationType == 2 ) %AM and FM
         mdb.TX1.stimulus.PT.modulationType = 1;    %FM
    else
        mdb.TX1.stimulus.PT.modulationType = 3;  %no modulation
    end
end

save mdb mdb;


function TX1_AMModDepth_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_AMModDepth_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX1_AMModDepth_editText as text
%        str2double(get(hObject,'String')) returns contents of TX1_AMModDepth_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
mdb.TX1.stimulus.PT.modDepth = user_entry;
save mdb mdb;

function TX1_ModFreq_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_ModFreq_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX1_ModFreq_editText as text
%        str2double(get(hObject,'String')) returns contents of TX1_ModFreq_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
 mdb.TX1.stimulus.PT.modFreq = user_entry;
 save mdb mdb;
 
 
 

% --- Executes on button press in TX1_stimulusSpeechSourceSelect_pushButton.
function TX1_stimulusSpeechSourceSelect_pushButton_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusSpeechSourceSelect_pushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
      [FileName,PathName,FilterIndex] = uigetfile('D:\Users\students\*.wav');
      fullfilename = sprintf('%s%s',PathName,FileName);
      disp(fullfilename);
      
      load mdb;
       mdb.TX1.stimulus.speech.source = fullfilename;
      set( mdb.TX1.stimulus.speech.sourceSelectPushButton_handle,'String',FileName);
      save mdb mdb;
      
function TX1_burstDuration_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_burstDuration_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX1_burstDuration_editText as text
%        str2double(get(hObject,'String')) returns contents of TX1_burstDuration_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
 mdb.TX1.stimulus.burstDuration = user_entry;
 save mdb mdb;
 
 % --- Executes on slider movement.
function TX1_speechAmpSelect_slider_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_speechAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load mdb;
 mdb.TX1.stimulus.speech.amp =  get(hObject,'Value');
 save mdb mdb;
 
 %write the slider value to the ststic text
 set(mdb.TX1.stimulus.speech.ampEditText_handle,'String',get(hObject,'Value') );
 
  %update the SNR
 if (  mdb.TX1.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX1.stimulus.stimulusSelect.speech )
         snr =  mdb.TX1.stimulus.speech.amp -  mdb.TX1.stimulus.noise.amp;
         set(mdb.TX1.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 end
 
 
 % --- Executes on button press in TX1_start_toggleButton.
function TX1_start_toggleButton_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_start_toggleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX1_start_toggleButton
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    % Toggle button is pressed, take appropriate action
    set(hObject,'String','stop');
   % play_signal();  %play the required stimulus
   % playMode = TX1_prepare_signal( );
    %TX1_play_signal( );
    [TX1_playMode,TX2_playMode,TX3_playMode] = play_signal_multi(1,0,0);
    
    if (TX1_playMode == 1) %single shot
        set(hObject,'String','start'); %reset button
        set(hObject,'Value',0);
    end
        
    
elseif button_state == get(hObject,'Min')
    % Toggle button is not pressed, take appropriate action
    set(hObject,'String','start');
    TX1_stop_signal();
    set(hObject,'String','start'); %reset button
    set(hObject,'Value',0);
end



function TX1_PTFreqValue_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_PTFreqValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX1_PTFreqValue_editText as text
%        str2double(get(hObject,'String')) returns contents of TX1_PTFreqValue_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
%check if entered value is in frequency range
sliderMax = get(mdb.TX1.stimulus.PT.PTFreqSelectSlider_handle,'Max');
sliderMin = get(mdb.TX1.stimulus.PT.PTFreqSelectSlider_handle,'Min');
if (   (user_entry > sliderMax) || (user_entry <  sliderMin)  )
    set(hObject,'String',sliderMin);
    set(mdb.TX1.stimulus.PT.PTFreqSelectSlider_handle,'Value',sliderMin);
    mdb.TX1.stimulus.PT.freq = sliderMin;
    save mdb mdb;
    return
end

%update the slider and mdb with the new entry
set(mdb.TX1.stimulus.PT.PTFreqSelectSlider_handle,'Value',user_entry);
mdb.TX1.stimulus.PT.freq = user_entry;
save mdb mdb;




function TX1_PTAmpValue_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_PTAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX1_PTAmpValue_editText as text
%        str2double(get(hObject,'String')) returns contents of TX1_PTAmpValue_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
%check if entered value is in frequency range
sliderMax = get(mdb.TX1.stimulus.PT.PTAmpSelectSlider_handle,'Max');
sliderMin = get(mdb.TX1.stimulus.PT.PTAmpSelectSlider_handle,'Min');
if (   (user_entry > sliderMax) || (user_entry <  sliderMin)  )
    set(hObject,'String',sliderMin);
    set(mdb.TX1.stimulus.PT.PTAmpSelectSlider_handle,'Value',sliderMin);
    mdb.TX1.stimulus.PT.amp = sliderMin;
    save mdb mdb;
    return
end


%update the slider with the new entry
set(mdb.TX1.stimulus.PT.PTAmpSelectSlider_handle,'Value',user_entry);
 mdb.TX1.stimulus.PT.amp = user_entry;
 
  %update the SNR
 if (  mdb.TX1.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX1.stimulus.stimulusSelect.pureTone )
         snr =  mdb.TX1.stimulus.PT.amp -  mdb.TX1.stimulus.noise.amp;
         set(mdb.TX1.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
 end
 
save mdb mdb;


% --- Executes on selection change in TX1_stimulusNoiseSourceSelect_popupmenu.
function TX1_stimulusNoiseSourceSelect_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusNoiseSourceSelect_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TX1_stimulusNoiseSourceSelect_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TX1_stimulusNoiseSourceSelect_popupmenu


% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
load mdb;
set(mdb.TX1.stimulus.noise.sourceFileName_staticText_handle,'Visible','off'); %reset the source file name
set(mdb.TX1.stimulus.noise.filterPannel_handle,'Visible','off');

switch str{val}
    case 'black noise'
        mdb.TX1.stimulus.noise.source = 1; %1=white noise'
    case 'NB noise'
        set(mdb.TX1.stimulus.noise.filterPannel_handle,'Visible','on');
         mdb.TX1.stimulus.noise.source = 2;  %2=NB noise
    case 'from file'
         [FileName,PathName,FilterIndex] = uigetfile('D:\Users\students\*.wav');
         fullfilename = sprintf('%s%s',PathName,FileName);
         disp(fullfilename);
         mdb.TX1.stimulus.noise.source = 3;  %3=from file
          mdb.TX1.stimulus.noise.fileName = fullfilename;
        set(mdb.TX1.stimulus.noise.sourceFileName_staticText_handle,'String',FileName);  
        set(mdb.TX1.stimulus.noise.sourceFileName_staticText_handle,'Visible','on');        
end

 save mdb mdb;
 

      
      


% --- Executes on slider movement.
function TX1_noiseAmpSelect_slider_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_noiseAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

load mdb;
 mdb.TX1.stimulus.noise.amp = get(hObject,'Value');
 
 %write the slider value to the edit text
 set(mdb.TX1.stimulus.noise.ampEditText_handle,'String',get(hObject,'Value') );
 
 %update the SNR
 if (  mdb.TX1.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked  
     if ( mdb.TX1.stimulus.stimulusSelect.pureTone )
         snr =  mdb.TX1.stimulus.PT.amp -  mdb.TX1.stimulus.noise.amp;
         set(mdb.TX1.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
     if ( mdb.TX1.stimulus.stimulusSelect.speech )
         snr =  mdb.TX1.stimulus.speech.amp -  mdb.TX1.stimulus.noise.amp;
         set(mdb.TX1.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 end
 
  save mdb mdb;





function TX1_noiseAmpValue_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_noiseAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX1_noiseAmpValue_editText as text
%        str2double(get(hObject,'String')) returns contents of TX1_noiseAmpValue_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
%check if entered value is in amplitude range
sliderMax = get(mdb.TX1.stimulus.noise.ampSelectSlider_handle,'Max');
sliderMin = get(mdb.TX1.stimulus.noise.ampSelectSlider_handle,'Min');
if (   (user_entry > sliderMax) || (user_entry <  sliderMin)  )
    set(hObject,'String',sliderMin);
    set(mdb.TX1.stimulus.noise.ampSelectSlider_handle,'Value',sliderMin);
    mdb.TX1.stimulus.noise.amp = sliderMin;
    save mdb mdb;
    return
end


%update the slider with the new entry
set(mdb.TX1.stimulus.noise.ampSelectSlider_handle,'Value',user_entry);
 mdb.TX1.stimulus.noise.amp = user_entry;
 
 %update the SNR
 if (  mdb.TX1.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX1.stimulus.stimulusSelect.pureTone )
         snr =  mdb.TX1.stimulus.PT.amp -  mdb.TX1.stimulus.noise.amp;
         set(mdb.TX1.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
     if ( mdb.TX1.stimulus.stimulusSelect.speech )
         snr =  mdb.TX1.stimulus.speech.amp -  mdb.TX1.stimulus.noise.amp;
         set(mdb.TX1.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 end
 
save mdb mdb;



function TX1_speechAmpValue_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_speechAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX1_speechAmpValue_editText as text
%        str2double(get(hObject,'String')) returns contents of TX1_speechAmpValue_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
%check if entered value is in frequency range
sliderMax = get(mdb.TX1.stimulus.speech.ampSelectSlider_handle,'Max');
sliderMin = get(mdb.TX1.stimulus.speech.ampSelectSlider_handle,'Min');
if (   (user_entry > sliderMax) || (user_entry <  sliderMin)  )
    set(hObject,'String',sliderMin);
    set(mdb.TX1.stimulus.speech.ampSelectSlider_handle,'Value',sliderMin);
    mdb.TX1.stimulus.speech.amp = sliderMin;
    save mdb mdb;
    return
end


%update the slider with the new entry
set(mdb.TX1.stimulus.speech.ampSelectSlider_handle,'Value',user_entry);
 mdb.TX1.stimulus.speech.amp = user_entry;
 
  %update the SNR
 if (  mdb.TX1.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX1.stimulus.stimulusSelect.speech )
         snr =  mdb.TX1.stimulus.speech.amp -  mdb.TX1.stimulus.noise.amp;
         set(mdb.TX1.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 end
 
save mdb mdb;



function TX1_stimulus_noiseFilterBW_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_stimulus_noiseFilterBW_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX1_stimulus_noiseFilterBW_editText as text
%        str2double(get(hObject,'String')) returns contents of TX1_stimulus_noiseFilterBW_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
    errordlg('You must enter a numeric value','Bad Input','modal')
    uicontrol(hObject)
    return
end

load mdb;
%check if entered value is in frequency range
maxValue = 200;
minValue = 5;
if (   (user_entry > maxValue) || (user_entry <  minValue)  )
    set(hObject,'String',minValue);
    mdb.TX1.stimulus.noise.NBBW = minValue;
    save mdb mdb;
    return
end
 
mdb.TX1.stimulus.noise.NBBW = user_entry;
 save mdb mdb;


function TX1_stimulus_noiseFilterCntrFrq_edtiText_Callback(hObject, eventdata, handles)
% hObject    handle to TX1_stimulus_noiseFilterCntrFrq_edtiText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX1_stimulus_noiseFilterCntrFrq_edtiText as text
%        str2double(get(hObject,'String')) returns contents of TX1_stimulus_noiseFilterCntrFrq_edtiText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
    errordlg('You must enter a numeric value','Bad Input','modal')
    uicontrol(hObject)
    return
end

load mdb;
%check if entered value is in frequency range
maxValue = get(mdb.TX1.stimulus.PT.PTFreqSelectSlider_handle,'Max');
minValue = get(mdb.TX1.stimulus.PT.PTFreqSelectSlider_handle,'Min');
if (   (user_entry > maxValue) || (user_entry <  minValue)  )
    set(hObject,'String',minValue);
    mdb.TX1.stimulus.noise.NBCntrFrq = minValue;
    save mdb mdb;
    return
end

 mdb.TX1.stimulus.noise.NBCntrFrq = user_entry;
 save mdb mdb;


% --- Executes on button press in master_TX3_checkBox.
function master_TX3_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to master_TX3_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of master_TX3_checkBox

    load mdb;
    mdb.master.TX3_select = get(hObject,'Value');
    save mdb mdb ;


% --- Executes on button press in master_TX2_checkBox.
function master_TX2_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to master_TX2_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of master_TX2_checkBox

    load mdb;
    mdb.master.TX2_select = get(hObject,'Value');
    save mdb mdb ;


% --- Executes on button press in master_TX1_checkBox.
function master_TX1_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to master_TX1_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of master_TX1_checkBox

    load mdb;
    mdb.master.TX1_select = get(hObject,'Value');
    save mdb mdb ;



% *****************************88
%****************************8
%**************************************************************
% NEW CHANNEL !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% ************************************


% --- Executes on button press in TX3_pause_toggleButton.
function TX3_pause_toggleButton_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_pause_toggleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX3_pause_toggleButton


% --- Executes on button press in TX2_pause_toggleButton.
function TX2_pause_toggleButton_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_pause_toggleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX2_pause_toggleButton


% --- Executes on button press in TX2_start_toggleButton.
function TX2_start_toggleButton_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_start_toggleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX2_start_toggleButton

button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    % Toggle button is pressed, take appropriate action
    set(hObject,'String','stop');
   % play_signal();  %play the required stimulus
    [TX1_playMode,TX2_playMode,TX3_playMode] = play_signal_multi(0,1,0);
    
    if (TX2_playMode == 1) %single shot
        set(hObject,'String','start'); %reset button
        set(hObject,'Value',0);
    end
        
    
elseif button_state == get(hObject,'Min')
    % Toggle button is not pressed, take appropriate action
    set(hObject,'String','start');
    TX2_stop_signal();
    set(hObject,'String','start'); %reset button
    set(hObject,'Value',0);
end




function TX2_burstDuration_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_burstDuration_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX2_burstDuration_editText as text
%        str2double(get(hObject,'String')) returns contents of TX2_burstDuration_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
 mdb.TX2.stimulus.burstDuration = user_entry;
 save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX2_burstDuration_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_burstDuration_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX2.stimulus.burstDuration = init_entry;
save mdb mdb;



% --- Executes on button press in TX3_start_toggleButton.
function TX3_start_toggleButton_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_start_toggleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX3_start_toggleButton

button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    % Toggle button is pressed, take appropriate action
    set(hObject,'String','stop');
   % play_signal();  %play the required stimulus
    [TX1_playMode,TX2_playMode,TX3_playMode] = play_signal_multi(0,0,1);
    
    if (TX3_playMode == 1) %single shot
        set(hObject,'String','start'); %reset button
        set(hObject,'Value',0);
    end
        
    
elseif button_state == get(hObject,'Min')
    % Toggle button is not pressed, take appropriate action
    set(hObject,'String','start');
    TX3_stop_signal();
    set(hObject,'String','start'); %reset button
    set(hObject,'Value',0);
end



function TX3_burstDuration_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_burstDuration_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX3_burstDuration_editText as text
%        str2double(get(hObject,'String')) returns contents of TX3_burstDuration_editText as a double
user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
 mdb.TX3.stimulus.burstDuration = user_entry;
 save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_burstDuration_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_burstDuration_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX3.stimulus.burstDuration = init_entry;
save mdb mdb;


% --- Executes on button press in TX3_stimulusSelectNoise_checkBox.
function TX3_stimulusSelectNoise_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_stimulusSelectNoise_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX3_stimulusSelectNoise_checkBox

    load mdb;
    mdb.TX3.stimulus.stimulusSelect.noise = get(hObject,'Value');
    save mdb mdb;
    
    %update the SNR
 if (  mdb.TX3.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX3.stimulus.stimulusSelect.pureTone )
         snr =  mdb.TX3.stimulus.PT.amp -  mdb.TX3.stimulus.noise.amp;
         set(mdb.TX3.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
     if ( mdb.TX3.stimulus.stimulusSelect.speech )
         snr =  mdb.TX3.stimulus.speech.amp -  mdb.TX3.stimulus.noise.amp;
         set(mdb.TX3.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 else
        set(mdb.TX3.stimulus.noise.snrPT_staticText_handle,'String','null');
        set(mdb.TX3.stimulus.noise.snrSpeech_staticText_handle,'String','null');
 end
    
    


% --- Executes on slider movement.
function TX3_noiseAmpSelect_slider_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_noiseAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

load mdb;
 mdb.TX3.stimulus.noise.amp = get(hObject,'Value');
 
 %write the slider value to the edit text
 set(mdb.TX3.stimulus.noise.ampEditText_handle,'String',get(hObject,'Value') );
 
 %update the SNR
 if (  mdb.TX3.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked  
     if ( mdb.TX3.stimulus.stimulusSelect.pureTone )
         snr =  mdb.TX3.stimulus.PT.amp -  mdb.TX3.stimulus.noise.amp;
         set(mdb.TX3.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
     if ( mdb.TX3.stimulus.stimulusSelect.speech )
         snr =  mdb.TX3.stimulus.speech.amp -  mdb.TX3.stimulus.noise.amp;
         set(mdb.TX3.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 end
 
  save mdb mdb;





% --- Executes during object creation, after setting all properties.
function TX3_noiseAmpSelect_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_noiseAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

load mdb;
mdb.TX3.stimulus.noise.ampSelectSlider_handle = hObject;
 mdb.TX3.stimulus.noise.amp = get(hObject,'Value');
 save mdb mdb;



function TX3_noiseAmpValue_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_noiseAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX3_noiseAmpValue_editText as text
%        str2double(get(hObject,'String')) returns contents of TX3_noiseAmpValue_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
%check if entered value is in amplitude range
sliderMax = get(mdb.TX3.stimulus.noise.ampSelectSlider_handle,'Max');
sliderMin = get(mdb.TX3.stimulus.noise.ampSelectSlider_handle,'Min');
if (   (user_entry > sliderMax) || (user_entry <  sliderMin)  )
    set(hObject,'String',sliderMin);
    set(mdb.TX3.stimulus.noise.ampSelectSlider_handle,'Value',sliderMin);
    mdb.TX3.stimulus.noise.amp = sliderMin;
    save mdb mdb;
    return
end


%update the slider with the new entry
set(mdb.TX3.stimulus.noise.ampSelectSlider_handle,'Value',user_entry);
 mdb.TX3.stimulus.noise.amp = user_entry;
 
 %update the SNR
 if (  mdb.TX3.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX3.stimulus.stimulusSelect.pureTone )
         snr =  mdb.TX3.stimulus.PT.amp -  mdb.TX3.stimulus.noise.amp;
         set(mdb.TX3.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
     if ( mdb.TX3.stimulus.stimulusSelect.speech )
         snr =  mdb.TX3.stimulus.speech.amp -  mdb.TX3.stimulus.noise.amp;
         set(mdb.TX3.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 end
 
save mdb mdb;




% --- Executes during object creation, after setting all properties.
function TX3_noiseAmpValue_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_noiseAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
mdb.TX3.stimulus.noise.ampEditText_handle = hObject;
save mdb mdb;

% --- Executes on selection change in TX3_stimulusNoiseSourceSelect_popupmenu.
function TX3_stimulusNoiseSourceSelect_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_stimulusNoiseSourceSelect_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TX3_stimulusNoiseSourceSelect_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TX3_stimulusNoiseSourceSelect_popupmenu

% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
load mdb;
set(mdb.TX3.stimulus.noise.sourceFileName_staticText_handle,'Visible','off'); %reset the source file name
set(mdb.TX3.stimulus.noise.filterPannel_handle,'Visible','off');

switch str{val}
    case 'white noise'
        mdb.TX3.stimulus.noise.source = 1; %1=white noise'
    case 'NB noise'
        set(mdb.TX3.stimulus.noise.filterPannel_handle,'Visible','on');
         mdb.TX3.stimulus.noise.source = 2;  %2=NB noise
    case 'from file'
         [FileName,PathName,FilterIndex] = uigetfile('D:\Users\students\*.wav');
         fullfilename = sprintf('%s%s',PathName,FileName);
         disp(fullfilename);
         mdb.TX3.stimulus.noise.source = 3;  %3=from file
          mdb.TX3.stimulus.noise.fileName = fullfilename;
        set(mdb.TX3.stimulus.noise.sourceFileName_staticText_handle,'String',FileName);  
        set(mdb.TX3.stimulus.noise.sourceFileName_staticText_handle,'Visible','on');        
end

 save mdb mdb;
 



% --- Executes during object creation, after setting all properties.
function TX3_stimulusNoiseSourceSelect_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_stimulusNoiseSourceSelect_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Determine the selected data set.
str = get(hObject, 'String');
% Set initial data to the first data set.
load mdb;
switch str{1}
    case 'white noise'
       mdb.TX3.stimulus.noise.source = 1; %1=white noise
    case 'NB noise'
       mdb.TX3.stimulus.noise.source = 2;  %2=NB noise
    case 'from file'
       mdb.TX3.stimulus.noise.source = 3;  %3=from file 
    case 'reveresed speech'
       mdb.TX3.stimulus.noise.source = 4; %4=reveresed speech 
end

mdb.TX3.stimulus.noise.fileName = 0;

save mdb mdb;



% --- Executes on selection change in TX3_stimulus_NoisePhase_popupmenu.
function TX3_stimulus_NoisePhase_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_stimulus_NoisePhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TX3_stimulus_NoisePhase_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TX3_stimulus_NoisePhase_popupmenu

str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
load mdb;

switch str{val}
    case '0 deg'
        mdb.TX3.stimulus.noise.phase = 0;
    case '180 deg'
       mdb.TX3.stimulus.noise.phase = 180;   
end

 save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_stimulus_NoisePhase_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_stimulus_NoisePhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
 mdb.TX3.stimulus.noise.phase = 0;
 save mdb mdb;


% --- Executes on button press in TX3_stimulusSelectPT_checkBox.
function TX3_stimulusSelectPT_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_stimulusSelectPT_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX3_stimulusSelectPT_checkBox

   load mdb;
    mdb.TX3.stimulus.stimulusSelect.pureTone = get(hObject,'Value');
    save mdb mdb ;
    
      %update the SNR
 if (  mdb.TX3.stimulus.stimulusSelect.pureTone )   % only if noise stimulus is checked
     if ( mdb.TX3.stimulus.stimulusSelect.noise )
         snr =  mdb.TX3.stimulus.PT.amp -  mdb.TX3.stimulus.noise.amp;
         set(mdb.TX3.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
 else
        set(mdb.TX3.stimulus.noise.snrPT_staticText_handle,'String','null');
 end 


% --- Executes on slider movement.
function TX3_PTFreqSelect_slider_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_PTFreqSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

load mdb;
 mdb.TX3.stimulus.PT.freq = get(hObject,'Value');
 save mdb mdb;
 
 %write the slider value to the ststic text
 set(mdb.TX3.stimulus.PT.freqEditText_handle,'String',get(hObject,'Value') );


% --- Executes during object creation, after setting all properties.
function TX3_PTFreqSelect_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_PTFreqSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

load mdb;
mdb.TX3.stimulus.PT.PTFreqSelectSlider_handle = hObject;
 mdb.TX3.stimulus.PT.freq = get(hObject,'Value');
 save mdb mdb;


% --- Executes on slider movement.
function TX3_PTAmpSelect_slider_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_PTAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

load mdb;
 mdb.TX3.stimulus.PT.amp = get(hObject,'Value');
 save mdb mdb;
 
 %write the slider value to the ststic text
 set(mdb.TX3.stimulus.PT.ampEditText_handle,'String',get(hObject,'Value') );
 
  %update the SNR
 if (  mdb.TX3.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX3.stimulus.stimulusSelect.pureTone )
         snr =  mdb.TX3.stimulus.PT.amp -  mdb.TX3.stimulus.noise.amp;
         set(mdb.TX3.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
 end


% --- Executes during object creation, after setting all properties.
function TX3_PTAmpSelect_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_PTAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

load mdb;
mdb.TX3.stimulus.PT.PTAmpSelectSlider_handle = hObject;
 mdb.TX3.stimulus.PT.amp = get(hObject,'Value');
 save mdb mdb;



function TX3_PTFreqValue_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_PTFreqValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX3_PTFreqValue_editText as text
%        str2double(get(hObject,'String')) returns contents of TX3_PTFreqValue_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
%check if entered value is in frequency range
sliderMax = get(mdb.TX3.stimulus.PT.PTFreqSelectSlider_handle,'Max');
sliderMin = get(mdb.TX3.stimulus.PT.PTFreqSelectSlider_handle,'Min');
if (   (user_entry > sliderMax) || (user_entry <  sliderMin)  )
    set(hObject,'String',sliderMin);
    set(mdb.TX3.stimulus.PT.PTFreqSelectSlider_handle,'Value',sliderMin);
    mdb.TX3.stimulus.PT.freq = sliderMin;
    save mdb mdb;
    return
end

%update the slider and mdb with the new entry
set(mdb.TX3.stimulus.PT.PTFreqSelectSlider_handle,'Value',user_entry);
mdb.TX3.stimulus.PT.freq = user_entry;
save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_PTFreqValue_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_PTFreqValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
mdb.TX3.stimulus.PT.freqEditText_handle = hObject;
save mdb mdb;



function TX3_PTAmpValue_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_PTAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX3_PTAmpValue_editText as text
%        str2double(get(hObject,'String')) returns contents of TX3_PTAmpValue_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
%check if entered value is in frequency range
sliderMax = get(mdb.TX3.stimulus.PT.PTAmpSelectSlider_handle,'Max');
sliderMin = get(mdb.TX3.stimulus.PT.PTAmpSelectSlider_handle,'Min');
if (   (user_entry > sliderMax) || (user_entry <  sliderMin)  )
    set(hObject,'String',sliderMin);
    set(mdb.TX3.stimulus.PT.PTAmpSelectSlider_handle,'Value',sliderMin);
    mdb.TX3.stimulus.PT.amp = sliderMin;
    save mdb mdb;
    return
end


%update the slider with the new entry
set(mdb.TX3.stimulus.PT.PTAmpSelectSlider_handle,'Value',user_entry);
 mdb.TX3.stimulus.PT.amp = user_entry;
 
  %update the SNR
 if (  mdb.TX3.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX3.stimulus.stimulusSelect.pureTone )
         snr =  mdb.TX3.stimulus.PT.amp -  mdb.TX3.stimulus.noise.amp;
         set(mdb.TX3.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
 end
 
save mdb mdb;



% --- Executes during object creation, after setting all properties.
function TX3_PTAmpValue_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_PTAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
mdb.TX3.stimulus.PT.ampEditText_handle = hObject;
save mdb mdb;


% --- Executes on selection change in TX3_stimulus_PTPhase_popupmenu.
function TX3_stimulus_PTPhase_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_stimulus_PTPhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TX3_stimulus_PTPhase_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TX3_stimulus_PTPhase_popupmenu

% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
load mdb;

switch str{val}
    case '0 deg'
        mdb.TX3.stimulus.PT.phase = 0; 
    case '90 deg'
        mdb.TX3.stimulus.PT.phase = 90;
    case '180 deg'
        mdb.TX3.stimulus.PT.phase = 180;
    case '270 deg'
        mdb.TX3.stimulus.PT.phase = 270;       
end

 save mdb mdb;
 


% --- Executes during object creation, after setting all properties.
function TX3_stimulus_PTPhase_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_stimulus_PTPhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
mdb.TX3.stimulus.PT.phase = 0;
save mdb mdb;


% --- Executes on button press in TX3_stimulusSelectSpeech_checkBox.
function TX3_stimulusSelectSpeech_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_stimulusSelectSpeech_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX3_stimulusSelectSpeech_checkBox

   load mdb;
    mdb.TX3.stimulus.stimulusSelect.speech = get(hObject,'Value');
    save mdb mdb;
    
      %update the SNR
 if (  mdb.TX3.stimulus.stimulusSelect.speech )   % only if noise stimulus is checked
     if ( mdb.TX3.stimulus.stimulusSelect.noise )
         snr =  mdb.TX3.stimulus.speech.amp -  mdb.TX3.stimulus.noise.amp;
         set(mdb.TX3.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 else
        set(mdb.TX3.stimulus.noise.snrSpeech_staticText_handle,'String','null');
 end


% --- Executes on slider movement.
function TX3_speechAmpSelect_slider_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_speechAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

load mdb;
 mdb.TX3.stimulus.speech.amp =  get(hObject,'Value');
 save mdb mdb;
 
 %write the slider value to the ststic text
 set(mdb.TX3.stimulus.speech.ampEditText_handle,'String',get(hObject,'Value') );
 
  %update the SNR
 if (  mdb.TX3.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX3.stimulus.stimulusSelect.speech )
         snr =  mdb.TX3.stimulus.speech.amp -  mdb.TX3.stimulus.noise.amp;
         set(mdb.TX3.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 end


% --- Executes during object creation, after setting all properties.
function TX3_speechAmpSelect_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_speechAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

load mdb;
mdb.TX3.stimulus.speech.ampSelectSlider_handle = hObject;
 mdb.TX3.stimulus.speech.amp = get(hObject,'Value');
 save mdb mdb;


% --- Executes on button press in TX3_stimulusSpeechSourceSelect_pushButton.
function TX3_stimulusSpeechSourceSelect_pushButton_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_stimulusSpeechSourceSelect_pushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

      [FileName,PathName,FilterIndex] = uigetfile('D:\Users\students\*.wav');
      fullfilename = sprintf('%s%s',PathName,FileName);
      disp(fullfilename);
      
      load mdb;
       mdb.TX3.stimulus.speech.source = fullfilename;
      set( mdb.TX3.stimulus.speech.sourceSelectPushButton_handle,'String',FileName);
      save mdb mdb;



function TX3_speechAmpValue_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_speechAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX3_speechAmpValue_editText as text
%        str2double(get(hObject,'String')) returns contents of TX3_speechAmpValue_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
%check if entered value is in frequency range
sliderMax = get(mdb.TX3.stimulus.speech.ampSelectSlider_handle,'Max');
sliderMin = get(mdb.TX3.stimulus.speech.ampSelectSlider_handle,'Min');
if (   (user_entry > sliderMax) || (user_entry <  sliderMin)  )
    set(hObject,'String',sliderMin);
    set(mdb.TX3.stimulus.speech.ampSelectSlider_handle,'Value',sliderMin);
    mdb.TX3.stimulus.speech.amp = sliderMin;
    save mdb mdb;
    return
end


%update the slider with the new entry
set(mdb.TX3.stimulus.speech.ampSelectSlider_handle,'Value',user_entry);
 mdb.TX3.stimulus.speech.amp = user_entry;
 
  %update the SNR
 if (  mdb.TX3.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX3.stimulus.stimulusSelect.speech )
         snr =  mdb.TX3.stimulus.speech.amp -  mdb.TX3.stimulus.noise.amp;
         set(mdb.TX3.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 end
 
save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_speechAmpValue_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_speechAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
mdb.TX3.stimulus.speech.ampEditText_handle = hObject;
save mdb mdb;


% --- Executes on selection change in TX3_stimulus_SpeechPhase_popupmenu.
function TX3_stimulus_SpeechPhase_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_stimulus_SpeechPhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TX3_stimulus_SpeechPhase_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TX3_stimulus_SpeechPhase_popupmenu

% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
load mdb;

switch str{val}
    case '0 deg'
        mdb.TX3.stimulus.speech.phase = 0;
    case '180 deg'
      mdb.TX3.stimulus.speech.phase = 180;   
end

 save mdb mdb;
 



% --- Executes during object creation, after setting all properties.
function TX3_stimulus_SpeechPhase_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_stimulus_SpeechPhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
 mdb.TX3.stimulus.speech.phase = 0;
 save mdb mdb;


% --- Executes on button press in TX2_stimulusSelectNoise_checkBox.
function TX2_stimulusSelectNoise_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_stimulusSelectNoise_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX2_stimulusSelectNoise_checkBox

    load mdb;
    mdb.TX2.stimulus.stimulusSelect.noise = get(hObject,'Value');
    save mdb mdb;
    
    %update the SNR
 if (  mdb.TX2.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX2.stimulus.stimulusSelect.pureTone )
         snr =  mdb.TX2.stimulus.PT.amp -  mdb.TX2.stimulus.noise.amp;
         set(mdb.TX2.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
     if ( mdb.TX2.stimulus.stimulusSelect.speech )
         snr =  mdb.TX2.stimulus.speech.amp -  mdb.TX2.stimulus.noise.amp;
         set(mdb.TX2.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 else
        set(mdb.TX2.stimulus.noise.snrPT_staticText_handle,'String','null');
        set(mdb.TX2.stimulus.noise.snrSpeech_staticText_handle,'String','null');
 end
    
    


% --- Executes on slider movement.
function TX2_noiseAmpSelect_slider_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_noiseAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

load mdb;
 mdb.TX2.stimulus.noise.amp = get(hObject,'Value');
 
 %write the slider value to the edit text
 set(mdb.TX2.stimulus.noise.ampEditText_handle,'String',get(hObject,'Value') );
 
 %update the SNR
 if (  mdb.TX2.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked  
     if ( mdb.TX2.stimulus.stimulusSelect.pureTone )
         snr =  mdb.TX2.stimulus.PT.amp -  mdb.TX2.stimulus.noise.amp;
         set(mdb.TX2.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
     if ( mdb.TX2.stimulus.stimulusSelect.speech )
         snr =  mdb.TX2.stimulus.speech.amp -  mdb.TX2.stimulus.noise.amp;
         set(mdb.TX2.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 end
 
  save mdb mdb;





% --- Executes during object creation, after setting all properties.
function TX2_noiseAmpSelect_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_noiseAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

load mdb;
mdb.TX2.stimulus.noise.ampSelectSlider_handle = hObject;
 mdb.TX2.stimulus.noise.amp = get(hObject,'Value');
 save mdb mdb;



function TX2_noiseAmpValue_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_noiseAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX2_noiseAmpValue_editText as text
%        str2double(get(hObject,'String')) returns contents of TX2_noiseAmpValue_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
%check if entered value is in amplitude range
sliderMax = get(mdb.TX2.stimulus.noise.ampSelectSlider_handle,'Max');
sliderMin = get(mdb.TX2.stimulus.noise.ampSelectSlider_handle,'Min');
if (   (user_entry > sliderMax) || (user_entry <  sliderMin)  )
    set(hObject,'String',sliderMin);
    set(mdb.TX2.stimulus.noise.ampSelectSlider_handle,'Value',sliderMin);
    mdb.TX2.stimulus.noise.amp = sliderMin;
    save mdb mdb;
    return
end


%update the slider with the new entry
set(mdb.TX2.stimulus.noise.ampSelectSlider_handle,'Value',user_entry);
 mdb.TX2.stimulus.noise.amp = user_entry;
 
 %update the SNR
 if (  mdb.TX2.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX2.stimulus.stimulusSelect.pureTone )
         snr =  mdb.TX2.stimulus.PT.amp -  mdb.TX2.stimulus.noise.amp;
         set(mdb.TX2.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
     if ( mdb.TX2.stimulus.stimulusSelect.speech )
         snr =  mdb.TX2.stimulus.speech.amp -  mdb.TX2.stimulus.noise.amp;
         set(mdb.TX2.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 end
 
save mdb mdb;




% --- Executes during object creation, after setting all properties.
function TX2_noiseAmpValue_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_noiseAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
mdb.TX2.stimulus.noise.ampEditText_handle = hObject;
save mdb mdb;


% --- Executes on selection change in TX2_stimulusNoiseSourceSelect_popupmenu.
function TX2_stimulusNoiseSourceSelect_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_stimulusNoiseSourceSelect_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TX2_stimulusNoiseSourceSelect_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TX2_stimulusNoiseSourceSelect_popupmenu

% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
load mdb;
set(mdb.TX2.stimulus.noise.sourceFileName_staticText_handle,'Visible','off'); %reset the source file name
set(mdb.TX2.stimulus.noise.filterPannel_handle,'Visible','off');

switch str{val}
    case 'white noise'
        mdb.TX2.stimulus.noise.source = 1; %1=white noise'
    case 'NB noise'
        set(mdb.TX2.stimulus.noise.filterPannel_handle,'Visible','on');
         mdb.TX2.stimulus.noise.source = 2;  %2=NB noise
    case 'from file'
         [FileName,PathName,FilterIndex] = uigetfile('D:\Users\students\*.wav');
         fullfilename = sprintf('%s%s',PathName,FileName);
         disp(fullfilename);
         mdb.TX2.stimulus.noise.source = 3;  %3=from file
          mdb.TX2.stimulus.noise.fileName = fullfilename;
        set(mdb.TX2.stimulus.noise.sourceFileName_staticText_handle,'String',FileName);  
        set(mdb.TX2.stimulus.noise.sourceFileName_staticText_handle,'Visible','on');        
end

 save mdb mdb;
 



% --- Executes during object creation, after setting all properties.
function TX2_stimulusNoiseSourceSelect_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_stimulusNoiseSourceSelect_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Determine the selected data set.
str = get(hObject, 'String');
% Set initial data to the first data set.
load mdb;
switch str{1}
    case 'white noise'
       mdb.TX2.stimulus.noise.source = 1; %1=white noise
    case 'NB noise'
       mdb.TX2.stimulus.noise.source = 2;  %2=NB noise
    case 'from file'
       mdb.TX2.stimulus.noise.source = 3;  %3=from file 
    case 'reveresed speech'
       mdb.TX2.stimulus.noise.source = 4; %4=reveresed speech 
end

mdb.TX2.stimulus.noise.fileName = 0;

save mdb mdb;



% --- Executes on selection change in TX2_stimulus_NoisePhase_popupmenu.
function TX2_stimulus_NoisePhase_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_stimulus_NoisePhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TX2_stimulus_NoisePhase_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TX2_stimulus_NoisePhase_popupmenu
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
load mdb;

switch str{val}
    case '0 deg'
        mdb.TX2.stimulus.noise.phase = 0;
    case '180 deg'
       mdb.TX2.stimulus.noise.phase = 180;   
end

 save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX2_stimulus_NoisePhase_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_stimulus_NoisePhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


load mdb;
 mdb.TX2.stimulus.noise.phase = 0;
 save mdb mdb;

% --- Executes on button press in TX2_stimulusSelectPT_checkBox.
function TX2_stimulusSelectPT_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_stimulusSelectPT_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX2_stimulusSelectPT_checkBox

   load mdb;
    mdb.TX2.stimulus.stimulusSelect.pureTone = get(hObject,'Value');
    save mdb mdb ;
    
      %update the SNR
 if (  mdb.TX2.stimulus.stimulusSelect.pureTone )   % only if noise stimulus is checked
     if ( mdb.TX2.stimulus.stimulusSelect.noise )
         snr =  mdb.TX2.stimulus.PT.amp -  mdb.TX2.stimulus.noise.amp;
         set(mdb.TX2.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
 else
        set(mdb.TX2.stimulus.noise.snrPT_staticText_handle,'String','null');
 end


% --- Executes on slider movement.
function TX2_PTFreqSelect_slider_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_PTFreqSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

load mdb;
 mdb.TX2.stimulus.PT.freq = get(hObject,'Value');
 save mdb mdb;
 
 %write the slider value to the ststic text
 set(mdb.TX2.stimulus.PT.freqEditText_handle,'String',get(hObject,'Value') );


% --- Executes during object creation, after setting all properties.
function TX2_PTFreqSelect_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_PTFreqSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

load mdb;
mdb.TX2.stimulus.PT.PTFreqSelectSlider_handle = hObject;
 mdb.TX2.stimulus.PT.freq = get(hObject,'Value');
 save mdb mdb;

% --- Executes on slider movement.
function TX2_PTAmpSelect_slider_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_PTAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

load mdb;
 mdb.TX2.stimulus.PT.amp = get(hObject,'Value');
 save mdb mdb;
 
 %write the slider value to the ststic text
 set(mdb.TX2.stimulus.PT.ampEditText_handle,'String',get(hObject,'Value') );
 
  %update the SNR
 if (  mdb.TX2.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX2.stimulus.stimulusSelect.pureTone )
         snr =  mdb.TX2.stimulus.PT.amp -  mdb.TX2.stimulus.noise.amp;
         set(mdb.TX2.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
 end

% --- Executes during object creation, after setting all properties.
function TX2_PTAmpSelect_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_PTAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

load mdb;
mdb.TX2.stimulus.PT.PTAmpSelectSlider_handle = hObject;
 mdb.TX2.stimulus.PT.amp = get(hObject,'Value');
 save mdb mdb;



function TX2_PTFreqValue_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_PTFreqValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX2_PTFreqValue_editText as text
%        str2double(get(hObject,'String')) returns contents of TX2_PTFreqValue_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
%check if entered value is in frequency range
sliderMax = get(mdb.TX2.stimulus.PT.PTFreqSelectSlider_handle,'Max');
sliderMin = get(mdb.TX2.stimulus.PT.PTFreqSelectSlider_handle,'Min');
if (   (user_entry > sliderMax) || (user_entry <  sliderMin)  )
    set(hObject,'String',sliderMin);
    set(mdb.TX2.stimulus.PT.PTFreqSelectSlider_handle,'Value',sliderMin);
    mdb.TX2.stimulus.PT.freq = sliderMin;
    save mdb mdb;
    return
end

%update the slider and mdb with the new entry
set(mdb.TX2.stimulus.PT.PTFreqSelectSlider_handle,'Value',user_entry);
mdb.TX2.stimulus.PT.freq = user_entry;
save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX2_PTFreqValue_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_PTFreqValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
mdb.TX2.stimulus.PT.freqEditText_handle = hObject;
save mdb mdb;



function TX2_PTAmpValue_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_PTAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX2_PTAmpValue_editText as text
%        str2double(get(hObject,'String')) returns contents of TX2_PTAmpValue_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
%check if entered value is in frequency range
sliderMax = get(mdb.TX2.stimulus.PT.PTAmpSelectSlider_handle,'Max');
sliderMin = get(mdb.TX2.stimulus.PT.PTAmpSelectSlider_handle,'Min');
if (   (user_entry > sliderMax) || (user_entry <  sliderMin)  )
    set(hObject,'String',sliderMin);
    set(mdb.TX2.stimulus.PT.PTAmpSelectSlider_handle,'Value',sliderMin);
    mdb.TX2.stimulus.PT.amp = sliderMin;
    save mdb mdb;
    return
end


%update the slider with the new entry
set(mdb.TX2.stimulus.PT.PTAmpSelectSlider_handle,'Value',user_entry);
 mdb.TX2.stimulus.PT.amp = user_entry;
 
  %update the SNR
 if (  mdb.TX2.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX2.stimulus.stimulusSelect.pureTone )
         snr =  mdb.TX2.stimulus.PT.amp -  mdb.TX2.stimulus.noise.amp;
         set(mdb.TX2.stimulus.noise.snrPT_staticText_handle,'String',snr);
     end
 end
 
save mdb mdb;



% --- Executes during object creation, after setting all properties.
function TX2_PTAmpValue_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_PTAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
mdb.TX2.stimulus.PT.ampEditText_handle = hObject;
save mdb mdb;


% --- Executes on selection change in TX2_stimulus_PTPhase_popupmenu.
function TX2_stimulus_PTPhase_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_stimulus_PTPhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TX2_stimulus_PTPhase_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TX2_stimulus_PTPhase_popupmenu

% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
load mdb;

switch str{val}
    case '0 deg'
        mdb.TX2.stimulus.PT.phase = 0; 
    case '90 deg'
        mdb.TX2.stimulus.PT.phase = 90;
    case '180 deg'
        mdb.TX2.stimulus.PT.phase = 180;
    case '270 deg'
        mdb.TX2.stimulus.PT.phase = 270;       
end

 save mdb mdb;
 


% --- Executes during object creation, after setting all properties.
function TX2_stimulus_PTPhase_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_stimulus_PTPhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
mdb.TX2.stimulus.PT.phase = 0;
save mdb mdb;

% --- Executes on button press in TX2_stimulusSelectSpeech_checkBox.
function TX2_stimulusSelectSpeech_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_stimulusSelectSpeech_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX2_stimulusSelectSpeech_checkBox

   load mdb;
    mdb.TX2.stimulus.stimulusSelect.speech = get(hObject,'Value');
    save mdb mdb;
    
      %update the SNR
 if (  mdb.TX2.stimulus.stimulusSelect.speech )   % only if noise stimulus is checked
     if ( mdb.TX2.stimulus.stimulusSelect.noise )
         snr =  mdb.TX2.stimulus.speech.amp -  mdb.TX2.stimulus.noise.amp;
         set(mdb.TX2.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 else
        set(mdb.TX2.stimulus.noise.snrSpeech_staticText_handle,'String','null');
 end


% --- Executes on slider movement.
function TX2_speechAmpSelect_slider_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_speechAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

load mdb;
 mdb.TX2.stimulus.speech.amp =  get(hObject,'Value');
 save mdb mdb;
 
 %write the slider value to the ststic text
 set(mdb.TX2.stimulus.speech.ampEditText_handle,'String',get(hObject,'Value') );
 
  %update the SNR
 if (  mdb.TX2.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX2.stimulus.stimulusSelect.speech )
         snr =  mdb.TX2.stimulus.speech.amp -  mdb.TX2.stimulus.noise.amp;
         set(mdb.TX2.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 end


% --- Executes during object creation, after setting all properties.
function TX2_speechAmpSelect_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_speechAmpSelect_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

load mdb;
mdb.TX2.stimulus.speech.ampSelectSlider_handle = hObject;
 mdb.TX2.stimulus.speech.amp = get(hObject,'Value');
 save mdb mdb;

% --- Executes on button press in TX2_stimulusSpeechSourceSelect_pushButton.
function TX2_stimulusSpeechSourceSelect_pushButton_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_stimulusSpeechSourceSelect_pushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

      [FileName,PathName,FilterIndex] = uigetfile('D:\Users\students\*.wav');
      fullfilename = sprintf('%s%s',PathName,FileName);
      disp(fullfilename);
      
      load mdb;
       mdb.TX2.stimulus.speech.source = fullfilename;
      set( mdb.TX2.stimulus.speech.sourceSelectPushButton_handle,'String',FileName);
      save mdb mdb;



function TX2_speechAmpValue_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_speechAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX2_speechAmpValue_editText as text
%        str2double(get(hObject,'String')) returns contents of TX2_speechAmpValue_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
%check if entered value is in frequency range
sliderMax = get(mdb.TX2.stimulus.speech.ampSelectSlider_handle,'Max');
sliderMin = get(mdb.TX2.stimulus.speech.ampSelectSlider_handle,'Min');
if (   (user_entry > sliderMax) || (user_entry <  sliderMin)  )
    set(hObject,'String',sliderMin);
    set(mdb.TX2.stimulus.speech.ampSelectSlider_handle,'Value',sliderMin);
    mdb.TX2.stimulus.speech.amp = sliderMin;
    save mdb mdb;
    return
end


%update the slider with the new entry
set(mdb.TX2.stimulus.speech.ampSelectSlider_handle,'Value',user_entry);
 mdb.TX2.stimulus.speech.amp = user_entry;
 
  %update the SNR
 if (  mdb.TX2.stimulus.stimulusSelect.noise )   % only if noise stimulus is checked
     if ( mdb.TX2.stimulus.stimulusSelect.speech )
         snr =  mdb.TX2.stimulus.speech.amp -  mdb.TX2.stimulus.noise.amp;
         set(mdb.TX2.stimulus.noise.snrSpeech_staticText_handle,'String',snr);
     end
 end
 
save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX2_speechAmpValue_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_speechAmpValue_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
mdb.TX2.stimulus.speech.ampEditText_handle = hObject;
save mdb mdb;


% --- Executes on selection change in TX2_stimulus_SpeechPhase_popupmenu.
function TX2_stimulus_SpeechPhase_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_stimulus_SpeechPhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TX2_stimulus_SpeechPhase_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TX2_stimulus_SpeechPhase_popupmenu

% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
load mdb;

switch str{val}
    case '0 deg'
        mdb.TX2.stimulus.speech.phase = 0;
    case '180 deg'
      mdb.TX2.stimulus.speech.phase = 180;   
end

 save mdb mdb;
 



% --- Executes during object creation, after setting all properties.
function TX2_stimulus_SpeechPhase_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_stimulus_SpeechPhase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load mdb;
 mdb.TX2.stimulus.speech.phase = 0;
 save mdb mdb;
 
 

function TX2_ModFreq_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_ModFreq_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX2_ModFreq_editText as text
%        str2double(get(hObject,'String')) returns contents of TX2_ModFreq_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
 mdb.TX2.stimulus.PT.modFreq = user_entry;
 save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX2_ModFreq_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_ModFreq_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX2.stimulus.PT.modFreq = init_entry;
save mdb mdb;



function TX2_stimulus_noiseFilterBW_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_stimulus_noiseFilterBW_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX2_stimulus_noiseFilterBW_editText as text
%        str2double(get(hObject,'String')) returns contents of TX2_stimulus_noiseFilterBW_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
    errordlg('You must enter a numeric value','Bad Input','modal')
    uicontrol(hObject)
    return
end

load mdb;
%check if entered value is in frequency range
maxValue = 200;
minValue = 5;
if (   (user_entry > maxValue) || (user_entry <  minValue)  )
    set(hObject,'String',minValue);
    mdb.TX2.stimulus.noise.NBBW = minValue;
    save mdb mdb;
    return
end
 
mdb.TX2.stimulus.noise.NBBW = user_entry;
 save mdb mdb;



% --- Executes during object creation, after setting all properties.
function TX2_stimulus_noiseFilterBW_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_stimulus_noiseFilterBW_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX2.stimulus.noise.NBBW = init_entry;
save mdb mdb;



function TX2_stimulus_noiseFilterCntrFrq_edtiText_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_stimulus_noiseFilterCntrFrq_edtiText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX2_stimulus_noiseFilterCntrFrq_edtiText as text
%        str2double(get(hObject,'String')) returns contents of TX2_stimulus_noiseFilterCntrFrq_edtiText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
    errordlg('You must enter a numeric value','Bad Input','modal')
    uicontrol(hObject)
    return
end

load mdb;
%check if entered value is in frequency range
maxValue = get(mdb.TX2.stimulus.PT.PTFreqSelectSlider_handle,'Max');
minValue = get(mdb.TX2.stimulus.PT.PTFreqSelectSlider_handle,'Min');
if (   (user_entry > maxValue) || (user_entry <  minValue)  )
    set(hObject,'String',minValue);
    mdb.TX2.stimulus.noise.NBCntrFrq = minValue;
    save mdb mdb;
    return
end

 mdb.TX2.stimulus.noise.NBCntrFrq = user_entry;
 save mdb mdb;



% --- Executes during object creation, after setting all properties.
function TX2_stimulus_noiseFilterCntrFrq_edtiText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_stimulus_noiseFilterCntrFrq_edtiText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX2.stimulus.noise.NBCntrFrq = init_entry;
save mdb mdb;



function TX3_ModFreq_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_ModFreq_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX3_ModFreq_editText as text
%        str2double(get(hObject,'String')) returns contents of TX3_ModFreq_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
 mdb.TX3.stimulus.PT.modFreq = user_entry;
 save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_ModFreq_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_ModFreq_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX3.stimulus.PT.modFreq = init_entry;
save mdb mdb;



function TX3_stimulus_noiseFilterBW_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_stimulus_noiseFilterBW_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX3_stimulus_noiseFilterBW_editText as text
%        str2double(get(hObject,'String')) returns contents of TX3_stimulus_noiseFilterBW_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
    errordlg('You must enter a numeric value','Bad Input','modal')
    uicontrol(hObject)
    return
end

load mdb;
%check if entered value is in frequency range
maxValue = 200;
minValue = 5;
if (   (user_entry > maxValue) || (user_entry <  minValue)  )
    set(hObject,'String',minValue);
    mdb.TX3.stimulus.noise.NBBW = minValue;
    save mdb mdb;
    return
end
 
mdb.TX3.stimulus.noise.NBBW = user_entry;
 save mdb mdb;



% --- Executes during object creation, after setting all properties.
function TX3_stimulus_noiseFilterBW_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_stimulus_noiseFilterBW_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX3.stimulus.noise.NBBW = init_entry;
save mdb mdb;



function TX3_stimulus_noiseFilterCntrFrq_edtiText_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_stimulus_noiseFilterCntrFrq_edtiText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX3_stimulus_noiseFilterCntrFrq_edtiText as text
%        str2double(get(hObject,'String')) returns contents of TX3_stimulus_noiseFilterCntrFrq_edtiText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
    errordlg('You must enter a numeric value','Bad Input','modal')
    uicontrol(hObject)
    return
end

load mdb;
%check if entered value is in frequency range
maxValue = get(mdb.TX3.stimulus.PT.PTFreqSelectSlider_handle,'Max');
minValue = get(mdb.TX3.stimulus.PT.PTFreqSelectSlider_handle,'Min');
if (   (user_entry > maxValue) || (user_entry <  minValue)  )
    set(hObject,'String',minValue);
    mdb.TX3.stimulus.noise.NBCntrFrq = minValue;
    save mdb mdb;
    return
end

 mdb.TX3.stimulus.noise.NBCntrFrq = user_entry;
 save mdb mdb;



% --- Executes during object creation, after setting all properties.
function TX3_stimulus_noiseFilterCntrFrq_edtiText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_stimulus_noiseFilterCntrFrq_edtiText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX3.stimulus.noise.NBCntrFrq = init_entry;
save mdb mdb;

% --- Executes on button press in TX3_stimulusModulationAM_checkBox.
function TX3_stimulusModulationAM_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_stimulusModulationAM_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX3_stimulusModulationAM_checkBox

load mdb;
if (get(hObject,'Value'))
    if (  mdb.TX3.stimulus.PT.modulationType == 3 )  %no modulation
        mdb.TX3.stimulus.PT.modulationType = 0; %AM
    else  %FM is required too
        mdb.TX3.stimulus.PT.modulationType = 2; %AM and FM
    end
else
    if (  mdb.TX3.stimulus.PT.modulationType == 2 ) %AM and FM
         mdb.TX3.stimulus.PT.modulationType = 1;    %FM
    else
        mdb.TX3.stimulus.PT.modulationType = 3;  %no modulation
    end
end

save mdb mdb;




function TX3_AMModDepth_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_AMModDepth_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX3_AMModDepth_editText as text
%        str2double(get(hObject,'String')) returns contents of TX3_AMModDepth_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
mdb.TX3.stimulus.PT.modDepth = user_entry;
save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_AMModDepth_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_AMModDepth_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX3.stimulus.PT.modDepth = init_entry;
save mdb mdb;


% --- Executes on button press in TX3_stimulusModulationFM_checkBox.
function TX3_stimulusModulationFM_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_stimulusModulationFM_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX3_stimulusModulationFM_checkBox

load mdb;
if (get(hObject,'Value'))
    if (  mdb.TX3.stimulus.PT.modulationType == 3 )  %no modulation
        mdb.TX3.stimulus.PT.modulationType = 1; %FM
    else  %AM is required too
        mdb.TX3.stimulus.PT.modulationType = 2; %AM and FM
    end
else
    if (  mdb.TX3.stimulus.PT.modulationType == 2 ) %AM and FM
         mdb.TX3.stimulus.PT.modulationType = 0;    %AM
    else
        mdb.TX3.stimulus.PT.modulationType = 3;  %no modulation
    end
end

save mdb mdb;



function TX3_FMModIndex_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX3_FMModIndex_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX3_FMModIndex_editText as text
%        str2double(get(hObject,'String')) returns contents of TX3_FMModIndex_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
mdb.TX3.stimulus.PT.modIndex = user_entry;
save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_FMModIndex_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_FMModIndex_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX3.stimulus.PT.modIndex = init_entry;
save mdb mdb;


% --- Executes on button press in TX2_stimulusModulationAM_checkBox.
function TX2_stimulusModulationAM_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_stimulusModulationAM_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX2_stimulusModulationAM_checkBox

load mdb;
if (get(hObject,'Value'))
    if (  mdb.TX2.stimulus.PT.modulationType == 3 )  %no modulation
        mdb.TX2.stimulus.PT.modulationType = 0; %AM
    else  %FM is required too
        mdb.TX2.stimulus.PT.modulationType = 2; %AM and FM
    end
else
    if (  mdb.TX2.stimulus.PT.modulationType == 2 ) %AM and FM
         mdb.TX2.stimulus.PT.modulationType = 1;    %FM
    else
        mdb.TX2.stimulus.PT.modulationType = 3;  %no modulation
    end
end

save mdb mdb;




function TX2_AMModDepth_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_AMModDepth_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX2_AMModDepth_editText as text
%        str2double(get(hObject,'String')) returns contents of TX2_AMModDepth_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
mdb.TX2.stimulus.PT.modDepth = user_entry;
save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX2_AMModDepth_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_AMModDepth_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX2.stimulus.PT.modDepth = init_entry;
save mdb mdb;


% --- Executes on button press in TX2_stimulusModulationFM_checkBox.
function TX2_stimulusModulationFM_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_stimulusModulationFM_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX2_stimulusModulationFM_checkBox

load mdb;
if (get(hObject,'Value'))
    if (  mdb.TX2.stimulus.PT.modulationType == 3 )  %no modulation
        mdb.TX1.stimulus.PT.modulationType = 1; %FM
    else  %AM is required too
        mdb.TX2.stimulus.PT.modulationType = 2; %AM and FM
    end
else
    if (  mdb.TX2.stimulus.PT.modulationType == 2 ) %AM and FM
         mdb.TX2.stimulus.PT.modulationType = 0;    %AM
    else
        mdb.TX2.stimulus.PT.modulationType = 3;  %no modulation
    end
end

save mdb mdb;



function TX2_FMModIndex_editText_Callback(hObject, eventdata, handles)
% hObject    handle to TX2_FMModIndex_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX2_FMModIndex_editText as text
%        str2double(get(hObject,'String')) returns contents of TX2_FMModIndex_editText as a double

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
errordlg('You must enter a numeric value','Bad Input','modal')
uicontrol(hObject)
return
end

load mdb;
mdb.TX2.stimulus.PT.modIndex = user_entry;
save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX2_FMModIndex_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_FMModIndex_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

init_entry = str2double(get(hObject,'string'));
load mdb;
mdb.TX2.stimulus.PT.modIndex = init_entry;
save mdb mdb;



% --- Executes on button press in main_FFDac1_checkBox.
function main_FFDac1_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac1_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac1_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(1)=get(hObject,'Value');
    save mdb mdb;


% --- Executes on button press in main_FFDac2_checkBox.
function main_FFDac2_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac2_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac2_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(2)=get(hObject,'Value');
    save mdb mdb;


% --- Executes on button press in main_FFDac3_checkBox.
function main_FFDac3_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac3_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac3_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(3)=get(hObject,'Value');
    save mdb mdb;



% --- Executes on button press in main_FFDac4_checkBox.
function main_FFDac4_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac4_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac4_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(4)=get(hObject,'Value');
    save mdb mdb;



% --- Executes on button press in main_FFDac5_checkBox.
function main_FFDac5_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac5_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac5_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(5)=get(hObject,'Value');
    save mdb mdb;



% --- Executes on button press in main_FFDac6_checkBox.
function main_FFDac6_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac6_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac6_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(6)=get(hObject,'Value');
    save mdb mdb;



% --- Executes on button press in main_FFDac7_checkBox.
function main_FFDac7_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac7_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac7_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(7)=get(hObject,'Value');
    save mdb mdb;



% --- Executes on button press in main_FFDac8_checkBox.
function main_FFDac8_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac8_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac8_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(8)=get(hObject,'Value');
    save mdb mdb;

% --- Executes on button press in main_FFDac9_checkBox.
function main_FFDac9_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac9_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac9_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(9)=get(hObject,'Value');
    save mdb mdb;

% --- Executes on button press in main_FFDac9_checkBox.
function main_FFDac10_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac9_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac9_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(10)=get(hObject,'Value');
    save mdb mdb;
    
% --- Executes on button press in main_FFDac9_checkBox.
function main_FFDac11_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac9_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac9_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(11)=get(hObject,'Value');
    save mdb mdb;
    
% --- Executes on button press in main_FFDac9_checkBox.
function main_FFDac12_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac9_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac9_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(12)=get(hObject,'Value');
    save mdb mdb;
    
% --- Executes on button press in main_FFDac9_checkBox.
function main_FFDac13_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac9_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac9_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(13)=get(hObject,'Value');
    save mdb mdb;
    
% --- Executes on button press in main_FFDac9_checkBox.
function main_FFDac14_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac9_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac9_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(14)=get(hObject,'Value');
    save mdb mdb;

% --- Executes on button press in main_FFDac9_checkBox.
function main_FFDac15_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac9_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac9_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(15)=get(hObject,'Value');
    save mdb mdb;
    
% --- Executes on button press in main_FFDac9_checkBox.
function main_FFDac16_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac9_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac9_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(16)=get(hObject,'Value');
    save mdb mdb;
    
% --- Executes on button press in main_FFDac9_checkBox.
function main_FFDac17_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac9_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac9_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(17)=get(hObject,'Value');
    save mdb mdb;
    
% --- Executes on button press in main_FFDac9_checkBox.
function main_FFDac18_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_FFDac9_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_FFDac9_checkBox

    load mdb;
    mdb.main.transducer.FF.newDacVector(18)=get(hObject,'Value');
    save mdb mdb;
    
% --- Executes on button press in main_transducerSelect_TX1Set_pushbutton.
function main_transducerSelect_TX1Set_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to main_transducerSelect_TX1Set_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 load mdb;

switch mdb.main.transducer.newSource
    case 'FF'
       % set the new FF DAC vector to be the current vector for TX1
      for k=1:1:18
           mdb.TX1.transducer.FF.DacVector(k) =  mdb.main.transducer.FF.newDacVector(k);
      end
      mdb.TX1.transducer.source = 'FF';
        
     % find-out what DAC's to use - disply as text on the GUI
    j=1;
    dac_array={'1   ';'2   ';'3   ';'4   ';'5   ';'6   ';'7   ';'8   ';...
    '9   ';'10   ';'11   ';'12   ';'13   ';'14   ';'15   ';'16   ';'17   ';'18   '};
 
    for i=1:1:18
        if (mdb.TX1.transducer.FF.DacVector(i) == 1)
            gui_staticText{j} = dac_array{i};
            %gui_staticText{j} = {strcat(char(dac_array(i)),{'    '})};
            j=j+1;
        end
    end
    gui_staticText = num2str(cell2mat(gui_staticText));
%     for i = 1:length(gui_staticText)
%         set( mdb.TX1.SelectedTranducerOutput_staticText_handle,'String',gui_staticText{i});
%         if (i == length(gui_staticText))
%             break;
%         else
%             set( mdb.TX1.SelectedTranducerOutput_staticText_handle,'String',gui_staticText{i+1});
%         end
%     end
    set( mdb.TX1.SelectedTranducerOutput_staticText_handle,'String',gui_staticText);    
    set( mdb.TX1.SelectedTranducerSource_staticText_handle,'String','FF Speakers');
   
                
    case 'AC'
        
         % set the new AC output vector to be the current vector for TX1
        for p=1:1:2
           mdb.TX1.transducer.AC.outputVector(p) =  mdb.main.transducer.AC.newOutputVector(p);
        end
        mdb.TX1.transducer.source = 'AC';
        
               
         % find-out what outputs to use - disply as text on the GUI
         t=1;
        output_array={'right ear';'left ear'};
        
        for q=1:1:2
            if (mdb.TX1.transducer.AC.outputVector(q) == 1)
                gui_staticText{t} = output_array{q};
                t=t+1;
            end
        end
        
        set( mdb.TX1.SelectedTranducerOutput_staticText_handle,'String',gui_staticText');
        set( mdb.TX1.SelectedTranducerSource_staticText_handle,'String','AC source');

        
    case 'BC'
        
        % set the new BC output vector to be the current vector for TX1
        for w=1:1:2
           mdb.TX1.transducer.BC.outputVector(w) =  mdb.main.transducer.BC.newOutputVector(w);
        end
        mdb.TX1.transducer.source = 'BC';
        
               
         % find-out what outputs to use - disply as text on the GUI
         v=1;
        output_array={'right ear';'left ear'};
        
        for x=1:1:2
            if (mdb.TX1.transducer.BC.outputVector(x) == 1)
                gui_staticText{v} = output_array{x};
                v=v+1;
            end
        end
        
        set( mdb.TX1.SelectedTranducerOutput_staticText_handle,'String',gui_staticText');
        set( mdb.TX1.SelectedTranducerSource_staticText_handle,'String','BC source');
               
end

save mdb mdb;
 


% --- Executes on button press in main_transducerSelect_TX2Set_pushbutton.
function main_transducerSelect_TX2Set_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to main_transducerSelect_TX2Set_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load mdb;

switch mdb.main.transducer.newSource
    case 'FF'
         % set the new FF DAC vector to be the current vector for TX2
        for k=1:1:18
           mdb.TX2.transducer.FF.DacVector(k) =  mdb.main.transducer.FF.newDacVector(k);
        end
        mdb.TX2.transducer.source = 'FF';
        
     % find-out what DAC's to use - disply as text on the GUI
    j=1;
    dac_array={'1   ';'2   ';'3   ';'4   ';'5   ';'6   ';'7   ';'8   ';...
    '9   ';'10   ';'11   ';'12   ';'13   ';'14   ';'15   ';'16   ';'17   ';'18   '};
 
    for i=1:1:18
        if (mdb.TX2.transducer.FF.DacVector(i) == 1)
            gui_staticText{j} = dac_array{i};
            j=j+1;
        end
    end
    gui_staticText = num2str(cell2mat(gui_staticText));
    set( mdb.TX2.SelectedTranducerOutput_staticText_handle,'String',gui_staticText);
    set( mdb.TX2.SelectedTranducerSource_staticText_handle,'String','FF Speakers');
                
        
    case 'AC'
        
         % set the new AC output vector to be the current vector for TX2
        for p=1:1:2
           mdb.TX2.transducer.AC.outputVector(p) =  mdb.main.transducer.AC.newOutputVector(p);
        end
        mdb.TX2.transducer.source = 'AC';
        
               
         % find-out what outputs to use - disply as text on the GUI
         t=1;
        output_array={'right ear';'left ear'};
        
        for q=1:1:2
            if (mdb.TX2.transducer.AC.outputVector(q) == 1)
                gui_staticText{t} = output_array{q};
                t=t+1;
            end
        end
        
        set( mdb.TX2.SelectedTranducerOutput_staticText_handle,'String',gui_staticText');
        set( mdb.TX2.SelectedTranducerSource_staticText_handle,'String','AC source');

        
    case 'BC'
        
        % set the new BC output vector to be the current vector for TX2
        for w=1:1:2
           mdb.TX2.transducer.BC.outputVector(w) =  mdb.main.transducer.BC.newOutputVector(w);
        end
        mdb.TX2.transducer.source = 'BC';
        
               
         % find-out what outputs to use - disply as text on the GUI
         v=1;
        output_array={'right ear';'left ear'};
        
        for x=1:1:2
            if (mdb.TX2.transducer.BC.outputVector(x) == 1)
                gui_staticText{v} = output_array{x};
                v=v+1;
            end
        end
        
        set( mdb.TX2.SelectedTranducerOutput_staticText_handle,'String',gui_staticText');
        set( mdb.TX2.SelectedTranducerSource_staticText_handle,'String','BC source');
               
end
 
save mdb mdb;
 

% --- Executes on button press in main_ACrightEar_checkBox.
function main_ACrightEar_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_ACrightEar_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_ACrightEar_checkBox

    load mdb;
     mdb.main.transducer.AC.newOutputVector(1) = get(hObject,'Value');
    save mdb mdb ;


% --- Executes on button press in main_ACleftEar_checkBox.
function main_ACleftEar_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_ACleftEar_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_ACleftEar_checkBox

    load mdb;
     mdb.main.transducer.AC.newOutputVector(2) = get(hObject,'Value');
    save mdb mdb ;


% --- Executes on button press in main_transducerSelect_TX3Set_pushbutton.
function main_transducerSelect_TX3Set_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to main_transducerSelect_TX3Set_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load mdb;

switch mdb.main.transducer.newSource
    case 'FF'
         % set the new FF DAC vector to be the current vector for TX3
        for k=1:1:18
           mdb.TX3.transducer.FF.DacVector(k) =  mdb.main.transducer.FF.newDacVector(k);
        end
        mdb.TX3.transducer.source = 'FF';
        
     % find-out what DAC's to use - disply as text on the GUI
    j=1;
    dac_array={'1   ';'2   ';'3   ';'4   ';'5   ';'6   ';'7   ';'8   ';...
    '9   ';'10   ';'11   ';'12   ';'13   ';'14   ';'15   ';'16   ';'17   ';'18   '};
 
    for i=1:1:18
        if (mdb.TX3.transducer.FF.DacVector(i) == 1)
            gui_staticText{j} = dac_array{i};
            j=j+1;
        end
    end
    gui_staticText = num2str(cell2mat(gui_staticText));
    set( mdb.TX3.SelectedTranducerOutput_staticText_handle,'String',gui_staticText);
    set( mdb.TX3.SelectedTranducerSource_staticText_handle,'String','FF Speakers');
                
        
    case 'AC'
        
         % set the new AC output vector to be the current vector for TX3
        for p=1:1:2
           mdb.TX3.transducer.AC.outputVector(p) =  mdb.main.transducer.AC.newOutputVector(p);
        end
        mdb.TX3.transducer.source = 'AC';
        
               
         % find-out what outputs to use - disply as text on the GUI
         t=1;
        output_array={'right ear';'left ear'};
        
        for q=1:1:2
            if (mdb.TX3.transducer.AC.outputVector(q) == 1)
                gui_staticText{t} = output_array{q};
                t=t+1;
            end
        end
        
        set( mdb.TX3.SelectedTranducerOutput_staticText_handle,'String',gui_staticText');
        set( mdb.TX3.SelectedTranducerSource_staticText_handle,'String','AC source');

        
    case 'BC'
        
        % set the new BC output vector to be the current vector for TX3
        for w=1:1:2
           mdb.TX3.transducer.BC.outputVector(w) =  mdb.main.transducer.BC.newOutputVector(w);
        end
        mdb.TX3.transducer.source = 'BC';
        
               
         % find-out what outputs to use - disply as text on the GUI
         v=1;
        output_array={'right ear';'left ear'};
        
        for x=1:1:2
            if (mdb.TX3.transducer.BC.outputVector(x) == 1)
                gui_staticText{v} = output_array{x};
                v=v+1;
            end
        end
        
        set( mdb.TX3.SelectedTranducerOutput_staticText_handle,'String',gui_staticText');
        set( mdb.TX3.SelectedTranducerSource_staticText_handle,'String','BC source');
               
end
 
save mdb mdb;



% --- Executes on button press in main_BCrightEar_checkBox.
function main_BCrightEar_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_BCrightEar_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_BCrightEar_checkBox

    load mdb;
    mdb.main.transducer.BC.newOutputVector(1) = get(hObject,'Value');
    save mdb mdb;


% --- Executes on button press in main_BCleftEar_checkBox.
function main_BCleftEar_checkBox_Callback(hObject, eventdata, handles)
% hObject    handle to main_BCleftEar_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_BCleftEar_checkBox

     load mdb;
    mdb.main.transducer.BC.newOutputVector(2) = get(hObject,'Value');
    save mdb mdb;

% ***************************** 
% ********* MAIN - CREATE FUNCTIONS ****************
%*****************************************


% --- Executes during object creation, after setting all properties.
function main_FFspeakers_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to main_FFspeakers_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    h=hObject;
    load mdb;
    mdb.main.FFspeakers_panel_handle = h;
    
    %start the DAC vector
    for i=1:1:18
        mdb.main.transducer.FF.newDacVector(i)=0;
    end
    
    save mdb mdb;
    
%     set(h,'Visible','off');


% --- Executes during object creation, after setting all properties.
function main_ACSource_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to main_ACSource_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    h=hObject;
    load mdb;
    mdb.main.ACSource_panel_handle=h;
    
    for i=1:1:2
         mdb.main.transducer.AC.newOutputVector(i) = 0;
    end
    
    save mdb mdb;
    
    set(h,'Visible','off');


% --- Executes during object creation, after setting all properties.
function main_BCSource_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to main_BCSource_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    h=hObject;
    load mdb;
    mdb.main.BCSource_panel_handle=h;
    
    for i=1:1:2
         mdb.main.transducer.BC.newOutputVector(i) = 0;
    end
    
    save mdb mdb;
    
    set(h,'Visible','off');


% --- Executes when selected object is changed in main_transducerSelect_panel.
function main_transducerSelect_panel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in main_transducerSelect_panel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

    val = get(eventdata.NewValue,'Tag') % Get Tag of selected object
    disp(val);
    switch get(eventdata.NewValue,'Tag') % Get Tag of selected object
        case 'main_transducerSelectFF_radioButton'
            load mdb;
            set(mdb.main.ACSource_panel_handle,'Visible','off');
            set(mdb.main.BCSource_panel_handle,'Visible','off');
            set(mdb.main.FFspeakers_panel_handle,'Visible','on');
            mdb.main.transducer.newSource = 'FF';
            save mdb mdb;
        case 'main_transducerSelectAC_radioButton'
            load mdb;
            set(mdb.main.FFspeakers_panel_handle,'Visible','off');
            set(mdb.main.BCSource_panel_handle,'Visible','off');
            set( mdb.main.ACSource_panel_handle,'Visible','on'); 
            mdb.main.transducer.newSource = 'AC';
            save mdb mdb;
        case 'main_transducerSelectBC_radioButton'
             load mdb;
             set(mdb.main.FFspeakers_panel_handle,'Visible','off');
             set(mdb.main.ACSource_panel_handle,'Visible','off');
             set(mdb.main.BCSource_panel_handle,'Visible','on');
             mdb.main.transducer.newSource = 'BC';
             save mdb mdb;
    end


% --- Executes during object creation, after setting all properties.
function TX2_selectedTransducerSource_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_selectedTransducerSource_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    handle=hObject;    
    set(hObject,'String','no selection');
    load mdb;
    mdb.TX2.SelectedTranducerSource_staticText_handle=handle;
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX1_selectedTransducerOutput_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_selectedTransducerOutput_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    handle=hObject;    
    set(hObject,'String','no selection');
    load mdb;
    mdb.TX1.SelectedTranducerOutput_staticText_handle=handle;
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_selectedTransducerSource_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_selectedTransducerSource_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    handle=hObject;    
    set(hObject,'String','no selection');
    load mdb;
    mdb.TX3.SelectedTranducerSource_staticText_handle=handle;
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_selectedTransducerOutput_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_selectedTransducerOutput_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    handle=hObject;    
    set(hObject,'String','no selection');
    load mdb;
    mdb.TX3.SelectedTranducerOutput_staticText_handle=handle;
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX2_transducer_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_transducer_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    load mdb;
    for i=1;1;18
         mdb.TX2.transducer.FF.DacVector(i) = 0;
    end
    
    for j=1;1;2
        mdb.TX2.transducer.AC.outputVector(j) = 0;
    end
    
    for k=1;1;2
        mdb.TX2.transducer.BC.outputVector(k) = 0;
    end
    
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX1_selectedTransducerSource_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_selectedTransducerSource_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    handle=hObject;    
    set(hObject,'String','no selection');
    load mdb;
    mdb.TX1.SelectedTranducerSource_staticText_handle=handle;
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function main_transducerSelect_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to main_transducerSelect_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    load mdb;
    mdb.main.transducer.newSource = 'NULL';
    mdb.TX1.transducer.source = 'NULL';
    mdb.TX2.transducer.source = 'NULL';
    mdb.TX3.transducer.source = 'NULL';
    
    
%    mdb.RP = Circuit_Loader('D:\Users\Adi_Dayan\TDT_multiChannel\full_3.rcx'); 
    
    save mdb mdb;
    


% --- Executes during object creation, after setting all properties.
function TX2_selectedTransducerOutput_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_selectedTransducerOutput_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    handle=hObject;    
    set(hObject,'String','no selection');
    load mdb;
    mdb.TX2.SelectedTranducerOutput_staticText_handle=handle;
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_transducer_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_transducer_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    load mdb;
    for i=1;1;18
         mdb.TX3.transducer.FF.DacVector(i) = 0;
    end
    
    for j=1;1;2
        mdb.TX3.transducer.AC.outputVector(j) = 0;
    end
    
    for k=1;1;2
        mdb.TX3.transducer.BC.outputVector(k) = 0;
    end
    
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX2_stimulusModulationFM_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_stimulusModulationFM_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

load mdb;
 mdb.TX2.stimulus.PT.modulationType = 3;  %no modulation
 save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_stimulusModulationFM_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_stimulusModulationFM_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

load mdb;
 mdb.TX3.stimulus.PT.modulationType = 3;  %no modulation
 save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX1_stimulusModulationAM_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_stimulusModulationAM_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function TX2_stimulusSelectSpeech_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_stimulusSelectSpeech_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    load mdb;
    mdb.TX2.stimulus.stimulusSelect.speech = 0;
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_stimulusSelectSpeech_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_stimulusSelectSpeech_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

   load mdb;
    mdb.TX3.stimulus.stimulusSelect.speech = 0;
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX2_stimulusSpeechSourceSelect_pushButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_stimulusSpeechSourceSelect_pushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

 load mdb;
 mdb.TX2.stimulus.speech.sourceSelectPushButton_handle = hObject;
 save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_stimulusSpeechSourceSelect_pushButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_stimulusSpeechSourceSelect_pushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

 load mdb;
 mdb.TX3.stimulus.speech.sourceSelectPushButton_handle = hObject;
 save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX2_stimulusSelectNoise_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_stimulusSelectNoise_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
    load mdb;
    mdb.TX2.stimulus.stimulusSelect.noise = 0;
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_stimulusSelectNoise_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_stimulusSelectNoise_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    load mdb;
    mdb.TX3.stimulus.stimulusSelect.noise = 0;
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX2_noiseSnrPT_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_noiseSnrPT_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

load mdb;
mdb.TX2.stimulus.noise.snrPT_staticText_handle = hObject;
save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_noiseSnrPT_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_noiseSnrPT_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

load mdb;
mdb.TX3.stimulus.noise.snrPT_staticText_handle = hObject;
save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX2_noiseSnrSpeech_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_noiseSnrSpeech_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

load mdb;
mdb.TX2.stimulus.noise.snrSpeech_staticText_handle = hObject;
save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX3_noiseSnrSpeech_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_noiseSnrSpeech_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

load mdb;
mdb.TX3.stimulus.noise.snrSpeech_staticText_handle = hObject;
save mdb mdb;


% --- Executes during object creation, after setting all properties.
function TX2_stimulus_noiseFilter_pannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_stimulus_noiseFilter_pannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

load mdb;
mdb.TX2.stimulus.noise.filterPannel_handle = hObject;
save mdb mdb;

set(hObject,'Visible','off');


% --- Executes during object creation, after setting all properties.
function TX3_stimulus_noiseFilter_pannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_stimulus_noiseFilter_pannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

load mdb;
mdb.TX3.stimulus.noise.filterPannel_handle = hObject;
save mdb mdb;

set(hObject,'Visible','off');


% --- Executes during object creation, after setting all properties.
function TX2_stimulusNoiseSourceFileName_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX2_stimulusNoiseSourceFileName_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

load mdb;
mdb.TX2.stimulus.noise.sourceFileName_staticText_handle = hObject;
save mdb mdb;
set(hObject,'Visible','off');


% --- Executes during object creation, after setting all properties.
function TX3_stimulusNoiseSourceFileName_staticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX3_stimulusNoiseSourceFileName_staticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

load mdb;
mdb.TX3.stimulus.noise.sourceFileName_staticText_handle = hObject;
save mdb mdb;
set(hObject,'Visible','off');


% --- Executes during object creation, after setting all properties.
function TX1_start_toggleButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX1_start_toggleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called






% --- Executes during object creation, after setting all properties.
function master_TX1_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to master_TX1_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    load mdb;
    mdb.master.TX1_select = 0;
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function master_TX2_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to master_TX2_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    load mdb;
    mdb.master.TX2_select = 0;
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function master_TX3_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to master_TX3_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    load mdb;
    mdb.master.TX3_select = 0;
    save mdb mdb;


% --- Executes during object creation, after setting all properties.
function master_start_toggleButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to master_start_toggleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    load mdb;
     mdb.master.TX1_playMode = 1; %default = single shot
     mdb.master.TX2_playMode = 1; %default = single shot
     mdb.master.TX3_playMode = 1; %default = single shot
     save mdb mdb;


% --- Executes during object creation, after setting all properties.
function master_mainMaster_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to master_mainMaster_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

global RP;
global whiteNoise_vector;
path = strcat(pwd,'\Copy_of_full_3.rcx');
[RP,status,message] = Circuit_Loader(path);
statusNumbers = bitget(status,[1 2 3])
if(  any(0 == statusNumbers ) )
   idx = find(0==statusNumbers);
   numOfError = idx(1);
   if(1 == numOfError)
      message = strcat(message,sprintf('\nPlease restart the DTD system'));
   end
   uiwait(msgbox(message,'Error','error'));
end
whiteNoise_vector = randn(1,3000000);


% 
% % --- Executes during object creation, after setting all properties.
% function main_FFDac9_checkBox_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to main_FFDac9_checkBox (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function main_FFDac9_checkBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to main_FFDac9_checkBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in SpeakersMapButton.
function SpeakersMapButton_Callback(hObject, eventdata, handles)
% hObject    handle to SpeakersMapButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
top = imread('Maps/SpeakersTop.jpg');
low = imread('Maps/SpeakersLow.jpg');
figure();
subplot(1,2,1);
imshow(top);
title('Speakers Numbers in top level');
subplot(1,2,2);
imshow(low);
title('Speakers Numbers in middle level');


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PP16Map.
function PP16Map_Callback(hObject, eventdata, handles)
% hObject    handle to PP16Map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I = imread('Maps/PP16Map.jpg');
figure();
imshow(I);

% 
% % --- Executes on button press in checkbox151.
% function checkbox151_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox151 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox151
% 
% 
% % --- Executes on button press in checkbox152.
% function checkbox152_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox152 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox152
% 
% 
% % --- Executes on button press in checkbox153.
% function checkbox153_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox153 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox153
% 
% 
% % --- Executes on button press in checkbox154.
% function checkbox154_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox154 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox154
% 
% 
% % --- Executes on button press in checkbox155.
% function checkbox155_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox155 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox155
% 
% 
% % --- Executes on button press in checkbox156.
% function checkbox156_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox156 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox156
% 
% 
% % --- Executes on button press in checkbox157.
% function checkbox157_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox157 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox157
% 
% 
% % --- Executes on button press in checkbox158.
% function checkbox158_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox158 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox158
% 
% 
% % --- Executes on button press in checkbox159.
% function checkbox159_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox159 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox159
% 
% 
% % --- Executes on button press in checkbox160.
% function checkbox160_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox160 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox160
% 
% 
% % --- Executes on button press in checkbox161.
% function checkbox161_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox161 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox161
% 
% 
% % --- Executes on button press in checkbox162.
% function checkbox162_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox162 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox162
% 
% 
% % --- Executes on button press in checkbox163.
% function checkbox163_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox163 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox163
% 
% 
% % --- Executes on button press in checkbox164.
% function checkbox164_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox164 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox164
% 
% 
% % --- Executes on button press in checkbox165.
% function checkbox165_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox165 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox165
% 
% 
% % --- Executes on button press in checkbox166.
% function checkbox166_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox166 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox166
% 
% 
% % --- Executes on button press in checkbox167.
% function checkbox167_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox167 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox167
% 
% 
% % --- Executes on button press in checkbox168.
% function checkbox168_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox168 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox168
% 
% 
% % --- Executes on button press in checkbox169.
% function checkbox169_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox169 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox169
% 
% 
% % --- Executes on button press in checkbox170.
% function checkbox170_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox170 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox170
% 
% 
% % --- Executes on button press in checkbox171.
% function checkbox171_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox171 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox171
% 
% 
% % --- Executes on button press in checkbox172.
% function checkbox172_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox172 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of checkbox172
% 
% 
% % --- Executes on button press in main_transducerSelectFF_radioButton.
% function main_transducerSelectFF_radioButton_Callback(hObject, eventdata, handles)
% % hObject    handle to main_transducerSelectFF_radioButton (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of main_transducerSelectFF_radioButton
% 


% --- Executes on button press in main_transducerSelectFF_radioButton.
function main_transducerSelectFF_radioButton_Callback(hObject, eventdata, handles)
% hObject    handle to main_transducerSelectFF_radioButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of
% main_transducerSelectFF_radioButton
    load mdb;
    set(mdb.main.ACSource_panel_handle,'Visible','off');
    set(mdb.main.BCSource_panel_handle,'Visible','off');
    set(mdb.main.FFspeakers_panel_handle,'Visible','on');
    mdb.main.transducer.newSource = 'FF';
    save mdb mdb;

