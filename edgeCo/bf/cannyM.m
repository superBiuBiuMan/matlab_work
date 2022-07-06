%https://zhuanlan.zhihu.com/p/42122107
%8通道%https://www.iteye.com/blog/854369721-2431134 
%http://www.uml.org.cn/ai/201812212.asp
%非极大值抑制和双阈值%https://blog.csdn.net/weixin_40647819/article/details/91411424

%https://www.freesion.com/article/15941168015/  重要~
%DT canny算子边缘图像
%origin 原灰度图像

function [DT]=cannyM(origin)


%% 1.高斯模糊下
[rows,cols]=size(origin);
G = fspecial('gaussian', 5, 2);
img=im2double(origin); % 数据类型转化uint8-->double，uint8类型参与运算容易溢出
img= imfilter(img,G,'same'); %官方函数实现高斯模糊

%% 2.计算梯度值
%梯度幅度值
img_TX=zeros(rows,cols);
%梯度幅度值
img_TY=zeros(rows,cols);
for r=2:rows-1
    for c=2:cols-1
        tempX=-img(r-1,  c-1) + img(r-1, c+1 )-2* img(r, c-1 ) +  2* img(r,  c+1)-img(r+1, c-1 ) +  img(r+1,  c+1);
        img_TX(r,c)=abs(tempX);
        tempY=img(r-1,c-1)+2*img(r-1,c ) + img(r-1,c+1 ) -img(r+1,c-1) -2*img(r+1, c) -img(r+1,c+1 );
        img_TY(r,c)=abs(tempY);
    end
end
img_sobelAll=img_TX+img_TY;
%% 3.计算梯度方向
%%梯度方向(角度值)
imgST=atan2(img_TY,img_TX);%获取弧度，范围：-pi~pi
imgST = imgST*180/pi;%将弧度转换为角度，得到角度图像，与原图像大小相等.

%% 4.开始过滤非最大值(非最大抑制) 

%首先将角度划分成四个方向范围:水平(0°)、-45°、垂直(90°)、+45°
for i = 1:rows
    for j = 1:cols
        %水平方向
        if((imgST(i,j) >= -22.5) && (imgST(i,j) < 0)||(imgST(i,j) >= 0) && (imgST(i,j) < 22.5) || (imgST(i,j) <= -157.5) && (imgST(i,j) >= -180)||(imgST(i,j) >= 157.5)&&(imgST(i,j) <= 180))
            imgST(i,j) = 0;
        %-45度也就是135度方向
        elseif((imgST(i,j) >= 22.5) && (imgST(i,j) < 67.5) || (imgST(i,j) <= -112.5) && (imgST(i,j) > -157.5))
            imgST(i,j) = -45;
        %垂直方向
        elseif((imgST(i,j) >= 67.5) && (imgST(i,j) < 112.5) || (imgST(i,j) <= -67.5) && (imgST(i,j) >- 112.5))
            imgST(i,j) = 90;
       %45度方向
        elseif((imgST(i,j) >= 112.5) && (imgST(i,j) < 157.5) || (imgST(i,j) <= -22.5) && (imgST(i,j) > -67.5))
            imgST(i,j) = 45;  
        end
    end
end

%非极大值抑制图像
Nms = zeros(rows,cols);%定义一个非极大值图像
for i = 2:rows-1
    for j= 2:cols-1
        if (imgST(i,j) == 0 && img_sobelAll(i,j) == max([img_sobelAll(i,j), img_sobelAll(i,j+1), img_sobelAll(i,j-1)]))
            Nms(i,j) = img_sobelAll(i,j);
        elseif (imgST(i,j) == -45 && img_sobelAll(i,j) == max([img_sobelAll(i,j), img_sobelAll(i+1,j-1), img_sobelAll(i-1,j+1)]))
            Nms(i,j) = img_sobelAll(i,j);
        elseif (imgST(i,j) == 90 && img_sobelAll(i,j) == max([img_sobelAll(i,j), img_sobelAll(i+1,j), img_sobelAll(i-1,j)]))
            Nms(i,j) = img_sobelAll(i,j);
        elseif (imgST(i,j) == 45 && img_sobelAll(i,j) == max([img_sobelAll(i,j), img_sobelAll(i+1,j+1), img_sobelAll(i-1,j-1)]))
            Nms(i,j) = img_sobelAll(i,j);
        end
    end
end

%%  5.双阈值检测和连接边缘
DT = zeros(rows,cols);%定义一个双阈值图像
TL = 0.1 * max(max(Nms));%低阈值
TH = 0.3 * max(max(Nms));%高阈值
for i = 1  : rows
    for j = 1 : cols
        if (Nms(i, j) < TL)
            %低于阈值,抑制,非边缘
            DT(i,j) = 0;
        elseif (Nms(i, j) > TH)
            %高于阈值,边缘
            DT(i,j) = 1 ;
        %中间值,TL < Nms(i, j) < TH 使用8连通区域确定
        elseif ( Nms(i+1,j) < TH || Nms(i-1,j) < TH || Nms(i,j+1) < TH || Nms(i,j-1) < TH || Nms(i-1, j-1) < TH || Nms(i-1, j+1) < TH || Nms(i+1, j+1) < TH || Nms(i+1, j-1) < TH)
            DT(i,j) = 1;
        end
    end
end
end








