% dir=('D:\pictures');
% testdir=('D:\testPictures\test');
% trainingSet = imageSet(dir,'recursive');
% testSet = imageSet(testdir,'recursive');
% function [features] = getGLCMFeatures(image)
% features_all  = [];
% for i = 1:10
%     glcm = graycomatrix(image, 'Offset', [0,i]);
%     stats = graycoprops(glcm);
% end
% features=feature_all;
% end
% 
% function [trainingFeatures,trainingLabels,testFeatures,testLabels]=extractFeature(trainingSet,testSet)
% img = read(trainingSet(1), 1);
% %转化为灰度图像
% img=rgb2gray(img);
% %转化为2值图像
% lvl = graythresh(img);
% img = im2bw(img, lvl);
% img=imresize(img,[256 256]);
% cellSize = [4 4];
% [hog_feature, vis_hog] = extractHOGFeatures(img,'CellSize',cellSize);
% glcm_feature = getGLCMFeatures(img);
% SizeOfFeature = length(hog_feature)+ length(glcm_feature);
% trainingFeatures = [];
% trainingLabels = [];
% for digit = 1:numel(trainingSet)
% numImages = trainingSet(digit).Count;
% features = zeros(numImages, SizeOfFeature, ‘single’);%初始化特征向量
% % 遍历每张图片
% for i = 1:numImages
% img = read(trainingSet(digit), i);% 取出第i张图片
% end
% testFeatures = [];
% testLabels = [];
% for digit = 1:numel(testSet)
%     end
% end
% end
% 
% 
% 
    filepath = 'train_preperation/';
    % 6 classes of images
    % Work type
    TEST_SET = 1;

    % Training
    for i = 1:7
        % Get 75% images in the dataset to train
        if i == 1
            character="D";
        end
        if i == 2
            character="E";
        end
        if i == 3
            character="H";
        end
        if i == 4
            character="L";
        end
        if i == 5
            character="O";
        end
        if i == 6
            character="R";
        end
        if i == 7
            character="W";
        end
        for j = 1:762
            % Load images
            name = num2str(j);
            temp = load([filepath char(character) '/img_' name '.mat']);
            % Squeeze the image to 1D
            train_img = temp.img_matrix(:)';
            
            % Store the image in different classes
            if i == 1
                class_D(j,:) = train_img;%762 个D with 32x32=1024 个colomns
            end
            if i == 2
                class_E(j,:) = train_img;
            end
            if i == 3
                class_H(j,:) = train_img;
            end
            if i == 4
                class_L(j,:) = train_img;
            end
            if i == 5
                class_O(j,:) = train_img;
            end
            if i == 6
                class_R(j,:) = train_img;
            end
            if i == 7
                class_W(j,:) = train_img;
            end
        end
    end
    
    % Testing
    % Merge 6 classes
    all_class = [class_D; class_E; class_H; class_L; class_O; class_R; class_W];
%     k_value = 3;
    success = 0;

    % Test set
    test_class = zeros((1016-762)*7, 32*32);
    if TEST_SET == 1
        for i = 1:7
            % Get 25% images in the dataset to test
            if i == 1
                character="D";
            end
            if i == 2
                character="E";
            end
            if i == 3
                character="H";
            end
            if i == 4
                character="L";
            end
            if i == 5
                character="O";
            end
            if i == 6
                character="R";
            end
            if i == 7
                character="W";
            end
            for j = 763:1016
                % Load images
                name = num2str(j);
                temp = load([filepath char(character) '/img_' name '.mat']);
                test_img = temp.img_matrix(:)';
                test_class((i-1)*(1016-762) + j - 762,:) = test_img;
            end
        end
    end

all_class=double(all_class);
% 5334x1024
[data_row,data_col]=size(all_class);
all_class_label=zeros(data_row,1);
n=1;
for i=1:762
classifier = fitcecoc(trainingFeatures, trainingLabels);
save classifier.mat classifier;