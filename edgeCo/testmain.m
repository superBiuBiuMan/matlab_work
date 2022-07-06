clc,clear,close all;
Pic=rgb2gray(imread('666.jpg'));
%Pic=rgb2gray(imread('pic.png'));
subplot(2,3,1),imshow(Pic),title("原图像");

%% 高斯模糊下
G = fspecial('gaussian', 5, 2);
noGaussian=Pic;
Pic= imfilter(Pic,G,'same'); %官方函数实现高斯模糊

%% Sobel算子
afterSobel= MySobel(Pic,0.7);
subplot(2,3,2),imshow(afterSobel,[]),title("Sobel算子");
afterSobelGf=edge(Pic,'sobel','both');
subplot(2,3,3),imshow(afterSobelGf,[]),title("官方Sobel算子");
%% canny算子
afterCanny= cannyM(Pic);
subplot(2,3,4),imshow(afterCanny,[]),title("Canny算子");
afterCannyGF=edge(Pic,'canny');
subplot(2,3,5),imshow(afterCannyGF),title("官方Canny算子");

