function varargout = InterfaceDataAnalysis(varargin)
%Saving this for later https://youtu.be/9Tli0Fiw7r4


% INTERFACEDATAANALYSIS MATLAB code for InterfaceDataAnalysis.fig
%      INTERFACEDATAANALYSIS, by itself, creates a new INTERFACEDATAANALYSIS or raises the existing
%      singleton*.
%
%      H = INTERFACEDATAANALYSIS returns the handle to a new INTERFACEDATAANALYSIS or the handle to
%      the existing singleton*.
%
%      INTERFACEDATAANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACEDATAANALYSIS.M with the given input arguments.
%
%      INTERFACEDATAANALYSIS('Property','Value',...) creates a new INTERFACEDATAANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before InterfaceDataAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to InterfaceDataAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help InterfaceDataAnalysis

% Last Modified by GUIDE v2.5 05-Feb-2016 11:51:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @InterfaceDataAnalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @InterfaceDataAnalysis_OutputFcn, ...
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


% --- Executes just before InterfaceDataAnalysis is made visible.
function InterfaceDataAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to InterfaceDataAnalysis (see VARARGIN)

% Choose default command line output for InterfaceDataAnalysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes InterfaceDataAnalysis wait for user response (see UIRESUME)
% uiwait(handles.figureInterfaceData);

% --- Outputs from this function are returned to the command line.
function varargout = InterfaceDataAnalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Run_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Run_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Displacement_Run_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Displacement_Run_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('InterfaceDisplacement.m');
delete(handles.figureInterfaceData);

% --------------------------------------------------------------------
function FrictionT_DataA_Run_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to FrictionT_DataA_Run_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ------- FRICTION TESTING DATA ANALYSIS ------- %

% --- Executes on button press in SelectLeftPushButton.
function SelectLeftPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to SelectLeftPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global LeftFileName;
[FileName, PathName]= uigetfile('*.txt', 'Select the Text File');
% If the user clicks Cancel
if isequal(FileName, 0)
    LeftFileName= ' ';
else
    LeftFileName = strcat(PathName, FileName);
end

% --- Executes on button press in SelectRightPushButton.
function SelectRightPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to SelectRightPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RightFileName;
[FileName, PathName]= uigetfile('*.txt', 'Select the Text File');
% If the user clicks Cancel
if isequal(FileName, 0)
    RightFileName= ' ';
else
    RightFileName = strcat(PathName, FileName);
end

% --- Executes on button press in SelectTopPushButton.
function SelectTopPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to SelectTopPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TopFileName;
[FileName, PathName]= uigetfile('*.txt', 'Select the Text File');
% If the user clicks Cancel
if isequal(FileName, 0)
    TopFileName= ' ';
else
    TopFileName = strcat(PathName, FileName);
end

% --- Executes on button press in SelectBottomPushButton.
function SelectBottomPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to SelectBottomPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global BottomFileName;
[FileName, PathName]= uigetfile('*.txt', 'Select the Text File');
% If the user clicks Cancel
if isequal(FileName, 0)
    BottomFileName= ' ';
else
    BottomFileName = strcat(PathName, FileName);
end

% --- Executes on button press in CompareLateralPushButton.
function CompareLateralPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to CompareLateralPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global LeftFileName;
global RightFileName;
% Read the selected data files.
LData= csvread(LeftFileName)
RData= csvread(RightFileName);

% Obtain the tangent angles for both left and right files.
dL = length(LData);
for i = 1:dL
    LDataX= (LData(i,1));
    LDataY= (LData(i,2));
    LAngle(i, :)= atand(LDataY/LDataX);
end
%display(LAngle);

dR = length(RData);
for i = 1:dR
    RDataX= (RData(i,1));
    RDataY= (RData(i,2));
    RAngle(i, :)= atand(RDataY/RDataX);
end
%display(RAngle);

% Calculate the percent difference between each angle point, and average the
% total percent difference.
for i = 1:dR
    PerDiffLat(i, :)=((abs(RAngle(i, 1) - LAngle(i, 1))) / (0.5*(RAngle(i, 1) + LAngle(i, 1))))*100;
end

% Plot the two angles and their percent difference:
figure;
plot(RAngle);
hold on
plot(LAngle);
hold on
plot(PerDiffLat);
title('Right and Left Angles and Percent Difference');
legend('Right Angle','Left Angle', 'Percent Difference','Location','southwest')
xlabel('Frames') % x-axis label
ylabel('Degrees') % y-axis label


ALat= mean(PerDiffLat(~isinf(PerDiffLat)), 'omitnan');
display(PerDiffLat);
display(ALat);
    
% --- Executes on button press in CompareNormalPushButton.
function CompareNormalPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to CompareNormalPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TopFileName;
global BottomFileName;
% Read the selected data files.
TData= csvread(TopFileName);
BData= csvread(BottomFileName);

% Display the maximum values for top and bottom files (maximum displacement
% for the normal part of the system).

