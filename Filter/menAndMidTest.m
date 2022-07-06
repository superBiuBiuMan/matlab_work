%均值模糊和中值模糊测试
clear,clc,close all;
origin=imread('jy.png');
[rows,cols,dim]=size(origin);
%转化为灰色图片
if dim==3
    %彩色
    origin=rgb2gray(origin);
end
subplot(2,2,1),imshow(origin),title("原图像");
afterMeanFilter=MymenFilter(origin);
subplot(2,2,2),imshow(afterMeanFilter,[]),title("均值模糊后图像");
afterMidFilter=MymidFilter(origin);
subplot(2,2,3),imshow(afterMidFilter),title("中值模糊后图像");