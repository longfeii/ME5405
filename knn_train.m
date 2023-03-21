function [accuracy, success] = knn_train(k_value)
    filepath = 'train_preperation/';
    % 6 classes of images
    size = [26 26];
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
                class_D(j,:) = train_img;
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

        % Whole image feature
        for i = 1:(1016-762)*7
            d = zeros(762*7, 1);
            for k = 1:762*7
                d(k) = norm(double(test_class(i,:)) - double(all_class(k,1:32*32)));
            end

            % Determine the distance between 2 images and save the index
            [d, idx] = sort(d, 'ascend');
            idx = idx(1:k_value);
            idx = ceil(idx / 762);

            % Determine the class based on the training set
            k_n_n = zeros(1, 7);
            for k = 1:k_value
                if idx(k) == 0
                    idx(k) = 1;
                end
                k_n_n(idx(k)) = k_n_n(idx(k)) + 1; 
            end
            max_class = find(k_n_n == max(k_n_n));

            % Check if the test result is the same with the class
            if max_class == ceil(i / (1016-762))
                success = success + 1;
            end
        end
        
        % Measure the accuracy
        accuracy = success / ((1016 - 762)*7);
    end
    
    
    % Test the effect on the given characters
    if TEST_SET ~= 1
        test_filepath = 'KNN_Test/Test_character/';
        success = 0;
        for i = 1:7
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
            end
                character="W";
            temp = load([test_filepath char(character) '.mat']);

            test_img = temp.pad_chr(:)';

            % Whole image feature
            d = zeros(762*7, 1);
            for k = 1:762*7
                d(k) = norm(double(test_img) - all_class(k,:));
            end

            [d, idx] = sort(d, 'ascend');
            idx = idx(1:k_value);
            idx = ceil(idx / 762);

            k_n_n = zeros(1, 7);
            for k = 1:k_value
                k_n_n(idx(k)) = k_n_n(idx(k)) + 1; 
            end
            max_class = find(k_n_n == max(k_n_n));
            if max_class == i
                success = success + 1;
            end
        end
    accuracy = success / 7;
    end
end