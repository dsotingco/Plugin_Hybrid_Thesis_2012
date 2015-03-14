function varargout = PHEVGUI(varargin)
% PHEVGUI MATLAB code for PHEVGUI.fig
%      PHEVGUI, by itself, creates a new PHEVGUI or raises the existing
%      singleton*.
%
%      H = PHEVGUI returns the handle to a new PHEVGUI or the handle to
%      the existing singleton*.
%
%      PHEVGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PHEVGUI.M with the given input arguments.
%
%      PHEVGUI('Property','Value',...) creates a new PHEVGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PHEVGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PHEVGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PHEVGUI

% Last Modified by GUIDE v2.5 13-Apr-2012 22:12:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PHEVGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PHEVGUI_OutputFcn, ...
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


% --- Executes just before PHEVGUI is made visible.
function PHEVGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PHEVGUI (see VARARGIN)

% Choose default command line output for PHEVGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
setDefault(hObject,eventdata,handles);

% UIWAIT makes PHEVGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PHEVGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in stickGenButton.
function stickGenButton_Callback(hObject, eventdata, handles)
%panels    
set(handles.stickGenPanel,'Visible','on');
set(handles.quickCalcPanel,'Visible','off');
set(handles.plotterPanel,'Visible','off');

%tabs
set(handles.stickGenButton,'Position',[6.8 44 23 2]);
set(handles.stickGenButton,'FontWeight','bold');
set(handles.quickCalcButton,'Position',[29.6 44 23 1.5]);
set(handles.quickCalcButton,'FontWeight','normal');
set(handles.plotterButton,'Position',[52.4 44 23 1.5]);
set(handles.plotterButton,'FontWeight','normal');

%update
guidata(hObject,handles);
setDefault(hObject,eventdata,handles);

% --- Executes on button press in quickCalcButton.
function quickCalcButton_Callback(hObject, eventdata, handles)
%panels    
set(handles.stickGenPanel,'Visible','off');
set(handles.quickCalcPanel,'Visible','on');
set(handles.plotterPanel,'Visible','off');

%tabs
set(handles.stickGenButton,'Position',[6.8 44 23 1.5]);    
set(handles.stickGenButton,'FontWeight','normal');
set(handles.quickCalcButton,'Position',[29.6 44 23 2]);
set(handles.quickCalcButton,'FontWeight','bold');
set(handles.plotterButton,'Position',[52.4 44 23 1.5]);
set(handles.plotterButton,'FontWeight','normal');

%update
guidata(hObject,handles);
quickCalcUpdate(hObject,eventdata,handles);


% --- Executes on button press in plotterButton.
function plotterButton_Callback(hObject, eventdata, handles)
%panels    
set(handles.stickGenPanel,'Visible','off');
set(handles.quickCalcPanel,'Visible','off');
set(handles.plotterPanel,'Visible','on');

%tabs
set(handles.stickGenButton,'Position',[6.8 44 23 1.5]);    
set(handles.stickGenButton,'FontWeight','normal');
set(handles.quickCalcButton,'Position',[29.6 44 23 1.5]);
set(handles.quickCalcButton,'FontWeight','normal');
set(handles.plotterButton,'Position',[52.4 44 23 2]);
set(handles.plotterButton,'FontWeight','bold');

%update
guidata(hObject,handles);

% --- Executes on selection change in stickGenArchMenu.
function stickGenArchMenu_Callback(hObject, eventdata, handles)
archstr = get(hObject,'String');
archval = get(hObject,'Value');
handles.arch = archstr{archval};
%turn off the ultracapacitor menus if appropriate
if strcmp(handles.arch,'SERIES') || strcmp(handles.arch,'PARALLEL') || strcmp(handles.arch,'SPLIT')
    set(handles.stickGenUcaps,'Enable','off');
    set(handles.stickGenUcapsSlider,'Enable','off');
    set(handles.stickGenUcapsText,'Enable','off');
else
    set(handles.stickGenUcaps,'Enable','on');
    set(handles.stickGenUcapsSlider,'Enable','on');
    set(handles.stickGenUcapsText,'Enable','on');
    handles.ucaps = str2double(get(handles.stickGenUcaps,'String'));
end
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function stickGenArchMenu_CreateFcn(hObject, eventdata, handles)
archstr = get(hObject,'String');
archval = get(hObject,'Value');
handles.arch = archstr{archval};
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);


function stickGenBat_Callback(hObject, eventdata, handles)
if str2double(get(hObject,'String'))<get(handles.stickGenBatSlider,'Min')
    handles.bat = get(handles.stickGenBatSlider,'Min');
    set(handles.stickGenBatSlider,'Value',handles.bat);
    set(hObject,'String',handles.bat);
elseif str2double(get(hObject,'String'))>get(handles.stickGenBatSlider,'Max')
    handles.bat = get(handles.stickGenBatSlider,'Max');
    set(handles.stickGenBatSlider,'Value',handles.bat);
    set(hObject,'String',handles.bat);
