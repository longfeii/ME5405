%% Iterative method
function [ image ] = Iterative_thresholding(filepath)
    img=imread(filepath);
    img=im2gray(img);                                   
    img=im2double(img);                                 
    T=0.5*(min(img(:))+max(img(:)));
    done=false;
    while ~done
        g=img>=T;
        Tn=0.5*(mean(img(g))+mean(img(~g)));
        done=abs(T-Tn)<0.1;
        T=Tn;
    end         
    image=imbinarize(img,T);                               