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
%DESCRIPTION : This function draw a rectagle around the template. It also
%serves to give the illusion that the video is playing as the code runs
%through the frames. The video will play in the desired axes in the UI.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function draw_rect(RGB, xoffSet, yoffSet, template)
    imshow(RGB);%The image is displayed.
    %The rectangle is drawn on the image, and the image and rectangle are
    %set on the preset axes from the UI. "gca" is used to refer to the
    %preset axes.
    imrect(gca, [xoffSet, yoffSet, size(template,2), size(template,1)]);
end