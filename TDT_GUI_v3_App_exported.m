classdef TDT_GUI_v3_App_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        MainTab                         matlab.ui.container.Tab
        InputSignal2TX2DropDown         matlab.ui.control.DropDown
        InputSignal2TX2DropDownLabel    matlab.ui.control.Label
        SummaryPanel                    matlab.ui.container.Panel
        RefreshButton                   matlab.ui.control.Button
        ExportButton                    matlab.ui.control.Button
        OutputSelection3Panel           matlab.ui.container.Panel
        TX3FF5                          matlab.ui.control.CheckBox
        TX3FF6                          matlab.ui.control.CheckBox
        TX3FF7                          matlab.ui.control.CheckBox
        TX3FF8                          matlab.ui.control.CheckBox
        TX3FF4                          matlab.ui.control.CheckBox
        TX3FF3                          matlab.ui.control.CheckBox
        TX3FF2                          matlab.ui.control.CheckBox
        TX3FF1                          matlab.ui.control.CheckBox
        InputSignal3TX3DropDown         matlab.ui.control.DropDown
        InputSignal3TX3DropDownLabel    matlab.ui.control.Label
        OptionsTX3Button                matlab.ui.control.Button
        OutputSelection2Panel           matlab.ui.container.Panel
        TX2FF5                          matlab.ui.control.CheckBox
        TX2FF6                          matlab.ui.control.CheckBox
        TX2FF7                          matlab.ui.control.CheckBox
        TX2FF8                          matlab.ui.control.CheckBox
        TX2FF4                          matlab.ui.control.CheckBox
        TX2FF3                          matlab.ui.control.CheckBox
        TX2FF2                          matlab.ui.control.CheckBox
        TX2FF1                          matlab.ui.control.CheckBox
        OptionsTX2Button                matlab.ui.control.Button
        StartButton                     matlab.ui.control.StateButton
        MapOfRoomSpeakersButton         matlab.ui.control.Button
        OptionsTX1Button                matlab.ui.control.Button
        OutputSelection1Panel           matlab.ui.container.Panel
        TX1FF5                          matlab.ui.control.CheckBox
        TX1FF6                          matlab.ui.control.CheckBox
        TX1FF7                          matlab.ui.control.CheckBox
        TX1FF8                          matlab.ui.control.CheckBox
        TX1FF4                          matlab.ui.control.CheckBox
        TX1FF3                          matlab.ui.control.CheckBox
        TX1FF2                          matlab.ui.control.CheckBox
        TX1FF1                          matlab.ui.control.CheckBox
        OutputPortsFFPanel              matlab.ui.container.Panel
        MapPortsButton                  matlab.ui.control.Button
        Label_8                         matlab.ui.control.Label
        Label_7                         matlab.ui.control.Label
        Label_6                         matlab.ui.control.Label
        Label_5                         matlab.ui.control.Label
        Label_4                         matlab.ui.control.Label
        Label_3                         matlab.ui.control.Label
        Label_2                         matlab.ui.control.Label
        Label                           matlab.ui.control.Label
        InputSignal1TX1DropDown         matlab.ui.control.DropDown
        InputSignal1TX1DropDownLabel    matlab.ui.control.Label
        BehaviorualTab                  matlab.ui.container.Tab
        ChooseFolderButton_Behavioral_2  matlab.ui.control.Button
        CheckBox_Behavioral             matlab.ui.control.CheckBox
        ModesDropDown_Behavioral        matlab.ui.control.DropDown
        ModesDropDownLabel              matlab.ui.control.Label
        Behavioral_description          matlab.ui.control.Label
        ChooseFolderButton_Behavioral   matlab.ui.control.Button
        BehavioralShadenLabel           matlab.ui.control.Label
        Panel_Behavioral                matlab.ui.container.Panel
        StartButton_Behavioral          matlab.ui.control.Button
        CUsersLabDocumentsButton_Behavioral  matlab.ui.control.Button
        OutputdirLabel_3                matlab.ui.control.Label
        NameoffolderEditField_Behavioral  matlab.ui.control.EditField
        NameoffolderEditField_2Label    matlab.ui.control.Label
        OutputSettingsLabel_Behavioral  matlab.ui.control.Label
        NoiseOutputSelectionPanel_2     matlab.ui.container.Panel
        SNRNoiseOutput5_2               matlab.ui.control.CheckBox
        SNRNoiseOutput6_2               matlab.ui.control.CheckBox
        SNRNoiseOutput7_2               matlab.ui.control.CheckBox
        SNRNoiseOutput8_2               matlab.ui.control.CheckBox
        SNRNoiseOutput4_2               matlab.ui.control.CheckBox
        SNRNoiseOutput3_2               matlab.ui.control.CheckBox
        SNRNoiseOutput2_2               matlab.ui.control.CheckBox
        SNRNoiseOutput1_2               matlab.ui.control.CheckBox
        NoisedBEditField_2              matlab.ui.control.NumericEditField
        NoisedBEditField_2Label         matlab.ui.control.Label
        SignaldBEditField_Behavioral    matlab.ui.control.NumericEditField
        SignaldBEditField_2Label        matlab.ui.control.Label
        SignalOutputSelectionPanel_Behavioral  matlab.ui.container.Panel
        SNRSignalOutput5_Behavioral     matlab.ui.control.CheckBox
        SNRSignalOutput6_Behavioral     matlab.ui.control.CheckBox
        SNRSignalOutput7_Behavioral     matlab.ui.control.CheckBox
        SNRSignalOutput8_Behavioral     matlab.ui.control.CheckBox
        SNRSignalOutput4_Behavioral     matlab.ui.control.CheckBox
        SNRSignalOutput3_Behavioral     matlab.ui.control.CheckBox
        SNRSignalOutput2_Behavioral     matlab.ui.control.CheckBox
        SNRSignalOutput1_Behavioral     matlab.ui.control.CheckBox
        StartingConditionsLabel_2       matlab.ui.control.Label
        OutputPortsFFPanel_4            matlab.ui.container.Panel
        Label_35                        matlab.ui.control.Label
        Label_34                        matlab.ui.control.Label
        Label_33                        matlab.ui.control.Label
        Label_32                        matlab.ui.control.Label
        Label_31                        matlab.ui.control.Label
        Label_30                        matlab.ui.control.Label
        Label_29                        matlab.ui.control.Label
        Label_28                        matlab.ui.control.Label
        EarEditField_Behavioral         matlab.ui.control.EditField
        EarEditField_3Label             matlab.ui.control.Label
        AgeEditField_Behavioral         matlab.ui.control.EditField
        AgeEditField_3Label             matlab.ui.control.Label
        TestNameEditField_Behavioral    matlab.ui.control.EditField
        TestNameEditField_3Label        matlab.ui.control.Label
        GenderEditField_Behavioral      matlab.ui.control.EditField
        GenderEditField_3Label          matlab.ui.control.Label
        NameEditField_Behavioral        matlab.ui.control.EditField
        NameEditField_3Label            matlab.ui.control.Label
        PersonalDetailsLabel_Behavioral  matlab.ui.control.Label
        SNRFinderTab                    matlab.ui.container.Tab
        ChoosenoiseaudiofileButton      matlab.ui.control.Button
        ChooseNoiseTypeButtonGroup      matlab.ui.container.ButtonGroup
        NoisefromfileButton             matlab.ui.control.RadioButton
        WhiteNoiseButton                matlab.ui.control.RadioButton
        infoButton                      matlab.ui.control.Button
        ChooseFolderButton              matlab.ui.control.Button
        Label_11                        matlab.ui.control.Label
        SNRFinderLabel                  matlab.ui.control.Label
        Panel                           matlab.ui.container.Panel
        TestNameEditField               matlab.ui.control.EditField
        TestNameEditFieldLabel          matlab.ui.control.Label
        EarEditField                    matlab.ui.control.EditField
        EarEditFieldLabel               matlab.ui.control.Label
        GenderEditField                 matlab.ui.control.EditField
        GenderEditFieldLabel            matlab.ui.control.Label
        AgeEditField                    matlab.ui.control.EditField
        AgeEditFieldLabel               matlab.ui.control.Label
        NameEditField                   matlab.ui.control.EditField
        NameEditFieldLabel              matlab.ui.control.Label
        PersonalDetailsLabel            matlab.ui.control.Label
        NameoffolderEditField           matlab.ui.control.EditField
        NameoffolderEditFieldLabel      matlab.ui.control.Label
        NoisedBEditField                matlab.ui.control.NumericEditField
        NoisedBEditFieldLabel           matlab.ui.control.Label
        SignaldBEditField               matlab.ui.control.NumericEditField
        SignaldBEditFieldLabel          matlab.ui.control.Label
        NoiseOutputSelectionPanel       matlab.ui.container.Panel
        SNRNoiseOutput5                 matlab.ui.control.CheckBox
        SNRNoiseOutput6                 matlab.ui.control.CheckBox
        SNRNoiseOutput7                 matlab.ui.control.CheckBox
        SNRNoiseOutput8                 matlab.ui.control.CheckBox
        SNRNoiseOutput4                 matlab.ui.control.CheckBox
        SNRNoiseOutput3                 matlab.ui.control.CheckBox
        SNRNoiseOutput2                 matlab.ui.control.CheckBox
        SNRNoiseOutput1                 matlab.ui.control.CheckBox
        SignalOutputSelectionPanel      matlab.ui.container.Panel
        SNRSignalOutput5                matlab.ui.control.CheckBox
        SNRSignalOutput6                matlab.ui.control.CheckBox
        SNRSignalOutput7                matlab.ui.control.CheckBox
        SNRSignalOutput8                matlab.ui.control.CheckBox
        SNRSignalOutput4                matlab.ui.control.CheckBox
        SNRSignalOutput3                matlab.ui.control.CheckBox
        SNRSignalOutput2                matlab.ui.control.CheckBox
        SNRSignalOutput1                matlab.ui.control.CheckBox
        OutputdirLabel                  matlab.ui.control.Label
        CUsersLabDocumentsButton        matlab.ui.control.Button
        OutputSettingsLabel             matlab.ui.control.Label
        StartingConditionsLabel         matlab.ui.control.Label
        StartButton_2                   matlab.ui.control.Button
        OutputPortsFFPanel_2            matlab.ui.container.Panel
        Label_19                        matlab.ui.control.Label
        Label_18                        matlab.ui.control.Label
        Label_17                        matlab.ui.control.Label
        Label_16                        matlab.ui.control.Label
        Label_15                        matlab.ui.control.Label
        Label_14                        matlab.ui.control.Label
        Label_13                        matlab.ui.control.Label
        Label_12                        matlab.ui.control.Label
        SpatialHearingTab               matlab.ui.container.Tab
        ChoosesignalwordsfolderButtonSpatialHearing  matlab.ui.control.Button
        ChooseSignalTypeButtonGroupSpatialHearing  matlab.ui.container.ButtonGroup
        WordsFolderButton               matlab.ui.control.RadioButton
        PureToneButton                  matlab.ui.control.RadioButton
        NoiseModeButtonGroup            matlab.ui.container.ButtonGroup
        FixedSpeakersnoiseoutputButton  matlab.ui.control.RadioButton
        NoiseoutputwithsignalspeakerButton  matlab.ui.control.RadioButton
        SpatialNoiseOutputSelectionPanel  matlab.ui.container.Panel
        SpatialSignalOutput5Noise       matlab.ui.control.CheckBox
        SpatialSignalOutput6Noise       matlab.ui.control.CheckBox
        SpatialSignalOutput7Noise       matlab.ui.control.CheckBox
        SpatialSignalOutput8Noise       matlab.ui.control.CheckBox
        SpatialSignalOutput4Noise       matlab.ui.control.CheckBox
        SpatialSignalOutput3Noise       matlab.ui.control.CheckBox
        SpatialSignalOutput2Noise       matlab.ui.control.CheckBox
        SpatialSignalOutput1Noise       matlab.ui.control.CheckBox
        ChoosenoiseaudiofileButtonSpatialHearing  matlab.ui.control.Button
        ChooseNoiseTypeButtonGroupSpatialHearing  matlab.ui.container.ButtonGroup
        NoisefromfileButton_2           matlab.ui.control.RadioButton
        WhiteNoiseButton_2              matlab.ui.control.RadioButton
        NameoffiileEditField_2          matlab.ui.control.EditField
        NameoffiileEditFieldLabel_2     matlab.ui.control.Label
        OutputdirLabel_2                matlab.ui.control.Label
        CUsersLabDocumentsButton_2      matlab.ui.control.Button
        OutputSettingsLabel_2           matlab.ui.control.Label
        PersonalDetailsLabel_2          matlab.ui.control.Label
        TestNameEditField_2             matlab.ui.control.EditField
        TestNameEditField_2Label        matlab.ui.control.Label
        EarEditField_2                  matlab.ui.control.EditField
        EarEditField_2Label             matlab.ui.control.Label
        GenderEditField_2               matlab.ui.control.EditField
        GenderEditField_2Label          matlab.ui.control.Label
        AgeEditField_2                  matlab.ui.control.EditField
        AgeEditField_2Label             matlab.ui.control.Label
        NameEditField_2                 matlab.ui.control.EditField
        NameEditField_2Label            matlab.ui.control.Label
        infoButton_2                    matlab.ui.control.Button
        DurationsecEditField            matlab.ui.control.NumericEditField
        DurationsecEditFieldLabel       matlab.ui.control.Label
        StartSpatialTestButton          matlab.ui.control.Button
        SignalFrequencyHzDropDown       matlab.ui.control.DropDown
        SignalFrequencyHzDropDownLabel  matlab.ui.control.Label
        OutputPortsFFPanel_3            matlab.ui.container.Panel
        Label_27                        matlab.ui.control.Label
        Label_26                        matlab.ui.control.Label
        Label_25                        matlab.ui.control.Label
        Label_24                        matlab.ui.control.Label
        Label_23                        matlab.ui.control.Label
        Label_22                        matlab.ui.control.Label
        Label_21                        matlab.ui.control.Label
        Label_20                        matlab.ui.control.Label
        SpatialSignalOutputSelectionPanel  matlab.ui.container.Panel
        SpatialSignalOutput5            matlab.ui.control.CheckBox
        SpatialSignalOutput6            matlab.ui.control.CheckBox
        SpatialSignalOutput7            matlab.ui.control.CheckBox
        SpatialSignalOutput8            matlab.ui.control.CheckBox
        SpatialSignalOutput4            matlab.ui.control.CheckBox
        SpatialSignalOutput3            matlab.ui.control.CheckBox
        SpatialSignalOutput2            matlab.ui.control.CheckBox
        SpatialSignalOutput1            matlab.ui.control.CheckBox
        SpatialNoisedbEditField         matlab.ui.control.NumericEditField
        NoisedBLabel                    matlab.ui.control.Label
        SpatialSignaldbEditField        matlab.ui.control.NumericEditField
        SignaldBLabel                   matlab.ui.control.Label
        SpatialStartingConditionsLabel  matlab.ui.control.Label
        ModeButtonGroup                 matlab.ui.container.ButtonGroup
        NoiseIncreasingNoiseButton      matlab.ui.control.RadioButton
        quiteNoNoisedecreasingsignalButton  matlab.ui.control.RadioButton
        SpatialHearingTestLabel         matlab.ui.control.Label
        CalibrationTab                  matlab.ui.container.Tab
        GainTable                       matlab.ui.control.Table
        Label_10                        matlab.ui.control.Label
        ImportButton_2                  matlab.ui.control.Button
        CalibExportButton_2             matlab.ui.control.Button
        FFOutput7EditField              matlab.ui.control.NumericEditField
        FFOutput7EditFieldLabel         matlab.ui.control.Label
        FFOutput8EditField              matlab.ui.control.NumericEditField
        FFOutput8EditFieldLabel         matlab.ui.control.Label
        FFOutput6EditField              matlab.ui.control.NumericEditField
        FFOutput6EditFieldLabel         matlab.ui.control.Label
        FFOutput5EditField              matlab.ui.control.NumericEditField
        FFOutput5EditFieldLabel         matlab.ui.control.Label
        FFOutput3EditField              matlab.ui.control.NumericEditField
        FFOutput3EditFieldLabel         matlab.ui.control.Label
        FFOutput4EditField              matlab.ui.control.NumericEditField
        FFOutput4EditFieldLabel         matlab.ui.control.Label
        FFOutput2EditField              matlab.ui.control.NumericEditField
        FFOutput2EditFieldLabel         matlab.ui.control.Label
        Label_9                         matlab.ui.control.Label
        SpeakersLabel                   matlab.ui.control.Label
        FFOutput1EditField              matlab.ui.control.NumericEditField
        FFOutput1EditFieldLabel         matlab.ui.control.Label
        CalibExportButton               matlab.ui.control.Button
        ImportButton                    matlab.ui.control.Button
        AboutTab                        matlab.ui.container.Tab
        TDTGUIv3appwasdevelopedinLabel_3  matlab.ui.control.Label
        TDTGUIv3appwasdevelopedinLabel_2  matlab.ui.control.Label
        TDTGUIv3appwasdevelopedinLabel  matlab.ui.control.Label
        FlowExperimentBetaTab           matlab.ui.container.Tab
        GenerateExpreimentButton        matlab.ui.control.Button
        PlayPauseButton                 matlab.ui.control.StateButton
        ImportExcelButton               matlab.ui.control.StateButton
        HereyouwillabletorunexpreimentLabel  matlab.ui.control.Label
    end

    
    properties (Access = private)
        expriementPool % For background expreiment 
        fileExperiment % future file expriement for parllell computing
        OutputPath % Description
        online = 0 % will block running without TDT if online=1
        print
        
       
      
    end
    
    properties (Access = public)
        TX1Options 
        TX2Options 
        TX3Options 
        noiseFromFileFlag = 0 
    end
    
    
    methods (Access = private)
        
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.online = ~isfile('./OFFLINE');
            global RP;
            global whiteNoise_vector;
            % global parameters;
               
            % save parameters;
            path = strcat(pwd,'\Copy_of_full_5.rcx');
            [RP,status,message] = Circuit_Loader(path);
            statusNumbers = bitget(status,[1 2 3]);
            if(  any(0 == statusNumbers ) )
               idx = find(0==statusNumbers);
               numOfError = idx(1);
               if(1 == numOfError)
                  message = strcat(message,sprintf('\nPlease restart the DTD system'));
               end
               selection = uiconfirm(app.UIFigure,message,'Error','Icon','error','Options',{'Ok'});
               if(app.online)
