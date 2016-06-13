%%   ******************************  FRICTION TESTING *************************************
% University of California Berkeley
% Pister's Group - Swarm Lab  
% Student: Hani Gomez
% Email: gomezhc@berkeley.edu
% Using code by 
%   Student: Jesssica Ferreira Soares
%   Advisor: David Burnett
%   Email: jekasores@yahoo.com.br
%          JFerreiraSoares01@wildcats.jwu.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DESCRIPTION : 
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
clc; clear;

%% ########### MENU - FRICTION TESTING MEASUREMENTS #########

disp('Welcome to Friction Testing 1.0');
%Make this description better.
disp(sprintf('This program plots the maximum \ndisplacement of an object (micron and pixel unit)\nusing various test runs.\n\n'));
disp(sprintf('\t\t##### MENU #####\n'));

disp(sprintf('Choose the one of the following options\n'));
disp('1 - Start');
disp('2 - Done');

option = input('Option >> ');
disp(sprintf('\n\n'));
while ((option ~=1) && (option ~=2))
    option = input('Invalid input! Choose another option: ');
end

while (option == 1)
    main_menu;
    %disp(min(array_micro(:,1)));
    disp(sprintf('Choose the one of the following options\n'));
    disp('1 - Start Another One');
    disp('2 - Done');
    option = input('Option >> ');
    while ((option ~=1) && (option ~=2))
        option = input('Invalid input! Choose another option: ');
    end
end

disp(sprintf('You are done!\n'));
