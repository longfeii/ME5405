function [matrix] = connectivity_8(binary)
%paddiing first
siz=size(binary);
binary2=zeros(siz+2);
for i=2:siz(1)+1
    for j=2:siz(2)+1
        binary2(i,j)=1-binary(i-1,j-1);
    end
end
%label by top to down left to right
d=1;
for i=2:siz(1)+1
    for  j=2:siz(2)+1
        if (binary2(i,j)==1) && (binary2(i-1,j)==0)&& (binary2(i,j-1)==0)&&(binary2(i-1,j-1)==0)
            binary2(i,j)=d;
            d=d+1;
        elseif binary2(i,j)==1
                B=[binary2(i-1,j),binary2(i,j-1),binary2(i-1,j-1)];
                binary2(i,j)=min(B(B>0));

        else 
            binary2(i,j)=0;
        end
    end
end

% equivalent by top to down left to right
for z=1:2
for i=2:siz(1)+1
    for j=2:siz(2)+1
        if (binary2(i,j)>0)&&((binary2(i,j-1)>0)||(binary2(i-1,j)>0)||(binary2(i+1,j)>0)||(binary2(i,j+1)>0)||(binary2(i+1,j+1)>0)||(binary2(i-1,j+1)>0)||(binary2(i+1,j-1)>0)||(binary2(i-1,j-1)>0))
            for x=2:siz(1)+1
                for y=2:siz(2)+1
                    if binary2(x,y)==binary2(i,j)
                        A=[binary2(i,j-1),binary2(i-1,j),binary2(i,j),binary2(i,j+1),binary2(i+1,j),binary2(i+1,j+1),binary2(i+1,j-1),binary2(i-1,j+1),binary2(i-1,j-1)];
                        binary2(x,y)=min(A(A>0));
                    end
                end
            end
        end
    end
end
end
% equivalent by top to down left to right
% for i=siz+1:-1:2
%     for j=siz+1:-1:2
%         if binary2(i,j)>0
%               A=[binary2(i,j-1),binary2(i-1,j),binary2(i,j),binary2(i,j+1),binary2(i+1,j)];
%             binary2(i,j)=max(A);
%         end
%     end
% end

binary2(1,:)=[];
binary2(siz(1)+1,:)=[];
binary2(:,1)=[];
binary2(:,siz(2)+1)=[];
matrix=binary2;

