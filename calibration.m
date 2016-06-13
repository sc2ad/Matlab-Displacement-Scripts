clear;clc;
% Program to make Thorlabs CMOS camera mex files and to test performance.
%% Mex operation (done once, then save .mex files in active directory)
% mex  'OPEN_CAMERA.cpp' 'C:\Program Files\Thorlabs\Scientific Imaging\DCx Camera Support\Develop\Lib\uc480_64.lib'
% mex  'GRAB_FRAME.cpp' 'C:\Program Files\Thorlabs\Scientific Imaging\DCx Camera Support\Develop\Lib\uc480_64.lib'
% mex  'SET_PIXCLK_EXPTIME_FPS.cpp' 'C:\Program Files\Thorlabs\Scientific Imaging\DCx Camera Support\Develop\Lib\uc480_64.lib'
% mex  'CLOSE_CAMERA.cpp' 'C:\Program Files\Thorlabs\Scientific Imaging\DCx Camera Support\Develop\Lib\uc480_64.lib'
% 
% %% Open camera, get structure for image
[cam_handle, I]=OPEN_CAMERA(); % while camera is running, do not delete cam_handle!
%
% %% Set pixelclock, exposure, and frame rate
pixel_clock = 24; % range is 5 to 40 MHz. Higher is faster
exposure = 30; % range is 0 to 78. Higher is more exposed
frames_per_second = 20; %range is 0 to 100 (%). 100 is fastest
SET_PIXCLK_EXPTIME_FPS(cam_handle,pixel_clock,exposure,frames_per_second);
% 
%% Grab a frame
tic;
warning('off', 'images:initSize:adjustingMag');
for i=1:100000
    GRAB_FRAME(cam_handle, I); %Stores the image in I.image
    RGB=demosaic((I.image.'),'rggb');
    imshow(RGB);
    pause(0.001)
end
disp(['frame rate is ', num2str(100/toc) ' Hertz']);
% figure,imagesc(double(I.image));colorbar; %show the last image in a figure.
% %% Close the camera

CLOSE_CAMERA(cam_handle,I);