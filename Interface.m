% function varargout = Interface(varargin)
% % INTERFACE MATLAB code for Interface.fig
% %      INTERFACE, by itself, creates a new INTERFACE or raises the existing
% %      singleton*.
% %
% %      H = INTERFACE returns the handle to a new INTERFACE or the handle to
% %      the existing singleton*.
% %
% %      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
% %      function named CALLBACK in INTERFACE.M with the given input arguments.
% %
% %      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
% %      existing singleton*.  Starting from the left, property value pairs are
% %      applied to the GUI before Interface_OpeningFcn gets called.  An
% %      unrecognized property name or invalid value makes property application
% %      stop.  All inputs are passed to Interface_OpeningFcn via varargin.
% %
% %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
% %      instance to run (singleton)".
% %
% % See also: GUIDE, GUIDATA, GUIHANDLES
% 
% % Edit the above text to modify the response to help Interface
% 
% % Last Modified by GUIDE v2.5 24-Jan-2016 18:52:09
% 
% % Begin initialization code - DO NOT EDIT
% gui_Singleton = 1;
% gui_State = struct('gui_Name',       mfilename, ...
%                    'gui_Singleton',  gui_Singleton, ...
%                    'gui_OpeningFcn', @Interface_OpeningFcn, ...
%                    'gui_OutputFcn',  @Interface_OutputFcn, ...
%                    'gui_LayoutFcn',  [] , ...
%                    'gui_Callback',   []);
% if nargin && ischar(varargin{1})
%     gui_State.gui_Callback = str2func(varargin{1});
% end
% 
% if nargout
%     [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
% else
%     gui_mainfcn(gui_State, varargin{:});
% end
% % End initialization code - DO NOT EDIT
% 
% % global runP;
% % runP=2;
% % global exit;
% % exit=2;
% % --- Executes just before Interface is made visible.
% function Interface_OpeningFcn(hObject, eventdata, handles, varargin)
% % This function has no output args, see OutputFcn.
% % hObject    handle to figure
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% % varargin   command line arguments to Interface (see VARARGIN)
% 
% % Choose default command line output for Interface
% handles.output = hObject;
% % Update handles structure
% guidata(hObject, handles);
% % UIWAIT makes Interface wait for user response (see UIRESUME)
% % uiwait(handles.figure1);
% 
% % --- Outputs from this function are returned to the command line.
% function varargout = Interface_OutputFcn(hObject, eventdata, handles) 
% % varargout  cell array for returning output args (see VARARGOUT);
% % hObject    handle to figure
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Get default command line output from handles structure
% varargout{1} = handles.output;
% 
% % --- Executes on button press in Displacement.
% function Displacement_Callback(hObject, eventdata, handles)
% % hObject    handle to Displacement (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % --------------------------------------------------------------------
% function Friction_Testing_Callback(hObject, eventdata, handles)
% % hObject    handle to Friction_Testing (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% 
% % --------------------------------------------------------------------
% function Camera_Callback(hObject, eventdata, handles)
% % hObject    handle to Camera (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% print('Camera');
% 
% % --------------------------------------------------------------------
% function Recorded_Video_Callback(hObject, eventdata, handles)
% % hObject    handle to Recorded_Video (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% printf('Recorded Video');
% disp(sprintf('Recorded Video'));
% 
% % --- Executes on selection change in CameraRecordedPopUp.
% function CameraRecordedPopUp_Callback(hObject, eventdata, handles)
% % hObject    handle to CameraRecordedPopUp (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% % Hints: contents = cellstr(get(hObject,'String')) returns CameraRecordedPopUp contents as cell array
% %        contents{get(hObject,'Value')} returns selected item from CameraRecordedPopUp
% global option;
% items = get(hObject,'String');
% index_selected = get(hObject,'Value');
% item_selected = items{index_selected};
% display(item_selected);
% if (item_selected == 1)
%     option=1;
% else
%     option=2;
% end
% 
% % --- Executes during object creation, after setting all properties.
% function CameraRecordedPopUp_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to CameraRecordedPopUp (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: popupmenu controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% % --------------------------------------------------------------------
% function FrictionT_DataA_Run_Menu_Callback(hObject, eventdata, handles)
% % hObject    handle to FrictionT_DataA_Run_Menu (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % --------------------------------------------------------------------
% function Displacement_Run_Menu_Callback(hObject, eventdata, handles)
% % hObject    handle to Displacement_Run_Menu (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % --- Executes on button press in RunPushButton.
% function RunPushButton_Callback(hObject, eventdata, handles)
% % hObject    handle to RunPushButton (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% %This will run the main_menu code when the run button is pressed.
% run('main_menu.m');
% global xAxisMicronsValue;
% global yAxisMicronsValue;
% global xAxisPixelsValue;
% global yAxisPixelsValue;
% set(handles.xAxisMicrons, 'String', num2str(xAxisMicronsValue));
% set(handles.yAxisMicrons, 'String', num2str(yAxisMicronsValue));
% set(handles.xAxisPixels, 'String', num2str(xAxisPixelsValue));
% set(handles.yAxisPixels, 'String', num2str(yAxisPixelsValue));
% 
% % --- Executes on button press in SelectVideoPushButton.
% function SelectVideoPushButton_Callback(hObject, eventdata, handles)
% % hObject    handle to SelectVideoPushButton (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% %This will allow a dialogue window to open to give the illusion to the
% %   used of a file being uploaded, but in reality it will simply obtain
% %   the fulle path and name of the .avi file to send it to the main_menu 
% %   and read_video programs.
% global filename;
% [FileName, PathName]= uigetfile('*.avi', 'Select the Video File');
% % If the user clicks Cancel
% if isequal(FileName, 0)
%     filename= ' ';
% else
%     filename = strcat(PathName, FileName);
% end
% 
% %display(filename); //For testing
% %display([FileName, PathName]); //For testing
% 
% function EnterPrecisionTextBox_Callback(hObject, eventdata, handles)
% % hObject    handle to EnterPrecisionTextBox (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of EnterPrecisionTextBox as text
% %        str2double(get(hObject,'String')) returns contents of EnterPrecisionTextBox as a double
% global InPrecision;
% InPrecision = str2double(get(hObject,'string'));
% if isnan(InPrecision)
%   errordlg('You must enter a numeric value','Invalid Input','modal')
%   uicontrol(hObject)
%   return
% else
%   display(InPrecision);
% end
% 
% % --- Executes during object creation, after setting all properties.
% function EnterPrecisionTextBox_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to EnterPrecisionTextBox (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% function EnterMaxDispTextBox_Callback(hObject, eventdata, handles)
% % hObject    handle to EnterMaxDispTextBox (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of EnterMaxDispTextBox as text
% %        str2double(get(hObject,'String')) returns contents of EnterMaxDispTextBox as a double
% global InMaxDisp;
% InMaxDisp = str2double(get(hObject,'string'));
% if isnan(InMaxDisp)
%   errordlg('You must enter a numeric value','Invalid Input','modal')
%   uicontrol(hObject)
%   return
% else
%   display(InMaxDisp);
% end
% 
% % --- Executes during object creation, after setting all properties.
% function EnterMaxDispTextBox_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to EnterMaxDispTextBox (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% % --- Executes on button press in SelectFolderPushButton.
% function SelectFolderPushButton_Callback(hObject, eventdata, handles)
% % hObject    handle to SelectFolderPushButton (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % The user can choose which folder to save the data files and figures to.
% global SaveFolder;
% SaveFolder= uigetdir('Select folder');
% % If the user clicks Cancel
% if isequal(SaveFolder, 0)
%     SaveFolder= ' ';
% end
% %display(SaveFolder);
% 
% function NameFigureTextBox_Callback(hObject, eventdata, handles)
% % hObject    handle to NameFigureTextBox (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of NameFigureTextBox as text
% %        str2double(get(hObject,'String')) returns contents of NameFigureTextBox as a double
% global NameFigure;
% NameFigure = get(hObject,'string');
% display(NameFigure);
% 
% % --- Executes during object creation, after setting all properties.
% function NameFigureTextBox_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to NameFigureTextBox (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% function NameDataFileTextBox_Callback(hObject, eventdata, handles)
% % hObject    handle to NameDataFileTextBox (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of NameDataFileTextBox as text
% %        str2double(get(hObject,'String')) returns contents of NameDataFileTextBox as a double
% global NameDataFile;
% NameDataFile = get(hObject,'string');
% display(NameDataFile);
% 
% % --- Executes during object creation, after setting all properties.
% function NameDataFileTextBox_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to NameDataFileTextBox (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
