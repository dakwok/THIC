function varargout = NINJA_GUI_Darwin_Yale_2017(varargin)
% NINJA_GUI_DARWIN_YALE_2017 MATLAB code for NINJA_GUI_Darwin_Yale_2017.fig
%      NINJA_GUI_DARWIN_YALE_2017, by itself, creates a new NINJA_GUI_DARWIN_YALE_2017 or raises the existing
%      singleton*.
%
%      H = NINJA_GUI_DARWIN_YALE_2017 returns the handle to a new NINJA_GUI_DARWIN_YALE_2017 or the handle to
%      the existing singleton*.
%
%      NINJA_GUI_DARWIN_YALE_2017('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NINJA_GUI_DARWIN_YALE_2017.M with the given input arguments.
%
%      NINJA_GUI_DARWIN_YALE_2017('Property','Value',...) creates a new NINJA_GUI_DARWIN_YALE_2017 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NINJA_GUI_Darwin_Yale_2017_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NINJA_GUI_Darwin_Yale_2017_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NINJA_GUI_Darwin_Yale_2017

% Last Modified by GUIDE v2.5 16-Oct-2020 20:33:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NINJA_GUI_Darwin_Yale_2017_OpeningFcn, ...
                   'gui_OutputFcn',  @NINJA_GUI_Darwin_Yale_2017_OutputFcn, ...
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

% -------------------------------------------------------------------------
%                             Initial Opening 
% -------------------------------------------------------------------------

% --- Executes just before NINJA_GUI_Darwin_Yale_2017 is made visible.
function NINJA_GUI_Darwin_Yale_2017_OpeningFcn(hObject, eventdata, handles, varargin)
global threshold_intensity row_number total_pixels size_threshold scale_bar calibrated_area
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NINJA_GUI_Darwin_Yale_2017 (see VARARGIN)

% Choose default command line output for NINJA_GUI_Darwin_Yale_2017
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% [DK] Set scale bar to initially be 50
scale_bar = 50;

% [DK] Set calibration area to that of the 20x (Enhanced) magnification
calibrated_area = 4.1490e+05;
set(handles.Calibrated_Area_String, 'String', calibrated_area);

% [DK] Set set threshold to initially be 8000
size_threshold = 8000;

% [DK] Set up the initial pixel number to be '3228160'
total_pixels = 3228160;

% [DK] Set up the initial row number in the table to be 1
row_number = 1;

% [DK] Set threshold intensity to be 0
threshold_intensity = 0;

% [DK] Set the number of rows and columns in table when starting GUI
columns = 4;
rows = 500;
set(handles.Results_Table,'Data', cell(rows, columns));

% UIWAIT makes NINJA_GUI_Darwin_Yale_2017 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% *** Darwin Note ***: Under here, set where the original thresholds will be when
% the GUI opens up for the first time

% --- Outputs from this function are returned to the command line.
function varargout = NINJA_GUI_Darwin_Yale_2017_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Push_CellCounter.
function Push_CellCounter_Callback(hObject, eventdata, handles)
% hObject    handle to Push_CellCounter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% -------------------------------------------------------------------------
%                             BROWSE BUTTON 
% -------------------------------------------------------------------------
% --- Executes on button press in Push_Browse.
function Push_Browse_Callback(hObject, eventdata, handles)
global folder_name
% *** Purpose ***: To open "pop-up" window for selecting folder
% *** To Do *** 1) Make a drop down for file type (e.g. TIF, JGP.)
folder_name = uigetdir; % pops out window, returns file path with OK, returns 0 with Cancel
% get what is inside the folder
Infolder = dir(folder_name);
% Initialize the cell of string that will be update in the list box
MyListOfFiles = [];
% Loop on every element in the folder and update the list
for i = 1:length(Infolder)
   if Infolder(i).isdir==0
       MyListOfFiles{end+1,1} = Infolder(i).name;
   end
end
% update the listbox with the result
set(handles.Slide_Dropdown,'String',MyListOfFiles)
folder_name;

% -------------------------------------------------------------------------
%                            CAPTURE BUTTON
% -------------------------------------------------------------------------
% --- Executes on button press in Capture_PushButton.
function Capture_PushButton_Callback(hObject, eventdata, handles)
global row_number totalArea_um totalPerimeter_um
% hObject    handle to Capture_PushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Take the table out of the GUI as an editable matrix
table_data = get(handles.Results_Table, 'Data');

