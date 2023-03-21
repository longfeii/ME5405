function matrix = regiongrow_4(binary)
[M,N] = size(binary);
matrix = zeros(M,N);        	 % label matrix
label = 0;                 	 % label
sf = 0;               	 % stop find seed                   	 
stack = zeros(M*N,2);   
counter = 0;			 
xoffset=[1,-1,0,0];
yoffset=[0,0,1,-1]; % offset
while 1
    % find the seed
     flag = 0;
     for i = 1:M
        for j = 1:N
          if binary(i,j)==1%if the pixel is white(objext)
            counter = counter+1;%counter+1
            stack(counter,:) = [i,j];%input i j at correponding row
            label = label+1;
            matrix(i,j) = label;
            binary(i,j) = 0;  %the pixel after search turn into black 
	        flag = 1;
            break
          end        
        end
        if flag
             break
        end
        if (i==M)&&(j==N)
            sf=1;
        end
     end
     if sf
         break
     end
    % connection
    while counter
        x = stack(counter,1);
        y = stack(counter,2);
        counter = counter-1;
        for n = 1:4
            dx = x+xoffset(n);
            dy = y+yoffset(n);
            if (dx>M)||(dy>N)||(dx<1)||(dy<1)
                  break
            end
            if binary(dx,dy)%find the object pixel
                counter = counter+1;
                stack(counter,:) = [dx,dy];
                binary(dx,dy) = 0;
                matrix(dx,dy) = label;
            end
        end
    end
end