else
    handles.bat = str2double(get(hObject,'String'));
    set(handles.stickGenBatSlider,'Value',handles.bat);
end
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function stickGenBat_CreateFcn(hObject, eventdata, handles)
handles.bat = str2double(get(hObject,'String'));
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);


function stickGenMot_Callback(hObject, eventdata, handles)
if str2double(get(hObject,'String')) < get(handles.stickGenMotSlider,'Min')
    handles.motor = get(handles.stickGenMotSlider,'Min');
    set(handles.stickGenMotSlider,'Value',handles.motor);
    set(hObject,'String',handles.motor);
elseif str2double(get(hObject,'String')) > get(handles.stickGenMotSlider,'Max')
    handles.motor = get(handles.stickGenMotSlider,'Max');
    set(handles.stickGenMotSlider,'Value',handles.motor);
    set(hObject,'String',handles.motor);
else
    handles.motor = str2double(get(hObject,'String'));
    set(handles.stickGenMotSlider,'Value',handles.motor);
end
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function stickGenMot_CreateFcn(hObject, eventdata, handles)
handles.motor = str2double(get(hObject,'String'));
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);


function stickGenEng_Callback(hObject, eventdata, handles)
if str2double(get(hObject,'String')) < get(handles.stickGenEngSlider,'Min')
    handles.engine = get(handles.stickGenEngSlider,'Min');
    set(handles.stickGenEngSlider,'Value',handles.engine);
    set(hObject,'String',handles.engine);
elseif str2double(get(hObject,'String')) > get(handles.stickGenEngSlider,'Max')
    handles.engine = get(handles.stickGenEngSlider,'Max');
    set(handles.stickGenEngSlider,'Value',handles.engine);
    set(hObject,'String',handles.engine);
else
    handles.engine = str2double(get(hObject,'String'));
    set(handles.stickGenEngSlider,'Value',handles.engine);
end
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function stickGenEng_CreateFcn(hObject, eventdata, handles)
handles.engine = str2double(get(hObject,'String'));
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);


function stickGenUcaps_Callback(hObject, eventdata, handles)
if str2double(get(hObject,'String')) < get(handles.stickGenUcapsSlider,'Min')
    handles.ucaps = get(handles.stickGenUcapsSlider,'Min');
    set(handles.stickGenUcapsSlider,'Value',handles.ucaps);
    set(hObject,'String',handles.ucaps);
elseif str2double(get(hObject,'String')) > get(handles.stickGenUcapsSlider,'Max')
    handles.ucaps = get(handles.stickGenUcapsSlider,'Max');
    set(handles.stickGenUcapsSlider,'Value',handles.ucaps);
    set(hObject,'String',handles.ucaps);
else
    handles.ucaps = str2double(get(hObject,'String'));
    set(handles.stickGenUcapsSlider,'Value',handles.ucaps);
end
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function stickGenUcaps_CreateFcn(hObject, eventdata, handles)
handles.ucaps = str2double(get(hObject,'String'));
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);

% --- Executes on slider movement.
function stickGenBatSlider_Callback(hObject, eventdata, handles)
set(handles.stickGenBat,'String',get(hObject,'Value'));
handles.bat = get(hObject,'Value');
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function stickGenBatSlider_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
guidata(hObject,handles);

% --- Executes on slider movement.
function stickGenMotSlider_Callback(hObject, eventdata, handles)
set(handles.stickGenMot,'String',get(hObject,'Value'));
handles.motor = get(hObject,'Value');
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function stickGenMotSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stickGenMotSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
guidata(hObject,handles);

% --- Executes on slider movement.
function stickGenEngSlider_Callback(hObject, eventdata, handles)
set(handles.stickGenEng,'String',get(hObject,'Value'));
handles.engine = get(hObject,'Value');
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function stickGenEngSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stickGenEngSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
guidata(hObject,handles);

% --- Executes on slider movement.
function stickGenUcapsSlider_Callback(hObject, eventdata, handles)
set(handles.stickGenUcaps,'String',get(hObject,'Value'));
handles.ucaps = get(hObject,'Value');
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function stickGenUcapsSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stickGenUcapsSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
guidata(hObject,handles);


function stickGenMiles_Callback(hObject, eventdata, handles)
if str2double(get(hObject,'String')) < 0
    handles.miles = 0;
    set(hObject,'String',handles.miles);
else
    handles.miles = str2double(get(hObject,'String'));
    
end
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function stickGenMiles_CreateFcn(hObject, eventdata, handles)
handles.miles = str2double(get(hObject,'String'));
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);


function stickGenGasPrice_Callback(hObject, eventdata, handles)
if str2double(get(hObject,'String')) < 0
    handles.gasPrice = 0;
    set(hObject,'String',handles.gasPrice);
else
    handles.gasPrice = str2double(get(hObject,'String'));
    
