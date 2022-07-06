%https://blog.csdn.net/u014485485/article/details/78364573
%https://www.jianshu.com/p/2334bee37de5
origin = rgb2gray(imread('666.jpg'));
subplot(121),imshow(origin),title("原图像");
originDouble=mat2gray(origin);   %图像矩阵的归一化
[m,n]=size(originDouble);
Threshold=0.1;  %设定阈值
afterPic=zeros(m-1,n-1);
%Laplace算子
for x=2:m-1 
    for y=2:n-1
        %模板运算
        L=-4*originDouble(x, y) + originDouble(x-1, y) + originDouble(x+1, y) + originDouble(x, y-1) + originDouble(x, y+1); 
        if(L > Threshold)
            afterPic(x,y)=1;  %白
        else
            afterPic(x,y)=0;    %黑
        end
    end
end
subplot(122),imshow(afterPic);title('Laplacia阈值为0.1');