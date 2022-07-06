%https://blog.csdn.net/ytang_/article/details/75451934
%傅里叶变换的低通滤波
%低通滤波选用理想低通滤波方式
% d0 是阈值(通带半径)，可以修改，初步设定为50
% 
clear,clc,close all;
img_origin=imread('fft1.png');
img_origin=rgb2gray(img_origin);
d0=50;  %阈值
%公式https://www.cnblogs.com/laumians-notes/p/8592968.html
img_noise=img_origin; % 这里先不加,
%img_noise=imnoise(img_origin,'gaussian'); % 加高斯噪声
img_f=fftshift(fft2(double(img_noise)));  %傅里叶变换得到频谱
[m n]=size(img_f);
m_mid=fix(m/2);  %是不是可以有其他取整方式？
n_mid=fix(n/2);  
img_lpf=zeros(m,n);
for i=1:m
    for j=1:n
        d=sqrt((i-m_mid)^2+(j-n_mid)^2);   %理想低通滤波，求距离
        if d<=d0
            h(i,j)=1;
        else
            h(i,j)=0;
        end
        img_lpf(i,j)=h(i,j)*img_f(i,j);  
    end
end

img_lpf=ifftshift(img_lpf);    %反傅里叶变换
img_lpf=uint8(real(ifft2(img_lpf)));  %取实数部分

subplot(2,2,1);imshow(img_origin);title('原图');
subplot(2,2,2);imshow(img_noise);title('噪声图');
subplot(2,2,3);imshow(img_lpf);title('理想低通滤波');