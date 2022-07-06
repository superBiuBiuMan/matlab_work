%高斯模糊
%高斯模糊就是让一个高斯矩阵和所要模糊的矩阵相点乘（即两个矩阵对应位置的两个数相乘），然后把所得矩阵的各项之和相加，即为模糊中心点的值。
%所谓高斯矩阵就是由高斯函数（即正态分布函数）得到的矩阵。
function [afterGaussianRGB]=MyGaussianRGB(origin)
r=origin(:,:,1);
g=origin(:,:,2);
b=origin(:,:,3);
[rows,cols,~]=size(origin);
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
imgGaussianR=uint8(zeros(rows,cols));
imgGaussianG=uint8(zeros(rows,cols));
imgGaussianB=uint8(zeros(rows,cols));
for i=1:rows
    for j=1:cols
       area=r_expandImg(i:i+N-1,j:j+N-1);
       temp=area.*toolcore;
       temp2=sum(sum(temp));
       imgGaussianR(i,j)=temp2;
    end
end
imgGaussianR=imgGaussianR(expandNumber:rows,expandNumber:cols);
for i=1:rows
    for j=1:cols
       area=g_expandImg(i:i+N-1,j:j+N-1);
       temp=area.*toolcore;
       temp2=sum(sum(temp));
       imgGaussianG(i,j)=temp2;
    end
end
imgGaussianG=imgGaussianG(expandNumber:rows,expandNumber:cols);
for i=1:rows
    for j=1:cols
       area=b_expandImg(i:i+N-1,j:j+N-1);
       temp=area.*toolcore;
       temp2=sum(sum(temp));
       imgGaussianB(i,j)=temp2;
    end
end
imgGaussianB=imgGaussianB(expandNumber:rows,expandNumber:cols);
afterGaussianRGB=uint8(cat(3,imgGaussianR,imgGaussianG,imgGaussianB));
end
