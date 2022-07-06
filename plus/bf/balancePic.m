%https://blog.csdn.net/timeless_2014/article/details/80389433
%https://blog.csdn.net/qq_40608730/article/details/105114392
%直方图均衡化
clear,clc,close all;
origin=rgb2gray(imread("666.jpg"));
subplot(3,3,1),imshow(origin),title("原来图像");
subplot(3,3,2),imhist(origin),title("原图直方图");

[rows,cols]=size(origin);
%灰度级
L=256;
%统计灰度 0~255 
%         1~256
statNumber=zeros(1,256);
%转一列
allNumber=double(origin(:)); 
%像素数
pixaccount=rows*cols;
%循环统计
for i=1:pixaccount
        statNumber( allNumber( i )+1 )=statNumber( allNumber( i )+1  ) +1;
end
%统计好了数量,计算累积分布函数
cdf=statNumber;
for i=1:256
     cdf(i)=sum(statNumber(1:i));
end
%求最小累积分布函数值
cdfmin=min(cdf);
%均衡化
for i=1:rows
   for j=1:cols
     origin(i,j)=round(( ( cdf( origin(i,j)+1 ) - cdfmin ) / (pixaccount-cdfmin) )*(L-1));
   end
end
subplot(3,3,3),imshow(origin),title("均衡化后");
subplot(3,3,4),imhist(origin),title("均衡化后直方图");