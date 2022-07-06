origin=rgb2gray(imread("666.jpg"));
%figure(1),imshow(origin),title("原来图像");

[rows,cols]=size(origin);
t=0;
for i=1:rows
   for j=1:cols
        if(origin(i,j)==255)
            t=t+1;
        end
   end
end