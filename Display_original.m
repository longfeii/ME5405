function [original_img] = Display_original(filepath)
    % object file already exists in the working directory
    % open the file as read-only.
    fid=fopen(filepath,'r');
    
    % 'A' is the matrix(64x64) into which the data of the object file is read
    % the format of the read data is string type
    % ~ is the number of elements of the matrix.
    [A, ~]=fscanf(fid,'%s',[64,64]);
    
    % close the file hander.
    fclose(fid);
    
    % transpose Matrix A to column vectors.
    A=A';
    
    % Create a 64x64 'B' matrix and initialize its elements to 0.
    B=zeros(64,64);                                         
    
    % Convert the A-V in the 'A' matrix to ASCII code minus 55 to become the
    % value of 10-32, and other 0-9 are stored in the B matrix together.
    for i=1:64
         for j=1:64
             if isletter(A(i,j))==1
                 B(i,j)=abs(A(i,j))-55;
             elseif isletter(A(i,j))==0
                 B(i,j)=str2double(A(i,j))+1;
             end
         end
    end
    
    % Convert numeric matrix B to grayscale.
    original_img=mat2gray(B);

end