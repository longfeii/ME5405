function Data=wcropshow(c,img,angle)%c=boundingbox parameters c(1)c(2)= coordinate of left up conner c(3)c(4) pixel length of row and column
 siz=size(c) ;
 siz2=size(img);
 for x=1:siz(1)%numbers of objects
      M=c(x,4);%numbers of row of every objects
      N=c(x,3);%numbers of coloumn of every objects
      matrix=zeros(M,N);
      a=floor(c(x,2));%left up conner x coordinate
      b=floor(c(x,1));%left up conner y coordinate
      for i=1:M
          for j=1:N
              matrix(i,j)=img(a+i,b+j);
          end
      end
      Data{x}=imrotation_nearest(matrix,angle);
      matrix_RGB=label2rgb(Data{x},'hsv',[0 0 0]);
      pos(x,:) = [c(x,1)/siz2(2),(siz2(1)-(c(x,2)+c(x,4)))/siz2(1),c(x,3)/siz2(2),c(x,4)/siz2(1)];
      subplot('Position',pos(x,:))
      imshow(matrix_RGB,'InitialMagnification','fit');
 end
end