end
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function stickGenGasPrice_CreateFcn(hObject, eventdata, handles)
handles.gasPrice = str2double(get(hObject,'String'));
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);


function stickGenElecPrice_Callback(hObject, eventdata, handles)
if str2double(get(hObject,'String')) < 0
    handles.elecPrice = 0;
    set(hObject,'String',handles.elecPrice);
else
    handles.elecPrice = str2double(get(hObject,'String'));
end
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

function stickGenBatPrice_Callback(hObject, eventdata, handles)
if str2double(get(hObject,'String')) < 0
    handles.batPrice = 0;
    set(hObject,'String',handles.batPrice);
else
    handles.batPrice = str2double(get(hObject,'String'));
end
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function stickGenBatPrice_CreateFcn(hObject, eventdata, handles)
handles.batPrice = str2double(get(hObject,'String'));
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function stickGenElecPrice_CreateFcn(hObject, eventdata, handles)
handles.elecPrice = str2double(get(hObject,'String'));
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);

function stickGenUcapPrice_Callback(hObject, eventdata, handles)
if str2double(get(hObject,'String')) < 0
    handles.ucapPrice = 0;
    set(hObject,'String',handles.ucapPrice);
else
    handles.ucapPrice = str2double(get(hObject,'String'));
end
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function stickGenUcapPrice_CreateFcn(hObject, eventdata, handles)
handles.ucapPrice = str2double(get(hObject,'String'));
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);

function stickGenClassPrice_Callback(hObject, eventdata, handles)
if str2double(get(hObject,'String')) < 0
    handles.classPrice = 0;
    set(hObject,'String',handles.classPrice);
else
    handles.classPrice = str2double(get(hObject,'String'));
end
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function stickGenClassPrice_CreateFcn(hObject, eventdata, handles)
handles.classPrice = str2double(get(hObject,'String'));
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);

% --- Executes on button press in classCheckbox.
function classCheckbox_Callback(hObject, eventdata, handles)
if(get(hObject,'Value')==0)
    set(handles.stickGenClassPrice,'Enable','on');
else
    set(handles.stickGenClassPrice,'Enable','off');
end
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

function batModelCheckbox_Callback(hObject, eventdata, handles)
if(get(hObject,'Value')==0)
    set(handles.stickGenBatPrice,'Enable','on');
else
    set(handles.stickGenBatPrice,'Enable','off');
end
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

% --- Executes on button press in ucapModelCheckbox.
function ucapModelCheckbox_Callback(hObject, eventdata, handles)
if(get(hObject,'Value')==0)
    set(handles.stickGenUcapPrice,'Enable','on');
else
    set(handles.stickGenUcapPrice,'Enable','off');
end
guidata(hObject,handles);
stickGenUpdateAll(hObject,eventdata,handles);

function res = fuelCost(hObject,eventdata,handles)
cdrange = getRawData(handles.arch,'CDRANGE',handles.bat,handles.motor,handles.engine,handles.ucaps);
uf = getUtilityFactor(cdrange,'MDIUF');
CDmiles = uf.*handles.miles;
CSmiles = (1 - uf).*handles.miles;
%the 0.01 below is for converting kWh / 100mi. to kWh / mi.
CDelecFuelCost = handles.elecPrice.*0.01.*getProcessedData(handles.arch,'CD_ELEC_COMBINED',handles.bat,handles.motor,handles.engine,handles.ucaps).*CDmiles;
CDgasFuelCost = handles.gasPrice./getProcessedData(handles.arch,'CD_MPG_COMBINED',handles.bat,handles.motor,handles.engine,handles.ucaps).*CDmiles;
CSgasFuelCost = handles.gasPrice./getProcessedData(handles.arch,'CS_MPG_COMBINED',handles.bat,handles.motor,handles.engine,handles.ucaps).*CSmiles;
res = CDelecFuelCost + CDgasFuelCost + CSgasFuelCost;
guidata(hObject,handles);

function stickGenUpdateAll(hObject,eventdata,handles)
%interpolation limits
batLimits = [5 25];
motorLimits = [50 150];
engineLimits = [50 75];
ucapLimits = [25 100];

%battery interp limits
if (handles.bat < min(batLimits)) || (handles.bat > max(batLimits))
    set(handles.extrapBatText,'Visible','on');
else
    set(handles.extrapBatText,'Visible','off');
end

%motor interp limits
if (handles.motor < min(motorLimits)) || (handles.motor > max(motorLimits))
    set(handles.extrapMotText,'Visible','on');
else
    set(handles.extrapMotText,'Visible','off');
end

%engine interp limits
if (handles.engine < min(engineLimits)) || (handles.engine > max(engineLimits))
    set(handles.extrapEngineText,'Visible','on');
else
    set(handles.extrapEngineText,'Visible','off');
end

%ucap interp limits
if (handles.ucaps < min(ucapLimits)) || (handles.ucaps > max(ucapLimits))
    set(handles.extrapUcapText,'Visible','on');
