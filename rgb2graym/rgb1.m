%https://www.cnblogs.com/finlay/p/3665302.html
%加权平均值法
clear,clc,close all;
origin=imread('love.png');
subplot(1,2,1),imshow(origin);
title("原图像");
r=origin(:,:,1);
g=origin(:,:,2);
b=origin(:,:,3);

[row,col,~]=size(origin);
for ro=1:row
   for co=1:col
    afterOrigin(ro,co)=r(ro,co)*0.299 + g(ro,co)*0.587 + b(ro,co)*0.114;
   end
end
subplot(1,2,2),imshow(afterOrigin);
title("加权平均值法转化之后的灰度图像 ");