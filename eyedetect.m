function varargout = eyedetect(varargin)


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @eyedetect_OpeningFcn, ...
                   'gui_OutputFcn',  @eyedetect_OutputFcn, ...
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

function eyedetect_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;


guidata(hObject, handles);




function varargout = eyedetect_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function pushbutton1_Callback(hObject, eventdata, handles)

global sourcepic;
[fname,pname]=uigetfile({'*.jpg';'*.bmp';'*.gif'},'multiselect','off');  
if fname==0
    return;
end
filePath=[pname,fname];
sourcepic=imread(filePath);
axes(handles.axes1);
 
imshow(sourcepic);




function pushbutton2_Callback(hObject, eventdata, handles)

global sourcepic;
global graypic;
global rect;
global center;
adjustimg= imadjust(sourcepic,[0.4 0.6],[]);
bw=im2bw(adjustimg(:,:,2),200/255);
center=[];
   L = bwlabel(bw ,8);

   
 BB  = regionprops(L, 'centroid','BoundingBox','Area','MajorAxisLength','MinorAxisLength'); 
       maxrear=0;
       rect=[];
for qq=1:size(BB,1)
   if BB(qq).Area>maxrear
        rect=BB(qq).BoundingBox;
        maxrear=BB(qq).Area;
        center=BB(qq).Centroid;
        
   end
end



axes(handles.axes2); 
imshow(bw,[])
hold on
   rectangle('position',rect,'edgecolor','r');
 
hold off;

function pushbutton3_Callback(hObject, eventdata, handles)

global center;
global sourcepic;
pic=sourcepic(:,:,3);
[rr,cc]=size(pic);
resultpic=uint8(zeros(rr,cc));
for tt=0:2048
    for rr=60:-1:20
        xx=round(center(2)+rr*cos(tt*2*pi/2048));
        yy=round(center(1)+rr*sin(tt*2*pi/2048));
        
        xx2=round(center(2)+(rr+15)*cos(tt*2*pi/2048));
        yy2=round(center(1)+(rr+15)*sin(tt*2*pi/2048));
        pix1=pic(xx,yy);
         pix2=pic(xx2,yy2);
         
         if pix2-pix1>2
              resultpic(xx,yy)=255;
             break;
         end
         
      
    end
    
    
end

se = strel('ball',12,12);

resultpic=imdilate(resultpic,se);
resultpic=imfill(resultpic);

resultpic=imerode(resultpic,se);
edgepic=edge(resultpic,'canny');
axes(handles.axes2); 
imshow(edgepic,[])


function pushbutton4_Callback(hObject, eventdata, handles)

global zhifang;
global graypic;

junzhi=0;
for i=0:255
    junzhi=i*zhifang(i+1)+junzhi;
end
str=sprintf('%.2f',junzhi);
set(handles.edit1,'string',str);

fangcha=0;
for i=0:255
    fangcha=(double(i)-junzhi)^2*zhifang(i+1)+fangcha;
end
str=sprintf('%.2f',fangcha);
set(handles.edit2,'string',str);

energy=0;
for i=0:255
    energy=zhifang(i+1)^2+energy;
end
str=sprintf('%.2f',energy);
set(handles.edit5,'string',str);

entropy=0;
for i=0:255
    entropy=zhifang(i+1)*log(zhifang(i+1));
end
entropy=(-1)*entropy;
str=sprintf('%.2f',entropy);
set(handles.edit6,'string',str);

if  entropy~=0
    set(handles.edit7,'string','Smoke detected');
else
    set(handles.edit7,'string','Normal');
end



function edit1_Callback(hObject, eventdata, handles)


function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)

function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)

function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)


function edit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)

function edit6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)

function edit7_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function axes1_CreateFcn(hObject, eventdata, handles)

function pushbutton5_Callback(hObject, eventdata, handles)

clc
close all