disp('Maximum y-displacement in pixels for Top File');
disp(min(TData(:,2)));
disp('Maximum y-displacement in pixels for Bottom File');
disp(min(BData(:,2)));

% Obtain the angles for both top and bottom files.
dT = length(TData);
for i = 1:dT
    TDataX= (TData(i,1));
    TDataY= (TData(i,2));
    TAngle(i, :)= atand(TDataY/TDataX);
end
%display(TAngle);

dB = length(BData);
for i = 1:dB
    BDataX= (BData(i,1));
    BDataY= (BData(i,2));
    BAngle(i, :)= atand(BDataY/BDataX);
end
%display(BAngle);

% Calculate the percent difference between each angle point, and average the
% total percent difference.
for i = 1:dT
    PerDiffNorm(i, :)=((abs(TAngle(i, 1) - BAngle(i, 1))) / (0.5*(TAngle(i, 1) + BAngle(i, 1))))*100;
end

% Plot the two angles and their percent difference:
figure;
plot(BAngle);
hold on
plot(TAngle);
hold on
plot(PerDiffNorm);
title('Top and Bottom Angles and Percent Difference');
legend('Bottom Angle','Top Angle', 'Percent Difference','Location','southwest')
xlabel('Frames') % x-axis label
ylabel('Degrees') % y-axis label

ANorm= mean(PerDiffNorm(~isinf(PerDiffNorm)), 'omitnan');
%display(PerDiffNorm);
display(ANorm);

% ------- DISPLACEMENT DIFFERENCE BETWEEN TWO AREAS ------- %

% --- Executes on button press in SelectFirstPushButton.
function SelectFirstPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to SelectFirstPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FirstFileName;
[FileName, PathName]= uigetfile('*.txt', 'Select the Text File');
% If the user clicks Cancel
if isequal(FileName, 0)
    FirstFileName= ' ';
else
    FirstFileName = strcat(PathName, FileName);
end

% --- Executes on button press in SelectSecondPushButton.
function SelectSecondPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to SelectSecondPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SecondFileName;
[FileName, PathName]= uigetfile('*.txt', 'Select the Text File');
% If the user clicks Cancel
if isequal(FileName, 0)
    SecondFileName= ' ';
else
    SecondFileName = strcat(PathName, FileName);
end

% --- Executes on button press in CompareDispDiffPushButton.
function CompareDispDiffPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to CompareDispDiffPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FirstFileName;
global SecondFileName;
global DispDiffSaveFolder;
global DispDiffNameFigure;
global DispDiffNameDataFile;

% Read the selected data files.
FData= csvread(FirstFileName);
SData= csvread(SecondFileName);

% Obtain the displacement difference for both files (x and y).
dF = length(FData);
for i = 1:dF
    FDataX= (FData(i,1));
    FDataY= (FData(i,2));
    SDataX= (SData(i,1));
    SDataY= (SData(i,2));
    Diff(i, 1)= FDataX-SDataX;
    Diff(i, 2)= FDataY-SDataY;
end

% Plot the figure
figure;
plot(Diff);
title(strcat(DispDiffNameFigure,' Displacement Difference - Subpixel'));
legend('Difference in X','Difference in Y','Location','southwest')
xlabel('Frames') % x-axis label
ylabel('Pixels') % y-axis label

% Indicates where to save figure and what to name it.
savefig(strcat(DispDiffSaveFolder, '/', DispDiffNameFigure, '.fig'));

% Indicates where to save data file and what to name it.
dlmwrite(strcat(DispDiffSaveFolder, '/', DispDiffNameDataFile, '.txt'), Diff);

% --- Executes on button press in DispDiffSelectFolderPushButton.
function DispDiffSelectFolderPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to DispDiffSelectFolderPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% The user can choose which folder to save the data files and figures to.
global DispDiffSaveFolder;
DispDiffSaveFolder= uigetdir('Select folder');
% If the user clicks Cancel
if isequal(DispDiffSaveFolder, 0)
    DispDiffSaveFolder= ' ';
end


function NameFigureTextBox_Callback(hObject, eventdata, handles)
% hObject    handle to NameFigureTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NameFigureTextBox as text
%        str2double(get(hObject,'String')) returns contents of NameFigureTextBox as a double
global DispDiffNameFigure;
DispNameFigure = get(hObject,'string');
display(DispNameFigure);

% --- Executes during object creation, after setting all properties.
function NameFigureTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NameFigureTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NameDataFileTextBox_Callback(hObject, eventdata, handles)
% hObject    handle to NameDataFileTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DispDiffNameDataFile;
DispDiffNameDataFile = get(hObject,'string');
display(DispDiffNameDataFile);
% Hints: get(hObject,'String') returns contents of NameDataFileTextBox as text
%        str2double(get(hObject,'String')) returns contents of NameDataFileTextBox as a double


% --- Executes during object creation, after setting all properties.
function NameDataFileTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NameDataFileTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
