function [accuracy,weight] = som(m,n)
tic
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

%自组织映射网络m*n 竞争层最少节点数量 =5*sqrt(N)  N：训练样本的个数 如果是正方形输出层，边长等于 竞争层节点数再开一次根号，并向上取整就行
% m=7;
% n=7;
%neuron numbers neu_num 25
neu_num=m*n;
%random weight initialization 25x1024
w = rand(neu_num, data_col); 
%initial learning rate
learn0 = 0.6;
learn_rate = learn0;
%learing parameter
learn_para=1000;
%iteration number
iter =1000;
%neuron position
[I,J] = ind2sub([m, n], 1:neu_num);
%neibor area initial
neighbor0 =2;
neighbor_redius = neighbor0;
%neiber parameter
neighbor_para = 1000/log(neighbor0);
%random select
rs=randi([1 5334],1,5334);
 

for t=1:iter 
    for j=1:data_row        %获取样本点值
        data_x = all_class(rs(j),:); %1x1024
        % find the min one from 25 rows
        [win_row, win_som_index]=min(dist(data_x,w'));  %1x1024and1024x25
        %find the neuron troplogical postion
        [win_som_row,win_som_col] =  ind2sub([m, n],win_som_index);%5x5矩阵中的横纵坐标
        win_som=[win_som_row,win_som_col];
        %calculate the distance
        distance_som = exp( sum(( ([I( : ), J( : )] - repmat(win_som, neu_num,1)) .^2) ,2)/(-2*neighbor_redius^2)) ;
        %update the weights
        for i = 1:neu_num
           % if distance_som(i)<neighbor_redius*neighbor_redius 
            w(i,:) = w(i,:) + learn_rate.*distance_som(i).*( data_x - w(i,:));
        end
    end
 
    %upadte the learning rate
    learn_rate = learn0 * exp(-t/learn_para);   
    %update the radius
    neighbor_redius = neighbor0*exp(-t/neighbor_para);  
end
weight=w;
neu=cell(1,size(w,1));
for i=1:size(w,1)
    neu{1,i}=[];
end

for num=1:data_row
    [som_row,col]= min(sum(( (w - repmat(all_class(num,:), neu_num,1)) .^2) ,2));%每行元素总和取最小一行对应
    neu{ceil(num/762),col}= [neu{1,col},num];    
end
%25个神经元每个对应5334行里的哪些行
%save the neuron，.mat format
path1=strcat(filepath,'neu25.mat');
save(path1,'neu');
label=zeros(7,neu_num);
for i=1:neu_num
    for j=1:7
        ss=size(neu{j,i});
        S(j)=ss(2);
    end
    [daxiao,roww]=max(S);
    for j=1:7
        if S(j)==daxiao
           label(j,i)=j;
        end
    end
end
success=0;
for k=1:(1016-762)*7
[som_row,col]= min(sum(( (weight - repmat(test_class(k,:), neu_num,1)) .^2) ,2));
for j=1:7
if label(j,col)==ceil(k/(1016-762))
    success=success+1;
end
end
accuracy = success / ((1016-762)*7);
    toc;
end



