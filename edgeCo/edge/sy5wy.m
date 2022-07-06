clc,clear,close all
TU=imread('666.jpg');
TU=rgb2gray(TU);
%sobel边缘检测
TU_test=edge(TU,'sobel',[],'both');
TU_sobel=sobelwy(TU,0.7);
subplot(1,2,1);
imshow(TU_test);
subplot(1,2,2);
imshow(TU_sobel);