%高斯模糊
%高斯模糊就是让一个高斯矩阵和所要模糊的矩阵相点乘（即两个矩阵对应位置的两个数相乘），然后把所得矩阵的各项之和相加，即为模糊中心点的值。
%所谓高斯矩阵就是由高斯函数（即正态分布函数）得到的矩阵。
%https://blog.csdn.net/nima1994/article/details/79776802
%https://blog.csdn.net/m0_37454852/article/details/78684204
clear,clc,close all;
origin=imread('aaa.png');
[rows,cols,~]=size(origin);
grayPic=im2gray(origin);
subplot(2,2,1),imshow(grayPic);
%创建3*3高斯矩阵
N=4;
toolcore=zeros(N);
de=10.0;
for x=1:N
    for y=1:N
        %公式
        toolcore(x,y)=(exp((-((x)^2+(y)^2))/(2*de^2)) )/2*pi*de^2;
    end
end
%保证相加为1
toolcore=toolcore./(sum(sum(toolcore)));
%扩展
expandNumber=floor(N/2);
expand_img = double(wextend('2D','zpd',grayPic,expandNumber));

%subplot(2,2,2),imshow(expand_img,[]),title("扩展后的");
img_undist=uint8(zeros(rows,cols));
for i=1:rows
    for j=1:cols
       %高斯运算
       area=expand_img(i:i+N-1,j:j+N-1);
       temp=area.*toolcore;
       temp2=sum(sum(temp));
       img_undist(i,j)=temp2;
    end
end

subplot(2,2,2),imshow(img_undist,[]),title("模糊后的");

