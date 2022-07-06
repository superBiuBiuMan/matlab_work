%https://blog.csdn.net/timeless_2014/article/details/80389433
%https://blog.csdn.net/qq_40608730/article/details/105114392
%直方图均衡化
clear,clc,close all;
origin=rgb2gray(imread("666.jpg"));
subplot(221),imshow(origin),title("原来图像");
subplot(222),imhist(origin),title("原图直方图");

[rows,cols]=size(origin);
%灰度级
L=256;
statNumber=zeros(1,256);
%转一列
allNumber=double(origin(:)); 
pixaccount=rows*cols;
for i=1:pixaccount
        statNumber( allNumber( i )+1 )=statNumber( allNumber( i )+1  ) +1;
end

CDF=statNumber;
for i=1:256
    for j=1:i
        CDF(i)=CDF(i)+statNumber(j);
    end
end
cdfmin=min(CDF);
%均衡化
for i=1:rows
   for j=1:cols
     origin(i,j)=round(( ( CDF( origin(i,j)+1 ) - cdfmin ) / (pixaccount-cdfmin) )*(L-1));
   end
end
subplot(223),imshow(origin),title("均衡化后");
subplot(224),imhist(origin),title("均衡化后直方图");
