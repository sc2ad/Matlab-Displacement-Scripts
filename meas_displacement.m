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
%DESCRIPTION : This function calculates the coordinate in subpixel of the
%moved template. It also give the object displacement in subpixels and
%microns
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function [xoffSet, yoffSet, dispx, dispy,x, y, c1] = meas_displacement(template, rect, img, xtemp, ytemp, precision, displacement)
pixelsize = 3.6*10^(-6); %defined by cameras's manufacture 
min_displacement = 2; %pixel unit
Xm =40*10^(-6); %distance according to chip dimensions in microns
Xp = 184.67662; %distance according image in pixels. Correspond to Xm

%%    ************************** WHOLE PIXEL PRECISION COORDINATES *************************
     
        %DEFINE SEARCH AREA - obtained from no interpolated image
        width = displacement; 
        height = displacement;

        xmin = rect(1) - width;
        ymin = rect(2)- height;
        n_width = 2*width+rect(3);
        n_height = 2*height+rect(4);
        [A, rectangle] = imcrop(img,[xmin ymin n_width n_height]);
        draw_rect(img, n_width, n_height, A);
       
        %PERFORM NORMALIZED CROSS-CORRELATION
         c = normxcorr2(template,A);
             
        %FIND PEAK CROSS-CORRELATION
        [ypeak, xpeak] = find(c==max(c(:)));   
        xpeak = xpeak+round(rectangle(1))-1;
        ypeak = ypeak+round(rectangle(2))-1;

        
%% ************************** SUBPIXEL PRECISION COORDINATES *************************
        
        %GENERATE MOVED TEMPLATE
        new_xmin= (xpeak-xtemp) + rect(1);
        new_ymin = (ypeak-ytemp) + rect(2);
        [moved_template, rect1] = imcrop(img,[new_xmin new_ymin rect(3) rect(4)]);

        %GENERATE NEW SEARCH AREA (BASED IN MOVED TEMPLATE)
        width1 = min_displacement;
        height1 = min_displacement;
        xmin1 = rect1(1) - width1;
        ymin1 = rect1(2)- height1;
        n_width1 = 2*width1+rect1(3);
        n_height1 = 2*height1+rect1(4);
        [A1, rectangle1] = imcrop(img,[xmin1 ymin1 n_width1 n_height1]);
        
        % BICUBIC INTERPOLATION - TEMPLATE
        interp_template = im2double(template);
        [numRows,numCols,dim] = size(interp_template);
        [X,Y] = meshgrid(1:numCols,1:numRows);
        [Xq,Yq]= meshgrid(1:precision:numCols,1:precision:numRows);
        V=interp_template;
        interp_template = interp2(X,Y,V,Xq,Yq, 'cubic'); 
        
        % BICUBIC INTERPOLATION - SEARCH AREA (FROM MOVED TEMPLATE
        interp_A = im2double(A1);
        [numRows,numCols,dim] = size(interp_A);
        [X,Y] = meshgrid(1:numCols,1:numRows);
        [Xq,Yq]= meshgrid(1:precision:numCols,1:precision:numRows);
        V=interp_A;
        interp_A = interp2(X,Y,V,Xq,Yq, 'cubic');   
        
        
         %PERFORM NORMALIZED CROSS-CORRELATION
         c1 = normxcorr2(interp_template,interp_A);
         
        %FIND PEAK CROSS-CORRELATION
        [new_ypeak, new_xpeak] = find(c1==max(c1(:)));  

        new_xpeak = new_xpeak/(1/precision);
        new_ypeak = new_ypeak/(1/precision);
        new_xpeak = new_xpeak+round(rectangle1(1));
        new_ypeak = new_ypeak+round(rectangle1(2));
        disp('(xpeak,ypeak) =');
        disp([new_xpeak, new_ypeak]);

    disp('__ __ __ __ __ __ __ __ __ __ __ __');
    
    yoffSet = new_ypeak-(size(template,1));
    xoffSet = new_xpeak-(size(template,2));

    %DISPLACEMENT IN PIXELS
    y = new_ypeak-ytemp;
    x = new_xpeak-xtemp;
    
    %DISPLACEMENT IN MICRONS
    dispx = Xm*x/Xp;
    dispy = Xm*y/Xp;
    

end


