% 均值滤波(自编函数) 
% imag:滤波原图(带噪声)  n:模版边长
% 作者：Nan --Dut
clear ,clc,close all;
imag=imread('love.png');
imag=rgb2gray(imag);
imag= imnoise(imag,'salt & pepper',0.05); %向图像添加噪声
subplot(1,2,1),imshow(imag),title("原图");
n=4;%滤波器边长
h = ones(n);
pp2 = h./(n*n);
%生成外围补0的矩阵
 [a,b] = size(imag);
 N = zeros(a+2,b+2);%N即为补0矩阵
 N(2:a+1,2:b+1)=imag;
 [a,b] = size(N);
 %for循环实现卷积
 I=double(zeros(a-2,b-2));
for i=2:a-1
    for j=2:b-1
        for m=1:3
            i1=i-2+m;
            for n=1:3
                j1=j-2+n;
                I(i-1,j-1)=N(i1,j1)*pp2(m,n)+I(i-1,j-1);
            end
        end
     end
end
I=uint(I); %其实不用写这个,写这个也可以,imshow(I,[]);
subplot(1,2,2),imshow(I,[]),title("后的");
