%https://www.cnblogs.com/ninghechuan/p/9529936.html
%https://www.cnblogs.com/wxl845235800/p/7700887.html
%Soble算子
%afterSobel 返回Sobel边缘图
%rmg 传递灰度图片
%threshold 阈值
function [afterSobel]=MySobel(img,threshold)
	[rows,cols]=size(img);
    %转double
    img=im2double(img);
	%Sobel算子
	img_SobelX=zeros(rows,cols);
	img_SobelY=zeros(rows,cols);
	for r=2:rows-1
		for c=2:cols-1
            tempX=-img(r-1,  c-1) + img(r-1, c+1 )-2* img(r, c-1 ) +  2* img(r,  c+1)-img(r+1, c-1 ) +  img(r+1,  c+1);
            img_SobelX(r,c)=abs(tempX);
            tempY=img(r-1,c-1)+2*img(r-1,c ) + img(r-1,c+1 ) -img(r+1,c-1) -2*img(r+1, c) -img(r+1,c+1 );
            img_SobelY(r,c)=abs(tempY);
		end    
	end
	afterSobel=img_SobelX+img_SobelY;
    %抑制
    for r=1:rows
        for c=1:cols
            if afterSobel(r,c)>threshold
                afterSobel(r,c)=1;
            else
                afterSobel(r,c)=0;
            end
        end
    end
end

