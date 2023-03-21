%% Adaptive Thresholding using the Integral Image
function [ image ] = Adaptive_thresholding(filepath,m)
    img=imread(filepath);

    img=double(img);
    sz=size(img);
    h=sz(1);
    w=sz(2);
    s=4*floor(h/16)+1;
    for i=1:w
        sum =0;
        for j=1:h
            sum=sum + img(j,i);
            if i==1
                intImg(j,i)=sum;
            else
                intImg(j,i)=intImg(j,i-1) + sum;
            end
        end
    end

    % perform thresholding
    for i=1:w
        for j=1:h
            x1=max(i-round(s/2),2); % check border
            x2=min(i+round(s/2),w);
            y1=max(j-round(s/2),2);
            y2=min(j+round(s/2),h);
            count =(x2-x1)*(y2-y1);
            % I(x,y)=s(x2,y2)-s(x1,y2)-s(x2,y1)+s(x1,x1)
            sum =intImg(y2,x2)-intImg(y1-1,x2)-intImg(y2,x1-1) + intImg(y1-1,x1-1);
            % The value of the current pixel is m lower than the average
            % Then it is set to black.
            if (img(j,i)*count)<=(sum *m) 
                image(j,i)=0;
            else
                image(j,i)=1;
            end
        end
    end
    
    % Bridge the breakpoint, fill the isolated inner pixel and Remove the H-connected pixel
    image=~image;
    image=bwmorph(image,"bridge");
    image=bwmorph(image,"fill");
    image = bwmorph(image,"hbreak");
    
    % Use the bwareaopen function to remove small background noise from the image.
    image = bwareaopen(image,15);
    image=~image;

