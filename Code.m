function varargout = finalui(varargin)
% FINALUI MATLAB code for finalui.fig
%      FINALUI, by itself, creates a new FINALUI or raises the existing
%      singleton*.
%
%      H = FINALUI returns the handle to a new FINALUI or the handle to
%      the existing singleton*.
%
%      FINALUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINALUI.M with the given input arguments.
%
%      FINALUI('Property','Value',...) creates a new FINALUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before finalui_OpeningFcn gets called.  An
%      unrecognized property naam or invalid value makes property application
%      stop.  All inputs are passed to finalui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help finalui

% Last Modified by GUIDE v2.5 05-Mar-2014 17:05:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @finalui_OpeningFcn, ...
                   'gui_OutputFcn',  @finalui_OutputFcn, ...
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


% --- Executes just before finalui is made visible.
function finalui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to finalui (see VARARGIN)

% Choose default command line output for finalui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes finalui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = finalui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function naam_Callback(hObject, eventdata, handles)
% hObject    handle to naam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of naam as text
%        str2double(get(hObject,'String')) returns contents of naam as a double


% --- Executes during object creation, after setting all properties.
function naam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to naam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
naam=get(handles.naam,'String');
I=imread(strcat('licenseplate\MM4-BV4-portfolio\Bijlage\images\',naam));
%I=imresize(
org=I;
axes(handles.axes2);
[h,w,f]=size(I);
imshow(I);
axes(handles.axes3);
% Extract Y component (Convert an Image to Gray)
Igray = rgb2gray(I);
[rows cols] = size(Igray);
%% Dilate and Erode Image in order to remove noise
Idilate = Igray;
for i = 1:rows
for j = 2:cols-1
temp = max(Igray(i,j-1), Igray(i,j));
Idilate(i,j) = max(temp, Igray(i,j+1));
end
end
I = Idilate;
%title('Grey Image')
%imshow(Igray);
%title('Dilated Image')
%imshow(Idilate);
%imshow(I);
difference = 0;
sum = 0;
total_sum = 0;
difference = uint32(difference);
%% PROCESS EDGES IN HORIZONTAL DIRECTION
disp('Processing Edges Horizontally...');
max_horz = 0;
maximum = 0;
for i = 2:cols
sum = 0;
for j = 2:rows
if(I(j, i) > I(j-1, i))
difference = uint32(I(j, i) - I(j-1, i));
else
difference = uint32(I(j-1, i) - I(j, i));
end
if(difference > 40)
sum = sum + difference;
end
end
horz1(i) = sum;
% Find Peak Value
if(sum > maximum)
max_horz = i;
maximum = sum;
end
total_sum = total_sum + sum;
end
average = total_sum / cols;
%figure(5);
% Plot the Histogram for analysis
%subplot(3,1,1);
%plot (horz1);
%title('Horizontal Edge Processing Histogram');
%xlabel('Column Number ->');
%ylabel('Difference ->');
%% Smoothen the Horizontal Histogram by applying Low Pass Filter
disp('Passing Horizontal Histogram through Low Pass Filter...');

sum = 0;
horz = horz1;
for i = 21:(cols-21)
sum = 0;
for j = (i-20):(i+20)
sum = sum + horz1(j);
end
horz(i) = sum / 41;
end
%subplot(3,1,2);
%plot (horz);
%title('Histogram after passing through Low Pass Filter');
%xlabel('Column Number ->');
%ylabel('Difference ->');
%% Filter out Horizontal Histogram Values by applying Dynamic Threshold
disp('Filter out Horizontal Histogram...');
for i = 1:cols
if(horz(i) < average)
horz(i) = 0;
for j = 1:rows
I(j, i) = 0;
end
end
end
%subplot(3,1,3);
%plot (horz);
%title('Histogram after Filtering');
%xlabel('Column Number ->');
%ylabel('Difference ->');
%% PROCESS EDGES IN VERTICAL DIRECTION
difference = 0;
total_sum = 0;
difference = uint32(difference);
disp('Processing Edges Vertically...');
maximum = 0;
max_vert = 0;
for i = 2:rows
sum = 0;

for j = 2:cols %cols
if(I(i, j) > I(i, j-1))
difference = uint32(I(i, j) - I(i, j-1));
end
if(I(i, j) <= I(i, j-1))
difference = uint32(I(i, j-1) - I(i, j));
end
if(difference > 40)
sum = sum + difference;
end
end
vert1(i) = sum;
%% Find Peak in Vertical Histogram
if(sum > maximum)
max_vert = i;
maximum = sum;
end
total_sum = total_sum + sum;
end
average = total_sum / rows;
%figure(6)
%subplot(3,1,1);
%plot (vert1);
%title('Vertical Edge Processing Histogram');
%xlabel('Row Number ->');
%ylabel('Difference ->');
%% Smoothen the Vertical Histogram by applying Low Pass Filter
disp('Passing Vertical Histogram through Low Pass Filter...');
sum = 0;
vert = vert1;
for i = 21:(rows-21)
sum = 0;
for j = (i-20):(i+20)
sum = sum + vert1(j);
end
vert(i) = sum / 41;
end

%subplot(3,1,2);
%plot (vert);
%title('Histogram after passing through Low Pass Filter');
%xlabel('Row Number ->');
%ylabel('Difference ->');
%% Filter out Vertical Histogram Values by applying Dynamic Threshold
disp('Filter out Vertical Histogram...');
for i = 1:rows
if(vert(i) < average)
vert(i) = 0;
for j = 1:cols
I(i, j) = 0;
end
end
end
%subplot(3,1,3);
%plot (vert);
%title('Histogram after Filtering');
%xlabel('Row Number ->');
%ylabel('Difference ->');
%figure(7), imshow(I);
%% Find Probable candidates for Number Plate
j = 1;
for i = 2:cols-2
if(horz(i) ~= 0 && horz(i-1) == 0 && horz(i+1) == 0)
column(j) = i;
column(j+1) = i;
j = j + 2;
elseif((horz(i) ~= 0 && horz(i-1) == 0) || (horz(i) ~= 0 && horz(i+1) == 0))
column(j) = i;
j = j+1;
end
end
j = 1;
for i = 2:rows-2
if(vert(i) ~= 0 && vert(i-1) == 0 && vert(i+1) == 0)
row(j) = i;
row(j+1) = i;

j = j + 2;
elseif((vert(i) ~= 0 && vert(i-1) == 0) || (vert(i) ~= 0 && vert(i+1) == 0))
row(j) = i;
j = j+1;
end
end
[temp column_size] = size (column);
if(mod(column_size, 2))
column(column_size+1) = cols;
end
[temp row_size] = size (row);
if(mod(row_size, 2))
row(row_size+1) = rows;
end
%% Region of Interest Extraction
%Check each probable candidate
for i = 1:2:row_size
for j = 1:2:column_size
% If it is not the most probable region remove it from image
if(~((max_horz >= column(j) && max_horz <= column(j+1)) && (max_vert >=row(i) && max_vert <= row(i+1))))
%This loop is only for displaying proper output to User
for m = row(i):row(i+1)
for n = column(j):column(j+1)
I(m, n) = 0;
end
end
end
end
end

imwrite(I,'tempocr.jpg');
I=imshow(I);
 status = dos('tesseract tempocr.jpg out')


 
 fid=fopen('out.txt','r')
Data=fscanf(fid,'%c' )

set(handles.text8,'String',Data);
%CharData=char(Data)
fclose(fid)

conn = database('project', 'root', '','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/')
qry=strcat('select name from license where pltno="',Data,'"');
curs = exec(conn, qry)
curs=fetch(curs)
%setdbprefs('DataReturnFormat','cellarray')
set(handles.text3,'String',curs.Data);
qry=strcat('select addr from license where pltno="',Data,'"');
curs = exec(conn, qry)
curs=fetch(curs)
set(handles.text4,'String',curs.Data);
qry=strcat('select vtype from license where pltno="',Data,'"');
curs = exec(conn, qry)
curs=fetch(curs)
set(handles.text5,'String',curs.Data);
qry=strcat('select pltno from license where pltno="',Data,'"');
curs = exec(conn, qry)
curs=fetch(curs)
set(handles.text6,'String',curs.Data);
close(curs);
close(conn);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end