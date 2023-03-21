clc;
% It is highly recommended to comment KNN part (Task7/8) first to see the 
% result of other tasks, and then to look at KNN, because one KNN session
% takes 1 minute (7 minutes totally for Task 7/8).

%% Task 1:
% Display the original image on screen.
original_image = imread('hello_world.jpg');
figure(1);
imshow(original_image);
imwrite(original_image,'result\original_image_2.jpg');

%% Task 2:
% Create an image which is a sub-image of the original image comprising the
% middle line – HELLO, WORLD.
filepath = 'result\original_image_2.jpg';
[sub_image]=cut_sub_image(filepath);
figure(2);
imshow(sub_image);
imwrite(sub_image,"result\original_sub_image_2.jpg");

%% Task 3:
% Create a binary image from Step 2 using thresholding.
clear binary_image;
filepath='result\original_sub_image_2.jpg';
[binary_image] = Global_thresholding(filepath);
figure(3);
imshow(binary_image);
imwrite(binary_image,"result\binary_image_2.jpg");
%% Task 4:
% Determine an one-pixel thin image of the objects. 

addpath(genpath('.\thin'));
img=single(binary_image);


% ImgThin = bwmorph(img,'skel',Inf);
% figure(10);
% imshow(ImgThin,'InitialMagnification','fit')


% ThinClass=HilditchThin(img);
ThinClass=ZhangSuenThin(img);
% ThinClass=RosenfeldThin(img);

imgThin=ThinClass.thinImg;
figure(4);
imshow(mat2gray(imgThin),'InitialMagnification','fit')
imshow(imgThin,'InitialMagnification','fit')

%% Task 5:
% Determine the outline(s). 
addpath(genpath('.\outline'));

% imgOutline = bwmorph(img,'remove');
% figure(11);
% imshow(imgOutline,'InitialMagnification','fit')

% BW1=edge(img,"sobel");
% figure(12);
% imshow(mat2gray(BW1),'InitialMagnification','fit')

OutlineClass=CannyEdgeDetection(3,1,img);
% OutlineClass=RobertsEdgeDetection(img);
% OutlineClass=PrewittEdgeDetection(img);

imgOutline=OutlineClass.outlineImg;
figure(5);
% imshow(imgOutline,'InitialMagnification','fit')
imshow(mat2gray(imgOutline),'InitialMagnification','fit')

%% Task 6:
for i=1:3
 binary_image(:,i)=[];
end
%%classical method
matrix_4=connectivity_4(~binary_image);
matrix_4_RGB = label2rgb(matrix_4,'hsv',[0 0 0],'shuffle');
figure(6);
imshow(matrix_4_RGB,'InitialMagnification','fit')
title('segmentation by classical algorithm connectivity 4');

% matrix_8=connectivity_8(~binary_image);
% matrix_8_RGB = label2rgb(matrix_8,'hsv',[0 0 0],'shuffle');
% figure;
% imshow(matrix_8_RGB,'InitialMagnification','fit')
% title('segmentation by classical algorithm connectivity 8');
%region grow method
matrix_region_4=regiongrow_4(binary_image);
figure(7);
matrix_region_4_RGB = label2rgb(matrix_region_4,'hsv',[0 0 0],'shuffle');
imshow(matrix_region_4_RGB,'InitialMagnification','fit');
title('segmentation by region grow connectivity 4');

% matrix_region_8=regiongrow_8(binary_image);
% figure;
% matrix_region_8_RGB = label2rgb(matrix_region_8,'hsv',[0 0 0],'shuffle');
% imshow(matrix_region_8_RGB,'InitialMagnification','fit');
% title('segmentation by region grow connectivity 8');

%bound and label the objects
figure(8);
position=boundbox(matrix_region_4,matrix_region_4_RGB);
title('bound and label the objects');
%crop and show the seperated objects
figure(9);
segment_matrix=wcropshow(position,matrix_region_4,30);%boundingbox parameters position(1)position(2)= coordinate of left up conner position(3)position(4) = pixel length of row and column ,rotation angle by nearest
sgtitle('crop image to seperate objects and rotate by 30');

%% Task 7
% Use KNN to recognize characters
% Choose value of k
%     train_preparation();
%-----------------------------------------------------uncomment code there
% k_value=3;
% [accuracy, success] = knn_train(k_value);    
% disp(['K = ' num2str(k_value),'; The accuracy is ' num2str(accuracy)])
%-----------------------------------------------------uncomment code there

%Use som 
[accuracy_s,weight]=som(6,6);
 
%Use SVM

%% Task 8
% Experiment by tuning the hyperparameter
%-----------------------------------------------------uncomment code there
for k_value = 1:2:10
    [accuracy, success] = knn_train(k_value); 
    disp(['K = ' num2str(k_value),'; The accuracy is ' num2str(accuracy)])
end
%-----------------------------------------------------uncomment code there
