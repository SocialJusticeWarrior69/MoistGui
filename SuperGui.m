function varargout = SuperGui(varargin)
% SUPERGUI MATLAB code for SuperGui.fig
%      SUPERGUI, by itself, creates a new SUPERGUI or raises the existing
%      singleton*.
%
%      H = SUPERGUI returns the handle to a new SUPERGUI or the handle to
%      the existing singleton*.
%
%      SUPERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUPERGUI.M with the given input arguments.
%
%      SUPERGUI('Property','Value',...) creates a new SUPERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SuperGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SuperGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SuperGui

% Last Modified by GUIDE v2.5 31-Oct-2017 22:06:55

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SuperGui_OpeningFcn, ...
                   'gui_OutputFcn',  @SuperGui_OutputFcn, ...
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

% --- Executes just before SuperGui is made visible.
function SuperGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SuperGui (see VARARGIN)

% Choose default command line output for SuperGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%frequencies of each note
fA = 440.00; % Master Tuned to A 440
fAb = fA*2^(-1/12);
fG = fAb*2^(-1/12);
fGb = fG*2^(-1/12);
fF = fGb*2^(-1/12);
fE = fF*2^(-1/12);
fEb = fE*2^(-1/12);
fD = fEb*2^(-1/12);
fDb = fD*2^(-1/12);
fC = fDb*2^(-1/12);
fBb = fA*2^(1/12);
fB = fBb*2^(1/12);
handles.fA = fA;
handles.fAb = fAb;
handles.fG = fG;
handles.fGb = fGb;
handles.fF = fF;
handles.fE = fE;
handles.fEb = fEb;
handles.fD = fD;
handles.fDb = fDb;
handles.fC = fC;
handles.fBb = fBb;
handles.fB = fB;
%amplitude of signal
amp = 10;
handles.amp = amp;
%Sampling Frequency
fSample = 44100;
handles.fSample = fSample;
%Audio Time
tmax = 0.25;
handles.tmax = tmax;
%Points of Sample
npts = fSample*tmax;
handles.npts = npts;
%Octave Set
Octave = 0;
handles.Octave = Octave;

guidata(hObject,handles);
%%%%%%%%%%%%%%%%%%%%%%%%%%

% This sets up the initial plot - only do when we are invisible
% so window can get raised using SuperGui.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
end

% UIWAIT makes SuperGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SuperGui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;

popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        plot(rand(5));
    case 2
        plot(sin(1:0.01:25.99));
    case 3
        bar(1:.5:10);
    case 4
        plot(membrane);
    case 5
        surf(peaks);
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in RecordButton.
function RecordButton_Callback(hObject, eventdata, handles)
% hObject    handle to RecordButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AudioInput = audiorecorder(8000,8,1);
if get(hObject,'Value') == 1 
    %Records audio for two seconds
    disp('Start');
    recordblocking(AudioInput,2);
    disp('End');
else
end



% --- Executes on button press in PlayButton.
function PlayButton_Callback(hObject, eventdata, handles)
% hObject    handle to PlayButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AudioInput = get(handles.RecordButton, 'Value');
if get(hObject,'Value') == 1
    p = play(AudioInput);
else
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% PUSH BUTTON KEYS %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% C key.
function Ckey_Callback(hObject, eventdata, handles)
% hObject    handle to Ckey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
t=linspace(0,handles.tmax,handles.npts);
tvector = 2*pi*t;
y = handles.amp*sin(handles.fC*tvector);
sound(y,handles.fSample)
else
end



% Db Key.
function DbKey_Callback(hObject, eventdata, handles)
% hObject    handle to DbKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
t=linspace(0,handles.tmax,handles.npts);
tvector = 2*pi*t;
y = handles.amp*sin(handles.fDb*tvector);
sound(y,handles.fSample)
else
end

% D key.
function Dkey_Callback(hObject, eventdata, handles)
% hObject    handle to Dkey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
t=linspace(0,handles.tmax,handles.npts);
tvector = 2*pi*t;
y = handles.amp*sin(handles.fD*tvector);
sound(y,handles.fSample)
else
end

% Eb Key.
function EbKey_Callback(hObject, eventdata, handles)
% hObject    handle to EbKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
t=linspace(0,handles.tmax,handles.npts);
tvector = 2*pi*t;
y = handles.amp*sin(handles.fEb*tvector);
sound(y,handles.fSample)
else
end

% E key.
function Ekey_Callback(hObject, eventdata, handles)
% hObject    handle to Ekey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
t=linspace(0,handles.tmax,handles.npts);
tvector = 2*pi*t;
y = handles.amp*sin(handles.fE*tvector);
sound(y,handles.fSample)
else
end

% F key.
function Fkey_Callback(hObject, eventdata, handles)
% hObject    handle to Fkey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
t=linspace(0,handles.tmax,handles.npts);
tvector = 2*pi*t;
y = handles.amp*sin(handles.fF*tvector);
sound(y,handles.fSample)
else
end

% Gb Key.
function GbKey_Callback(hObject, eventdata, handles)
% hObject    handle to GbKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
t=linspace(0,handles.tmax,handles.npts);
tvector = 2*pi*t;
y = handles.amp*sin(handles.fGb*tvector);
sound(y,handles.fSample)
else
end

% G key.
function Gkey_Callback(hObject, eventdata, handles)
% hObject    handle to Gkey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
t=linspace(0,handles.tmax,handles.npts);
tvector = 2*pi*t;
y = handles.amp*sin(handles.fG*tvector);
sound(y,handles.fSample)
else
end

% Ab Key.
function AbKey_Callback(hObject, eventdata, handles)
% hObject    handle to AbKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
t=linspace(0,handles.tmax,handles.npts);
tvector = 2*pi*t;
y = handles.amp*sin(handles.fAb*tvector);
sound(y,handles.fSample)
else
end

% A key.
function Akey_Callback(hObject, eventdata, handles)
% hObject    handle to Akey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
t=linspace(0,handles.tmax,handles.npts);
tvector = 2*pi*t;
y = handles.amp*sin(handles.fA*tvector);
sound(y,handles.fSample)
else
end

% Bb Key.
function BbKey_Callback(hObject, eventdata, handles)
% hObject    handle to BbKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
t=linspace(0,handles.tmax,handles.npts);
tvector = 2*pi*t;
y = handles.amp*sin(handles.fBb*tvector);
sound(y,handles.fSample)
else
end

% B key.
function Bkey_Callback(hObject, eventdata, handles)
% hObject    handle to Bkey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
t=linspace(0,handles.tmax,handles.npts);
tvector = 2*pi*t;
y = handles.amp*sin(handles.fB*tvector);
sound(y,handles.fSample)
else
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% PUSH BUTTON KEYS %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in OctaveDown.
function OctaveDown_Callback(hObject, eventdata, handles)
% hObject    handle to OctaveDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.Octave = handles.Octave -1;
    guidata(hObject, handles);
    disp(handles.Octave)
else
end
% Hint: get(hObject,'Value') returns toggle state of OctaveDown


% --- Executes on button press in OctaveUp.
function OctaveUp_Callback(hObject, eventdata, handles)
% hObject    handle to OctaveUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.Octave = handles.Octave + 1;
    guidata(hObject, handles);
    disp(handles.Octave)
else
end
% Hint: get(hObject,'Value') returns toggle state of OctaveUp
