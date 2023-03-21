function [matrix_rotation]=imrotation_nearest(img,angle)
a = deg2rad(angle);
[M,N]=size(img);
newM=floor(M*cos(a)+N*sin(a));
newN=floor(N*cos(a)+M*sin(a));
matrix_rotation=zeros(newM,newN);
centroid=[(M+1)/2,(N+1)/2];
newcentroid=[((newM+1)/2),((newN+1)/2)];
A=[cos(a),sin(a);
    -sin(a),cos(a)];
for i=1:newM
    for j=1:newN
        newco=[i-newcentroid(1);-j+newcentroid(2)];
        cobycen=A*newco;
        co=[cobycen(1)+centroid(1);-cobycen(2)+centroid(2)];
        c=[round(co(1));round(co(2))];
         if (c(1)>0)&&(c(2)>0)&&(c(1)<M+1)&&(c(2)<N+1)
           matrix_rotation(i,j)=img(c(1),c(2));
         else
           matrix_rotation(i,j)=0;
         end
    end
end
end
