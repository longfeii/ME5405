%% OTSU Threshold
function [ image ] = OTSU_thresholding(filepath)
    img=imread(filepath);
    T=graythresh(img);
    image=imbinarize(img,T);