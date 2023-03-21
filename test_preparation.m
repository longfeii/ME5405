clc

img=imread('hello_world.jpg');

%% D
x1=[400,440];
y1=[100,155];
sub_image1 =imcrop(img,[x1(1),y1(1),abs(x1(1)-x1(2)),abs(y1(1)-y1(2))]);
sub_image1=rgb2gray(sub_image1);
figure(1);
imshow(sub_image1);
imwrite(sub_image1,'KNN_Test\1.jpg');
% sub_image1 = imresize(sub_image1,[32,32]);
[h,w]=size(sub_image1);
for y=1: w
    for x=1: h
        if sub_image1(x,y)<125
            sub_image1(x,y)=0;
        else
            sub_image1(x,y)=1;
        end
        img_matrix_D(x,y)=sub_image1(x,y);
    end
end
filesave=['KNN_Test/Test_character/D','.mat'];
save(filesave,"img_matrix_D");

%% E
x2=[40,80];
y2=[100,155];
sub_image2 =imcrop(img,[x2(1),y2(1),abs(x2(1)-x2(2)),abs(y2(1)-y2(2))]);
figure(2);
imwrite(sub_image2,'KNN_Test\E.jpg');
imshow(sub_image2);
% sub_image2 = imresize(sub_image2,[32,32]);
[h,w]=size(sub_image2);
for y=1: w
    for x=1: h
        if sub_image2(x,y)<125
            sub_image2(x,y)=0;
        else
            sub_image2(x,y)=1;
        end
        img_matrix_E(x,y)=sub_image2(x,y);
    end
end
filesave=['KNN_Test/Test_character/E','.mat'];
save(filesave,"img_matrix_E");

%% H
x3=[5,40];
y3=[100,155];
sub_image3 =imcrop(img,[x3(1),y3(1),abs(x3(1)-x3(2)),abs(y3(1)-y3(2))]);
figure(3);
imwrite(sub_image3,'KNN_Test\H.jpg');
imshow(sub_image3);
% sub_image1 = imresize(sub_image1,[32,32]);
[h,w]=size(sub_image3);
for y=1: w
    for x=1: h
        if sub_image3(x,y)<125
            sub_image3(x,y)=0;
        else
            sub_image3(x,y)=1;
        end
        img_matrix_H(x,y)=sub_image3(x,y);
    end
end
filesave=['KNN_Test/Test_character/H','.mat'];
save(filesave,"img_matrix_H");

%% L
x4=[80,120];
y4=[100,155];
sub_image4 =imcrop(img,[x4(1),y4(1),abs(x4(1)-x4(2)),abs(y4(1)-y4(2))]);
figure(4);
imwrite(sub_image4,'KNN_Test\L.jpg');
imshow(sub_image4);
% sub_image4 = imresize(sub_image4,[32,32]);
[h,w]=size(sub_image4);
for y=1: w
    for x=1: h
        if sub_image4(x,y)<125
            sub_image4(x,y)=0;
        else
            sub_image4(x,y)=1;
        end
        img_matrix_L(x,y)=sub_image4(x,y);
    end
end
filesave=['KNN_Test/Test_character/L','.mat'];
save(filesave,"img_matrix_L");

%% O
x5=[145,185];
y5=[100,155];
sub_image5 =imcrop(img,[x5(1),y5(1),abs(x5(1)-x5(2)),abs(y5(1)-y5(2))]);
figure(5);
imwrite(sub_image5,'KNN_Test\O.jpg');
imshow(sub_image5);
% sub_image1 = imresize(sub_image1,[32,32]);
[h,w]=size(sub_image5);
for y=1: w
    for x=1: h
        if sub_image5(x,y)<125
            sub_image5(x,y)=0;
        else
            sub_image5(x,y)=1;
        end
        img_matrix_O(x,y)=sub_image5(x,y);
    end
end
filesave=['KNN_Test/Test_character/O','.mat'];
save(filesave,"img_matrix_O");

%% R
x6=[330,362];
y6=[100,155];
sub_image6 =imcrop(img,[x6(1),y6(1),abs(x6(1)-x6(2)),abs(y6(1)-y6(2))]);
figure(6);
imwrite(sub_image6,'KNN_Test\R.jpg');
imshow(sub_image6);
% sub_image1 = imresize(sub_image1,[32,32]);
[h,w]=size(sub_image6);
for y=1: w
    for x=1: h
        if sub_image6(x,y)<125
            sub_image6(x,y)=0;
        else
            sub_image6(x,y)=1;
        end
        img_matrix_R(x,y)=sub_image6(x,y);
    end
end
filesave=['KNN_Test/Test_character/R','.mat'];
save(filesave,"img_matrix_R");

%% W
x7=[250,290];
y7=[100,155];
sub_image7 =imcrop(img,[x7(1),y7(1),abs(x7(1)-x7(2)),abs(y7(1)-y7(2))]);
figure(7);
imwrite(sub_image7,'KNN_Test\W.jpg');
imshow(sub_image7);
% sub_image1 = imresize(sub_image1,[32,32]);
[h,w]=size(sub_image7);
for y=1: w
    for x=1: h
        if sub_image7(x,y)<125
            sub_image7(x,y)=0;
        else
            sub_image7(x,y)=1;
        end
        img_matrix_W(x,y)=sub_image7(x,y);
    end
end
filesave=['KNN_Test/Test_character/W','.mat'];
save(filesave,"img_matrix_W");