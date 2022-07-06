%https://max.book118.com/html/2017/0920/134508059.shtm
%低频滤波的matlab实现
clear,clc,close all;
Z=double(rgb2gray(imread('fft1.png')));
%显示原图像
subplot(1,2,1),imshow(Z,[]),title('origin');
[rows,cols]=size(Z);
B=ones(rows,cols);
%运算
C=fftshift(fft2(Z));
D=C.*B;
FF=ifft2(D);
subplot(1,2,2),imshow(abs(FF),[]),title('Low');




