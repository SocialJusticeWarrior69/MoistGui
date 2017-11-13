%tqtq
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

% Last Modified by GUIDE v2.5 13-Nov-2017 13:29:04

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
      
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update handles structure
guidata(hObject, handles);

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
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 cla;
            t=linspace(0,handles.tmax,handles.npts);
            plot(t(1:100),handles.y(1:100))
            
            %Setting Plot Axis
            Tmin = min(t(1:100));
            Tmax = max(t(1:100));
            xlim([Tmin Tmax])
            Min = min(handles.y);
            Max = max(handles.y);
            ylim([Min Max])



% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------

% --------------------------------------------------------------------


% --- Executes on button press in RecordButton.
function RecordButton_Callback(hObject, eventdata, handles)
% hObject    handle to RecordButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 cla;
AudioIn = audiorecorder(44100,16,1);
if get(hObject,'Value') == 1
    %Records audio for a second
    recordblocking(AudioIn,1);
    Audio = getaudiodata(AudioIn);
    handles.Audio = Audio;
    guidata(hObject,handles);
else
end



% --- Executes on button press in PlayButton.
function PlayButton_Callback(hObject, eventdata, handles)
% hObject    handle to PlayButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 cla;
if get(hObject,'Value') == 1
    soundsc(handles.Audio,44100);
    plot(handles.Audio);
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
    y = handles.amp*sin(handles.fC*(2^handles.Octave)*tvector);
    handles.y = y;
    guidata(hObject,handles);
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
    y = handles.amp*sin(handles.fDb*(2^handles.Octave)*tvector);
    handles.y = y;
    guidata(hObject,handles);
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
    y = handles.amp*sin(handles.fD*(2^handles.Octave)*tvector);
    handles.y = y;
    guidata(hObject,handles);
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
    y = handles.amp*sin(handles.fEb*(2^handles.Octave)*tvector);
    handles.y = y;
    guidata(hObject,handles);
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
    y = handles.amp*sin(handles.fE*(2^handles.Octave)*tvector);
    handles.y = y;
    guidata(hObject,handles);
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
    y = handles.amp*sin(handles.fF*(2^handles.Octave)*tvector);
    handles.y = y;
    guidata(hObject,handles);
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
    y = handles.amp*sin(handles.fGb*(2^handles.Octave)*tvector);
    handles.y = y;
    guidata(hObject,handles);
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
    y = handles.amp*sin(handles.fG*(2^handles.Octave)*tvector);
    handles.y = y;
    guidata(hObject,handles);
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
    y = handles.amp*sin(handles.fAb*(2^handles.Octave)*tvector);
    handles.y = y;
    guidata(hObject,handles);
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
    y = handles.amp*sin(handles.fA*(2^handles.Octave)*tvector);
    handles.y = y;
    guidata(hObject,handles);
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
    y = handles.amp*sin(handles.fBb*(2^handles.Octave)*tvector);
    handles.y = y;
    guidata(hObject,handles);
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
    y = handles.amp*sin(handles.fB*(2^handles.Octave)*tvector);
    handles.y = y;
    guidata(hObject,handles);
    sound(y,handles.fSample)
else
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% PUSH BUTTON KEYS %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in UpOct.
function UpOct_Callback(hObject, eventdata, handles)
% hObject    handle to UpOct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.Octave = handles.Octave + 1;
    guidata(hObject, handles);
    set(handles.OctDisp, 'String', num2str(handles.Octave));
else
end
% Hint: get(hObject,'Value') returns toggle state of UpOct


% --- Executes on button press in DownOct.
function DownOct_Callback(hObject, eventdata, handles)
% hObject    handle to DownOct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.Octave = handles.Octave -1;
    guidata(hObject, handles);
    set(handles.OctDisp, 'String', num2str(handles.Octave));
else
end
% Hint: get(hObject,'Value') returns toggle state of DownOct
