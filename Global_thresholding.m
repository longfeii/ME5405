%% Use the method of Global Tresholding
function [binary_image] = Global_thresholding(filepath)
    % read the image
    img=imread(filepath);
    % if the image matrix is ​​RGB three-dimensional data
    % convert it into a two-dimensional grayscale image.
    if numel(size(img))>2
        double(img);
        img = rgb2gray(img);
    end
    [width,height] = size(img);
    % set break condition
    T0 = 1;
    % initial threshold T1
    T1= 20;

    % Set G1, G2 two column vectors
    % count the values ​​of <T and >T respectively.
    gray_leval_1 = 1;
    gray_leval_2 = 1;

    while 1
        for i = 1:width
            for j = 1:height
                if img(i,j)>T1
                    G1(gray_leval_1) = img(i,j); % get group G1
                    gray_leval_1 = gray_leval_1 + 1;
                else
                    G2(gray_leval_2) = img(i,j); % get group G2
                    gray_leval_2 = gray_leval_2 + 1;
                end
            end
        end
        % Calculate the mean of G1 and G2
        avg1 = mean(G1);
        avg2 = mean(G2);
        T2 = (avg1 + avg2)/2;
        if abs(T2 - T1)<T0 
            break;
        end
        T1 = T2;
        gray_leval_1 = 1;
        gray_leval_2 = 1;
    end
    T1=uint8(T1);
    
    % If this is the second image, correct T1
    % Because we need to separate letters better
    img2=imread(filepath);
    if numel(size(img2))>2
        T1=T1+25;
    end

    for i=1:width
        for j=1:height
            if img(i,j)<T1
                binary_matrix(i,j)=0;
            else 
                binary_matrix(i,j)=1;
            end
        end
    end

    binary_image = mat2gray(binary_matrix);

end