else
    set(handles.extrapUcapText,'Visible','off');
end

if strcmp(handles.arch,'SERIES') || strcmp(handles.arch,'PARALLEL') || strcmp(handles.arch,'SPLIT')
    handles.ucaps = 0;
    set(handles.extrapUcapText,'Visible','off');
end
set(handles.stickGenMPGeRes,'String',sprintf('%0.1f',getProcessedData(handles.arch,'CD_MPGE_COMBINED',handles.bat,handles.motor,handles.engine,handles.ucaps)));
set(handles.stickGenElecRes,'String',round(getProcessedData(handles.arch,'CD_ELEC_COMBINED',handles.bat,handles.motor,handles.engine,handles.ucaps)));
set(handles.stickGenMPGRes,'String',sprintf('%0.1f',getProcessedData(handles.arch,'CD_MPG_COMBINED',handles.bat,handles.motor,handles.engine,handles.ucaps)));
set(handles.stickGenGasRes,'String',sprintf('%0.1f',getProcessedData(handles.arch,'CS_MPG_COMBINED',handles.bat,handles.motor,handles.engine,handles.ucaps)));
set(handles.stickGenGalRes,'String',sprintf('%0.1f',100./str2double(get(handles.stickGenGasRes,'String')))); %just convert MPG to to (gal / 100 mi.)
set(handles.stickGen60Time,'String',sprintf('%0.1f',getRawData(handles.arch,'ACCELTIME_CD',handles.bat,handles.motor,handles.engine,handles.ucaps)));
set(handles.stickGenCDrange,'String',round(getRawData(handles.arch,'CDRANGE',handles.bat,handles.motor,handles.engine,handles.ucaps)));
set(handles.stickGenQuarterTime,'String',sprintf('%0.1f',getRawData(handles.arch,'QUARTERMILETIME_CD',handles.bat,handles.motor,handles.engine,handles.ucaps)));
set(handles.stickGenCo2,'String',round(getProcessedData(handles.arch,'CO2_MDIUF',handles.bat,handles.motor,handles.engine,handles.ucaps)));
%set(handles.stickGenFuelCostRes,'String',['$' num2str(handles.gasPrice.*handles.miles./getProcessedData(handles.arch,'MPG_MDIUF',handles.bat,handles.motor,handles.engine,handles.ucaps))]);
%   temp = handles.gasPrice.*handles.miles./getProcessedData(handles.arch,'MPG_MDIUF',handles.bat,handles.motor,handles.engine,handles.ucaps);
set(handles.stickGenFuelCostRes,'String',['$' num2str(round(fuelCost(hObject,eventdata,handles)))]);
set(handles.stickGenMoneySavedRes,'String',['$' num2str(round(5.*handles.gasPrice.*handles.miles./22 - 5.*fuelCost(hObject,eventdata,handles)))]);  %average MPG is 22
if get(handles.batModelCheckbox,'Value')==1 && get(handles.ucapModelCheckbox,'Value')==1 && get(handles.classCheckbox,'Value')==1
    set(handles.stickGenBatPrice,'String',num2str(round(getBatteryCostPerKwh(handles.motor,handles.bat,'argonneMidModel'))));
    set(handles.stickGenUcapPrice,'String',num2str(round(getUcapCostPerKwh(handles.ucaps))));
    set(handles.stickGenClassPrice,'String',num2str(round(getMSRP(handles.engine+handles.motor))));
    handles.msrp = getMinMSRP(handles.bat,handles.motor,handles.engine,handles.ucaps);
    set(handles.stickGenMinMSRP,'String',['$' num2str(handles.msrp)]);
else
    batCost = handles.bat.*str2double(get(handles.stickGenBatPrice,'String'));
    ucapCost = handles.ucaps.*(8.4./3600).*str2double(get(handles.stickGenUcapPrice,'String'));
    classmsrp = str2double(get(handles.stickGenClassPrice,'String'));
    handles.msrp = round(classmsrp + getMotorCost(handles.motor) + getEngineCost(handles.engine) + batCost + ucapCost);
    set(handles.stickGenMinMSRP,'String',['$' num2str(handles.msrp)]);
end
cost2own = get5YrCost2Own(handles.arch,handles.bat,handles.motor,handles.engine,handles.ucaps,handles.msrp,handles.miles,handles.gasPrice,handles.elecPrice);
set(handles.stickGen5YrCost,'String',['$' num2str(cost2own)]);
set(handles.stickGenConfigText,'String',['Configuration: ' handles.arch ' PHEV with ' num2str(sprintf('%0.1f',handles.bat)) ' kWh battery, ' num2str(sprintf('%0.1f',handles.motor)) ' kW motor, ' num2str(sprintf('%0.1f',handles.engine)) ' kW engine, & ' num2str(sprintf('%0.1f',handles.ucaps)) ' ultracapacitors.']);
set(handles.stickGenPriceConfig,'String',['Pricing based on: ' num2str(handles.miles) ' miles per year, $' num2str(sprintf('%0.2f',handles.gasPrice)) '/gal of gasoline, $' num2str(handles.elecPrice) '/kWh of electricity, $' get(handles.stickGenBatPrice,'String') '/kWh of battery, and $' get(handles.stickGenUcapPrice,'String') '/kWh of ultracapacitors.']);
guidata(hObject,handles);
% disp('Update Successful');


