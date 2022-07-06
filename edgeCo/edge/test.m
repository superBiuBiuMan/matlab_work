%clc,clear;
origin=rgb2gray(imread('666.jpg'));
%picSobelMy=MySobel(origin);

subplot(441),imshow(origin),title("原图");

%subplot(442),imshow(picSobelMy,[]),title("SobelMy");





f=origin;
%将原图转化成二维灰度图
h=edge(f,'sobel','horizontal');
v=edge(f,'sobel','vertical');
g=edge(f,'sobel','both');
%显示图像
subplot(4,4,4),imshow(f);
subplot(4,4,5),imshow(h);
subplot(4,4,6),imshow(v);
subplot(4,4,7),imshow(g);