
aimg=imread("666.jpg");
[x,y,z]=size(aimg);
img=im2double(aimg); % 数据类型转化uint8-->double，uint8类型参与运算容易溢出
if(z==3)    % rgb-->gray
   img=(img(:,:,1).*229+img(:,:,2).*578+img(:,:,3).*114)./1000;
end
%% Sobel算子
img_sobel=zeros(x,y);
img_sobelx=img_sobel;
img_sobely=img_sobel;
for r=2:x-1
    for c=2:y-1
        tempX=-img(r-1,  c-1) + img(r-1, c+1 )-2* img(r, c-1 ) +  2* img(r,  c+1)-img(r+1, c-1 ) +  img(r+1,  c+1);
        img_sobelx(r,c)=abs(tempX);
       tempY=img(r-1,c-1)+2*img(r-1,c ) + img(r-1,c+1 ) -img(r+1,c-1) -2*img(r+1, c) -img(r+1,c+1 );
        img_sobely(r,c)=abs(tempY);
    end    
end

img_sobel=img_sobely+img_sobelx;
% for i=1:x
%     for j=1:y
%         if img_sobel(i,j)>0.7
%            img_sobel(i,j)=1;
%         else
%            img_sobel(i,j)=0;
%         end
%     end    
% end
% figure(1)
% imshow(img)
% figure(2)
% imshow(img_sobel)