% --- Executes on button press in stickGenUpdateButton.
function stickGenUpdateButton_Callback(hObject, eventdata, handles)
stickGenUpdateAll(hObject,eventdata,handles);


% --- Executes on button press in stickGenDefaultButton.
function stickGenDefaultButton_Callback(hObject, eventdata, handles)
    setDefault(hObject,eventdata,handles);
	
function setDefault(hObject,eventdata,handles)
%sets the program to Volt-like configuration
handles.arch = 'SERIES';
    handles.bat = 16;
    handles.motor = 111;
    handles.engine = 62;
    handles.ucaps = 25;
    handles.miles = 15000;
    handles.gasPrice = 3.70;
    handles.elecPrice = 0.12;
    handles.batPrice = getBatteryCost(handles.motor,handles.bat,'argonneMidModel');
    handles.ucapPrice = getUcapCost(handles.ucaps);
set(handles.stickGenArchMenu,'Value',1);
set(handles.stickGenBat,'String',handles.bat);
set(handles.stickGenBatSlider,'Value',handles.bat);
set(handles.stickGenMot,'String',handles.motor);
set(handles.stickGenMotSlider,'Value',handles.motor);
set(handles.stickGenEng,'String',handles.engine);
set(handles.stickGenEngSlider,'Value',handles.engine);
set(handles.stickGenUcaps,'String',handles.ucaps);
set(handles.stickGenUcapsSlider,'Value',handles.ucaps);
set(handles.stickGenUcaps,'Enable','off');
set(handles.stickGenUcapsSlider,'Enable','off');
set(handles.stickGenMiles,'String',handles.miles);
set(handles.stickGenGasPrice,'String',handles.gasPrice);
set(handles.stickGenElecPrice,'String',handles.elecPrice);
set(handles.stickGenBatPrice,'String',handles.batPrice);
set(handles.stickGenUcapPrice,'String',handles.ucapPrice);
set(handles.batModelCheckbox,'Value',1);
set(handles.stickGenBatPrice,'Enable','off');
set(handles.ucapModelCheckbox,'Value',1);
set(handles.stickGenUcapPrice,'Enable','off');
set(handles.classCheckbox,'Value',1);
set(handles.stickGenClassPrice,'Enable','off');
stickGenUpdateAll(hObject,eventdata,handles);

% --- Executes on button press in stickGenPriusButton.
function stickGenPriusButton_Callback(hObject, eventdata, handles)
%sets the program to Prius-like configuration
handles.arch = 'SPLIT';
    handles.bat = 4.4;
    handles.motor = 60;
    handles.engine = 73;
    handles.ucaps = 25;
    handles.miles = 15000;
    handles.gasPrice = 3.70;
    handles.elecPrice = 0.12;
    handles.batPrice = getBatteryCost(handles.motor,handles.bat,'argonneMidModel');
    handles.ucapPrice = getUcapCost(handles.ucaps);
set(handles.stickGenArchMenu,'Value',3);
set(handles.stickGenBat,'String',handles.bat);
set(handles.stickGenBatSlider,'Value',handles.bat);
set(handles.stickGenMot,'String',handles.motor);
set(handles.stickGenMotSlider,'Value',handles.motor);
set(handles.stickGenEng,'String',handles.engine);
set(handles.stickGenEngSlider,'Value',handles.engine);
set(handles.stickGenUcaps,'String',handles.ucaps);
set(handles.stickGenUcapsSlider,'Value',handles.ucaps);
set(handles.stickGenUcaps,'Enable','off');
set(handles.stickGenUcapsSlider,'Enable','off');
set(handles.stickGenMiles,'String',handles.miles);
set(handles.stickGenGasPrice,'String',handles.gasPrice);
set(handles.stickGenElecPrice,'String',handles.elecPrice);
set(handles.stickGenBatPrice,'String',handles.batPrice);
set(handles.stickGenUcapPrice,'String',handles.ucapPrice);
set(handles.batModelCheckbox,'Value',1);
set(handles.stickGenBatPrice,'Enable','off');
set(handles.ucapModelCheckbox,'Value',1);
set(handles.stickGenUcapPrice,'Enable','off');
set(handles.classCheckbox,'Value',1);
set(handles.stickGenClassPrice,'Enable','off');
stickGenUpdateAll(hObject,eventdata,handles);

