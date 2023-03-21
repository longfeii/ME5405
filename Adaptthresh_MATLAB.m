%% Adaptive image threshold using local first-order statistics
function [ image ] = Adaptthresh_MATLAB(filepath,m)
    img=imread(filepath);
    T=adaptthresh(img,m);
    image=imbinarize(img,T);

    % Use the bwareaopen function to remove small background noise from the image.
    image=~image;
    image = bwareaopen(image,20);

    % Bridge the breakpoint, fill the isolated inner pixel
    image=bwmorph(image,"bridge");
    image=bwmorph(image,"fill");

