%https://blog.csdn.net/u014485485/article/details/78364573
%https://www.jianshu.com/p/2334bee37de5
%afterPic 返回laplace处理过后的图像
%origin 原图像 灰度图
%Threshold 阈值,达到这个阈值即为边缘
function [afterPic]=laplaceM(origin,Threshold)
originDouble=mat2gray(origin);   %图像矩阵的归一化
[m,n]=size(originDouble);
afterPic=zeros(m-1,n-1);
%Laplace算子
for x=2:m-1 
    for y=2:n-1
        %模板运算
        %   0 1 0 
        %   1 -4 1
        %   0 1 0
        L=-4*originDouble(x, y) + originDouble(x-1, y) + originDouble(x+1, y) + originDouble(x, y-1) + originDouble(x, y+1); 
        if(L > Threshold )
            afterPic(x,y)=1;  %白
        else
            afterPic(x,y)=0;    %黑
        end
    end
end

end