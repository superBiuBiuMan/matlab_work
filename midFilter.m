%中值模糊
clear,clc,close all;
origin=imread('jy.png');
[rows,cols,dim]=size(origin);
%转化为灰色图片
if dim==3
    %彩色
    origin=rgb2gray(origin);
end
subplot(1,2,1),imshow(origin),title("原图像");
%选取矩阵宽高
N=5;
%创建0矩阵
afterOrigin=zeros(rows,cols);
temp=floor(N/2);
expand_img = wextend('2D','zpd', origin, temp);%扩展0
% 为什么需要扩展呢? 因为会多出来!!!!!因为额外向外取了几个值!!!
for i=1:rows
    for j=1:cols 
        % i=10 10:13 10 11 12 13  i=i=290
        selectArea=expand_img(i:i+N-1,j:j+N-1);%选取的N*N的矩阵
        temp1=selectArea(:);%转化为列向量
        middle=median(temp1);%求中值
        afterOrigin(i,j) = middle;
    end
end
afterOrigin=uint8(afterOrigin());
subplot(1,2,2),imshow(afterOrigin),title("中值滤波后的图像");
