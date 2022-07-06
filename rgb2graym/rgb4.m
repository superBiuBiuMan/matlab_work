%https://www.cnblogs.com/finlay/p/3665302.html
%最大值法
clear,clc,close all;
origin=imread('aaa.png');
subplot(2,2,1),imshow(origin),title("原图像");
[rows,cols,dim]=size(origin);
afterOrigin=uint8(zeros(rows,cols));
for i=1:rows
   for j=1:cols
        temp1=origin(i,j,1);
        temp2=origin(i,j,2);
        temp3=origin(i,j,3);
        temp4=temp1;
        if temp4<temp2
            temp4=temp2;
        elseif temp4<temp3
            temp4=temp3;
        end
        afterOrigin(i,j)=temp4;
   end
end
subplot(2,2,2),imshow(afterOrigin),title("最大值法转换后的");