%                  close all force;
                   quit force
               end
            end
            Initialize_Selection("TX1");
            Initialize_Selection("TX2");
            Initialize_Selection("TX3");
%             Update_Calibration(RP);
            load mdb;
            %update calibration tab screen
            arrayfun(@(ii) setfield(app,strcat('FFOutput',num2str(ii),'EditField'),'Value',mdb.Calibration.FF2SpeakerMap(ii))  , [1:8]);

            app.GainTable.Data = mdb.Calibration.GainTable;
            whiteNoise_vector = randn(1,3000000);
            
        end

        % Button pushed function: MapPortsButton
        function MapPortsButtonPushed(app, event)
            I = imread('Maps/PP16Map.jpg');
            figure();
            imshow(I);
        end

        % Value changed function: InputSignal1TX1DropDown
        function InputSignal1TX1DropDownValueChanged(app, event)
            value = app.InputSignal1TX1DropDown.Value;
            DropValueChangedHelper(app,"TX1",value);
        end

        % Value changed function: TX1FF1
        function TX1FF1ValueChanged(app, event)
            value = app.TX1FF1.Value;
            DacVectorTransducerHelper(app,"TX1",1,value);
        end

        % Value changed function: TX1FF2
        function TX1FF2ValueChanged(app, event)
            value = app.TX1FF2.Value;
             DacVectorTransducerHelper(app,"TX1",2,value);
        end

        % Value changed function: TX1FF3
        function TX1FF3ValueChanged(app, event)
            value = app.TX1FF3.Value;
             DacVectorTransducerHelper(app,"TX1",3,value);
        end

        % Value changed function: TX1FF4
        function TX1FF4ValueChanged(app, event)
            value = app.TX1FF4.Value;
             DacVectorTransducerHelper(app,"TX1",4,value);
        end

        % Value changed function: TX1FF5
        function TX1FF5ValueChanged(app, event)
            value = app.TX1FF5.Value;
             DacVectorTransducerHelper(app,"TX1",5,value);
        end

        % Value changed function: TX1FF6
        function TX1FF6ValueChanged(app, event)
            value = app.TX1FF6.Value;
             DacVectorTransducerHelper(app,"TX1",6,value);
        end

        % Value changed function: TX1FF7
        function TX1FF7ValueChanged(app, event)
            value = app.TX1FF7.Value;
             DacVectorTransducerHelper(app,"TX1",7,value);
        end

        % Value changed function: TX1FF8
        function TX1FF8ValueChanged(app, event)
            value = app.TX1FF8.Value;
            DacVectorTransducerHelper(app,"TX1",8,value);
        end

        % Button pushed function: OptionsTX1Button
        function OptionsTX1ButtonPushed(app, event)
            OptionsMenuOpenerHelper(app,1);
        end

        % Button pushed function: MapOfRoomSpeakersButton
        function MapOfRoomSpeakersButtonPushed(app, event)
            top = imread('Maps/SpeakersTop.jpg');
            horizontal = imread('Maps/SpeakersLow.jpg');
            figure();
            subplot(1,2,1);
            imshow(top);
            title('Speakers Numbers in top level');
            subplot(1,2,2);
            imshow(horizontal);
            title('Speakers Numbers in horizontal level');
        end

        % Value changed function: StartButton
        function StartButtonValueChanged(app, event)
            value = app.StartButton.Value;
            if(1 == value )
                status = PrepareMdb(app);
                if(1 ==  status)
                    app.StartButton.Text = "Pause";
                    load mdb
                    [TX1_playMode,TX2_playMode,TX3_playMode] = play_signal_multi(mdb.master.TX1_select,mdb.master.TX2_select,mdb.master.TX3_select); 
                end
                
            %TODO: check if needed    
            %     if (TX1_playMode &&  TX2_playMode &&  TX3_playMode)  %single shot
            %         set(hObject,'String','start'); %reset button
            %         set(hObject,'Value',0);
            %     end
            
            else
                app.StartButton.Text = "Start";
                TXall_stop_signal();
            end
            
        end

        % Value changed function: InputSignal2TX2DropDown
        function InputSignal2TX2DropDownValueChanged(app, event)
            value = app.InputSignal2TX2DropDown.Value;
            DropValueChangedHelper(app,"TX2",value);
        end

        % Button pushed function: OptionsTX2Button
        function OptionsTX2ButtonPushed(app, event)
              OptionsMenuOpenerHelper(app,2);
        end

        % Value changed function: TX2FF1
        function TX2FF1ValueChanged(app, event)
            value = app.TX2FF1.Value;
            DacVectorTransducerHelper(app,"TX2",1,value);
        end

        % Value changed function: TX2FF2
        function TX2FF2ValueChanged(app, event)
            value = app.TX2FF2.Value;
            DacVectorTransducerHelper(app,"TX2",2,value);
        end

        % Value changed function: TX2FF3
        function TX2FF3ValueChanged(app, event)
            value = app.TX2FF3.Value;
            DacVectorTransducerHelper(app,"TX2",3,value);
        end

        % Value changed function: TX2FF4
        function TX2FF4ValueChanged(app, event)
            value = app.TX2FF4.Value;
            DacVectorTransducerHelper(app,"TX2",4,value);
        end

        % Value changed function: TX2FF5
        function TX2FF5ValueChanged(app, event)
            value = app.TX2FF5.Value;
            DacVectorTransducerHelper(app,"TX2",5,value);
        end

        % Value changed function: TX2FF6
        function TX2FF6ValueChanged(app, event)
            value = app.TX2FF6.Value;
            DacVectorTransducerHelper(app,"TX2",6,value);
        end

        % Value changed function: TX2FF7
        function TX2FF7ValueChanged(app, event)
            value = app.TX2FF7.Value;
            DacVectorTransducerHelper(app,"TX2",7,value);
        end

        % Value changed function: TX2FF8
        function TX2FF8ValueChanged(app, event)
            value = app.TX2FF8.Value;
            DacVectorTransducerHelper(app,"TX2",8,value);
        end

        % Value changed function: TX3FF1
        function TX3FF1ValueChanged(app, event)
            value = app.TX3FF1.Value;
             DacVectorTransducerHelper(app,"TX3",1,value);
        end

        % Value changed function: TX3FF2
        function TX3FF2ValueChanged(app, event)
            value = app.TX3FF2.Value;
            DacVectorTransducerHelper(app,"TX3",2,value);
        end

        % Value changed function: TX3FF3
        function TX3FF3ValueChanged(app, event)
            value = app.TX3FF3.Value;
            DacVectorTransducerHelper(app,"TX3",3,value);
        end

        % Value changed function: TX3FF4
        function TX3FF4ValueChanged(app, event)
            value = app.TX3FF4.Value;
            DacVectorTransducerHelper(app,"TX3",4,value);
        end

        % Value changed function: TX3FF5
        function TX3FF5ValueChanged(app, event)
            value = app.TX3FF5.Value;
            DacVectorTransducerHelper(app,"TX3",5,value);
        end

        % Value changed function: TX3FF6
        function TX3FF6ValueChanged(app, event)
            value = app.TX3FF6.Value;
            DacVectorTransducerHelper(app,"TX3",6,value);
            
        end

        % Value changed function: TX3FF7
        function TX3FF7ValueChanged(app, event)
            value = app.TX3FF7.Value;
            DacVectorTransducerHelper(app,"TX3",7,value);
        end

        % Value changed function: TX3FF8
        function TX3FF8ValueChanged(app, event)
            value = app.TX3FF8.Value;
            DacVectorTransducerHelper(app,"TX3",8,value);
        end

        % Value changed function: InputSignal3TX3DropDown
        function InputSignal3TX3DropDownValueChanged(app, event)
            value = app.InputSignal3TX3DropDown.Value;
            DropValueChangedHelper(app,"TX3",value);

        end

        % Button pushed function: OptionsTX3Button
        function OptionsTX3ButtonPushed(app, event)
             OptionsMenuOpenerHelper(app,3);
        end

        % Button pushed function: ExportButton
        function ExportButtonPushed(app, event)
%             TODO Add Logic for export button
        end

        % Value changed function: ImportExcelButton
        function ImportExcelButtonValueChanged(app, event)
            value = app.ImportExcelButton.Value;
           [FileName,PathName,FilterIndex] = uigetfile('Documents\*.xlsx');
                   if(FileName == 0)
                       return;
                   end
           
           app.fileExperiment  = fullfile(PathName,FileName);
%            app.scriptExperiment = readcell(fullfile(PathName,FileName));
           app.ImportExcelButton.Text = FileName;
           app.PlayPauseButton.Enable = 1;
           
        end

        % Value changed function: PlayPauseButton
        function PlayPauseButtonValueChanged(app, event)
            value = app.PlayPauseButton.Value;
            if(0 == value)

                %TODO make resart and resume buttons
                %TODO make it non-blocking function https://www.mathworks.com/help/parallel-computing/parallel.pool.parfeval.html#mw_130ecf71-d0dc-485c-b230-99fc0e9107e7
                app.PlayPauseButton.Text = 'Pause';
                HandleExpriement(readcell(app.fileExperiment),app.PlayPauseButton);
%                 app.expriementPool = parfeval(@HandleExpriement,0, app.scriptExperiment,app.PlayPauseButton);
            elseif(1 == value)
                app.PlayPauseButton.Text = 'Start';
%                 cancel(app.expriementPool);
            end
                
        end

        % Button pushed function: CalibExportButton
        function CalibExportButtonPushed(app, event)
%           gains = arrayfun(@(ii) getfield(app,strcat('Speaker',num2str(ii),'Spinner'),'Value')  , [1:18]);
            [file, path] = uiputfile(strcat('C:\Users\Lab\Documents\Gain of Speakers - ',date,'.xlsx'));
%             T = table([1:18]',gains');
            load mdb;
            T = mdb.Calibration.GainTable;
%             T.Properties.VariableNames = ["Speaker Number","Gain (db)"];
            writetable(T,fullfile(path,file) ,'Sheet',1,'Range','A1');
        end

        % Value changed function: FFOutput1EditField
        function FFOutput1EditFieldValueChanged(app, event)
            value = app.FFOutput1EditField.Value;
            UpdateFF2SpeakerMap(1,value);
        end

        % Value changed function: FFOutput2EditField
        function FFOutput2EditFieldValueChanged(app, event)
            value = app.FFOutput2EditField.Value;
            UpdateFF2SpeakerMap(2,value);
        end

        % Value changed function: FFOutput3EditField
        function FFOutput3EditFieldValueChanged(app, event)
            value = app.FFOutput3EditField.Value;
            UpdateFF2SpeakerMap(3,value);
        end

        % Value changed function: FFOutput4EditField
        function FFOutput4EditFieldValueChanged(app, event)
            value = app.FFOutput4EditField.Value;
            UpdateFF2SpeakerMap(4,value);
        end

        % Value changed function: FFOutput5EditField
        function FFOutput5EditFieldValueChanged(app, event)
            value = app.FFOutput5EditField.Value;
            UpdateFF2SpeakerMap(5,value);
        end

        % Value changed function: FFOutput6EditField
        function FFOutput6EditFieldValueChanged(app, event)
            value = app.FFOutput6EditField.Value;
            UpdateFF2SpeakerMap(6,value);
        end

        % Value changed function: FFOutput7EditField
        function FFOutput7EditFieldValueChanged(app, event)
            value = app.FFOutput7EditField.Value;
            UpdateFF2SpeakerMap(7,value);
        end

        % Value changed function: FFOutput8EditField
        function FFOutput8EditFieldValueChanged(app, event)
            value = app.FFOutput8EditField.Value;
            UpdateFF2SpeakerMap(8,value);
        end

        % Button pushed function: CalibExportButton_2
        function CalibExportButton_2Pushed(app, event)
            map = arrayfun(@(ii) getfield(app,strcat('FFOutput',num2str(ii),'EditField'),'Value')  , [1:8]);
            [file, path] = uiputfile(strcat('C:\Users\Lab\Documents\Map of FF2Speakers - ',date,'.xlsx'));
            T = table([1:8]',map');
            T.Properties.VariableNames = ["FF Channel Number","Speaker Number Mapping"];
            writetable(T,fullfile(path,file) ,'Sheet',1,'Range','A1');
        end

        % Button pushed function: ImportButton
        function ImportButtonPushed(app, event)
             [FileName,PathName] = uigetfile('Documents\*.xlsx');
             T = readtable(fullfile(PathName,FileName));
             if( height(T) ~= 18 || width(T)~= 6 )
               errordlg('Not a speakers gain file format.','Invalid File format');
               return;
             end
             T.Properties.VariableNames = ["250Hz","500Hz","1000Hz","2000Hz","4000Hz","Noise"];
             load mdb;
             mdb.Calibration.GainTable = T;
             app.GainTable.Data = T;
             save mdb mdb;
             global RP;
             Update_Calibration(RP);
             
        end

        % Button pushed function: ImportButton_2
        function ImportButton_2Pushed(app, event)
             [FileName,PathName] = uigetfile('Documents\*.xlsx');
             T = readtable(fullfile(PathName,FileName));
             if(length(T.SpeakerNumberMapping) ~= 8 )
               errordlg('Not a FF to speaker map file format.','Invalid File format');
               return;
             end
             load mdb;
             mdb.Calibration.FF2SpeakerMap= T.SpeakerNumberMapping';
