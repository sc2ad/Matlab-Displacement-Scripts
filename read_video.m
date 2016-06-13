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
%DESCRIPTION : This function gets images from a pre recorded video 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function [array_pixel1,array_micro1,array_pixel2,array_micro2] = read_video()
% function [array_pixel1,array_micro1,array_pixel2,array_micro2,theta] = read_video()

clear;clc;
disp(sprintf('\t\t\t##### READ VIDEO #####\n\n'));

%% **************** INPUT DATA ********************
% All variables are input in the UI and read by the Interface.m file then
% saved as global variables.
global filename;
global InPrecision;
global InMaxDisp;

pixelsize = 3.6*10^(-6); %defined by camera's manufacture 

video_name= filename;

precision = InPrecision;
displacement= InMaxDisp;
%
%% **************** GRAB FRAME *********************
tic;
warning('off', 'images:initSize:adjustingMag');

readerobj = VideoReader(video_name);
vidFrames = read(readerobj); %read all video frames
total_frames = get(readerobj, 'NumberOfFrames');

for i=1:total_frames
    
    %EXTRACT FRAME
    frame.cdata =  vidFrames(:,:,:,i);
    
    %IMAGE TREATMENT
    gray = rgb2gray(frame.cdata);
    
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
        [template1,rect1, xtemp1, ytemp1] = get_template(gray,precision);
        [template2,rect2, xtemp2, ytemp2] = get_template(gray,precision);
%         [templateAng,rectAng, xtempAng, ytempAng] = get_template(gray,precision);
        cont = 1;  
        
    else
        %CALCULATE DISPLACEMENT
        [xoffSet1, yoffSet1, dispx1,dispy1,x1,y1,c11] = meas_displacement(template1,rect1,gray, xtemp1, ytemp1,precision, displacement); 
        [xoffSet2, yoffSet2, dispx2,dispy2,x2,y2,c12] = meas_displacement(template2,rect2,gray, xtemp2, ytemp2,precision, displacement); 
        
        %DRAW RECTANGLE IN OBJECT      
        draw_rect(gray, xoffSet1, yoffSet1, template1);
        hold on;
        draw_rect(gray, xoffSet2, yoffSet2, template2);
        hold off;
        array_pixel1(cont,:) = [x1,y1, sqrt(x1^2 + y1^2)];
        array_micro1(cont,:) = [dispx1,dispy1, sqrt(dispx1^2 + dispy1^2)];
        array_pixel2(cont,:) = [x2,y2, sqrt(x1^2 + y1^2)];
        array_micro2(cont,:) = [dispx2,dispy2, sqrt(dispx2^2 + dispy2^2)];
%         theta(cont,1)=meas_angle(gray,rectAng);
        cont = cont+1;
    end
    pause(0.001)  
end

disp(['frame rate is ', num2str(100/toc) ' Hertz']);

end

