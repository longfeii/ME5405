function [matrix_rotation]=imrotation_bicubic(img,angle)
a = deg2rad(angle);
[M,N]=size(img);
newM=ceil(M*cos(a)+N*sin(a));
newN=ceil(N*cos(a)+M*sin(a));
matrix_rotation=zeros((newM+1),(newN+1));
centroid=[M/2,N/2];
newcentroid=[((newM+1)/2),((newN+1)/2)];
A=[cos(a),sin(a);
    -sin(a),cos(a)];
for i=1:newM
    for j=1:newN
        newco=[i-newcentroid(1);-j+newcentroid(2)];
        cobycen=A*newco;
        co=[cobycen(1)+centroid(1);-cobycen(2)+centroid(2)];
        c=[round(co(1));round(co(2))];
         if (co(1)>2)&&(co(2)>2)&&(co(1)<M-2)&&(co(2)<N-2)
             l=floor(co(1));
             a=co(1)-l;
             k=floor(co(2));
             b=co(2)-k;
             X1=zeros(4,4);  X2=zeros(4,4);  %distance matrix
             W1=ones(4,4); W2=ones(4,4);    %coefficent matrix
                    for x=1:4
                        for y=1:4
                            X1(x,y)=abs(a-x+2);
                            X2(x,y)=abs(b-y+2);
                            if X1(x,y)<=1
                                W1(x,y)=1.5*(X1(x,y))^3-2.5*(X1(x,y))^2+1;
                            else
                                if  X1(x,y)<2
                                    W1(x,y)=(-0.5)*(X1(x,y))^3+2.5*(X1(x,y))^2-4*X1(x,y)+2;
                                else
                                    W1(x,y)=0;
                                end
                            end
                            if X2(x,y)<=1
                                W2(x,y)=1.5*(X2(x,y))^3-2.5*(X2(x,y))^2+1;
                            else
                                if  X2(x,y)<2
                                    W2(x,y)=(-0.5)*(X2(x,y))^3+2.5*(X2(x,y))^2-4*X2(x,y)+2;
                                else
                                    W2(x,y)=0;
                                end
                            end
                        end
                    end
                     W=W1.*W2;
                    Z=ones(4,4);  %origin 
                    O=ones(4,4);  %after assign
                for x=1:4
                   for y=1:4
                            Z(x,y)=img(l+x-2,k+y-2);
                            O(x,y)=W(x,y).*Z(x,y);
                   end
                end
          O1=sum(sum(O));
          matrix_rotation(i,j)=O1;
         else
           matrix_rotation(i,j)=0;
         end
    end
end
end
