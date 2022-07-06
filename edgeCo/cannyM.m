%https://zhuanlan.zhihu.com/p/42122107
%8通道%https://www.iteye.com/blog/854369721-2431134 
%http://www.uml.org.cn/ai/201812212.asp
%非极大值抑制和双阈值%https://blog.csdn.net/weixin_40647819/article/details/91411424
%https://www.freesion.com/article/15941168015/  重要~
%DT canny算子边缘图像
%origin 原灰度图像

function [DT]=cannyM(origin)

[rows,cols]=size(origin);

G = fspecial('gaussian', 5, 2);
img=im2double(origin); 
img= imfilter(img,G,'same');

%计算梯度值
img_TX=zeros(rows,cols);
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
%计算梯度方向
imgST=atan2(img_TY,img_TX);
imgST = imgST*180/pi;
for i = 1:rows
    for j = 1:cols
        if((imgST(i,j) >= -22.5) && (imgST(i,j) < 0)||(imgST(i,j) >= 0) && (imgST(i,j) < 22.5) || (imgST(i,j) <= -157.5) && (imgST(i,j) >= -180)||(imgST(i,j) >= 157.5)&&(imgST(i,j) <= 180))
            imgST(i,j) = 0;
        elseif((imgST(i,j) >= 22.5) && (imgST(i,j) < 67.5) || (imgST(i,j) <= -112.5) && (imgST(i,j) > -157.5))
            imgST(i,j) = -45;
        elseif((imgST(i,j) >= 67.5) && (imgST(i,j) < 112.5) || (imgST(i,j) <= -67.5) && (imgST(i,j) > -112.5))
            imgST(i,j) = 90;
        elseif((imgST(i,j) >= 112.5) && (imgST(i,j) < 157.5) || (imgST(i,j) <= -22.5) && (imgST(i,j) > -67.5))
            imgST(i,j) = 45;  
        end
    end
end

%非极大值抑制图像
Nms = zeros(rows,cols);
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

DT = zeros(rows,cols);
TL = 0.1 * max(max(Nms));
TH = 0.3 * max(max(Nms));
for i = 1  : rows
    for j = 1 : cols
        if (Nms(i, j) < TL)
            DT(i,j) = 0;
        elseif (Nms(i, j) > TH)
            DT(i,j) = 1 ;
        elseif ( Nms(i+1,j) < TH || Nms(i-1,j) < TH || Nms(i,j+1) < TH || Nms(i,j-1) < TH || Nms(i-1, j-1) < TH || Nms(i-1, j+1) < TH || Nms(i+1, j+1) < TH || Nms(i+1, j-1) < TH)
            DT(i,j) = 1;
        end
    end
end
end








