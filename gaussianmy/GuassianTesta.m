clear,clc,close all;
origin=imread('aaa.png');

subplot(3,2,1),imshow(origin),title("原图像");

grayPic=rgb2gray(origin);
subplot(3,2,2),imshow(grayPic),title("灰度图像");


afterGaussian=MyGaussian(grayPic);
subplot(3,2,3),imshow(afterGaussian),title("高斯模糊图像");

%afterGaussianRGB=MyGaussianRGB(origin);
%subplot(3,2,3),imshow(afterGaussianRGB),title("co");