%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Perform hough transform on img to find dominant angle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function theta = meas_angle(image,rect)
    % convert image to grayscale
    I=imcrop(image,rect);
    BW=edge(I,'canny');
    % imshow(BW)
    
    % perform hough transform, with angular resolution of 0.0001 degs
    % theta is the angle of inclination of rho, the perpendicular 
    % distance that the line makes to the origin, wrt the x-axis
    % origin is top left corner of img
    % this angle is the same as the angle of the line of interest wrt
    % the vertical
    [H,T,R]=hough(BW,'Theta',-2:0.0001:2);
    
    % find peaks in hough transform
    P=houghpeaks(H,5,'threshold',ceil(0.01*max(H(:))));
    
    %find corresponeding lines
    lines = houghlines(BW,T,R,P,'FillGap',40,'MinLength',40);

    % troubleshoot by plotting img1 with houghlines on top
        figure, imshow(I), hold on
        max_len = 0;
        for k = 1:length(lines)
           xy = [lines(k).point1; lines(k).point2];
           plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
           % Plot beginnings and ends of lines
           plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
           plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    
           % Determine the endpoints of the longest line segment
           len = norm(lines(k).point1 - lines(k).point2);
           if ( len > max_len)
              max_len = len;
              xy_long = xy;
           end
        end
        plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');
        hold off
    
    % get max angle
    arr=zeros(1,length(lines));
    for j=1:length(lines)
        arr(j)=lines(j).theta;
    end
    theta=mean(abs(arr));
end