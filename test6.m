%https://blog.csdn.net/JMasker/article/details/82056407?utm_medium=distribute.pc_relevant.none-task-blog-2~default~baidujs_baidulandingword~default-1.no_search_link&spm=1001.2101.3001.4242
clear,clc,close all;
j=imread('jy.png');
%j=rgb2gray(j);
k=4;%设置矩阵
[rows,cols]=size(j);
b=zeros(rows+2*k,cols+2*k);%创建存储矩阵
b(k+1:rows+k,k+1:cols+k)=double(j(:,:));
%    0 0 0(k行0，其他方向也是)
%b=  0 j 0
%    0 0 0
c=zeros(rows,cols);
for i=k+1:rows+k
    for j=k+1:cols+k
        b(i,j)= sum(sum(b(i-k:i+k,j-k:j+k))) /((2*k+1).^2);%b(i,j)这个点为中心点的(2*k+1)^2的大小的矩阵的和*(1/（2*k+1）)
    end                                                   %这里就是均值均值滤波
end
c(:,:)=b(k+1:rows+k,k+1:cols+k);
imshow(c,[]);