% % --- Executes on button press in stickGenKarmaButton.
% function stickGenKarmaButton_Callback(hObject, eventdata, handles)
% %sets the program to Karma-like configuration
% handles.arch = 'SERIES';
%     handles.bat = 20;
%     handles.motor = 300;
%     handles.engine = 194;
%     handles.ucaps = 25;
%     handles.miles = 15000;
%     handles.gasPrice = 3.70;
%     handles.elecPrice = 0.12;
%     handles.batPrice = getBatteryCost(handles.motor,handles.bat,'argonneMidModel');
%     handles.ucapPrice = getUcapCost(handles.ucaps);
% set(handles.stickGenArchMenu,'Value',1);
% set(handles.stickGenBat,'String',handles.bat);
% set(handles.stickGenBatSlider,'Value',handles.bat);
% set(handles.stickGenMot,'String',handles.motor);
% set(handles.stickGenMotSlider,'Value',handles.motor);
% set(handles.stickGenEng,'String',handles.engine);
% set(handles.stickGenEngSlider,'Value',handles.engine);
% set(handles.stickGenUcaps,'String',handles.ucaps);
% set(handles.stickGenUcapsSlider,'Value',handles.ucaps);
% set(handles.stickGenUcaps,'Enable','off');
% set(handles.stickGenUcapsSlider,'Enable','off');
% set(handles.stickGenMiles,'String',handles.miles);
% set(handles.stickGenGasPrice,'String',handles.gasPrice);
% set(handles.stickGenElecPrice,'String',handles.elecPrice);
% set(handles.stickGenBatPrice,'String',handles.batPrice);
% set(handles.stickGenUcapPrice,'String',handles.ucapPrice);
% set(handles.batModelCheckbox,'Value',1);
% set(handles.stickGenBatPrice,'Enable','off');
% set(handles.ucapModelCheckbox,'Value',1);
% set(handles.stickGenUcapPrice,'Enable','off');
% set(handles.classCheckbox,'Value',1);
% set(handles.stickGenClassPrice,'Enable','off');
% stickGenUpdateAll(hObject,eventdata,handles);


% --- Executes on selection change in quickCalcArchMenu.
function quickCalcArchMenu_Callback(hObject, eventdata, handles)
archstr = get(hObject,'String');
archval = get(hObject,'Value');
handles.arch = archstr{archval};
%turn off the ultracapacitor menus if appropriate
if strcmp(handles.arch,'SERIES') || strcmp(handles.arch,'PARALLEL') || strcmp(handles.arch,'SPLIT')
    set(handles.quickCalcUcaps,'Enable','off');
    set(handles.quickCalcUcapsSlider,'Enable','off');
    set(handles.quickCalcUcapsText,'Enable','off');
else
    set(handles.quickCalcUcaps,'Enable','on');
    set(handles.quickCalcUcapsSlider,'Enable','on');
    set(handles.quickCalcUcapsText,'Enable','on');
    handles.ucaps = str2double(get(handles.quickCalcUcaps,'String'));
end
guidata(hObject,handles);
quickCalcUpdate(hObject,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function quickCalcArchMenu_CreateFcn(hObject, eventdata, handles)
archstr = get(hObject,'String');
archval = get(hObject,'Value');
handles.arch = archstr{archval};
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);

% --- Executes on selection change in quickCalcDataMenu.
function quickCalcDataMenu_Callback(hObject, eventdata, handles)
datastr = get(hObject,'String');
dataval = get(hObject,'Value');
handles.data = datastr{dataval};
cyclestr = get(handles.quickCalcCycleMenu,'String');
cycleval = get(handles.quickCalcCycleMenu,'Value');
handles.cycle = cyclestr{cycleval};
switch handles.data
    case {'MPG','CO2'}
        set(handles.quickCalcModeText,'Enable','on');
        set(handles.quickCalcModeMenu,'Enable','on');
        if(strcmp('COMBINED',handles.cycle))
            set(handles.quickCalcModeMenu,'String',{'MDIUF','FUF','CD','CS'});
        else
            set(handles.quickCalcModeMenu,'Value',1);
            set(handles.quickCalcModeMenu,'String',{'CD','CS'});
        end
            modestr = get(handles.quickCalcModeMenu,'String');
            modeval = get(handles.quickCalcModeMenu,'Value');
            handles.mode = modestr{modeval};
        set(handles.quickCalcCycleText,'Enable','on');
        set(handles.quickCalcCycleMenu,'Enable','on');
            cyclestr = get(handles.quickCalcCycleMenu,'String');
            cycleval = get(handles.quickCalcCycleMenu,'Value');
            handles.cycle = cyclestr{cycleval};
    case {'ELEC','MPGE'}
        set(handles.quickCalcModeText,'Enable','on');
        set(handles.quickCalcModeMenu,'Enable','on');
        if(strcmp('COMBINED',handles.cycle))
            set(handles.quickCalcModeMenu,'Value',1);
            set(handles.quickCalcModeMenu,'String',{'MDIUF','FUF','CD'});
        else
            set(handles.quickCalcModeMenu,'Value',1);
            set(handles.quickCalcModeMenu,'String',{'CD','CS'});
        end
            modestr = get(handles.quickCalcModeMenu,'String');
            modeval = get(handles.quickCalcModeMenu,'Value');
            handles.mode = modestr{modeval};
        set(handles.quickCalcCycleText,'Enable','on');
        set(handles.quickCalcCycleMenu,'Enable','on');
            cyclestr = get(handles.quickCalcCycleMenu,'String');
            cycleval = get(handles.quickCalcCycleMenu,'Value');
            handles.cycle = cyclestr{cycleval};
    case 'CDRANGE'
        set(handles.quickCalcCycleMenu,'Enable','off');
        set(handles.quickCalcModeMenu,'Enable','off');
        set(handles.quickCalcCycleText,'Enable','off');
        set(handles.quickCalcModeText,'Enable','off');
        handles.cycle = 'COMBINED';
        handles.mode = 'CD';
    case {'ACCELTIME','QUARTERMILETIME'}
        set(handles.quickCalcCycleMenu,'Enable','off');
        set(handles.quickCalcCycleText,'Enable','off');
        handles.cycle = 'COMBINED';
        set(handles.quickCalcModeMenu,'Value',1);
        set(handles.quickCalcModeMenu,'String',{'CD','CS'});
        	modestr = get(handles.quickCalcModeMenu,'String');
            modeval = get(handles.quickCalcModeMenu,'Value');
            handles.mode = modestr{modeval};
