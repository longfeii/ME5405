function [matrix_rotation]=imrotation_bilinear(img,angle)
a = deg2rad(angle);
[M,N]=size(img);
newM=ceil(M*cos(a)+N*sin(a));
newN=ceil(N*cos(a)+M*sin(a));
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
         if (co(1)>1)&&(co(2)>1)&&(co(1)<M)&&(co(2)<N)
             l=floor(co(1));
             a=co(1)-l;
             k=floor(co(2));
             b=co(2)-k;
           matrix_rotation(i,j)=(1-a)*(1-b)*img(l,k) + a*(1-b)*img(l+1,k) +(1-a)*b*img(l,k+1) + a*b*img(l+1,k+1);
         else
           matrix_rotation(i,j)=0;
         end
    end
end
end