%              arrayfun(@(ii) setfield(app,strcat('FFOutput',num2str(ii),'EditField'),'Value',mdb.Calibration.FF2SpeakerMap(ii))  , [1:8]);
             for ii=1:8
                 app.(strcat('FFOutput',num2str(ii),'EditField')).Value = mdb.Calibration.FF2SpeakerMap(ii);
             end
             save mdb mdb;
             global RP;
             Update_Calibration(RP);
             
        end

        % Button pushed function: ChooseFolderButton
        function ChooseFolderButtonPushed(app, event)
              app.ChooseFolderButton.Text =  uigetdir('C:\Users\Lab\Documents\Words Files\');
              app.Panel.Enable = 'on';
        end

        % Button pushed function: CUsersLabDocumentsButton
        function CUsersLabDocumentsButtonPushed(app, event)
            app.OutputPath = uigetdir('C:\Users\Lab\Documents');
        end

        % Button pushed function: StartButton_2
        function StartButton_2Pushed(app, event)
            if(app.NoisefromfileButton.Value==1 && strcmp(app.ChoosenoiseaudiofileButton.Text,"Choose noise audio file"))
                uialert(app.UIFigure,"Please choose noise file","No noise file chosen!");
                return;
            end
            if(7 == exist(fullfile(app.CUsersLabDocumentsButton.Text,app.NameoffolderEditField.Value),'dir'))
                uialert(app.UIFigure,'There is already folder with this name. Please change the name of folder','Duplicated folder name');
                return;
            end
               %add externel noise support from file (also if it is in mp3
               %file), test if the mp3 file can work at all
               SNRFinderHelper2(app); 
            
        end

        % Selection change function: TabGroup
        function TabGroupSelectionChanged(app, event)
            selectedTab = app.TabGroup.SelectedTab;
            Initialize_Selection("TX1");
            Initialize_Selection("TX2");
            Initialize_Selection("TX3");          
            switch selectedTab.Title
                case 'SNR Finder'
                    app.NameoffolderEditField.Value = replace(char(datetime) ,':','-');
                    app.noiseFromFileFlag = app.NoisefromfileButton.Value;
                case 'Spatial Hearing'
                    app.NameoffiileEditField_2.Value = replace(char(datetime) ,':','-');
%                     app.noiseFromFileFlag = app.NoisefromfileButton.Value;
                case 'Main'
                    
            end         
        end

        % Button pushed function: RefreshButton
        function RefreshButtonPushed(app, event)
            arrayfun(@(x) delete(x), app.print);
            PrepareMdb(app);
            load mdb
            s = PrintData(mdb);
            UIlabels = arrayfun(@(ii) uilabel(app.SummaryPanel,"Text",s(ii),'Position',[15+250*(ii-1) 20 200 100],'WordWrap',"off"),[1:length(s)]);
            app.print = UIlabels;
        end

        % Button pushed function: infoButton
        function infoButtonPushed(app, event)
            text = "SNR Finder is automatic process of finding the Signal Noise difference of a person. While the signal is .wav audio files that are taken from the selected folder The algorithem can be described like this: 1.Phase one, starting with rounds of 2 .wav files (number can be changed) - jump step in Noise is 10dB. Finding the threshold which person is less then 100% success rate. 2.Round of 4 words, and the goal is finding the 50% success. if success was more then 50% then inscresing noise , else if less then 50% success then decreasing the noise. step size of Noise is reduced in each round (10dB to 5dB to 2dB to 1dB)."
                % Create a figure window
                figure;
                
                % Create a text box with the text inside
                uicontrol('Style','text','String',text,'Units','normalized','Position',[0.1 0.1 0.8 0.8],'HorizontalAlignment','left','FontSize',12);
      
        end

        % Button pushed function: GenerateExpreimentButton
        function GenerateExpreimentButtonPushed(app, event)
            ExpreimentGenerator();
        end

        % Selection changed function: ModeButtonGroup
        function ModeButtonGroupSelectionChanged(app, event)
            selectedButton = app.ModeButtonGroup.SelectedObject;
            if(app.NoiseIncreasingNoiseButton.Value)
                [app.SpatialNoisedbEditField.Enable,...
                app.ChooseNoiseTypeButtonGroupSpatialHearing.Enable,...
                app.NoiseModeButtonGroup.Enable]=deal('on','on','on');
            else 
                [app.SpatialNoisedbEditField.Enable,...
                app.ChooseNoiseTypeButtonGroupSpatialHearing.Enable,...
                app.NoiseModeButtonGroup.Enable]=deal('off','off','off');
            end
%             app.SpatialNoisedbEditField.Enable=app.NoiseIncreasingNoiseButton.Value;
%             app.ChooseNoiseTypeButtonGroupSpatialHearing.Visible = app.NoiseIncreasingNoiseButton.Value;
%             app.ChooseNoiseTypeButtonGroupSpatialHearing.Enable= app.NoiseIncreasingNoiseButton.Value;
        end

        % Button pushed function: StartSpatialTestButton
        function StartSpatialTestButtonPushed(app, event)
            if(7 == exist(fullfile(app.CUsersLabDocumentsButton_2.Text,app.NameoffiileEditField_2.Value),'dir'))
                uialert(app.UIFigure,'There is already folder with this name. Please change the name of folder','Duplicated folder name');
                return;
            end
            SpatialHearingTestHelper(app);
        end

        % Button pushed function: infoButton_2
        function infoButton_2Pushed(app, event)
            % Define the text as a string variable
                text = 'This test is designed to help you find the best speaker for your localization. You will listen to a series of sounds from different speakers and rate how well you can locate them. The sounds will vary in loudness, and they will be mixed with background white noise. The test will measure the signal-to-noise ratio (SNR) for each speaker, which is the difference between the sound level of the signal and the noise. The lower the SNR, the better you can hear the signal over the noise. The test will compare the SNR results for all the speakers and tell you which one has the lowerest SNR for you. This means that you can hear the sounds more clearly and comfortably with that speaker. ';
                
                % Create a figure window
                figure;
                
                % Create a text box with the text inside
                uicontrol('Style','text','String',text,'Units','normalized','Position',[0.1 0.1 0.8 0.8],'HorizontalAlignment','left','FontSize',12);
        end

        % Button pushed function: CUsersLabDocumentsButton_2
        function CUsersLabDocumentsButton_2Pushed(app, event)
            app.CUsersLabDocumentsButton_2.Text = uigetdir('C:\Users\Lab\Documents');
        end

        % Selection changed function: ChooseNoiseTypeButtonGroup
        function ChooseNoiseTypeButtonGroupSelectionChanged(app, event)
            selectedButton = app.ChooseNoiseTypeButtonGroup.SelectedObject;
            if(strcmp(selectedButton.Text,"Noise from file"))
                app.ChoosenoiseaudiofileButton.Enable = 'on';
%                 app.ChoosenoiseaudiofileButton.Visible = "on";
            else
                app.ChoosenoiseaudiofileButton.Enable= 'off';
%                 app.ChoosenoiseaudiofileButton.Visible = "off";
                
            end
            app.noiseFromFileFlag = app.NoisefromfileButton.Value;
        end

        % Button pushed function: ChoosenoiseaudiofileButton
        function ChoosenoiseaudiofileButtonPushed(app, event)
            
            [file,path] = uigetfile("C:\Users\Lab\Documents\Noise\*");
            app.ChoosenoiseaudiofileButton.Text = fullfile(path,file);
        end

        % Selection changed function: 
        % ChooseNoiseTypeButtonGroupSpatialHearing
        function ChooseNoiseTypeButtonGroupSpatialHearingSelectionChanged(app, event)
            selectedButton = app.ChooseNoiseTypeButtonGroupSpatialHearing.SelectedObject;
            if(app.NoisefromfileButton_2.Value)
             app.ChoosenoiseaudiofileButtonSpatialHearing.Enable = 'on';
            else
                app.ChoosenoiseaudiofileButtonSpatialHearing.Enable = 'off';
            end
            app.noiseFromFileFlag = app.NoisefromfileButton_2.Value;
        end

        % Button pushed function: ChoosenoiseaudiofileButtonSpatialHearing
        function ChoosenoiseaudiofileButtonSpatialHearingPushed(app, event)
            [file,path] = uigetfile("C:\Users\Lab\Documents\Noise\*");
            app.ChoosenoiseaudiofileButtonSpatialHearing.Text = fullfile(path,file);
        end

        % Selection changed function: NoiseModeButtonGroup
        function NoiseModeButtonGroupSelectionChanged(app, event)
            selectedButton = app.NoiseModeButtonGroup.SelectedObject;
            if(app.FixedSpeakersnoiseoutputButton.Value)
                app.SpatialNoiseOutputSelectionPanel.Enable = 'on';
            else
                app.SpatialNoiseOutputSelectionPanel.Enable = 'off';
            end
        end

        % Selection changed function: 
        % ChooseSignalTypeButtonGroupSpatialHearing
        function ChooseSignalTypeButtonGroupSpatialHearingSelectionChanged(app, event)
            selectedButton = app.ChooseSignalTypeButtonGroupSpatialHearing.SelectedObject;
            app.SignalFrequencyHzDropDown.Enable = app.PureToneButton.Value;
             app.DurationsecEditField.Enable = app.PureToneButton.Value;
             app.ChoosesignalwordsfolderButtonSpatialHearing.Enable = app.WordsFolderButton.Value;
             
        end

        % Button pushed function: 
        % ChoosesignalwordsfolderButtonSpatialHearing
        function ChoosesignalwordsfolderButtonSpatialHearingPushed(app, event)
            app.ChoosesignalwordsfolderButtonSpatialHearing.Text =  uigetdir('C:\Users\Lab\Documents\Words Files\');
        end

        % Button pushed function: ChooseFolderButton_Behavioral
        function ChooseFolderButton_BehavioralPushed(app, event)
              app.ChooseFolderButton_Behavioral.Text =  uigetdir('C:\Users\Lab\Documents\CVC Words\Testing');
              app.Panel.Enable = 'on';
        end

        % Button pushed function: StartButton_Behavioral
        function StartButton_BehavioralPushed(app, event)
            app.StartButton_Behavioral.Enable = "off"
            try
            PrepareBehavioralMdb(app)
            BehavioralMain(app)
            app.StartButton_Behavioral.Enable = "on";
            
            catch e
                app.StartButton_Behavioral.Enable = "on";
                 fprintf(2, 'Error occurred: %s\n', e.message);
                 for i = 1:length(e.stack)                                                                          
                     fprintf(2, 'File: %s, Name: %s, Line: %d\n', e.stack(i).file, e.stack(i).name, e.stack(i).line);  
                 end
            end

        end

        % Value changed function: ModesDropDown_Behavioral
        function ModesDropDown_BehavioralValueChanged(app, event)
            value = app.ModesDropDown_Behavioral.Value;
            if strcmp(value,"Noise - 0 or 90")
                app.NoisedBEditField_2.Visible = "on";
                app.NoiseOutputSelectionPanel_2.Visible = "on";
                app.ChooseFolderButton_Behavioral_2.Visible = "on";
            else
                app.NoisedBEditField_2.Visible = "off";
                app.NoiseOutputSelectionPanel_2.Visible = "off"; 
                app.ChooseFolderButton_Behavioral_2.Visible = "off";

            end
        end

        % Button pushed function: ChooseFolderButton_Behavioral_2
        function ChooseFolderButton_Behavioral_2Pushed(app, event)
            app.ChooseFolderButton_Behavioral.Text =  uigetfile('C:\Users\Lab\Documents\Noise\*.*');

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.UIFigure.Position = [100 100 922 700];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.SelectionChangedFcn = createCallbackFcn(app, @TabGroupSelectionChanged, true);
            app.TabGroup.Position = [1 -1 922 702];

            % Create MainTab
            app.MainTab = uitab(app.TabGroup);
            app.MainTab.Title = 'Main';
            app.MainTab.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.MainTab.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];

            % Create InputSignal1TX1DropDownLabel
            app.InputSignal1TX1DropDownLabel = uilabel(app.MainTab);
            app.InputSignal1TX1DropDownLabel.HorizontalAlignment = 'right';
            app.InputSignal1TX1DropDownLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.InputSignal1TX1DropDownLabel.Position = [11 554 112 22];
            app.InputSignal1TX1DropDownLabel.Text = 'Input Signal 1 (TX1)';

            % Create InputSignal1TX1DropDown
            app.InputSignal1TX1DropDown = uidropdown(app.MainTab);
            app.InputSignal1TX1DropDown.Items = {'None', 'Pure Tune', 'Noise', 'From File'};
            app.InputSignal1TX1DropDown.ValueChangedFcn = createCallbackFcn(app, @InputSignal1TX1DropDownValueChanged, true);
            app.InputSignal1TX1DropDown.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.InputSignal1TX1DropDown.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InputSignal1TX1DropDown.Position = [164 543 116 44];
            app.InputSignal1TX1DropDown.Value = 'None';

            % Create OutputPortsFFPanel
            app.OutputPortsFFPanel = uipanel(app.MainTab);
            app.OutputPortsFFPanel.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.OutputPortsFFPanel.Title = 'Output Ports (FF)';
            app.OutputPortsFFPanel.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OutputPortsFFPanel.Position = [311 612 579 49];

            % Create Label
            app.Label = uilabel(app.OutputPortsFFPanel);
            app.Label.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label.Position = [21 7 25 22];
            app.Label.Text = '1';

            % Create Label_2
            app.Label_2 = uilabel(app.OutputPortsFFPanel);
            app.Label_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_2.Position = [86 7 25 22];
            app.Label_2.Text = '2';

            % Create Label_3
            app.Label_3 = uilabel(app.OutputPortsFFPanel);
            app.Label_3.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_3.Position = [216 7 25 22];
            app.Label_3.Text = '4';

            % Create Label_4
            app.Label_4 = uilabel(app.OutputPortsFFPanel);
            app.Label_4.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_4.Position = [151 7 25 22];
            app.Label_4.Text = '3';

            % Create Label_5
            app.Label_5 = uilabel(app.OutputPortsFFPanel);
            app.Label_5.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_5.Position = [476 7 25 22];
            app.Label_5.Text = '8';

            % Create Label_6
            app.Label_6 = uilabel(app.OutputPortsFFPanel);
            app.Label_6.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_6.Position = [411 7 25 22];
            app.Label_6.Text = '7';

            % Create Label_7
            app.Label_7 = uilabel(app.OutputPortsFFPanel);
            app.Label_7.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_7.Position = [346 7 25 22];
            app.Label_7.Text = '6';

            % Create Label_8
            app.Label_8 = uilabel(app.OutputPortsFFPanel);
            app.Label_8.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_8.Position = [281 7 25 22];
            app.Label_8.Text = '5';

            % Create MapPortsButton
            app.MapPortsButton = uibutton(app.OutputPortsFFPanel, 'push');
            app.MapPortsButton.ButtonPushedFcn = createCallbackFcn(app, @MapPortsButtonPushed, true);
            app.MapPortsButton.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.MapPortsButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.MapPortsButton.Position = [511 9 60 20];
            app.MapPortsButton.Text = 'Map';

            % Create OutputSelection1Panel
            app.OutputSelection1Panel = uipanel(app.MainTab);
            app.OutputSelection1Panel.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.OutputSelection1Panel.Title = 'Output Selection 1';
            app.OutputSelection1Panel.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OutputSelection1Panel.Position = [311 517 579 80];

            % Create TX1FF1
            app.TX1FF1 = uicheckbox(app.OutputSelection1Panel);
            app.TX1FF1.ValueChangedFcn = createCallbackFcn(app, @TX1FF1ValueChanged, true);
            app.TX1FF1.Text = '';
            app.TX1FF1.Position = [21 6 17 24];

            % Create TX1FF2
            app.TX1FF2 = uicheckbox(app.OutputSelection1Panel);
            app.TX1FF2.ValueChangedFcn = createCallbackFcn(app, @TX1FF2ValueChanged, true);
            app.TX1FF2.Text = '';
            app.TX1FF2.Position = [86 6 17 24];

            % Create TX1FF3
            app.TX1FF3 = uicheckbox(app.OutputSelection1Panel);
            app.TX1FF3.ValueChangedFcn = createCallbackFcn(app, @TX1FF3ValueChanged, true);
            app.TX1FF3.Text = '';
            app.TX1FF3.Position = [151 6 17 24];

            % Create TX1FF4
            app.TX1FF4 = uicheckbox(app.OutputSelection1Panel);
            app.TX1FF4.ValueChangedFcn = createCallbackFcn(app, @TX1FF4ValueChanged, true);
            app.TX1FF4.Text = '';
            app.TX1FF4.Position = [216 5 17 24];

            % Create TX1FF8
            app.TX1FF8 = uicheckbox(app.OutputSelection1Panel);
            app.TX1FF8.ValueChangedFcn = createCallbackFcn(app, @TX1FF8ValueChanged, true);
            app.TX1FF8.Text = '';
            app.TX1FF8.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX1FF8.Position = [476 6 17 24];

            % Create TX1FF7
            app.TX1FF7 = uicheckbox(app.OutputSelection1Panel);
            app.TX1FF7.ValueChangedFcn = createCallbackFcn(app, @TX1FF7ValueChanged, true);
            app.TX1FF7.Text = '';
            app.TX1FF7.Position = [411 6 17 24];

            % Create TX1FF6
            app.TX1FF6 = uicheckbox(app.OutputSelection1Panel);
            app.TX1FF6.ValueChangedFcn = createCallbackFcn(app, @TX1FF6ValueChanged, true);
            app.TX1FF6.Text = '';
            app.TX1FF6.Position = [346 6 17 24];

            % Create TX1FF5
            app.TX1FF5 = uicheckbox(app.OutputSelection1Panel);
            app.TX1FF5.ValueChangedFcn = createCallbackFcn(app, @TX1FF5ValueChanged, true);
            app.TX1FF5.Text = '';
            app.TX1FF5.Position = [281 6 17 24];

            % Create OptionsTX1Button
            app.OptionsTX1Button = uibutton(app.MainTab, 'push');
            app.OptionsTX1Button.ButtonPushedFcn = createCallbackFcn(app, @OptionsTX1ButtonPushed, true);
            app.OptionsTX1Button.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OptionsTX1Button.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.OptionsTX1Button.Enable = 'off';
            app.OptionsTX1Button.Position = [211 516 69 21];
            app.OptionsTX1Button.Text = 'Options';

            % Create MapOfRoomSpeakersButton
            app.MapOfRoomSpeakersButton = uibutton(app.MainTab, 'push');
            app.MapOfRoomSpeakersButton.ButtonPushedFcn = createCallbackFcn(app, @MapOfRoomSpeakersButtonPushed, true);
            app.MapOfRoomSpeakersButton.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.MapOfRoomSpeakersButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.MapOfRoomSpeakersButton.Position = [607 37 144 47];
            app.MapOfRoomSpeakersButton.Text = 'Map Of Room Speakers';

            % Create StartButton
            app.StartButton = uibutton(app.MainTab, 'state');
            app.StartButton.ValueChangedFcn = createCallbackFcn(app, @StartButtonValueChanged, true);
            app.StartButton.Text = 'Start';
            app.StartButton.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.StartButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.StartButton.Position = [779 37 103 47];

            % Create OptionsTX2Button
            app.OptionsTX2Button = uibutton(app.MainTab, 'push');
            app.OptionsTX2Button.ButtonPushedFcn = createCallbackFcn(app, @OptionsTX2ButtonPushed, true);
            app.OptionsTX2Button.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OptionsTX2Button.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.OptionsTX2Button.Enable = 'off';
            app.OptionsTX2Button.Position = [211 395 69 21];
            app.OptionsTX2Button.Text = 'Options';

            % Create OutputSelection2Panel
            app.OutputSelection2Panel = uipanel(app.MainTab);
            app.OutputSelection2Panel.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.OutputSelection2Panel.Title = 'Output Selection 2';
            app.OutputSelection2Panel.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OutputSelection2Panel.Position = [311 396 579 80];

            % Create TX2FF1
            app.TX2FF1 = uicheckbox(app.OutputSelection2Panel);
            app.TX2FF1.ValueChangedFcn = createCallbackFcn(app, @TX2FF1ValueChanged, true);
            app.TX2FF1.Text = '';
            app.TX2FF1.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX2FF1.Position = [21 6 17 24];

            % Create TX2FF2
            app.TX2FF2 = uicheckbox(app.OutputSelection2Panel);
            app.TX2FF2.ValueChangedFcn = createCallbackFcn(app, @TX2FF2ValueChanged, true);
            app.TX2FF2.Text = '';
            app.TX2FF2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX2FF2.Position = [86 6 17 24];

            % Create TX2FF3
            app.TX2FF3 = uicheckbox(app.OutputSelection2Panel);
            app.TX2FF3.ValueChangedFcn = createCallbackFcn(app, @TX2FF3ValueChanged, true);
            app.TX2FF3.Text = '';
            app.TX2FF3.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX2FF3.Position = [151 6 17 24];

            % Create TX2FF4
            app.TX2FF4 = uicheckbox(app.OutputSelection2Panel);
            app.TX2FF4.ValueChangedFcn = createCallbackFcn(app, @TX2FF4ValueChanged, true);
            app.TX2FF4.Text = '';
            app.TX2FF4.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX2FF4.Position = [216 5 17 24];

            % Create TX2FF8
            app.TX2FF8 = uicheckbox(app.OutputSelection2Panel);
            app.TX2FF8.ValueChangedFcn = createCallbackFcn(app, @TX2FF8ValueChanged, true);
            app.TX2FF8.Text = '';
            app.TX2FF8.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX2FF8.Position = [476 6 17 24];

            % Create TX2FF7
            app.TX2FF7 = uicheckbox(app.OutputSelection2Panel);
            app.TX2FF7.ValueChangedFcn = createCallbackFcn(app, @TX2FF7ValueChanged, true);
            app.TX2FF7.Text = '';
            app.TX2FF7.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX2FF7.Position = [411 6 17 24];

            % Create TX2FF6
            app.TX2FF6 = uicheckbox(app.OutputSelection2Panel);
            app.TX2FF6.ValueChangedFcn = createCallbackFcn(app, @TX2FF6ValueChanged, true);
            app.TX2FF6.Text = '';
            app.TX2FF6.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX2FF6.Position = [346 6 17 24];

            % Create TX2FF5
            app.TX2FF5 = uicheckbox(app.OutputSelection2Panel);
            app.TX2FF5.ValueChangedFcn = createCallbackFcn(app, @TX2FF5ValueChanged, true);
            app.TX2FF5.Text = '';
            app.TX2FF5.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX2FF5.Position = [281 6 17 24];

            % Create OptionsTX3Button
            app.OptionsTX3Button = uibutton(app.MainTab, 'push');
            app.OptionsTX3Button.ButtonPushedFcn = createCallbackFcn(app, @OptionsTX3ButtonPushed, true);
            app.OptionsTX3Button.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OptionsTX3Button.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.OptionsTX3Button.Enable = 'off';
            app.OptionsTX3Button.Position = [211 275 69 21];
            app.OptionsTX3Button.Text = 'Options';

            % Create InputSignal3TX3DropDownLabel
            app.InputSignal3TX3DropDownLabel = uilabel(app.MainTab);
            app.InputSignal3TX3DropDownLabel.HorizontalAlignment = 'right';
            app.InputSignal3TX3DropDownLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.InputSignal3TX3DropDownLabel.Position = [11 313 112 22];
            app.InputSignal3TX3DropDownLabel.Text = 'Input Signal 3 (TX3)';

            % Create InputSignal3TX3DropDown
            app.InputSignal3TX3DropDown = uidropdown(app.MainTab);
            app.InputSignal3TX3DropDown.Items = {'None', 'Pure Tune', 'Noise', 'From File'};
            app.InputSignal3TX3DropDown.ValueChangedFcn = createCallbackFcn(app, @InputSignal3TX3DropDownValueChanged, true);
            app.InputSignal3TX3DropDown.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.InputSignal3TX3DropDown.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InputSignal3TX3DropDown.Position = [164 302 116 44];
            app.InputSignal3TX3DropDown.Value = 'None';

            % Create OutputSelection3Panel
            app.OutputSelection3Panel = uipanel(app.MainTab);
            app.OutputSelection3Panel.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.OutputSelection3Panel.Title = 'Output Selection 3';
            app.OutputSelection3Panel.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OutputSelection3Panel.Position = [311 266 579 80];

            % Create TX3FF1
            app.TX3FF1 = uicheckbox(app.OutputSelection3Panel);
            app.TX3FF1.ValueChangedFcn = createCallbackFcn(app, @TX3FF1ValueChanged, true);
            app.TX3FF1.Text = '';
            app.TX3FF1.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX3FF1.Position = [21 6 17 24];

            % Create TX3FF2
            app.TX3FF2 = uicheckbox(app.OutputSelection3Panel);
            app.TX3FF2.ValueChangedFcn = createCallbackFcn(app, @TX3FF2ValueChanged, true);
            app.TX3FF2.Text = '';
            app.TX3FF2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX3FF2.Position = [86 6 17 24];

            % Create TX3FF3
            app.TX3FF3 = uicheckbox(app.OutputSelection3Panel);
            app.TX3FF3.ValueChangedFcn = createCallbackFcn(app, @TX3FF3ValueChanged, true);
            app.TX3FF3.Text = '';
            app.TX3FF3.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX3FF3.Position = [151 6 17 24];

            % Create TX3FF4
            app.TX3FF4 = uicheckbox(app.OutputSelection3Panel);
            app.TX3FF4.ValueChangedFcn = createCallbackFcn(app, @TX3FF4ValueChanged, true);
            app.TX3FF4.Text = '';
            app.TX3FF4.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX3FF4.Position = [216 5 17 24];

            % Create TX3FF8
            app.TX3FF8 = uicheckbox(app.OutputSelection3Panel);
            app.TX3FF8.ValueChangedFcn = createCallbackFcn(app, @TX3FF8ValueChanged, true);
            app.TX3FF8.Text = '';
            app.TX3FF8.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX3FF8.Position = [476 6 17 24];

            % Create TX3FF7
            app.TX3FF7 = uicheckbox(app.OutputSelection3Panel);
            app.TX3FF7.ValueChangedFcn = createCallbackFcn(app, @TX3FF7ValueChanged, true);
            app.TX3FF7.Text = '';
            app.TX3FF7.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX3FF7.Position = [411 6 17 24];

            % Create TX3FF6
            app.TX3FF6 = uicheckbox(app.OutputSelection3Panel);
            app.TX3FF6.ValueChangedFcn = createCallbackFcn(app, @TX3FF6ValueChanged, true);
            app.TX3FF6.Text = '';
            app.TX3FF6.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX3FF6.Position = [346 6 17 24];

            % Create TX3FF5
            app.TX3FF5 = uicheckbox(app.OutputSelection3Panel);
            app.TX3FF5.ValueChangedFcn = createCallbackFcn(app, @TX3FF5ValueChanged, true);
            app.TX3FF5.Text = '';
            app.TX3FF5.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TX3FF5.Position = [281 6 17 24];

            % Create ExportButton
            app.ExportButton = uibutton(app.MainTab, 'push');
            app.ExportButton.ButtonPushedFcn = createCallbackFcn(app, @ExportButtonPushed, true);
            app.ExportButton.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ExportButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.ExportButton.Position = [48 37 84 36];
            app.ExportButton.Text = 'Export';

            % Create RefreshButton
            app.RefreshButton = uibutton(app.MainTab, 'push');
            app.RefreshButton.ButtonPushedFcn = createCallbackFcn(app, @RefreshButtonPushed, true);
            app.RefreshButton.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.RefreshButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.RefreshButton.Position = [158 37 84 36];
            app.RefreshButton.Text = 'Refresh';

            % Create SummaryPanel
            app.SummaryPanel = uipanel(app.MainTab);
            app.SummaryPanel.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SummaryPanel.Title = 'Summary';
            app.SummaryPanel.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SummaryPanel.Position = [22 97 861 155];

            % Create InputSignal2TX2DropDownLabel
            app.InputSignal2TX2DropDownLabel = uilabel(app.MainTab);
            app.InputSignal2TX2DropDownLabel.HorizontalAlignment = 'right';
            app.InputSignal2TX2DropDownLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.InputSignal2TX2DropDownLabel.Position = [11 433 112 22];
            app.InputSignal2TX2DropDownLabel.Text = 'Input Signal 2 (TX2)';

            % Create InputSignal2TX2DropDown
            app.InputSignal2TX2DropDown = uidropdown(app.MainTab);
            app.InputSignal2TX2DropDown.Items = {'None', 'Pure Tune', 'Noise', 'From File'};
            app.InputSignal2TX2DropDown.ValueChangedFcn = createCallbackFcn(app, @InputSignal2TX2DropDownValueChanged, true);
            app.InputSignal2TX2DropDown.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.InputSignal2TX2DropDown.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InputSignal2TX2DropDown.Position = [164 422 116 44];
            app.InputSignal2TX2DropDown.Value = 'None';

            % Create BehaviorualTab
            app.BehaviorualTab = uitab(app.TabGroup);
            app.BehaviorualTab.Title = 'Behaviorual';

            % Create Panel_Behavioral
            app.Panel_Behavioral = uipanel(app.BehaviorualTab);
            app.Panel_Behavioral.Title = 'Panel';
            app.Panel_Behavioral.Position = [25 37 861 487];

            % Create PersonalDetailsLabel_Behavioral
            app.PersonalDetailsLabel_Behavioral = uilabel(app.Panel_Behavioral);
            app.PersonalDetailsLabel_Behavioral.FontSize = 15;
            app.PersonalDetailsLabel_Behavioral.FontWeight = 'bold';
            app.PersonalDetailsLabel_Behavioral.Position = [19 446 122 22];
            app.PersonalDetailsLabel_Behavioral.Text = 'Personal Details';

            % Create NameEditField_3Label
            app.NameEditField_3Label = uilabel(app.Panel_Behavioral);
            app.NameEditField_3Label.Position = [24 390 55 22];
            app.NameEditField_3Label.Text = 'Name';

            % Create NameEditField_Behavioral
            app.NameEditField_Behavioral = uieditfield(app.Panel_Behavioral, 'text');
            app.NameEditField_Behavioral.Position = [94 384 107 34];

            % Create GenderEditField_3Label
            app.GenderEditField_3Label = uilabel(app.Panel_Behavioral);
            app.GenderEditField_3Label.Position = [233 390 55 22];
            app.GenderEditField_3Label.Text = 'Gender';

            % Create GenderEditField_Behavioral
            app.GenderEditField_Behavioral = uieditfield(app.Panel_Behavioral, 'text');
            app.GenderEditField_Behavioral.Position = [303 384 107 34];

            % Create TestNameEditField_3Label
            app.TestNameEditField_3Label = uilabel(app.Panel_Behavioral);
            app.TestNameEditField_3Label.Position = [444 390 63 22];
            app.TestNameEditField_3Label.Text = 'Test Name';

            % Create TestNameEditField_Behavioral
            app.TestNameEditField_Behavioral = uieditfield(app.Panel_Behavioral, 'text');
            app.TestNameEditField_Behavioral.Position = [514 384 107 34];

            % Create AgeEditField_3Label
            app.AgeEditField_3Label = uilabel(app.Panel_Behavioral);
            app.AgeEditField_3Label.Position = [24 352 55 22];
            app.AgeEditField_3Label.Text = 'Age';

            % Create AgeEditField_Behavioral
            app.AgeEditField_Behavioral = uieditfield(app.Panel_Behavioral, 'text');
            app.AgeEditField_Behavioral.Position = [94 346 107 34];

            % Create EarEditField_3Label
            app.EarEditField_3Label = uilabel(app.Panel_Behavioral);
            app.EarEditField_3Label.Position = [233 352 55 22];
            app.EarEditField_3Label.Text = 'Ear';

            % Create EarEditField_Behavioral
            app.EarEditField_Behavioral = uieditfield(app.Panel_Behavioral, 'text');
            app.EarEditField_Behavioral.Position = [303 346 107 34];

            % Create OutputPortsFFPanel_4
            app.OutputPortsFFPanel_4 = uipanel(app.Panel_Behavioral);
            app.OutputPortsFFPanel_4.Title = 'Output Ports (FF)';
            app.OutputPortsFFPanel_4.Position = [304 282 509 49];

            % Create Label_28
            app.Label_28 = uilabel(app.OutputPortsFFPanel_4);
            app.Label_28.Position = [21 7 25 22];
            app.Label_28.Text = '1';

            % Create Label_29
            app.Label_29 = uilabel(app.OutputPortsFFPanel_4);
            app.Label_29.Position = [86 7 25 22];
            app.Label_29.Text = '2';

            % Create Label_30
            app.Label_30 = uilabel(app.OutputPortsFFPanel_4);
            app.Label_30.Position = [216 7 25 22];
            app.Label_30.Text = '4';

            % Create Label_31
            app.Label_31 = uilabel(app.OutputPortsFFPanel_4);
            app.Label_31.Position = [151 7 25 22];
            app.Label_31.Text = '3';

            % Create Label_32
            app.Label_32 = uilabel(app.OutputPortsFFPanel_4);
            app.Label_32.Position = [476 7 25 22];
            app.Label_32.Text = '8';

            % Create Label_33
            app.Label_33 = uilabel(app.OutputPortsFFPanel_4);
            app.Label_33.Position = [411 7 25 22];
            app.Label_33.Text = '7';

            % Create Label_34
            app.Label_34 = uilabel(app.OutputPortsFFPanel_4);
            app.Label_34.Position = [346 7 25 22];
            app.Label_34.Text = '6';

            % Create Label_35
            app.Label_35 = uilabel(app.OutputPortsFFPanel_4);
            app.Label_35.Position = [281 7 25 22];
            app.Label_35.Text = '5';

            % Create StartingConditionsLabel_2
            app.StartingConditionsLabel_2 = uilabel(app.Panel_Behavioral);
            app.StartingConditionsLabel_2.FontSize = 15;
            app.StartingConditionsLabel_2.FontWeight = 'bold';
            app.StartingConditionsLabel_2.Position = [26 241 145 22];
            app.StartingConditionsLabel_2.Text = 'Starting Conditions';

            % Create SignalOutputSelectionPanel_Behavioral
            app.SignalOutputSelectionPanel_Behavioral = uipanel(app.Panel_Behavioral);
            app.SignalOutputSelectionPanel_Behavioral.Title = 'Signal Output Selection';
            app.SignalOutputSelectionPanel_Behavioral.Position = [311 188 508 69];

            % Create SNRSignalOutput1_Behavioral
            app.SNRSignalOutput1_Behavioral = uicheckbox(app.SignalOutputSelectionPanel_Behavioral);
            app.SNRSignalOutput1_Behavioral.Text = '';
            app.SNRSignalOutput1_Behavioral.Position = [22 11 17 24];

            % Create SNRSignalOutput2_Behavioral
            app.SNRSignalOutput2_Behavioral = uicheckbox(app.SignalOutputSelectionPanel_Behavioral);
            app.SNRSignalOutput2_Behavioral.Text = '';
            app.SNRSignalOutput2_Behavioral.Position = [87 11 17 24];

            % Create SNRSignalOutput3_Behavioral
            app.SNRSignalOutput3_Behavioral = uicheckbox(app.SignalOutputSelectionPanel_Behavioral);
            app.SNRSignalOutput3_Behavioral.Text = '';
            app.SNRSignalOutput3_Behavioral.Position = [152 11 17 24];

            % Create SNRSignalOutput4_Behavioral
            app.SNRSignalOutput4_Behavioral = uicheckbox(app.SignalOutputSelectionPanel_Behavioral);
            app.SNRSignalOutput4_Behavioral.Text = '';
            app.SNRSignalOutput4_Behavioral.Position = [217 10 17 24];

            % Create SNRSignalOutput8_Behavioral
            app.SNRSignalOutput8_Behavioral = uicheckbox(app.SignalOutputSelectionPanel_Behavioral);
            app.SNRSignalOutput8_Behavioral.Text = '';
            app.SNRSignalOutput8_Behavioral.Position = [477 11 17 24];
            app.SNRSignalOutput8_Behavioral.Value = true;

            % Create SNRSignalOutput7_Behavioral
            app.SNRSignalOutput7_Behavioral = uicheckbox(app.SignalOutputSelectionPanel_Behavioral);
            app.SNRSignalOutput7_Behavioral.Text = '';
            app.SNRSignalOutput7_Behavioral.Position = [412 11 17 24];

            % Create SNRSignalOutput6_Behavioral
            app.SNRSignalOutput6_Behavioral = uicheckbox(app.SignalOutputSelectionPanel_Behavioral);
            app.SNRSignalOutput6_Behavioral.Text = '';
            app.SNRSignalOutput6_Behavioral.Position = [347 11 17 24];

            % Create SNRSignalOutput5_Behavioral
            app.SNRSignalOutput5_Behavioral = uicheckbox(app.SignalOutputSelectionPanel_Behavioral);
            app.SNRSignalOutput5_Behavioral.Text = '';
            app.SNRSignalOutput5_Behavioral.Position = [282 11 17 24];

            % Create SignaldBEditField_2Label
            app.SignaldBEditField_2Label = uilabel(app.Panel_Behavioral);
            app.SignaldBEditField_2Label.HorizontalAlignment = 'right';
            app.SignaldBEditField_2Label.Position = [16 198 65 22];
            app.SignaldBEditField_2Label.Text = 'Signal (dB)';

            % Create SignaldBEditField_Behavioral
            app.SignaldBEditField_Behavioral = uieditfield(app.Panel_Behavioral, 'numeric');
            app.SignaldBEditField_Behavioral.Position = [96 191 48 35];
            app.SignaldBEditField_Behavioral.Value = 60;

            % Create NoisedBEditField_2Label
            app.NoisedBEditField_2Label = uilabel(app.Panel_Behavioral);
            app.NoisedBEditField_2Label.HorizontalAlignment = 'right';
            app.NoisedBEditField_2Label.Position = [18 145 62 22];
            app.NoisedBEditField_2Label.Text = 'Noise (dB)';

            % Create NoisedBEditField_2
            app.NoisedBEditField_2 = uieditfield(app.Panel_Behavioral, 'numeric');
            app.NoisedBEditField_2.Visible = 'off';
            app.NoisedBEditField_2.Position = [95 138 49 35];
            app.NoisedBEditField_2.Value = 50;

            % Create NoiseOutputSelectionPanel_2
            app.NoiseOutputSelectionPanel_2 = uipanel(app.Panel_Behavioral);
            app.NoiseOutputSelectionPanel_2.Title = 'Noise Output Selection';
            app.NoiseOutputSelectionPanel_2.Visible = 'off';
            app.NoiseOutputSelectionPanel_2.Position = [311 108 508 69];

            % Create SNRNoiseOutput1_2
            app.SNRNoiseOutput1_2 = uicheckbox(app.NoiseOutputSelectionPanel_2);
            app.SNRNoiseOutput1_2.Text = '';
            app.SNRNoiseOutput1_2.Position = [22 11 17 24];

            % Create SNRNoiseOutput2_2
            app.SNRNoiseOutput2_2 = uicheckbox(app.NoiseOutputSelectionPanel_2);
            app.SNRNoiseOutput2_2.Text = '';
            app.SNRNoiseOutput2_2.Position = [87 11 17 24];

            % Create SNRNoiseOutput3_2
            app.SNRNoiseOutput3_2 = uicheckbox(app.NoiseOutputSelectionPanel_2);
            app.SNRNoiseOutput3_2.Text = '';
            app.SNRNoiseOutput3_2.Position = [152 11 17 24];

            % Create SNRNoiseOutput4_2
            app.SNRNoiseOutput4_2 = uicheckbox(app.NoiseOutputSelectionPanel_2);
            app.SNRNoiseOutput4_2.Text = '';
            app.SNRNoiseOutput4_2.Position = [217 10 17 24];

            % Create SNRNoiseOutput8_2
            app.SNRNoiseOutput8_2 = uicheckbox(app.NoiseOutputSelectionPanel_2);
            app.SNRNoiseOutput8_2.Text = '';
            app.SNRNoiseOutput8_2.Position = [477 11 17 24];

            % Create SNRNoiseOutput7_2
            app.SNRNoiseOutput7_2 = uicheckbox(app.NoiseOutputSelectionPanel_2);
            app.SNRNoiseOutput7_2.Text = '';
            app.SNRNoiseOutput7_2.Position = [412 11 17 24];

            % Create SNRNoiseOutput6_2
            app.SNRNoiseOutput6_2 = uicheckbox(app.NoiseOutputSelectionPanel_2);
            app.SNRNoiseOutput6_2.Text = '';
            app.SNRNoiseOutput6_2.Position = [347 11 17 24];

            % Create SNRNoiseOutput5_2
            app.SNRNoiseOutput5_2 = uicheckbox(app.NoiseOutputSelectionPanel_2);
            app.SNRNoiseOutput5_2.Text = '';
            app.SNRNoiseOutput5_2.Position = [282 11 17 24];

            % Create OutputSettingsLabel_Behavioral
            app.OutputSettingsLabel_Behavioral = uilabel(app.Panel_Behavioral);
            app.OutputSettingsLabel_Behavioral.FontSize = 15;
            app.OutputSettingsLabel_Behavioral.FontWeight = 'bold';
            app.OutputSettingsLabel_Behavioral.Position = [26 108 118 22];
            app.OutputSettingsLabel_Behavioral.Text = 'Output Settings';

            % Create NameoffolderEditField_2Label
            app.NameoffolderEditField_2Label = uilabel(app.Panel_Behavioral);
            app.NameoffolderEditField_2Label.HorizontalAlignment = 'right';
            app.NameoffolderEditField_2Label.Position = [26 70 84 22];
            app.NameoffolderEditField_2Label.Text = 'Name of folder';

            % Create NameoffolderEditField_Behavioral
            app.NameoffolderEditField_Behavioral = uieditfield(app.Panel_Behavioral, 'text');
            app.NameoffolderEditField_Behavioral.Position = [125 63 105 36];

            % Create OutputdirLabel_3
            app.OutputdirLabel_3 = uilabel(app.Panel_Behavioral);
            app.OutputdirLabel_3.Position = [329 68 105 26];
            app.OutputdirLabel_3.Text = 'Output dir';

            % Create CUsersLabDocumentsButton_Behavioral
            app.CUsersLabDocumentsButton_Behavioral = uibutton(app.Panel_Behavioral, 'push');
            app.CUsersLabDocumentsButton_Behavioral.Position = [409 59 182 42];
            app.CUsersLabDocumentsButton_Behavioral.Text = 'C:\Users\Lab\Documents';

            % Create StartButton_Behavioral
            app.StartButton_Behavioral = uibutton(app.Panel_Behavioral, 'push');
            app.StartButton_Behavioral.ButtonPushedFcn = createCallbackFcn(app, @StartButton_BehavioralPushed, true);
            app.StartButton_Behavioral.Position = [663 16 150 44];
            app.StartButton_Behavioral.Text = 'Start';

            % Create BehavioralShadenLabel
            app.BehavioralShadenLabel = uilabel(app.BehaviorualTab);
            app.BehavioralShadenLabel.FontSize = 18;
            app.BehavioralShadenLabel.Position = [33 617 169 43];
            app.BehavioralShadenLabel.Text = 'Behavioral (Shaden)';

            % Create ChooseFolderButton_Behavioral
            app.ChooseFolderButton_Behavioral = uibutton(app.BehaviorualTab, 'push');
            app.ChooseFolderButton_Behavioral.ButtonPushedFcn = createCallbackFcn(app, @ChooseFolderButton_BehavioralPushed, true);
            app.ChooseFolderButton_Behavioral.Position = [635 586 181 40];
            app.ChooseFolderButton_Behavioral.Text = 'Choose Folder';

            % Create Behavioral_description
            app.Behavioral_description = uilabel(app.BehaviorualTab);
            app.Behavioral_description.WordWrap = 'on';
            app.Behavioral_description.Position = [32 579 580 54];
            app.Behavioral_description.Text = 'Please choose folder directory which include at least 32 .wav audio files that contains cvc word, it has to be with number in the begnning for each word. for example ("1 - word.wav").';

            % Create ModesDropDownLabel
            app.ModesDropDownLabel = uilabel(app.BehaviorualTab);
            app.ModesDropDownLabel.HorizontalAlignment = 'right';
            app.ModesDropDownLabel.Position = [76 547 41 22];
            app.ModesDropDownLabel.Text = 'Modes';

            % Create ModesDropDown_Behavioral
            app.ModesDropDown_Behavioral = uidropdown(app.BehaviorualTab);
            app.ModesDropDown_Behavioral.Items = {'Baseline - quite', 'Noise - 0 or 90'};
            app.ModesDropDown_Behavioral.ValueChangedFcn = createCallbackFcn(app, @ModesDropDown_BehavioralValueChanged, true);
            app.ModesDropDown_Behavioral.Position = [168 547 145 22];
            app.ModesDropDown_Behavioral.Value = 'Baseline - quite';

            % Create CheckBox_Behavioral
            app.CheckBox_Behavioral = uicheckbox(app.BehaviorualTab);
            app.CheckBox_Behavioral.Text = 'Stop after each word';
            app.CheckBox_Behavioral.Position = [444 543 141 25];

            % Create ChooseFolderButton_Behavioral_2
            app.ChooseFolderButton_Behavioral_2 = uibutton(app.BehaviorualTab, 'push');
            app.ChooseFolderButton_Behavioral_2.ButtonPushedFcn = createCallbackFcn(app, @ChooseFolderButton_Behavioral_2Pushed, true);
            app.ChooseFolderButton_Behavioral_2.Visible = 'off';
            app.ChooseFolderButton_Behavioral_2.Position = [635 535 181 40];
            app.ChooseFolderButton_Behavioral_2.Text = 'Choose Noise Soruce';

            % Create SNRFinderTab
            app.SNRFinderTab = uitab(app.TabGroup);
            app.SNRFinderTab.Title = 'SNR Finder';
            app.SNRFinderTab.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SNRFinderTab.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];

            % Create Panel
            app.Panel = uipanel(app.SNRFinderTab);
            app.Panel.Enable = 'off';
            app.Panel.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Panel.Title = 'Panel';
            app.Panel.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Panel.Position = [25 37 861 487];

            % Create OutputPortsFFPanel_2
            app.OutputPortsFFPanel_2 = uipanel(app.Panel);
            app.OutputPortsFFPanel_2.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.OutputPortsFFPanel_2.Title = 'Output Ports (FF)';
            app.OutputPortsFFPanel_2.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OutputPortsFFPanel_2.Position = [304 282 509 49];

            % Create Label_12
            app.Label_12 = uilabel(app.OutputPortsFFPanel_2);
            app.Label_12.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_12.Position = [21 7 25 22];
            app.Label_12.Text = '1';

            % Create Label_13
            app.Label_13 = uilabel(app.OutputPortsFFPanel_2);
            app.Label_13.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_13.Position = [86 7 25 22];
            app.Label_13.Text = '2';

            % Create Label_14
            app.Label_14 = uilabel(app.OutputPortsFFPanel_2);
            app.Label_14.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_14.Position = [216 7 25 22];
            app.Label_14.Text = '4';

            % Create Label_15
            app.Label_15 = uilabel(app.OutputPortsFFPanel_2);
            app.Label_15.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_15.Position = [151 7 25 22];
            app.Label_15.Text = '3';

            % Create Label_16
            app.Label_16 = uilabel(app.OutputPortsFFPanel_2);
            app.Label_16.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_16.Position = [476 7 25 22];
            app.Label_16.Text = '8';

            % Create Label_17
            app.Label_17 = uilabel(app.OutputPortsFFPanel_2);
            app.Label_17.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_17.Position = [411 7 25 22];
            app.Label_17.Text = '7';

            % Create Label_18
            app.Label_18 = uilabel(app.OutputPortsFFPanel_2);
            app.Label_18.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_18.Position = [346 7 25 22];
            app.Label_18.Text = '6';

            % Create Label_19
            app.Label_19 = uilabel(app.OutputPortsFFPanel_2);
            app.Label_19.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_19.Position = [281 7 25 22];
            app.Label_19.Text = '5';

            % Create StartButton_2
            app.StartButton_2 = uibutton(app.Panel, 'push');
            app.StartButton_2.ButtonPushedFcn = createCallbackFcn(app, @StartButton_2Pushed, true);
            app.StartButton_2.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.StartButton_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.StartButton_2.Position = [663 16 150 44];
            app.StartButton_2.Text = 'Start';

            % Create StartingConditionsLabel
            app.StartingConditionsLabel = uilabel(app.Panel);
            app.StartingConditionsLabel.FontSize = 15;
            app.StartingConditionsLabel.FontWeight = 'bold';
            app.StartingConditionsLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.StartingConditionsLabel.Position = [26 241 145 22];
            app.StartingConditionsLabel.Text = 'Starting Conditions';

            % Create OutputSettingsLabel
            app.OutputSettingsLabel = uilabel(app.Panel);
            app.OutputSettingsLabel.FontSize = 15;
            app.OutputSettingsLabel.FontWeight = 'bold';
            app.OutputSettingsLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.OutputSettingsLabel.Position = [26 108 118 22];
            app.OutputSettingsLabel.Text = 'Output Settings';

            % Create CUsersLabDocumentsButton
            app.CUsersLabDocumentsButton = uibutton(app.Panel, 'push');
            app.CUsersLabDocumentsButton.ButtonPushedFcn = createCallbackFcn(app, @CUsersLabDocumentsButtonPushed, true);
            app.CUsersLabDocumentsButton.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CUsersLabDocumentsButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.CUsersLabDocumentsButton.Position = [409 59 182 42];
            app.CUsersLabDocumentsButton.Text = 'C:\Users\Lab\Documents';

            % Create OutputdirLabel
            app.OutputdirLabel = uilabel(app.Panel);
            app.OutputdirLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.OutputdirLabel.Position = [329 68 105 26];
            app.OutputdirLabel.Text = 'Output dir';

            % Create SignalOutputSelectionPanel
            app.SignalOutputSelectionPanel = uipanel(app.Panel);
            app.SignalOutputSelectionPanel.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SignalOutputSelectionPanel.Title = 'Signal Output Selection';
            app.SignalOutputSelectionPanel.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SignalOutputSelectionPanel.Position = [311 188 508 69];

            % Create SNRSignalOutput1
            app.SNRSignalOutput1 = uicheckbox(app.SignalOutputSelectionPanel);
            app.SNRSignalOutput1.Text = '';
            app.SNRSignalOutput1.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRSignalOutput1.Position = [22 11 17 24];

            % Create SNRSignalOutput2
            app.SNRSignalOutput2 = uicheckbox(app.SignalOutputSelectionPanel);
            app.SNRSignalOutput2.Text = '';
            app.SNRSignalOutput2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRSignalOutput2.Position = [87 11 17 24];

            % Create SNRSignalOutput3
            app.SNRSignalOutput3 = uicheckbox(app.SignalOutputSelectionPanel);
            app.SNRSignalOutput3.Text = '';
            app.SNRSignalOutput3.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRSignalOutput3.Position = [152 11 17 24];

            % Create SNRSignalOutput4
            app.SNRSignalOutput4 = uicheckbox(app.SignalOutputSelectionPanel);
            app.SNRSignalOutput4.Text = '';
            app.SNRSignalOutput4.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRSignalOutput4.Position = [217 10 17 24];

            % Create SNRSignalOutput8
            app.SNRSignalOutput8 = uicheckbox(app.SignalOutputSelectionPanel);
            app.SNRSignalOutput8.Text = '';
            app.SNRSignalOutput8.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRSignalOutput8.Position = [477 11 17 24];

            % Create SNRSignalOutput7
            app.SNRSignalOutput7 = uicheckbox(app.SignalOutputSelectionPanel);
            app.SNRSignalOutput7.Text = '';
            app.SNRSignalOutput7.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRSignalOutput7.Position = [412 11 17 24];

            % Create SNRSignalOutput6
            app.SNRSignalOutput6 = uicheckbox(app.SignalOutputSelectionPanel);
            app.SNRSignalOutput6.Text = '';
            app.SNRSignalOutput6.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRSignalOutput6.Position = [347 11 17 24];

            % Create SNRSignalOutput5
            app.SNRSignalOutput5 = uicheckbox(app.SignalOutputSelectionPanel);
            app.SNRSignalOutput5.Text = '';
            app.SNRSignalOutput5.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRSignalOutput5.Position = [282 11 17 24];

            % Create NoiseOutputSelectionPanel
            app.NoiseOutputSelectionPanel = uipanel(app.Panel);
            app.NoiseOutputSelectionPanel.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NoiseOutputSelectionPanel.Title = 'Noise Output Selection';
            app.NoiseOutputSelectionPanel.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.NoiseOutputSelectionPanel.Position = [311 108 508 69];

            % Create SNRNoiseOutput1
            app.SNRNoiseOutput1 = uicheckbox(app.NoiseOutputSelectionPanel);
            app.SNRNoiseOutput1.Text = '';
            app.SNRNoiseOutput1.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRNoiseOutput1.Position = [22 11 17 24];

            % Create SNRNoiseOutput2
            app.SNRNoiseOutput2 = uicheckbox(app.NoiseOutputSelectionPanel);
            app.SNRNoiseOutput2.Text = '';
            app.SNRNoiseOutput2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRNoiseOutput2.Position = [87 11 17 24];

            % Create SNRNoiseOutput3
            app.SNRNoiseOutput3 = uicheckbox(app.NoiseOutputSelectionPanel);
            app.SNRNoiseOutput3.Text = '';
            app.SNRNoiseOutput3.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRNoiseOutput3.Position = [152 11 17 24];

            % Create SNRNoiseOutput4
            app.SNRNoiseOutput4 = uicheckbox(app.NoiseOutputSelectionPanel);
            app.SNRNoiseOutput4.Text = '';
            app.SNRNoiseOutput4.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRNoiseOutput4.Position = [217 10 17 24];

            % Create SNRNoiseOutput8
            app.SNRNoiseOutput8 = uicheckbox(app.NoiseOutputSelectionPanel);
            app.SNRNoiseOutput8.Text = '';
            app.SNRNoiseOutput8.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRNoiseOutput8.Position = [477 11 17 24];

            % Create SNRNoiseOutput7
            app.SNRNoiseOutput7 = uicheckbox(app.NoiseOutputSelectionPanel);
            app.SNRNoiseOutput7.Text = '';
            app.SNRNoiseOutput7.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRNoiseOutput7.Position = [412 11 17 24];

            % Create SNRNoiseOutput6
            app.SNRNoiseOutput6 = uicheckbox(app.NoiseOutputSelectionPanel);
            app.SNRNoiseOutput6.Text = '';
            app.SNRNoiseOutput6.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRNoiseOutput6.Position = [347 11 17 24];

            % Create SNRNoiseOutput5
            app.SNRNoiseOutput5 = uicheckbox(app.NoiseOutputSelectionPanel);
            app.SNRNoiseOutput5.Text = '';
            app.SNRNoiseOutput5.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRNoiseOutput5.Position = [282 11 17 24];

            % Create SignaldBEditFieldLabel
            app.SignaldBEditFieldLabel = uilabel(app.Panel);
            app.SignaldBEditFieldLabel.HorizontalAlignment = 'right';
            app.SignaldBEditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SignaldBEditFieldLabel.Position = [16 198 65 22];
            app.SignaldBEditFieldLabel.Text = 'Signal (dB)';

            % Create SignaldBEditField
            app.SignaldBEditField = uieditfield(app.Panel, 'numeric');
            app.SignaldBEditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SignaldBEditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.SignaldBEditField.Position = [96 191 48 35];
            app.SignaldBEditField.Value = 60;

            % Create NoisedBEditFieldLabel
            app.NoisedBEditFieldLabel = uilabel(app.Panel);
            app.NoisedBEditFieldLabel.HorizontalAlignment = 'right';
            app.NoisedBEditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NoisedBEditFieldLabel.Position = [18 145 62 22];
            app.NoisedBEditFieldLabel.Text = 'Noise (dB)';

            % Create NoisedBEditField
            app.NoisedBEditField = uieditfield(app.Panel, 'numeric');
            app.NoisedBEditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NoisedBEditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.NoisedBEditField.Position = [95 138 49 35];
            app.NoisedBEditField.Value = 50;

            % Create NameoffolderEditFieldLabel
            app.NameoffolderEditFieldLabel = uilabel(app.Panel);
            app.NameoffolderEditFieldLabel.HorizontalAlignment = 'right';
            app.NameoffolderEditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NameoffolderEditFieldLabel.Position = [26 70 84 22];
            app.NameoffolderEditFieldLabel.Text = 'Name of folder';

            % Create NameoffolderEditField
            app.NameoffolderEditField = uieditfield(app.Panel, 'text');
            app.NameoffolderEditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NameoffolderEditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.NameoffolderEditField.Position = [125 63 105 36];

            % Create PersonalDetailsLabel
            app.PersonalDetailsLabel = uilabel(app.Panel);
            app.PersonalDetailsLabel.FontSize = 15;
            app.PersonalDetailsLabel.FontWeight = 'bold';
            app.PersonalDetailsLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.PersonalDetailsLabel.Position = [19 446 122 22];
            app.PersonalDetailsLabel.Text = 'Personal Details';

            % Create NameEditFieldLabel
            app.NameEditFieldLabel = uilabel(app.Panel);
            app.NameEditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NameEditFieldLabel.Position = [24 390 55 22];
            app.NameEditFieldLabel.Text = 'Name';

            % Create NameEditField
            app.NameEditField = uieditfield(app.Panel, 'text');
            app.NameEditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NameEditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.NameEditField.Position = [94 384 107 34];

            % Create AgeEditFieldLabel
            app.AgeEditFieldLabel = uilabel(app.Panel);
            app.AgeEditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.AgeEditFieldLabel.Position = [24 352 55 22];
            app.AgeEditFieldLabel.Text = 'Age';

            % Create AgeEditField
            app.AgeEditField = uieditfield(app.Panel, 'text');
            app.AgeEditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.AgeEditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.AgeEditField.Position = [94 346 107 34];

            % Create GenderEditFieldLabel
            app.GenderEditFieldLabel = uilabel(app.Panel);
            app.GenderEditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.GenderEditFieldLabel.Position = [233 390 55 22];
            app.GenderEditFieldLabel.Text = 'Gender';

            % Create GenderEditField
            app.GenderEditField = uieditfield(app.Panel, 'text');
            app.GenderEditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.GenderEditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.GenderEditField.Position = [303 384 107 34];

            % Create EarEditFieldLabel
            app.EarEditFieldLabel = uilabel(app.Panel);
            app.EarEditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.EarEditFieldLabel.Position = [233 352 55 22];
            app.EarEditFieldLabel.Text = 'Ear';

            % Create EarEditField
            app.EarEditField = uieditfield(app.Panel, 'text');
            app.EarEditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.EarEditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.EarEditField.Position = [303 346 107 34];

            % Create TestNameEditFieldLabel
            app.TestNameEditFieldLabel = uilabel(app.Panel);
            app.TestNameEditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TestNameEditFieldLabel.Position = [444 390 63 22];
            app.TestNameEditFieldLabel.Text = 'Test Name';

            % Create TestNameEditField
            app.TestNameEditField = uieditfield(app.Panel, 'text');
            app.TestNameEditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TestNameEditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.TestNameEditField.Position = [514 384 107 34];

            % Create SNRFinderLabel
            app.SNRFinderLabel = uilabel(app.SNRFinderTab);
            app.SNRFinderLabel.FontSize = 20;
            app.SNRFinderLabel.FontWeight = 'bold';
            app.SNRFinderLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SNRFinderLabel.Position = [11 605 212 53];
            app.SNRFinderLabel.Text = 'SNR Finder';

            % Create Label_11
            app.Label_11 = uilabel(app.SNRFinderTab);
            app.Label_11.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_11.Position = [39 582 533 31];
            app.Label_11.Text = 'Please choose folder directory which include at least 25 .wav audio files that contains signal each';

            % Create ChooseFolderButton
            app.ChooseFolderButton = uibutton(app.SNRFinderTab, 'push');
            app.ChooseFolderButton.ButtonPushedFcn = createCallbackFcn(app, @ChooseFolderButtonPushed, true);
            app.ChooseFolderButton.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ChooseFolderButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.ChooseFolderButton.Position = [626 582 181 40];
            app.ChooseFolderButton.Text = 'Choose Folder';

            % Create infoButton
            app.infoButton = uibutton(app.SNRFinderTab, 'push');
            app.infoButton.ButtonPushedFcn = createCallbackFcn(app, @infoButtonPushed, true);
            app.infoButton.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.infoButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.infoButton.Position = [141 620 55 22];
            app.infoButton.Text = 'info';

            % Create ChooseNoiseTypeButtonGroup
            app.ChooseNoiseTypeButtonGroup = uibuttongroup(app.SNRFinderTab);
            app.ChooseNoiseTypeButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @ChooseNoiseTypeButtonGroupSelectionChanged, true);
            app.ChooseNoiseTypeButtonGroup.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.ChooseNoiseTypeButtonGroup.Title = 'Choose Noise Type:';
            app.ChooseNoiseTypeButtonGroup.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ChooseNoiseTypeButtonGroup.Position = [45 530 284 53];

            % Create WhiteNoiseButton
            app.WhiteNoiseButton = uiradiobutton(app.ChooseNoiseTypeButtonGroup);
            app.WhiteNoiseButton.Text = 'White Noise';
            app.WhiteNoiseButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.WhiteNoiseButton.Position = [2 5 87 22];
            app.WhiteNoiseButton.Value = true;

            % Create NoisefromfileButton
            app.NoisefromfileButton = uiradiobutton(app.ChooseNoiseTypeButtonGroup);
            app.NoisefromfileButton.Text = 'Noise from file';
            app.NoisefromfileButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NoisefromfileButton.Position = [168 5 99 22];

            % Create ChoosenoiseaudiofileButton
            app.ChoosenoiseaudiofileButton = uibutton(app.SNRFinderTab, 'push');
            app.ChoosenoiseaudiofileButton.ButtonPushedFcn = createCallbackFcn(app, @ChoosenoiseaudiofileButtonPushed, true);
            app.ChoosenoiseaudiofileButton.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ChoosenoiseaudiofileButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.ChoosenoiseaudiofileButton.Enable = 'off';
            app.ChoosenoiseaudiofileButton.Position = [625 534 181 40];
            app.ChoosenoiseaudiofileButton.Text = 'Choose noise audio file';

            % Create SpatialHearingTab
            app.SpatialHearingTab = uitab(app.TabGroup);
            app.SpatialHearingTab.Title = 'Spatial Hearing';
            app.SpatialHearingTab.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SpatialHearingTab.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];

            % Create SpatialHearingTestLabel
            app.SpatialHearingTestLabel = uilabel(app.SpatialHearingTab);
            app.SpatialHearingTestLabel.FontSize = 20;
            app.SpatialHearingTestLabel.FontWeight = 'bold';
            app.SpatialHearingTestLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialHearingTestLabel.Position = [11 605 212 53];
            app.SpatialHearingTestLabel.Text = 'Spatial Hearing Test';

            % Create ModeButtonGroup
            app.ModeButtonGroup = uibuttongroup(app.SpatialHearingTab);
            app.ModeButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @ModeButtonGroupSelectionChanged, true);
            app.ModeButtonGroup.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.ModeButtonGroup.Title = 'Mode';
            app.ModeButtonGroup.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ModeButtonGroup.Position = [39 359 290 115];

            % Create quiteNoNoisedecreasingsignalButton
            app.quiteNoNoisedecreasingsignalButton = uiradiobutton(app.ModeButtonGroup);
            app.quiteNoNoisedecreasingsignalButton.Text = 'quite (No Noise - decreasing signal)';
            app.quiteNoNoisedecreasingsignalButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.quiteNoNoisedecreasingsignalButton.Position = [11 49 214 22];
            app.quiteNoNoisedecreasingsignalButton.Value = true;

            % Create NoiseIncreasingNoiseButton
            app.NoiseIncreasingNoiseButton = uiradiobutton(app.ModeButtonGroup);
            app.NoiseIncreasingNoiseButton.Text = 'Noise (Increasing Noise)';
            app.NoiseIncreasingNoiseButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NoiseIncreasingNoiseButton.Position = [11 27 153 22];

            % Create SpatialStartingConditionsLabel
            app.SpatialStartingConditionsLabel = uilabel(app.SpatialHearingTab);
            app.SpatialStartingConditionsLabel.FontSize = 15;
            app.SpatialStartingConditionsLabel.FontWeight = 'bold';
            app.SpatialStartingConditionsLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialStartingConditionsLabel.Position = [383 459 145 22];
            app.SpatialStartingConditionsLabel.Text = 'Starting Conditions';

            % Create SignaldBLabel
            app.SignaldBLabel = uilabel(app.SpatialHearingTab);
            app.SignaldBLabel.HorizontalAlignment = 'right';
            app.SignaldBLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SignaldBLabel.Position = [373 416 65 22];
            app.SignaldBLabel.Text = 'Signal (dB)';

            % Create SpatialSignaldbEditField
            app.SpatialSignaldbEditField = uieditfield(app.SpatialHearingTab, 'numeric');
            app.SpatialSignaldbEditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignaldbEditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.SpatialSignaldbEditField.Position = [453 409 105 35];
            app.SpatialSignaldbEditField.Value = 60;

            % Create NoisedBLabel
            app.NoisedBLabel = uilabel(app.SpatialHearingTab);
            app.NoisedBLabel.HorizontalAlignment = 'right';
            app.NoisedBLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NoisedBLabel.Enable = 'off';
            app.NoisedBLabel.Position = [375 363 62 22];
            app.NoisedBLabel.Text = 'Noise (dB)';

            % Create SpatialNoisedbEditField
            app.SpatialNoisedbEditField = uieditfield(app.SpatialHearingTab, 'numeric');
            app.SpatialNoisedbEditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialNoisedbEditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.SpatialNoisedbEditField.Enable = 'off';
            app.SpatialNoisedbEditField.Position = [452 356 105 35];
            app.SpatialNoisedbEditField.Value = 50;

            % Create SpatialSignalOutputSelectionPanel
            app.SpatialSignalOutputSelectionPanel = uipanel(app.SpatialHearingTab);
            app.SpatialSignalOutputSelectionPanel.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutputSelectionPanel.Title = 'Spatial Output Group (Signal)';
            app.SpatialSignalOutputSelectionPanel.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SpatialSignalOutputSelectionPanel.Position = [377 172 508 69];

            % Create SpatialSignalOutput1
            app.SpatialSignalOutput1 = uicheckbox(app.SpatialSignalOutputSelectionPanel);
            app.SpatialSignalOutput1.Text = '';
            app.SpatialSignalOutput1.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput1.Position = [22 11 17 24];
            app.SpatialSignalOutput1.Value = true;

            % Create SpatialSignalOutput2
            app.SpatialSignalOutput2 = uicheckbox(app.SpatialSignalOutputSelectionPanel);
            app.SpatialSignalOutput2.Text = '';
            app.SpatialSignalOutput2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput2.Position = [87 11 17 24];
            app.SpatialSignalOutput2.Value = true;

            % Create SpatialSignalOutput3
            app.SpatialSignalOutput3 = uicheckbox(app.SpatialSignalOutputSelectionPanel);
            app.SpatialSignalOutput3.Text = '';
            app.SpatialSignalOutput3.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput3.Position = [152 11 17 24];
            app.SpatialSignalOutput3.Value = true;

            % Create SpatialSignalOutput4
            app.SpatialSignalOutput4 = uicheckbox(app.SpatialSignalOutputSelectionPanel);
            app.SpatialSignalOutput4.Text = '';
            app.SpatialSignalOutput4.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput4.Position = [217 10 17 24];
            app.SpatialSignalOutput4.Value = true;

            % Create SpatialSignalOutput8
            app.SpatialSignalOutput8 = uicheckbox(app.SpatialSignalOutputSelectionPanel);
            app.SpatialSignalOutput8.Text = '';
            app.SpatialSignalOutput8.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput8.Position = [477 11 17 24];
            app.SpatialSignalOutput8.Value = true;

            % Create SpatialSignalOutput7
            app.SpatialSignalOutput7 = uicheckbox(app.SpatialSignalOutputSelectionPanel);
            app.SpatialSignalOutput7.Text = '';
            app.SpatialSignalOutput7.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput7.Position = [412 11 17 24];
            app.SpatialSignalOutput7.Value = true;

            % Create SpatialSignalOutput6
            app.SpatialSignalOutput6 = uicheckbox(app.SpatialSignalOutputSelectionPanel);
            app.SpatialSignalOutput6.Text = '';
            app.SpatialSignalOutput6.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput6.Position = [347 11 17 24];
            app.SpatialSignalOutput6.Value = true;

            % Create SpatialSignalOutput5
            app.SpatialSignalOutput5 = uicheckbox(app.SpatialSignalOutputSelectionPanel);
            app.SpatialSignalOutput5.Text = '';
            app.SpatialSignalOutput5.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput5.Position = [282 11 17 24];
            app.SpatialSignalOutput5.Value = true;

            % Create OutputPortsFFPanel_3
            app.OutputPortsFFPanel_3 = uipanel(app.SpatialHearingTab);
            app.OutputPortsFFPanel_3.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.OutputPortsFFPanel_3.Title = 'Output Ports (FF)';
            app.OutputPortsFFPanel_3.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OutputPortsFFPanel_3.Position = [378 245 509 49];

            % Create Label_20
            app.Label_20 = uilabel(app.OutputPortsFFPanel_3);
            app.Label_20.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_20.Position = [21 7 25 22];
            app.Label_20.Text = '1';

            % Create Label_21
            app.Label_21 = uilabel(app.OutputPortsFFPanel_3);
            app.Label_21.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_21.Position = [86 7 25 22];
            app.Label_21.Text = '2';

            % Create Label_22
            app.Label_22 = uilabel(app.OutputPortsFFPanel_3);
            app.Label_22.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_22.Position = [216 7 25 22];
            app.Label_22.Text = '4';

            % Create Label_23
            app.Label_23 = uilabel(app.OutputPortsFFPanel_3);
            app.Label_23.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_23.Position = [151 7 25 22];
            app.Label_23.Text = '3';

            % Create Label_24
            app.Label_24 = uilabel(app.OutputPortsFFPanel_3);
            app.Label_24.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_24.Position = [476 7 25 22];
            app.Label_24.Text = '8';

            % Create Label_25
            app.Label_25 = uilabel(app.OutputPortsFFPanel_3);
            app.Label_25.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_25.Position = [411 7 25 22];
            app.Label_25.Text = '7';

            % Create Label_26
            app.Label_26 = uilabel(app.OutputPortsFFPanel_3);
            app.Label_26.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_26.Position = [346 7 25 22];
            app.Label_26.Text = '6';

            % Create Label_27
            app.Label_27 = uilabel(app.OutputPortsFFPanel_3);
            app.Label_27.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_27.Position = [281 7 25 22];
            app.Label_27.Text = '5';

            % Create SignalFrequencyHzDropDownLabel
            app.SignalFrequencyHzDropDownLabel = uilabel(app.SpatialHearingTab);
            app.SignalFrequencyHzDropDownLabel.HorizontalAlignment = 'right';
            app.SignalFrequencyHzDropDownLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SignalFrequencyHzDropDownLabel.Position = [17 266 125 22];
            app.SignalFrequencyHzDropDownLabel.Text = 'Signal Frequency (Hz)';

            % Create SignalFrequencyHzDropDown
            app.SignalFrequencyHzDropDown = uidropdown(app.SpatialHearingTab);
            app.SignalFrequencyHzDropDown.Items = {'250', '500', '1000', '2000', '4000'};
            app.SignalFrequencyHzDropDown.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SignalFrequencyHzDropDown.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SignalFrequencyHzDropDown.Position = [157 266 100 22];
            app.SignalFrequencyHzDropDown.Value = '1000';

            % Create StartSpatialTestButton
            app.StartSpatialTestButton = uibutton(app.SpatialHearingTab, 'push');
            app.StartSpatialTestButton.ButtonPushedFcn = createCallbackFcn(app, @StartSpatialTestButtonPushed, true);
            app.StartSpatialTestButton.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.StartSpatialTestButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.StartSpatialTestButton.Position = [724 37 138 47];
            app.StartSpatialTestButton.Text = 'Start Spatial Test';

            % Create DurationsecEditFieldLabel
            app.DurationsecEditFieldLabel = uilabel(app.SpatialHearingTab);
            app.DurationsecEditFieldLabel.HorizontalAlignment = 'right';
            app.DurationsecEditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.DurationsecEditFieldLabel.Position = [58 229 81 22];
            app.DurationsecEditFieldLabel.Text = 'Duration (sec)';

            % Create DurationsecEditField
            app.DurationsecEditField = uieditfield(app.SpatialHearingTab, 'numeric');
            app.DurationsecEditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.DurationsecEditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.DurationsecEditField.Position = [154 229 100 22];
            app.DurationsecEditField.Value = 2;

            % Create infoButton_2
            app.infoButton_2 = uibutton(app.SpatialHearingTab, 'push');
            app.infoButton_2.ButtonPushedFcn = createCallbackFcn(app, @infoButton_2Pushed, true);
            app.infoButton_2.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.infoButton_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.infoButton_2.Position = [241 625 55 22];
            app.infoButton_2.Text = 'info';

            % Create NameEditField_2Label
            app.NameEditField_2Label = uilabel(app.SpatialHearingTab);
            app.NameEditField_2Label.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NameEditField_2Label.Position = [39 547 55 22];
            app.NameEditField_2Label.Text = 'Name';

            % Create NameEditField_2
            app.NameEditField_2 = uieditfield(app.SpatialHearingTab, 'text');
            app.NameEditField_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NameEditField_2.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.NameEditField_2.Position = [109 541 107 34];

            % Create AgeEditField_2Label
            app.AgeEditField_2Label = uilabel(app.SpatialHearingTab);
            app.AgeEditField_2Label.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.AgeEditField_2Label.Position = [39 509 55 22];
            app.AgeEditField_2Label.Text = 'Age';

            % Create AgeEditField_2
            app.AgeEditField_2 = uieditfield(app.SpatialHearingTab, 'text');
            app.AgeEditField_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.AgeEditField_2.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.AgeEditField_2.Position = [109 503 107 34];

            % Create GenderEditField_2Label
            app.GenderEditField_2Label = uilabel(app.SpatialHearingTab);
            app.GenderEditField_2Label.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.GenderEditField_2Label.Position = [248 547 55 22];
            app.GenderEditField_2Label.Text = 'Gender';

            % Create GenderEditField_2
            app.GenderEditField_2 = uieditfield(app.SpatialHearingTab, 'text');
            app.GenderEditField_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.GenderEditField_2.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.GenderEditField_2.Position = [318 541 107 34];

            % Create EarEditField_2Label
            app.EarEditField_2Label = uilabel(app.SpatialHearingTab);
            app.EarEditField_2Label.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.EarEditField_2Label.Position = [248 509 55 22];
            app.EarEditField_2Label.Text = 'Ear';

            % Create EarEditField_2
            app.EarEditField_2 = uieditfield(app.SpatialHearingTab, 'text');
            app.EarEditField_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.EarEditField_2.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.EarEditField_2.Position = [318 503 107 34];

            % Create TestNameEditField_2Label
            app.TestNameEditField_2Label = uilabel(app.SpatialHearingTab);
            app.TestNameEditField_2Label.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TestNameEditField_2Label.Position = [459 547 63 22];
            app.TestNameEditField_2Label.Text = 'Test Name';

            % Create TestNameEditField_2
            app.TestNameEditField_2 = uieditfield(app.SpatialHearingTab, 'text');
            app.TestNameEditField_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TestNameEditField_2.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.TestNameEditField_2.Position = [529 541 107 34];

            % Create PersonalDetailsLabel_2
            app.PersonalDetailsLabel_2 = uilabel(app.SpatialHearingTab);
            app.PersonalDetailsLabel_2.FontSize = 15;
            app.PersonalDetailsLabel_2.FontWeight = 'bold';
            app.PersonalDetailsLabel_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.PersonalDetailsLabel_2.Position = [44 586 122 22];
            app.PersonalDetailsLabel_2.Text = 'Personal Details';

            % Create OutputSettingsLabel_2
            app.OutputSettingsLabel_2 = uilabel(app.SpatialHearingTab);
            app.OutputSettingsLabel_2.FontSize = 15;
            app.OutputSettingsLabel_2.FontWeight = 'bold';
            app.OutputSettingsLabel_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.OutputSettingsLabel_2.Position = [14 75 118 22];
            app.OutputSettingsLabel_2.Text = 'Output Settings';

            % Create CUsersLabDocumentsButton_2
            app.CUsersLabDocumentsButton_2 = uibutton(app.SpatialHearingTab, 'push');
            app.CUsersLabDocumentsButton_2.ButtonPushedFcn = createCallbackFcn(app, @CUsersLabDocumentsButton_2Pushed, true);
            app.CUsersLabDocumentsButton_2.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CUsersLabDocumentsButton_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.CUsersLabDocumentsButton_2.Position = [420 37 182 42];
            app.CUsersLabDocumentsButton_2.Text = 'C:\Users\Lab\Documents';

            % Create OutputdirLabel_2
            app.OutputdirLabel_2 = uilabel(app.SpatialHearingTab);
            app.OutputdirLabel_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.OutputdirLabel_2.Position = [340 46 105 26];
            app.OutputdirLabel_2.Text = 'Output dir';

            % Create NameoffiileEditFieldLabel_2
            app.NameoffiileEditFieldLabel_2 = uilabel(app.SpatialHearingTab);
            app.NameoffiileEditFieldLabel_2.HorizontalAlignment = 'right';
            app.NameoffiileEditFieldLabel_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NameoffiileEditFieldLabel_2.Position = [37 48 84 22];
            app.NameoffiileEditFieldLabel_2.Text = 'Name of folder';

            % Create NameoffiileEditField_2
            app.NameoffiileEditField_2 = uieditfield(app.SpatialHearingTab, 'text');
            app.NameoffiileEditField_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NameoffiileEditField_2.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.NameoffiileEditField_2.Position = [136 41 105 36];

            % Create ChooseNoiseTypeButtonGroupSpatialHearing
            app.ChooseNoiseTypeButtonGroupSpatialHearing = uibuttongroup(app.SpatialHearingTab);
            app.ChooseNoiseTypeButtonGroupSpatialHearing.SelectionChangedFcn = createCallbackFcn(app, @ChooseNoiseTypeButtonGroupSpatialHearingSelectionChanged, true);
            app.ChooseNoiseTypeButtonGroupSpatialHearing.Enable = 'off';
            app.ChooseNoiseTypeButtonGroupSpatialHearing.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.ChooseNoiseTypeButtonGroupSpatialHearing.Title = 'Choose Noise Type:';
            app.ChooseNoiseTypeButtonGroupSpatialHearing.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ChooseNoiseTypeButtonGroupSpatialHearing.Position = [615 347 240 45];

            % Create WhiteNoiseButton_2
            app.WhiteNoiseButton_2 = uiradiobutton(app.ChooseNoiseTypeButtonGroupSpatialHearing);
            app.WhiteNoiseButton_2.Text = 'White Noise';
            app.WhiteNoiseButton_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.WhiteNoiseButton_2.Position = [2 -3 87 22];
            app.WhiteNoiseButton_2.Value = true;

            % Create NoisefromfileButton_2
            app.NoisefromfileButton_2 = uiradiobutton(app.ChooseNoiseTypeButtonGroupSpatialHearing);
            app.NoisefromfileButton_2.Text = 'Noise from file';
            app.NoisefromfileButton_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NoisefromfileButton_2.Position = [133 -4 99 22];

            % Create ChoosenoiseaudiofileButtonSpatialHearing
            app.ChoosenoiseaudiofileButtonSpatialHearing = uibutton(app.SpatialHearingTab, 'push');
            app.ChoosenoiseaudiofileButtonSpatialHearing.ButtonPushedFcn = createCallbackFcn(app, @ChoosenoiseaudiofileButtonSpatialHearingPushed, true);
            app.ChoosenoiseaudiofileButtonSpatialHearing.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ChoosenoiseaudiofileButtonSpatialHearing.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.ChoosenoiseaudiofileButtonSpatialHearing.Enable = 'off';
            app.ChoosenoiseaudiofileButtonSpatialHearing.Position = [626 299 236 40];
            app.ChoosenoiseaudiofileButtonSpatialHearing.Text = 'Choose noise audio file';

            % Create SpatialNoiseOutputSelectionPanel
            app.SpatialNoiseOutputSelectionPanel = uipanel(app.SpatialHearingTab);
            app.SpatialNoiseOutputSelectionPanel.Enable = 'off';
            app.SpatialNoiseOutputSelectionPanel.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialNoiseOutputSelectionPanel.Title = 'Spatial Output Group (Noise)';
            app.SpatialNoiseOutputSelectionPanel.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SpatialNoiseOutputSelectionPanel.Position = [377 96 508 69];

            % Create SpatialSignalOutput1Noise
            app.SpatialSignalOutput1Noise = uicheckbox(app.SpatialNoiseOutputSelectionPanel);
            app.SpatialSignalOutput1Noise.Text = '';
            app.SpatialSignalOutput1Noise.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput1Noise.Position = [22 11 17 24];

            % Create SpatialSignalOutput2Noise
            app.SpatialSignalOutput2Noise = uicheckbox(app.SpatialNoiseOutputSelectionPanel);
            app.SpatialSignalOutput2Noise.Text = '';
            app.SpatialSignalOutput2Noise.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput2Noise.Position = [87 11 17 24];

            % Create SpatialSignalOutput3Noise
            app.SpatialSignalOutput3Noise = uicheckbox(app.SpatialNoiseOutputSelectionPanel);
            app.SpatialSignalOutput3Noise.Text = '';
            app.SpatialSignalOutput3Noise.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput3Noise.Position = [152 11 17 24];

            % Create SpatialSignalOutput4Noise
            app.SpatialSignalOutput4Noise = uicheckbox(app.SpatialNoiseOutputSelectionPanel);
            app.SpatialSignalOutput4Noise.Text = '';
            app.SpatialSignalOutput4Noise.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput4Noise.Position = [217 10 17 24];

            % Create SpatialSignalOutput8Noise
            app.SpatialSignalOutput8Noise = uicheckbox(app.SpatialNoiseOutputSelectionPanel);
            app.SpatialSignalOutput8Noise.Text = '';
            app.SpatialSignalOutput8Noise.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput8Noise.Position = [477 11 17 24];

            % Create SpatialSignalOutput7Noise
            app.SpatialSignalOutput7Noise = uicheckbox(app.SpatialNoiseOutputSelectionPanel);
            app.SpatialSignalOutput7Noise.Text = '';
            app.SpatialSignalOutput7Noise.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput7Noise.Position = [412 11 17 24];

            % Create SpatialSignalOutput6Noise
            app.SpatialSignalOutput6Noise = uicheckbox(app.SpatialNoiseOutputSelectionPanel);
            app.SpatialSignalOutput6Noise.Text = '';
            app.SpatialSignalOutput6Noise.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput6Noise.Position = [347 11 17 24];

            % Create SpatialSignalOutput5Noise
            app.SpatialSignalOutput5Noise = uicheckbox(app.SpatialNoiseOutputSelectionPanel);
            app.SpatialSignalOutput5Noise.Text = '';
            app.SpatialSignalOutput5Noise.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpatialSignalOutput5Noise.Position = [282 11 17 24];

            % Create NoiseModeButtonGroup
            app.NoiseModeButtonGroup = uibuttongroup(app.SpatialHearingTab);
            app.NoiseModeButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @NoiseModeButtonGroupSelectionChanged, true);
            app.NoiseModeButtonGroup.Enable = 'off';
            app.NoiseModeButtonGroup.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NoiseModeButtonGroup.Title = 'Noise Mode ';
            app.NoiseModeButtonGroup.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.NoiseModeButtonGroup.Position = [33 106 290 75];

            % Create NoiseoutputwithsignalspeakerButton
            app.NoiseoutputwithsignalspeakerButton = uiradiobutton(app.NoiseModeButtonGroup);
            app.NoiseoutputwithsignalspeakerButton.Text = 'Noise output with signal speaker';
            app.NoiseoutputwithsignalspeakerButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.NoiseoutputwithsignalspeakerButton.Position = [11 29 196 22];
            app.NoiseoutputwithsignalspeakerButton.Value = true;

            % Create FixedSpeakersnoiseoutputButton
            app.FixedSpeakersnoiseoutputButton = uiradiobutton(app.NoiseModeButtonGroup);
            app.FixedSpeakersnoiseoutputButton.Text = 'Fixed Speakers noise output';
            app.FixedSpeakersnoiseoutputButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FixedSpeakersnoiseoutputButton.Position = [11 5 174 22];

            % Create ChooseSignalTypeButtonGroupSpatialHearing
            app.ChooseSignalTypeButtonGroupSpatialHearing = uibuttongroup(app.SpatialHearingTab);
            app.ChooseSignalTypeButtonGroupSpatialHearing.SelectionChangedFcn = createCallbackFcn(app, @ChooseSignalTypeButtonGroupSpatialHearingSelectionChanged, true);
            app.ChooseSignalTypeButtonGroupSpatialHearing.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.ChooseSignalTypeButtonGroupSpatialHearing.Title = 'Choose Signal Type:';
            app.ChooseSignalTypeButtonGroupSpatialHearing.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ChooseSignalTypeButtonGroupSpatialHearing.Position = [611 470 240 45];

            % Create PureToneButton
            app.PureToneButton = uiradiobutton(app.ChooseSignalTypeButtonGroupSpatialHearing);
            app.PureToneButton.Text = 'Pure Tone';
            app.PureToneButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.PureToneButton.Position = [2 -3 77 22];
            app.PureToneButton.Value = true;

            % Create WordsFolderButton
            app.WordsFolderButton = uiradiobutton(app.ChooseSignalTypeButtonGroupSpatialHearing);
            app.WordsFolderButton.Text = 'Words Folder';
            app.WordsFolderButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.WordsFolderButton.Position = [133 -4 94 22];

            % Create ChoosesignalwordsfolderButtonSpatialHearing
            app.ChoosesignalwordsfolderButtonSpatialHearing = uibutton(app.SpatialHearingTab, 'push');
            app.ChoosesignalwordsfolderButtonSpatialHearing.ButtonPushedFcn = createCallbackFcn(app, @ChoosesignalwordsfolderButtonSpatialHearingPushed, true);
            app.ChoosesignalwordsfolderButtonSpatialHearing.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ChoosesignalwordsfolderButtonSpatialHearing.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.ChoosesignalwordsfolderButtonSpatialHearing.Enable = 'off';
            app.ChoosesignalwordsfolderButtonSpatialHearing.Position = [617 407 236 40];
            app.ChoosesignalwordsfolderButtonSpatialHearing.Text = 'Choose signal words folder';

            % Create CalibrationTab
            app.CalibrationTab = uitab(app.TabGroup);
            app.CalibrationTab.Title = 'Calibration';
            app.CalibrationTab.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CalibrationTab.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];

            % Create ImportButton
            app.ImportButton = uibutton(app.CalibrationTab, 'push');
            app.ImportButton.ButtonPushedFcn = createCallbackFcn(app, @ImportButtonPushed, true);
            app.ImportButton.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ImportButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.ImportButton.Position = [48 63 66 31];
            app.ImportButton.Text = 'Import';

            % Create CalibExportButton
            app.CalibExportButton = uibutton(app.CalibrationTab, 'push');
            app.CalibExportButton.ButtonPushedFcn = createCallbackFcn(app, @CalibExportButtonPushed, true);
            app.CalibExportButton.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CalibExportButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.CalibExportButton.Position = [145 63 66 31];
            app.CalibExportButton.Text = 'Export';

            % Create FFOutput1EditFieldLabel
            app.FFOutput1EditFieldLabel = uilabel(app.CalibrationTab);
            app.FFOutput1EditFieldLabel.HorizontalAlignment = 'right';
            app.FFOutput1EditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput1EditFieldLabel.Position = [746 489 70 22];
            app.FFOutput1EditFieldLabel.Text = 'FF Output 1';

            % Create FFOutput1EditField
            app.FFOutput1EditField = uieditfield(app.CalibrationTab, 'numeric');
            app.FFOutput1EditField.Limits = [1 18];
            app.FFOutput1EditField.ValueChangedFcn = createCallbackFcn(app, @FFOutput1EditFieldValueChanged, true);
            app.FFOutput1EditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput1EditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.FFOutput1EditField.Position = [831 483 31 33];
            app.FFOutput1EditField.Value = 1;

            % Create SpeakersLabel
            app.SpeakersLabel = uilabel(app.CalibrationTab);
            app.SpeakersLabel.HorizontalAlignment = 'center';
            app.SpeakersLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.SpeakersLabel.Position = [787 523 99 25];
            app.SpeakersLabel.Text = 'Speakers';

            % Create Label_9
            app.Label_9 = uilabel(app.CalibrationTab);
            app.Label_9.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_9.Position = [697 566 225 75];
            app.Label_9.Text = {'Please let the software to know which'; ' speakers are connected to the '; 'output so the correct calibration '; 'numbers will be taken into account'};

            % Create FFOutput2EditFieldLabel
            app.FFOutput2EditFieldLabel = uilabel(app.CalibrationTab);
            app.FFOutput2EditFieldLabel.HorizontalAlignment = 'right';
            app.FFOutput2EditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput2EditFieldLabel.Position = [746 439 70 22];
            app.FFOutput2EditFieldLabel.Text = 'FF Output 2';

            % Create FFOutput2EditField
            app.FFOutput2EditField = uieditfield(app.CalibrationTab, 'numeric');
            app.FFOutput2EditField.Limits = [1 18];
            app.FFOutput2EditField.ValueChangedFcn = createCallbackFcn(app, @FFOutput2EditFieldValueChanged, true);
            app.FFOutput2EditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput2EditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.FFOutput2EditField.Position = [831 433 31 33];
            app.FFOutput2EditField.Value = 2;

            % Create FFOutput4EditFieldLabel
            app.FFOutput4EditFieldLabel = uilabel(app.CalibrationTab);
            app.FFOutput4EditFieldLabel.HorizontalAlignment = 'right';
            app.FFOutput4EditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput4EditFieldLabel.Position = [746 338 70 22];
            app.FFOutput4EditFieldLabel.Text = 'FF Output 4';

            % Create FFOutput4EditField
            app.FFOutput4EditField = uieditfield(app.CalibrationTab, 'numeric');
            app.FFOutput4EditField.Limits = [1 18];
            app.FFOutput4EditField.ValueChangedFcn = createCallbackFcn(app, @FFOutput4EditFieldValueChanged, true);
            app.FFOutput4EditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput4EditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.FFOutput4EditField.Position = [831 332 31 33];
            app.FFOutput4EditField.Value = 4;

            % Create FFOutput3EditFieldLabel
            app.FFOutput3EditFieldLabel = uilabel(app.CalibrationTab);
            app.FFOutput3EditFieldLabel.HorizontalAlignment = 'right';
            app.FFOutput3EditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput3EditFieldLabel.Position = [746 388 70 22];
            app.FFOutput3EditFieldLabel.Text = 'FF Output 3';

            % Create FFOutput3EditField
            app.FFOutput3EditField = uieditfield(app.CalibrationTab, 'numeric');
            app.FFOutput3EditField.Limits = [1 18];
            app.FFOutput3EditField.ValueChangedFcn = createCallbackFcn(app, @FFOutput3EditFieldValueChanged, true);
            app.FFOutput3EditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput3EditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.FFOutput3EditField.Position = [831 382 31 33];
            app.FFOutput3EditField.Value = 3;

            % Create FFOutput5EditFieldLabel
            app.FFOutput5EditFieldLabel = uilabel(app.CalibrationTab);
            app.FFOutput5EditFieldLabel.HorizontalAlignment = 'right';
            app.FFOutput5EditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput5EditFieldLabel.Position = [746 282 70 22];
            app.FFOutput5EditFieldLabel.Text = 'FF Output 5';

            % Create FFOutput5EditField
            app.FFOutput5EditField = uieditfield(app.CalibrationTab, 'numeric');
            app.FFOutput5EditField.Limits = [1 18];
            app.FFOutput5EditField.ValueChangedFcn = createCallbackFcn(app, @FFOutput5EditFieldValueChanged, true);
            app.FFOutput5EditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput5EditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.FFOutput5EditField.Position = [831 276 31 33];
            app.FFOutput5EditField.Value = 5;

            % Create FFOutput6EditFieldLabel
            app.FFOutput6EditFieldLabel = uilabel(app.CalibrationTab);
            app.FFOutput6EditFieldLabel.HorizontalAlignment = 'right';
            app.FFOutput6EditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput6EditFieldLabel.Position = [746 230 70 22];
            app.FFOutput6EditFieldLabel.Text = 'FF Output 6';

            % Create FFOutput6EditField
            app.FFOutput6EditField = uieditfield(app.CalibrationTab, 'numeric');
            app.FFOutput6EditField.Limits = [1 18];
            app.FFOutput6EditField.ValueChangedFcn = createCallbackFcn(app, @FFOutput6EditFieldValueChanged, true);
            app.FFOutput6EditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput6EditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.FFOutput6EditField.Position = [831 224 31 33];
            app.FFOutput6EditField.Value = 6;

            % Create FFOutput8EditFieldLabel
            app.FFOutput8EditFieldLabel = uilabel(app.CalibrationTab);
            app.FFOutput8EditFieldLabel.HorizontalAlignment = 'right';
            app.FFOutput8EditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput8EditFieldLabel.Position = [746 124 70 22];
            app.FFOutput8EditFieldLabel.Text = 'FF Output 8';

            % Create FFOutput8EditField
            app.FFOutput8EditField = uieditfield(app.CalibrationTab, 'numeric');
            app.FFOutput8EditField.Limits = [1 18];
            app.FFOutput8EditField.ValueChangedFcn = createCallbackFcn(app, @FFOutput8EditFieldValueChanged, true);
            app.FFOutput8EditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput8EditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.FFOutput8EditField.Position = [831 118 31 33];
            app.FFOutput8EditField.Value = 8;

            % Create FFOutput7EditFieldLabel
            app.FFOutput7EditFieldLabel = uilabel(app.CalibrationTab);
            app.FFOutput7EditFieldLabel.HorizontalAlignment = 'right';
            app.FFOutput7EditFieldLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput7EditFieldLabel.Position = [746 176 70 22];
            app.FFOutput7EditFieldLabel.Text = 'FF Output 7';

            % Create FFOutput7EditField
            app.FFOutput7EditField = uieditfield(app.CalibrationTab, 'numeric');
            app.FFOutput7EditField.Limits = [1 18];
            app.FFOutput7EditField.ValueChangedFcn = createCallbackFcn(app, @FFOutput7EditFieldValueChanged, true);
            app.FFOutput7EditField.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.FFOutput7EditField.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176];
            app.FFOutput7EditField.Position = [831 170 31 33];
            app.FFOutput7EditField.Value = 7;

            % Create CalibExportButton_2
            app.CalibExportButton_2 = uibutton(app.CalibrationTab, 'push');
            app.CalibExportButton_2.ButtonPushedFcn = createCallbackFcn(app, @CalibExportButton_2Pushed, true);
            app.CalibExportButton_2.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CalibExportButton_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.CalibExportButton_2.Position = [819 63 66 31];
            app.CalibExportButton_2.Text = 'Export';

            % Create ImportButton_2
            app.ImportButton_2 = uibutton(app.CalibrationTab, 'push');
            app.ImportButton_2.ButtonPushedFcn = createCallbackFcn(app, @ImportButton_2Pushed, true);
            app.ImportButton_2.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ImportButton_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.ImportButton_2.Position = [722 63 66 31];
            app.ImportButton_2.Text = 'Import';

            % Create Label_10
            app.Label_10 = uilabel(app.CalibrationTab);
            app.Label_10.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.Label_10.Position = [92 566 304 75];
            app.Label_10.Text = {'A Linear Gain (in dB) map for each speaker in the room'; 'Gain = 1 means no change in the output'};

            % Create GainTable
            app.GainTable = uitable(app.CalibrationTab);
            app.GainTable.BackgroundColor = [0.0705882352941176 0.0705882352941176 0.0705882352941176;0.129411764705882 0.129411764705882 0.129411764705882];
            app.GainTable.ColumnName = {'250Hz'; '500Hz'; '1000Hz'; '2000Hz'; '4000Hz'; 'White Noise'};
            app.GainTable.RowName = {};
            app.GainTable.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.GainTable.Position = [21 130 564 444];

            % Create AboutTab
            app.AboutTab = uitab(app.TabGroup);
            app.AboutTab.Title = 'About';
            app.AboutTab.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.AboutTab.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];

            % Create TDTGUIv3appwasdevelopedinLabel
            app.TDTGUIv3appwasdevelopedinLabel = uilabel(app.AboutTab);
            app.TDTGUIv3appwasdevelopedinLabel.FontSize = 20;
            app.TDTGUIv3appwasdevelopedinLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TDTGUIv3appwasdevelopedinLabel.Position = [42 514 1248 123];
            app.TDTGUIv3appwasdevelopedinLabel.Text = {'This app was devolped in Audio-Neuro Lab in Clinical Center in Haifa University '; 'and the Technion have collaborated to develop this app. '};

            % Create TDTGUIv3appwasdevelopedinLabel_2
            app.TDTGUIv3appwasdevelopedinLabel_2 = uilabel(app.AboutTab);
            app.TDTGUIv3appwasdevelopedinLabel_2.FontSize = 20;
            app.TDTGUIv3appwasdevelopedinLabel_2.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TDTGUIv3appwasdevelopedinLabel_2.Position = [37 354 799 123];
            app.TDTGUIv3appwasdevelopedinLabel_2.Text = {'If you have any suggestions or improvements for the app,'; 'please send an email to Jattias@univ.Haifa.ac.il'};

            % Create TDTGUIv3appwasdevelopedinLabel_3
            app.TDTGUIv3appwasdevelopedinLabel_3 = uilabel(app.AboutTab);
            app.TDTGUIv3appwasdevelopedinLabel_3.FontSize = 20;
            app.TDTGUIv3appwasdevelopedinLabel_3.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.TDTGUIv3appwasdevelopedinLabel_3.Position = [41 197 799 123];
            app.TDTGUIv3appwasdevelopedinLabel_3.Text = 'Version: 1.1';

            % Create FlowExperimentBetaTab
            app.FlowExperimentBetaTab = uitab(app.TabGroup);
            app.FlowExperimentBetaTab.Title = 'Flow Experiment Beta';
            app.FlowExperimentBetaTab.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.FlowExperimentBetaTab.ForegroundColor = [0.850980392156863 0.850980392156863 0.850980392156863];

            % Create HereyouwillabletorunexpreimentLabel
            app.HereyouwillabletorunexpreimentLabel = uilabel(app.FlowExperimentBetaTab);
            app.HereyouwillabletorunexpreimentLabel.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.HereyouwillabletorunexpreimentLabel.Position = [117 586 707 61];
            app.HereyouwillabletorunexpreimentLabel.Text = 'Here you will able to run automatic experiment that composed from severel setups/configurations of different inputs and speakers';

            % Create ImportExcelButton
            app.ImportExcelButton = uibutton(app.FlowExperimentBetaTab, 'state');
            app.ImportExcelButton.ValueChangedFcn = createCallbackFcn(app, @ImportExcelButtonValueChanged, true);
            app.ImportExcelButton.Text = 'Import Excel';
            app.ImportExcelButton.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ImportExcelButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.ImportExcelButton.Position = [113 465 122 46];

            % Create PlayPauseButton
            app.PlayPauseButton = uibutton(app.FlowExperimentBetaTab, 'state');
            app.PlayPauseButton.ValueChangedFcn = createCallbackFcn(app, @PlayPauseButtonValueChanged, true);
            app.PlayPauseButton.Enable = 'off';
            app.PlayPauseButton.Text = 'Start';
            app.PlayPauseButton.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PlayPauseButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.PlayPauseButton.Position = [365 465 122 46];

            % Create GenerateExpreimentButton
            app.GenerateExpreimentButton = uibutton(app.FlowExperimentBetaTab, 'push');
            app.GenerateExpreimentButton.ButtonPushedFcn = createCallbackFcn(app, @GenerateExpreimentButtonPushed, true);
            app.GenerateExpreimentButton.BackgroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.GenerateExpreimentButton.FontColor = [0.850980392156863 0.850980392156863 0.850980392156863];
            app.GenerateExpreimentButton.Position = [109 78 130 47];
            app.GenerateExpreimentButton.Text = 'Generate Expreiment';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = TDT_GUI_v3_App_exported

            runningApp = getRunningApp(app);

            % Check for running singleton app
            if isempty(runningApp)

                % Create UIFigure and components
                createComponents(app)

                % Register the app with App Designer
                registerApp(app, app.UIFigure)

                % Execute the startup function
                runStartupFcn(app, @startupFcn)
            else

                % Focus the running singleton app
                figure(runningApp.UIFigure)

                app = runningApp;
            end

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end