end
guidata(hObject,handles);
quickCalcUpdate(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function quickCalcDataMenu_CreateFcn(hObject, eventdata, handles)
datastr = get(hObject,'String');
dataval = get(hObject,'Value');
handles.data = datastr{dataval};
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);

% --- Executes on selection change in quickCalcCycleMenu.
function quickCalcCycleMenu_Callback(hObject, eventdata, handles)
cyclestr = get(hObject,'String');
cycleval = get(hObject,'Value');
handles.cycle = cyclestr{cycleval};
switch handles.cycle
    case 'COMBINED'
        datastr = get(handles.quickCalcDataMenu,'String');
        dataval = get(handles.quickCalcDataMenu,'Value');
        handles.data = datastr{dataval};
        if(strcmp(handles.data,'MPGE') || strcmp(handles.data,'ELEC'))
            set(handles.quickCalcModeMenu,'Value',1);
            set(handles.quickCalcModeMenu,'String',{'MDIUF','FUF','CD'});
        else
            set(handles.quickCalcModeMenu,'String',{'MDIUF','FUF','CD','CS'});
        end
        modestr = get(handles.quickCalcModeMenu,'String');
        modeval = get(handles.quickCalcModeMenu,'Value');
        handles.mode = modestr{modeval};
    otherwise
        set(handles.quickCalcModeMenu,'Value',1);
        set(handles.quickCalcModeMenu,'String',{'CD','CS'});
        modestr = get(handles.quickCalcModeMenu,'String');
        modeval = get(handles.quickCalcModeMenu,'Value');
        handles.mode = modestr{modeval};
end
guidata(hObject,handles);
quickCalcUpdate(hObject,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function quickCalcCycleMenu_CreateFcn(hObject, eventdata, handles)
cyclestr = get(hObject,'String');
cycleval = get(hObject,'Value');
handles.cycle = cyclestr{cycleval};
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);

% --- Executes on selection change in quickCalcModeMenu.
function quickCalcModeMenu_Callback(hObject, eventdata, handles)
modestr = get(hObject,'String');
modeval = get(hObject,'Value');
handles.mode = modestr{modeval};
guidata(hObject,handles);
quickCalcUpdate(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function quickCalcModeMenu_CreateFcn(hObject, eventdata, handles)
modestr = get(hObject,'String');
modeval = get(hObject,'Value');
handles.mode = modestr{modeval};
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);

function quickCalcBat_Callback(hObject, eventdata, handles)
if str2double(get(hObject,'String'))<get(handles.quickCalcBatSlider,'Min')
    handles.bat = get(handles.quickCalcBatSlider,'Min');
    set(handles.quickCalcBatSlider,'Value',handles.bat);
    set(hObject,'String',handles.bat);
elseif str2double(get(hObject,'String'))>get(handles.quickCalcBatSlider,'Max')
    handles.bat = get(handles.quickCalcBatSlider,'Max');
    set(handles.quickCalcBatSlider,'Value',handles.bat);
    set(hObject,'String',handles.bat);
else
    handles.bat = str2double(get(hObject,'String'));
    set(handles.quickCalcBatSlider,'Value',handles.bat);
end
guidata(hObject,handles);
quickCalcUpdate(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function quickCalcBat_CreateFcn(hObject, eventdata, handles)
handles.bat = str2double(get(hObject,'String'));
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);


