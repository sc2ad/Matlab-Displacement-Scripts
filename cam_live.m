%%   ******************************  AUTOMATION - PROBE STATION MEASUREMENTS *************************************
% Summer intership 2015 - University of California Berkeley
% Pister's Group - Swarm Lab
% Home institution - Universidade Federal de Ouro Preto
% Exchange program - Ciencias sem Fronteiras 
% Sponsors - CAPES 
%            CNPq
%            Brazilian Federal Government     
% Student: Jesssica Ferreira Soares
% Advisor: David Burnett
% Email: jekasores@yahoo.com.br
%        JFerreiraSoares01@wildcats.jwu.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DESCRIPTION : This function gets images from the camera 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function [array_pixel,array_micro] = camera_live()

clear;clc;
disp(sprintf('\t\t\t##### CAMERA LIVE #####\n\n'));

%% *****************   MEX OPERATION (DONE ONCE, THEN SAVE .MEX FILES IN ACTIVE DIRECTORY) **************************
% mex  'OPEN_CAMERA.cpp' 'C:\Program Files\Thorlabs\Scientific Imaging\DCx Camera Support\Develop\Lib\uc480_64.lib'
% mex  'GRAB_FRAME.cpp' 'C:\Program Files\Thorlabs\Scientific Imaging\DCx Camera Support\Develop\Lib\uc480_64.lib'
% mex  'SET_PIXCLK_EXPTIME_FPS.cpp' 'C:\Program Files\Thorlabs\Scientific Imaging\DCx Camera Support\Develop\Lib\uc480_64.lib'
% mex  'CLOSE_CAMERA.cpp' 'C:\Program Files\Thorlabs\Scientific Imaging\DCx Camera Support\Develop\Lib\uc480_64.lib'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %% Open camera, get structure for image
[cam_handle, I]=OPEN_CAMERA(); % while camera is running, do not delete cam_handle!

%% *****************  SET PIXELCLOCK, EXPOSURE, AND FRAME RATE ************************
pixel_clock = 24; % range is 5 to 40 MHz. Higher is faster
exposure = 30; % range is 0 to 78. Higher is more exposed
frames_per_second = 20; %range is 0 to 100 (%). 100 is fastest
SET_PIXCLK_EXPTIME_FPS(cam_handle,pixel_clock,exposure,frames_per_second);

%% **************** INPUT DATA ********************
pixelsize = 3.6*10^(-6); %defined by cameras's manufecture 
% obj = input('Enter how many objects you want o crop in the image: ');
precision = input('Enter with the precision in pixels: ');
displacement= input('Enter with the maximum displacement in pixels: ');
total_frames = input('Enter with the number of frames the camera should capture: ');

%
%% **************** GRAB FRAME *********************
% tic;
warning('off', 'images:initSize:adjustingMag');


for i=1:total_frames;
    GRAB_FRAME(cam_handle, I); %Stores the image in I.image
    RGB=demosaic((I.image.'),'rggb');
    iptsetpref('ImshowAxesVisible','on'); % Turn warning on

    %IMAGE TREATMENT
    gray = rgb2gray(RGB);
   
    if i==1
        
        disp('Frame size in pixels: ');
        disp(size(gray));
        max_displacement = min(size(gray));
        while (displacement > max_displacement)
            displacement= input('Enter a new value displacement in pixels! It should respect the frame dimension. New value: ');
        end
        
  
        %SHOW IMAGE 
         imshow(gray);
        
         %CROP TEMPLATE
        [template,rect, xtemp, ytemp] = get_template(gray,precision);
        cont = 1;  
        
    else
 
        %CALCULATE DISPLACEMENT
        tic;
        [xoffSet, yoffSet, dispx,dispy,x,y,c1] = meas_displacement(template,rect,gray, xtemp, ytemp,precision, displacement); 
        toc;

        %DRAW RECTANGLE AROUND OBJECT
        draw_rect(gray, xoffSet, yoffSet, template);

        array_pixel(cont,:) = [x,y];
        array_micro(cont,:) = [dispx,dispy];
        cont = cont+1;

    end
    
    pause(0.001)
    
end

% disp(['frame rate is ', num2str(100/toc) ' Hertz']);

 CLOSE_CAMERA(cam_handle,I);


end

