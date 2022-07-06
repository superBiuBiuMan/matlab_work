%https://www.cnblogs.com/finlay/p/3665302.html
%平均值法
			clear,clc,close all;
			origin=imread('aaa.png');
			subplot(1,2,1),imshow(origin),title("原图像");
			[rows,cols,~]=size(origin);
			for i=1:rows
			for j=1:cols
				sum=0;
				for k=1:3
					% sum=sum+origin(i,j,k);
					sum=sum+origin(i,j,k)/3;
				end
				afterOrigin(i,j)=sum;
			end
			end
			subplot(1,2,2);
			imshow(afterOrigin);
			title("平均值法");