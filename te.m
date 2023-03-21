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

neu_num=25

label=zeros(7,neu_num);
for i=1:neu_num
    for j=1:7
        ss=size(neu{j,i});
        S(j)=ss(2);
    end
    [daxiao,roww]=max(S);
    for j=1:7
        if S(j)==daxiao;
           label(j,i)=j;
        end
    end
end
for k=1:(1016-762)*7
[som_row,col]= min(sum(( (weight - repmat(test_class(k,:), neu_num,1)) .^2) ,2));
for j=1:7
if label(j,col)==ceil(k/(1016-762))
    success=success+1;
end
end
end

accuracy = success / ((1016-762)*7);