function quickCalcMot_Callback(hObject, eventdata, handles)
if str2double(get(hObject,'String'))<get(handles.quickCalcMotSlider,'Min')
    handles.mot = get(handles.quickCalcMotSlider,'Min');
    set(handles.quickCalcMotSlider,'Value',handles.mot);
    set(hObject,'String',handles.mot);
elseif str2double(get(hObject,'String'))>get(handles.quickCalcMotSlider,'Max')
    handles.mot = get(handles.quickCalcMotSlider,'Max');
    set(handles.quickCalcMotSlider,'Value',handles.mot);
    set(hObject,'String',handles.mot);
else
    handles.mot = str2double(get(hObject,'String'));
    set(handles.quickCalcMotSlider,'Value',handles.mot);
end
guidata(hObject,handles);
quickCalcUpdate(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function quickCalcMot_CreateFcn(hObject, eventdata, handles)
handles.mot = str2double(get(hObject,'String'));
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);


function quickCalcEng_Callback(hObject, eventdata, handles)
if str2double(get(hObject,'String')) < get(handles.quickCalcEngSlider,'Min')
    handles.engine = get(handles.quickCalcEngSlider,'Min');
    set(handles.quickCalcEngSlider,'Value',handles.engine);
    set(hObject,'String',handles.engine);
elseif str2double(get(hObject,'String')) > get(handles.quickCalcEngSlider,'Max')
    handles.engine = get(handles.quickCalcEngSlider,'Max');
    set(handles.quickCalcEngSlider,'Value',handles.engine);
    set(hObject,'String',handles.engine);
else
    handles.engine = str2double(get(hObject,'String'));
    set(handles.quickCalcEngSlider,'Value',handles.engine);
end
guidata(hObject,handles);
quickCalcUpdate(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function quickCalcEng_CreateFcn(hObject, eventdata, handles)
handles.engine = str2double(get(hObject,'String'));
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);

function quickCalcUcaps_Callback(hObject, eventdata, handles)
if str2double(get(hObject,'String')) < get(handles.quickCalcUcapsSlider,'Min')
    handles.ucaps = get(handles.quickCalcUcapsSlider,'Min');
    set(handles.quickCalcUcapsSlider,'Value',handles.ucaps);
    set(hObject,'String',handles.ucaps);
elseif str2double(get(hObject,'String')) > get(handles.quickCalcUcapsSlider,'Max')
    handles.ucaps = get(handles.quickCalcUcapsSlider,'Max');
    set(handles.quickCalcUcapsSlider,'Value',handles.ucaps);
    set(hObject,'String',handles.ucaps);
else
    handles.ucaps = str2double(get(hObject,'String'));
    set(handles.quickCalcUcapsSlider,'Value',handles.ucaps);
end
guidata(hObject,handles);
quickCalcUpdate(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function quickCalcUcaps_CreateFcn(hObject, eventdata, handles)
handles.ucaps = str2double(get(hObject,'String'));
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);

% --- Executes on slider movement.
function quickCalcBatSlider_Callback(hObject, eventdata, handles)
set(handles.quickCalcBat,'String',get(hObject,'Value'));
handles.bat = get(hObject,'Value');
guidata(hObject,handles);
quickCalcUpdate(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function quickCalcBatSlider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
guidata(hObject,handles);

% --- Executes on slider movement.
function quickCalcMotSlider_Callback(hObject, eventdata, handles)
set(handles.quickCalcMot,'String',get(hObject,'Value'));
handles.motor = get(hObject,'Value');
guidata(hObject,handles);
quickCalcUpdate(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function quickCalcMotSlider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
guidata(hObject,handles);

% --- Executes on slider movement.
function quickCalcEngSlider_Callback(hObject, eventdata, handles)
set(handles.quickCalcEng,'String',get(hObject,'Value'));
handles.engine = get(hObject,'Value');
guidata(hObject,handles);
quickCalcUpdate(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function quickCalcEngSlider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
guidata(hObject,handles);

% --- Executes on slider movement.
function quickCalcUcapsSlider_Callback(hObject, eventdata, handles)
set(handles.quickCalcUcaps,'String',get(hObject,'Value'));
handles.ucaps = get(hObject,'Value');
guidata(hObject,handles);
quickCalcUpdate(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function quickCalcUcapsSlider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
guidata(hObject,handles);

function quickCalcUpdate(hObject,eventdata,handles)
% handles.arch
% handles.data
% handles.cycle
% handles.mode
if strcmp(handles.arch,'SERIES') || strcmp(handles.arch,'PARALLEL') || strcmp(handles.arch,'SPLIT')
    handles.ucaps = 0;
end
set(handles.quickCalcRes,'String',getData(handles.arch,handles.data,handles.cycle,handles.mode,handles.bat,handles.motor,handles.engine,handles.ucaps));
set(handles.quickCalcUnitsRes,'String',getDataUnits(handles.data));
guidata(hObject,handles);
