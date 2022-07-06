clear,clc,close all;
x=imread('aaa.png');
r=x(:,:,1);
g=x(:,:,2);
b=x(:,:,3);
cc=cat(3,r,g,b);
imshow(cc);