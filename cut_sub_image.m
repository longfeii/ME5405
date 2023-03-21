function [sub_image]=cut_sub_image(filepath)
    % read the image.
    img=imread(filepath);

    % The first method: The ginput function allows the user to
    % interactively use the mouse to select the area to be cut to obtain
    % two coordinate points and cut in a rectangle.

    % n is the number of points you want to select, and the abscissa and
    % ordinate of the mouse point will be stored in [x, y]. Then output x,
    % y to get the coordinates of the point that needs to be intercepted on
    % the picture.

    % [x,y] = ginput(2);

    % The second method: directly specify the value of the x and y coordinates.
    x=[5,440];
    y=[100,170];

    % Cut the image, the starting coordinate point (x1, y1) is intercepted
    % to the ending coordinate point (x2, y2).
    sub_image =imcrop(img,[x(1),y(1),abs(x(1)-x(2)),abs(y(1)-y(2))]);

end