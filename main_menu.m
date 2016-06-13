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
%DESCRIPTION : This function enables the user to interact with the program
%throught a menu and choose what kind of image will be used for object
%detection and displacement calculation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function main_menu()

%%
clc;clear;

%% ########### MENU - PROBE STATION MEASUREMENTS #########
disp('Welcome to Probe Station Measurements 1.0!');
disp(sprintf('This program calculates the displacement \nof an object (micron and pixel unit)\nfrom different visual resources.\n\n'));
disp(sprintf('\t\t##### MENU #####\n'));
disp(sprintf('Choose one of the following options\n'));
disp('1 - Camera live');
disp('2 - Read recorded video');

global option;
global SaveFolder;
global NameFigure;
global NameDataFile;

%%option = input('Option >> ');
disp(sprintf('\n\n'));
while ((option ~=1) & (option ~=2))
    option = input('Invalid input! Choose another option: ');
end
if (option == 1)
    [array_pixel1,array_micro1,array_pixel2,array_micro2] = cam_live();
%     [array_pixel1,array_micro1,array_pixel2,array_micro2,theta] = cam_live();
else
    [array_pixel1,array_micro1,array_pixel2,array_micro2] = read_video();
%     [array_pixel1,array_micro1,array_pixel2,array_micro2,theta] = read_video();
end

global xAxisMicronsValue;
global yAxisMicronsValue;
global xAxisPixelsValue;
global yAxisPixelsValue;

disp('Maximum displacement in pixels: ');
disp('axes x: ');
disp(min(array_pixel1(:,1)));
xAxisPixelsValue = min(array_pixel1(:,1));
disp('axes y: ');
disp(min(array_pixel1(:,2)));
yAxisPixelsValue = min(array_pixel1(:,2));
% figure;subplot(1,2,1);plot(array_pixel);title('Displacement object - subpixel');
figure;
plot(array_pixel1);title(strcat(NameFigure,' Object displacement - Subpixel'));
legend('Displacement in X','Displacement in Y','Diagonal Displacement','Location','southwest')
xlswrite('Data', array_pixel1);
xlabel('Frames') % x-axis label
ylabel('Pixels') % y-axis label

% Indicates where to save figure and what to name it.
savefig(strcat(SaveFolder, '/', NameFigure, '.fig'));

% save('blah','array_pixel1', 'array_pixel2')

% Indicates where to save data file and what to name it.
dlmwrite(strcat(SaveFolder, '/', NameDataFile, '.txt'),[array_pixel1, array_pixel2]);

M= csvread(strcat(SaveFolder, '/', NameDataFile, '.txt'));

display(M);

disp('Maximum displacement in micros: ');
disp('axes x: ');
disp(min(array_micro1(:,1)));
xAxisMicronsValue = min(array_micro1(:,1));
disp('axes y: ');
disp(min(array_micro1(:,2)));
yAxisMicronsValue = min(array_micro1(:,2));
% subplot(1,2,2);plot(array_pixel);title('Displacement object - microns');

end
