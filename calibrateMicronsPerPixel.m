%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Summer intership 2016 - University of California Berkeley
% Pister's Group - Swarm Lab    
% Student: Jesssica Ferreira Soares
% Advisor: Daniel Contreras
% Email: adamznow@gmail.com
%        dcontreras462@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DESCRIPTION : This function creates a calibration period where the user
%can place/draw a line in the live view, that line represents some number
%of microns, as defined by the user, thus removing the need to fill in the
%constant: 'Microns per Inch'
%NOTE: Do make sure that the line is clearly visible of the first frame of
%the video (AS OF NOW)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function micronsPerPixel = calibrateMicronsPerPixel()
% Returns the number of microns per pixel
% GET AN IMAGE
global filename
disp('Beginning Calibration Phase: Please open a video where there is a line in the video')
[FileName, PathName]= uigetfile('*.avi', 'Select the Video File');
% If the user clicks Cancel
if isequal(FileName, 0)
    filename= ' ';
else
    filename = strcat(PathName, FileName);
disp('Input length (in microns) of the line:')
prompt = {'Input length (in microns) of the line:'};
dlg_title = 'Input';
num_lines = 1;
answer = inputdlg(prompt,dlg_title,num_lines);
%micronsPerLine = answer
micronsPerLine = str2num(answer{:});
% GET INPUT SOMEHOW
disp(filename)
video_name = filename;
disp(video_name)
readerobj = VideoReader(video_name);
vidFrames = read(readerobj); %read all video frames
%EXTRACT FRAME
frame.cdata =  vidFrames(:,:,:,0);

%IMAGE TREATMENT
gray = rgb2gray(frame.cdata);


% CALIBRATE IT THROUGH VISION PROCESSING
% ONCE LINE HAS BEEN FOUND, ASK FOR MICRON LENGTH OF IT (OR BEFORE)
% CALCULATE # OF PIXELS OF THE LINE, AND DIVIDE THE MICRONS AND PIXELS TO
% GET MICRONSPERPIXEL

end