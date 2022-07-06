%https://max.book118.com/html/2017/0920/134508059.shtm
clear,clc,close all;
Z=double(rgb2gray(imread('fft1.png')));
subplot(1 ,2, 1 ),imshow(Z,[]);
[rows,cols]=size(Z);
B=ones(rows,cols);
%B(128-30:128+30,128- 30:128+30)=1;
B1=1-B;
C=ifftshift(fft2(Z));
D=C.*B1;
FF=ifft2(D);
subplot(1 ,2,2),imshow(abs(FF),[]);
