%高斯模糊
%高斯模糊就是让一个高斯矩阵和所要模糊的矩阵相点乘（即两个矩阵对应位置的两个数相乘），然后把所得矩阵的各项之和相加，即为模糊中心点的值。
%所谓高斯矩阵就是由高斯函数（即正态分布函数）得到的矩阵。
clear,clc,close all;
origin=imread('aaa.png');
r=origin(:,:,1);
g=origin(:,:,2);
b=origin(:,:,3);
[rows,cols,~]=size(origin);
subplot(2,2,1),imshow(origin);
%创建卷积核4*4
N=4;
toolcore=zeros(N);%卷积核
de=1.5;
for x=1:N
    for y=1:N
        toolcore(x,y)=(exp((-((x-1)^2+(y-1)^2))/(2*de^2)) )/(2*pi*de^2);
    end
end
%保证相加为1
toolcore=toolcore./(sum(sum(toolcore)));
%扩展
expandNumber=floor(N/2);
r_expandImg = double(wextend('2D','zpd',r,expandNumber));
g_expandImg = double(wextend('2D','zpd',g,expandNumber));
b_expandImg = double(wextend('2D','zpd',b,expandNumber));
%预先分配内存
img_undistr=uint8(zeros(rows,cols));
img_undistg=uint8(zeros(rows,cols));
img_undistb=uint8(zeros(rows,cols));
for i=1:rows
    for j=1:cols
       area=r_expandImg(i:i+N-1,j:j+N-1);
       temp=area.*toolcore;
       temp2=sum(sum(temp));
       img_undistr(i,j)=temp2;
    end
end
img_undistr=img_undistr(expandNumber:rows,expandNumber:cols);
for i=1:rows
    for j=1:cols
       area=g_expandImg(i:i+N-1,j:j+N-1);
       temp=area.*toolcore;
       temp2=sum(sum(temp));
       img_undistg(i,j)=temp2;
    end
end
img_undistg=img_undistg(expandNumber:rows,expandNumber:cols);
for i=1:rows
    for j=1:cols
       area=b_expandImg(i:i+N-1,j:j+N-1);
       temp=area.*toolcore;
       temp2=sum(sum(temp));
       img_undistb(i,j)=temp2;
    end
end
img_undistb=img_undistb(expandNumber:rows,expandNumber:cols);
newImage=uint8(cat(3,img_undistr,img_undistg,img_undistb));
%newImage=newImage(expandNumber:rows,expandNumber:cols);
subplot(2,2,2),imshow(newImage),title("模糊后的");

