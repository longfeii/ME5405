clc;
clear;
%% Task 1:
% Display the original image on screen.
filepath = 'chromo.txt';
[original_image] = Display_original(filepath);
figure(1);
imshow(original_image,'InitialMagnification','fit');
imwrite(original_image,"result\original_image_1.jpg");
%% Task 2:
% Threshold the image and convert it into binary image.
clear binary_image;
filepath = 'result\original_image_1.jpg';
% [binary_image] = Global_thresholding(filepath); % Own implementation
% [binary_image] = OTSU_thresholding(filepath);
% [binary_image] = Iterative_thresholding(filepath);
% [binary_image] = Adaptive_thresholding(filepath,0.75); % Own implementation
[binary_image] = Adaptthresh_MATLAB(filepath,0.74);
figure(2);
imshow(binary_image,'InitialMagnification','fit');
imwrite(binary_image,"result\binary_image_1.tif");
%% Task 3:
% Determine an one-pixel thin image of the objects. 
binary_image=imread('result\binary_image_1.tif');
imshow(binary_image,'InitialMagnification','fit')
binary_image1=bwmorph(binary_image,"bridge");
binary_image2=bwmorph(binary_image1,"fill");
addpath(genpath('.\thin'));
img=single(binary_image2);

% ImgThin = bwmorph(img,'skel',Inf);
% figure(10);
% imshow(ImgThin,'InitialMagnification','fit')


% ThinClass=HilditchThin(img);
ThinClass=ZhangSuenThin(img);
% ThinClass=RosenfeldThin(img);

imgThin=ThinClass.thinImg;
figure(3);
imshow(mat2gray(imgThin),'InitialMagnification','fit')
imshow(imgThin,'InitialMagnification','fit')


%% Task 4:
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
figure(4);
imshow(mat2gray(imgOutline),'InitialMagnification','fit')
% imshow(imgOutline,'InitialMagnification','fit')


%% Task 5:
%Label the different objects(color different objects in different colors)

% W = fspecial('gaussian',30,1); 
% G = imfilter(binary_image, W, 'replicate');
% figure(1);
% subplot(121); imshow(binary_image); title('origin image');
% subplot(122); imshow(G);    title('after filter');

% %preprocess dilate
% binary_image_erode = bwmorph(binary_image,'dilate');
% figure;
% imshow(binary_image_erode,'InitialMagnification','fit');
% title('dilate');

% binary_image_j=bwmorph(binary_image,'bridge');
% binary_image_i=bwmorph(binary_image_j,'fill');
% % binary_image_i=bwmorph(binary_image_z,'hbreak');
% figure;
% imshow(binary_image_i,'InitialMagnification','fit');
% title('bridge');


% %bwconncomp
% connect=bwconncomp(binary_image,8);
% labeled = labelmatrix(connect);
% RGB_label = label2rgb(labeled,'jet','k');
% figure;
% imshow(RGB_label,'InitialMagnification','fit');
% title('bwconncomp');

% %bwlabel
% labeled=bwlabel(binary_image,8);
% RGB_label=label2rgb(labeled,'jet','k');
% figure;
% imshow(RGB_label,'InitialMagnification','fit');
% title('bwlabel');


%%classical method
matrix_4=connectivity_4(~binary_image);
matrix_4_RGB = label2rgb(matrix_4,'hsv',[0 0 0],'shuffle');
figure;
imshow(matrix_4_RGB,'InitialMagnification','fit')
title('segmentation by classical algorithm connectivity 4');
% 
% matrix_8=connectivity_8(~binary_image);
% matrix_8_RGB = label2rgb(matrix_8,'hsv',[0 0 0],'shuffle');
% figure;
% imshow(matrix_8_RGB,'InitialMagnification','fit')
% title('segmentation by classical algorithm connectivity 8');

% 
% %region grow method
% matrix_region_4=regiongrow_4(binary_image);
% figure;
% matrix_region_4_RGB = label2rgb(matrix_region_4,'hsv',[0 0 0]);
% imshow(matrix_region_4_RGB,'InitialMagnification','fit');
% title('segmentation by region grow connectivity 4');
 
matrix_region_8=regiongrow_8(binary_image);
figure;
matrix_region_8_RGB = label2rgb(matrix_region_8,'hsv',[0 0 0]);
imshow(matrix_region_8_RGB,'InitialMagnification','fit');
title('segmentation by region grow connectivity 8');


%bound and label the objects
figure;
position=boundbox(matrix_region_8,matrix_region_8_RGB);
title('bound and label the objects');

%crop and show the seperated objects
figure;
segment_matrix=wcropshow(position,matrix_region_8,0);%boundingbox parameters position(1)position(2)= coordinate of left up conner position(3)position(4) = pixel length of row and column ,rotation angle by nearest
sgtitle('crop  image to seperate objects ');



%% Task 6:
% %Rotate the original image
rot30_ne=imrotate(original_image,-30,'nearest');
figure;imshow(rot30_ne,'InitialMagnification','fit');title('rot30 by nearest');
rot30_li=imrotate(original_image,-30,'bilinear');
figure;imshow(rot30_li,'InitialMagnification','fit');title('rot30 by bilinear');
rot30_cu=imrotate(original_image,-30,'bicubic');
figure;imshow(rot30_cu,'InitialMagnification','fit');title('rot30 by bicubic');

% %rotate whole image
% rot_nearest=imrotation_nearest(original_image,30);
% figure;imshow(rot_nearest,'InitialMagnification','fit');title('rot30 by nearest');
% rot_bilinear=imrotation_bilinear(original_image,30);
% figure;imshow(rot_bilinear,'InitialMagnification','fit');title('rot30 by bilinear');
rot_bicubic=imrotation_bicubic(original_image,30);
figure;imshow(rot_bicubic,'InitialMagnification','fit');title('rot30 by bicubic');
% 
% rot_nearest=imrotation_nearest(original_image,60);
% figure;imshow(rot_nearest,'InitialMagnification','fit');title('rot60 by nearest');
% rot_bilinear=imrotation_bilinear(original_image,60);
% figure;imshow(rot_bilinear,'InitialMagnification','fit');title('rot60 by bilinear');
% rot_bicubic=imrotation_bicubic(original_image,60);
% figure;imshow(rot_bicubic,'InitialMagnification','fit');title('rot60 by bicubic');
% 
% rot_nearest=imrotation_nearest(original_image,90);
% figure;imshow(rot_nearest,'InitialMagnification','fit');title('rot90 by nearest');
% rot_bilinear=imrotation_bilinear(original_image,90);
% figure;imshow(rot_bilinear,'InitialMagnification','fit');title('rot90 by bilinear');
% rot_bicubic=imrotation_bicubic(original_image,90);
% figure;imshow(rot_bicubic,'InitialMagnification','fit');title('rot90 by bicubic');


% %rotate seperate object
figure;
rotation_matrix=wcropshow(position,matrix_region_8,30);
sgtitle('crop image to seperate objects and rotate by 30'); 