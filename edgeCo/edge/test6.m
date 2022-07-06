clear,clc,close all;
img1=rgb2gray(imread('666.jpg'));
afterFFT2=ifft2(img1);
afterD=dream_dt(afterFFT2);

img2=rgb2gray(imread('2.png'));
afterFFT2=ifft2(img2);
afterG=dream_gt(afterFFT2);

DP=real(ifft2(ifftshift(afterD))); %real获取实部数据
GP=real(ifft2(ifftshift(afterG))); 
[rows,cols]=size(img1);
Hygrid=zeros(rows,cols);
for i=1:rows
   for j=1:cols
        Hygrid(i,j)=DP(i,j)+GP(i,j);
   end
end
subplot(2,3,1),imshow(img1),title('原图像');
subplot(2,3,2),imshow(DP,[]),title('经过反傅里叶后的低频 图片1');
subplot(2,3,3),imshow(GP,[]),title('经过反傅里叶后的高频 图片2 ');
subplot(2,3,6),imshow(Hygrid,[]),title('图片1,图片2 混合图像');
