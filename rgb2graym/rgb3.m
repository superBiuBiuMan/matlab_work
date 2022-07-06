%https://www.cnblogs.com/finlay/p/3665302.html
%单通道提取(分量法)
clear,clc,close all;
origin=imread('aaa.png');
subplot(2,2,1),imshow(origin),title("原图像");
r=origin(:,:,1);
g=origin(:,:,2);
b=origin(:,:,3);
afterorigin1=r;
afterorigin2=g;
afterorigin3=b;
subplot(2,2,2),imshow(afterorigin1),title("单独提取R通道");
subplot(2,2,3),imshow(afterorigin2),title("单独提取G通道");
subplot(2,2,4),imshow(afterorigin3),title("单独提取B通道");