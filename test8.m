clear,clc,close all;
origin=imread('jy.png');
N=4;
[rows,cols]=size(origin);
afterOrigin=zeros(rows,cols);%转换后的图像
muban=ones(N,N);%创建模板
muban=(1/9).*muban;%均值模板
expand_img = double(wextend('2D','zpd', origin, N/2));%扩展0，转double为了矩阵运算
%figure(222),imshow(expand_img,[]);
% 为什么需要扩展呢? 因为会多出来!!!!!因为额外向外取了几个值!!!
for i=1:rows
    for j=1:cols
        % i=10 10:13 10 11 12 13  i=i=290
        ave = sum(   sum( expand_img(i:i+N-1,j:j+N-1) .* muban)   ); %取出扩展元素与模板相乘,并求矩阵元素之和
        afterOrigin(i,j) = ave;
    end
end
figure(333);
imshow(afterOrigin,[]);