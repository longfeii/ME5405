function train_preparation()
    % D
    filepath = 'p_dataset_26/p_dataset_26/SampleD/';
    fileExt = '*.png';
    files = dir(fullfile(filepath,fileExt)); 
    len = size(files,1);
    for i=1:(len)
       fileName = strcat(filepath,files(i).name); 
       img = imread(fileName);
       img = imresize(img,0.25);
       [h,w]=size(img);
       for y=1: h
            for x=1: w
                if img(x,y)<125
                    img(x,y)=0;
                else
                    img(x,y)=1;
                end
                img_matrix(x,y)=img(x,y);
            end
       end
       filesave=['train_preperation/D/img_',num2str(i),'.mat'];
       save(filesave,"img_matrix");
    end

    % E
    filepath = 'p_dataset_26/p_dataset_26/SampleE/';
    fileExt = '*.png';
    files = dir(fullfile(filepath,fileExt)); 
    len = size(files,1);
    for i=1:(len)
       fileName = strcat(filepath,files(i).name); 
       img = imread(fileName);
       img = imresize(img,0.25);
       [h,w]=size(img);
       for y=1: h
            for x=1: w
                if img(x,y)<125
                    img(x,y)=0;
                else
                    img(x,y)=1;
                end
                img_matrix(x,y)=img(x,y);
            end
       end
       filesave=['train_preperation/E/img_',num2str(i),'.mat'];
       save(filesave,"img_matrix");
    end

    % H
    filepath = 'p_dataset_26/p_dataset_26/SampleH/';
    fileExt = '*.png';
    files = dir(fullfile(filepath,fileExt)); 
    len = size(files,1);
    for i=1:(len)
       fileName = strcat(filepath,files(i).name); 
       img = imread(fileName);
       img = imresize(img,0.25);
       [h,w]=size(img);
       for y=1: h
            for x=1: w
                if img(x,y)<125
                    img(x,y)=0;
                else
                    img(x,y)=1;
                end
                img_matrix(x,y)=img(x,y);
            end
       end
       filesave=['train_preperation/H/img_',num2str(i),'.mat'];
       save(filesave,"img_matrix");
    end

    % L
    filepath = 'p_dataset_26/p_dataset_26/SampleL/';
    fileExt = '*.png';
    files = dir(fullfile(filepath,fileExt)); 
    len = size(files,1);
    for i=1:(len)
       fileName = strcat(filepath,files(i).name); 
       img = imread(fileName);
       img = imresize(img,0.25);
       [h,w]=size(img);
       for y=1: h
            for x=1: w
                if img(x,y)<125
                    img(x,y)=0;
                else
                    img(x,y)=1;
                end
                img_matrix(x,y)=img(x,y);
            end
       end
       filesave=['train_preperation/L/img_',num2str(i),'.mat'];
       save(filesave,"img_matrix");
    end

    % O
    filepath = 'p_dataset_26/p_dataset_26/SampleO/';
    fileExt = '*.png';
    files = dir(fullfile(filepath,fileExt)); 
    len = size(files,1);
    for i=1:(len)
       fileName = strcat(filepath,files(i).name); 
       img = imread(fileName);
       img = imresize(img,0.25);
       [h,w]=size(img);
       for y=1: h
            for x=1: w
                if img(x,y)<125
                    img(x,y)=0;
                else
                    img(x,y)=1;
                end
                img_matrix(x,y)=img(x,y);
            end
       end
       filesave=['train_preperation/O/img_',num2str(i),'.mat'];
       save(filesave,"img_matrix");
    end

    % R
    filepath = 'p_dataset_26/p_dataset_26/SampleR/';
    fileExt = '*.png';
    files = dir(fullfile(filepath,fileExt)); 
    len = size(files,1);
    for i=1:(len)
       fileName = strcat(filepath,files(i).name); 
       img = imread(fileName);
       img = imresize(img,0.25);
       [h,w]=size(img);
       for y=1: h
            for x=1: w
                if img(x,y)<125
                    img(x,y)=0;
                else
                    img(x,y)=1;
                end
                img_matrix(x,y)=img(x,y);
            end
       end
       filesave=['train_preperation/R/img_',num2str(i),'.mat'];
       save(filesave,"img_matrix");
    end

    % W
    filepath = 'p_dataset_26/p_dataset_26/SampleW/';
    fileExt = '*.png';
    files = dir(fullfile(filepath,fileExt)); 
    len = size(files,1);
    for i=1:(len)
       fileName = strcat(filepath,files(i).name); 
       img = imread(fileName);
       img = imresize(img,0.25);
       [h,w]=size(img);
       for y=1: h
            for x=1: w
                if img(x,y)<125
                    img(x,y)=0;
                else
                    img(x,y)=1;
                end
                img_matrix(x,y)=img(x,y);
            end
       end
       filesave=['train_preperation/W/img_',num2str(i),'.mat'];
       save(filesave,"img_matrix");
    end