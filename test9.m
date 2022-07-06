clear,clc,close all;
origin=imread('jyColor.png');
subplot(1,2,1),imshow(origin),title("原图像");
r=origin(:,:,1);
g=origin(:,:,2);
b=origin(:,:,3);

N=4;%选取矩阵宽高
[rows,cols,~]=size(origin);
afterOrigin=zeros(rows,cols);%转换后的图像
muban=ones(N,N);%创建模板
muban=(1/9).*muban;%均值模板

expand_imgr = double(wextend('2D','zpd', r, N/2));%扩展0，转double为了矩阵运算
expand_imgg = double(wextend('2D','zpd', g, N/2));%扩展0，转double为了矩阵运算
expand_imgb = double(wextend('2D','zpd', b, N/2));%扩展0，转double为了矩阵运算
%figure(222),imshow(expand_img,[]);
% 为什么需要扩展呢? 因为会多出来!!!!!因为额外向外取了几个值!!!
% 
for i=1:rows
    for j=1:cols
        % i=10 10:13 10 11 12 13  i=i=290
        ave = sum(   sum( expand_imgr(i:i+N-1,j:j+N-1) .* muban)   ); %取出扩展元素与模板相乘,并求矩阵元素之和
        afterOriginr(i,j) = ave;
    end
end
for i=1:rows
    for j=1:cols
        % i=10 10:13 10 11 12 13  i=i=290
        ave = sum(   sum( expand_imgr(i:i+N-1,j:j+N-1) .* muban)   ); %取出扩展元素与模板相乘,并求矩阵元素之和
        afterOriging(i,j) = ave;
    end
end
for i=1:rows
    for j=1:cols
        % i=10 10:13 10 11 12 13  i=i=290
        ave = sum(   sum( expand_imgr(i:i+N-1,j:j+N-1) .* muban)   ); %取出扩展元素与模板相乘,并求矩阵元素之和
        afterOriginb(i,j) = ave;
    end
end
newImage=uint8(cat(3,afterOriginr,afterOriging,afterOriginb));
subplot(1,2,2),imshow(newImage),title("均值滤波后的图像");