% Set the name of the row
folder_files_matrix = get(handles.Slide_Dropdown, 'string');
selected_index = get(handles.Slide_Dropdown, 'Value');
selected_file_name = folder_files_matrix{selected_index};
table_data(row_number,1) = cellstr(selected_file_name);

% Set the value of the Area
table_data(row_number,2) = num2cell(totalArea_um);

% Set the value of the Perimeter
table_data(row_number,3) = num2cell(totalPerimeter_um);

% Set the value of the Thickness
table_data(row_number,4) = num2cell(totalArea_um'/totalPerimeter_um);

% Update the table with new data
set(handles.Results_Table, 'Data', table_data);

%desired_result = table_data{1,1}
row_number = row_number+1;


% -------------------------------------------------------------------------
%                             FILE DROPDOWN
% -------------------------------------------------------------------------
% --- Executes on selection change in Slide_Dropdown.
function Slide_Dropdown_Callback(hObject, eventdata, handles)
global folder_name
% hObject    handle to Slide_Dropdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Slide_Dropdown contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Slide_Dropdown
folder_files_matrix = get(handles.Slide_Dropdown, 'string');
selected_index = get(handles.Slide_Dropdown, 'Value');
selected_file_name = folder_files_matrix{selected_index};
file_path = strcat(folder_name, '/', selected_file_name);
image_raw = imread(file_path);
edit_1 = imsharpen(image_raw);
edit_2 = imadjust(edit_1,stretchlim(edit_1),[]);
axes(handles.Display);
imshow(edit_2);

axes(handles.Reference);
imshow(edit_2);


% -------------------------------------------------------------------------
%                          DELETE PUSH BUTTON
% -------------------------------------------------------------------------
function Push_Delete_Callback(hObject, eventdata, handles)
global row_number
% hObject    handle to Push_Delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
row_number = row_number-1;

% Take the table out of the GUI as an editable matrix
table_data = get(handles.Results_Table, 'Data');

% Set the name of the row
table_data{row_number,1} = [];

% Set the value of the Area
table_data{row_number,2} = [];

% Set the value of the Perimeter
table_data{row_number,3} = [];

% Set the value of the Thickness
table_data{row_number,4} = [];

% Update the table with new data
set(handles.Results_Table, 'Data', table_data);



% -------------------------------------------------------------------------
%                       REGION DETECTION PUSH BUTTON
% -------------------------------------------------------------------------
% --- Executes on button press in Push_Region.
function Push_Region_Callback(hObject, eventdata, handles)
global folder_name threshold_intensity totalArea_um totalPerimeter_um total_pixels size_threshold calibrated_area um_per_pixel
% hObject    handle to Push_Region (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on slider movement.
folder_files_matrix = get(handles.Slide_Dropdown, 'string');
selected_index = get(handles.Slide_Dropdown, 'Value');
selected_file_name = folder_files_matrix{selected_index};

file_path = strcat(folder_name, '/', selected_file_name);

image_raw = imread(file_path);
% image_gray = rgb2gray(image_raw); % Turn this code on if the file is
% colored

% Step 2: Sharpen and Create Reference Image
% Sharpen the image
edit_1 = imsharpen(image_raw);
% Saturate the upper 1% and lower 1% with default contrast limits
edit_2 = imadjust(edit_1,stretchlim(edit_1),[]);

% Step 3: Grayscale the image
edit_3 = rgb2gray(edit_2);

% Step 4: Threshold the Image (and Invert)
% Single-layer Thresholding (0.50 for outermost layer)
threshold_intensity;                
image_BW = im2bw(edit_1,threshold_intensity);

% Step 4a: Invert the gradient
image_invert = imcomplement(image_BW);

% Step 5: Fine Editing and Pore Removal from Threshold Image
% Set Lower bound for particle size (delete anything smaller in area)
image_noPores = bwareaopen(image_invert, size_threshold);
% Next, apply a layer of 2-D median filtering
image_clear = medfilt2(image_noPores);
% Next, apply a layer 2-D adaptive noise-removal filtering with 
% wiener2 function and set m = 3 and n = 3
image_clear2 = wiener2(image_clear,[2 2]); %change to 5 5 for ulcer, change to 2 2 for foot perimeter

axes(handles.Display);
imshow(image_clear2);

% Step 6: Fill in gaps
se = strel('disk',10); % used to be 2 when imfill was turned on
image_filledHoles = imclose(image_clear2,se);

% Overlay on the Reference image
image_FinalPerim = bwperim(~image_clear2);
image_overlay1 = imoverlay(edit_3, image_FinalPerim, 'red');
axes(handles.Reference);
imshow(image_overlay1);

% Step 7: Erosion
image_erosion = imerode(image_filledHoles, strel('disk',1));
image_cleanFinal = bwareaopen(image_erosion, 8000);

% Step 8: Area Calculator
Area_cells = bwarea(image_clear2);
total_pixels = numel(image_clear2);
Dermal_percentage = Area_cells./total_pixels;

Area_real = calibrated_area;

totalArea_um = Dermal_percentage*Area_real;

% Length Calculator
measurements = regionprops(image_cleanFinal, 'Perimeter');
allPerimeters = [measurements.Perimeter];
totalPerimeter_pixels = sum(allPerimeters);
totalPerimeter_um = um_per_pixel*totalPerimeter_pixels;


% -------------------------------------------------------------------------
%                     THRESHOLD (LB) INTENSITY INPUT 
% -------------------------------------------------------------------------
function Intensity_Lower_Input_Callback(hObject, eventdata, handles)
global threshold_intensity
% hObject    handle to Intensity_Lower_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Intensity_Lower_Input as text
%        str2double(get(hObject,'String')) returns contents of Intensity_Lower_Input as a double
lower_bound = str2num(get(hObject, 'String'));
set(handles.Intensity_Lower_Slider, 'Value', lower_bound);
threshold_intensity = lower_bound;
Push_Region_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Intensity_Lower_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Intensity_Lower_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -------------------------------------------------------------------------
%                   THRESHOLD (LB) INTENSITY SLIDER BAR
% -------------------------------------------------------------------------
% --- Executes on slider movement.
function Intensity_Lower_Slider_Callback(hObject, eventdata, handles)
global threshold_intensity
% hObject    handle to Intensity_Lower_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

slider_value = get(handles.Intensity_Lower_Slider, 'Value');
set(handles.Intensity_Lower_Input, 'String', slider_value);
threshold_intensity = slider_value;
Push_Region_Callback(hObject, eventdata, handles)



% -------------------------------------------------------------------------
%                     SIZE THRESHOLD SLIDER 
% -------------------------------------------------------------------------
% --- Executes on slider movement.
function Size_Slider_Callback(hObject, eventdata, handles)
global size_threshold total_pixels
% hObject    handle to Size_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider_value = get(handles.Size_Slider, 'Value')
normalized_value = slider_value*total_pixels
set(handles.Size_Input, 'String', normalized_value);
size_threshold = normalized_value;
Push_Region_Callback(hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function Size_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Size_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% -------------------------------------------------------------------------
%                        SIZE THRESHOLD INPUT 
% -------------------------------------------------------------------------
function Size_Input_Callback(hObject, eventdata, handles)
global size_threshold total_pixels
% hObject    handle to Size_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Size_Input as text
%        str2double(get(hObject,'String')) returns contents of Size_Input as a double
size_threshold = str2num(get(hObject, 'String'));
normalized_slider_threshold = size_threshold/total_pixels;
set(handles.Size_Slider, 'Value', normalized_slider_threshold);
Push_Region_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Size_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Size_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Intensity_Lower_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Intensity_Lower_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Intensity_Upper_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to Intensity_Upper_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Intensity_Upper_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Intensity_Upper_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% -------------------------------------------------------------------------
%                       MAGNIFICATION DROPDOWN 
% -------------------------------------------------------------------------
% --- Executes on selection change in Magnification_Dropdown.
function Magnification_Dropdown_Callback(hObject, eventdata, handles)
global scale_bar
% hObject    handle to Magnification_Dropdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Magnification_Dropdown contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Magnification_Dropdown
global calibration_folder_name

folder_files_matrix = get(handles.Magnification_Dropdown, 'string');
selected_index = get(handles.Magnification_Dropdown, 'Value');
selected_file_name = folder_files_matrix{selected_index}
file_path = strcat(calibration_folder_name, '/', selected_file_name);
image_raw = imread(file_path);

if strcmp(selected_file_name,'4x.JPG') == 1;
    scale_bar = 500;
elseif strcmp(selected_file_name,'10x.JPG') == 1;
    scale_bar = 100;
elseif strcmp(selected_file_name,'20x (Enhanced).JPG') == 1;
    scale_bar = 50;
elseif strcmp(selected_file_name,'20x (Normal).JPG') == 1;
    scale_bar = 50;
end

scale_bar

axes(handles.Display);
imshow(image_raw);

axes(handles.Reference);
imshow(image_raw);


% --- Executes during object creation, after setting all properties.
function Magnification_Dropdown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Magnification_Dropdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -------------------------------------------------------------------------
%                       CALIBRATION BROWSE BUTTON 
% -------------------------------------------------------------------------
% --- Executes on button press in Calibration_Upload.
function Calibration_Upload_Callback(hObject, eventdata, handles)
% hObject    handle to Calibration_Upload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% *** Purpose ***: To open "pop-up" window for selecting calibration image
global calibration_folder_name
% *** Purpose ***: To open "pop-up" window for selecting folder
% *** To Do *** 1) Make a drop down for file type (e.g. TIF, JGP.)
calibration_folder_name = uigetdir; % pops out window, returns file path with OK, returns 0 with Cancel
% get what is inside the folder
Infolder = dir(calibration_folder_name);
% Initialize the cell of string that will be update in the list box
MyListOfFiles = [];
% Loop on every element in the folder and update the list
for i = 1:length(Infolder)
   if Infolder(i).isdir==0
       MyListOfFiles{end+1,1} = Infolder(i).name;
   end
end
% update the listbox with the result
set(handles.Magnification_Dropdown,'String',MyListOfFiles);


% -------------------------------------------------------------------------
%                             CALIBRATION 
% -------------------------------------------------------------------------
% --- Executes on button press in Calibrate_Push.
function Calibrate_Push_Callback(hObject, eventdata, handles)
global scale_bar calibration_folder_name calibrated_area um_per_pixel
% hObject    handle to Calibrate_Push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% I calculated the width of the calibration line I made to be 2.694 pixels 
line_width = 2.694;

folder_files_matrix = get(handles.Magnification_Dropdown, 'string');
selected_index = get(handles.Magnification_Dropdown, 'Value');
selected_file_name = folder_files_matrix{selected_index};

file_path = strcat(calibration_folder_name, '/', selected_file_name);

% Upload the grid image with the calibration line (DO NOT USE ANY OTHERS)
image_grid = imread(file_path);

% The threshold of 0.7 would allow only the calibration line to be shown
level = 0.7;                 
image_BW = im2bw(image_grid,level);

% The calibration line is not technically a "line", rather it is more of
% a rectangle so we have to find the perimeter and then subtract both 
% widths before dividing by 2 to obtain the length of the "line"
measurements = regionprops(image_BW, 'Perimeter');
allPerimeters = [measurements.Perimeter];
perimeter_pixels = sum(allPerimeters);

% Length of the line
calibrated_length = (perimeter_pixels-(2*line_width))/2;

% The scale bar tells us how long the length is, therefore
um_per_pixel = scale_bar/calibrated_length;

% Obtain length and width of the complete image
[l,w] = size(image_BW);
image_calibratedlength = l*um_per_pixel;
image_calibratedwidth = w*um_per_pixel;

axes(handles.Display);
imshow(image_BW);

calibrated_area = image_calibratedlength*image_calibratedwidth

set(handles.Calibrated_Area_String, 'String', calibrated_area);

function Scale_Bar_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Scale_Bar_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Scale_Bar_Input as text
%        str2double(get(hObject,'String')) returns contents of Scale_Bar_Input as a double


% --- Executes during object creation, after setting all properties.
function Scale_Bar_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Scale_Bar_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Slide_Dropdown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slide_Dropdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
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



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider12_Callback(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider16_Callback(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
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


% --- Executes on slider movement.
function slider17_Callback(hObject, eventdata, handles)
% hObject    handle to slider17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider18_Callback(hObject, eventdata, handles)
% hObject    handle to slider18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider19_Callback(hObject, eventdata, handles)
% hObject    handle to slider19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to Intensity_Lower_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Intensity_Lower_Input as text
%        str2double(get(hObject,'String')) returns contents of Intensity_Lower_Input as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Intensity_Lower_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider20_Callback(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% -------------------------------------------------------------------------
%                                 HELP 
% -------------------------------------------------------------------------
% --- Executes on button press in Help_Button.
function Help_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('For troubleshooting or assistance, please contact Darwin Kwok at darwin.kwok@ucsf.edu or (808)-391-2239. Or figure this shit yourself', 'Troubleshooting')
