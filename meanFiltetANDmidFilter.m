clear,clc,close all;
origin=imread('jy.png');
[rows,cols,dim]=size(origin);
%转化为灰色图片
if dim==3
    %彩色
    origin=rgb2gray(origin);
end
subplot(2,2,1),imshow(origin),title("原图像");
%选取矩阵宽高
N=7;
%创建0矩阵
afterOrigin=zeros(rows,cols);
muban=ones(N,N);%创建模板
muban=(1/(N*N)).*muban;%均值模板1/(n*n)
temp=floor(N/2);
expand_img = double(wextend('2D','zpd', origin, temp));%扩展0，转double,为了矩阵运算
for i=1:rows
    for j=1:cols
        % i=10 10:13 10 11 12 13  i=i=290
        ave = sum(   sum( expand_img(i:i+N-1,j:j+N-1) .* muban)   ); %取出扩展元素与模板相乘,并求矩阵元素之和
        afterOrigin(i,j) = ave;
    end
end
%去除黑边
afterOrigin=afterOrigin(temp:rows,temp:cols);
subplot(2,2,2),imshow(afterOrigin,[]),title("均值滤波后的图像");
for i=1:rows
    for j=1:cols 
        % i=10 10:13 10 11 12 13  i=i=290
        selectArea=expand_img(i:i+N-1,j:j+N-1);%选取的N*N的矩阵
        temp1=selectArea(:);%转化为列向量
        middle=median(temp1);%求中值
        afterOrigin(i,j) = middle;
    end
end
%去除黑边
afterOrigin=afterOrigin(temp:rows,temp:cols);
subplot(2,2,3),imshow(afterOrigin,[]),title("中值滤波后的图像");