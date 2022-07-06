%https://www.cnblogs.com/finlay/p/3665302.html
clear,clc,close all;
origin=imread('aaa.png');
subplot(3,3,1),imshow(origin),title("原图像");
[rows,cols,dim]=size(origin);
r=origin(:,:,1);
g=origin(:,:,2);
b=origin(:,:,3);
%单通道法
%Gray,(i,j)= R(i,j)
%Gray2(i, j)= G(i,j)
%Gray3(i,j)= B(i,j)
afterOrgin1=r;
afterOrgin2=g;
afterOrgin3=b;
subplot(3,3,2),imshow(afterOrgin1),title("单通道R");
subplot(3,3,3),imshow(afterOrgin2),title("单通道G");
subplot(3,3,4),imshow(afterOrgin3),title("单通道B");
%加权平均值法 Gray(i, j)= 0.299* R(i,j)+0.578*G(i,j)+0.114* B(i,j)
% for i=1:rows
%     for j=1:cols
%         afterOrigin4(i,j)=r(i,j)*0.299 + g(i,j)*0.587 + b(i,j)*0.114;
%     end
% end
afterOrigin4=r.*0.299+g.*0.587+b.*0.114;
subplot(3,3,5),imshow(afterOrigin4),title("加权平均值法");
%平均值法 Gray(i, j)=(R(i, j)+G(i, j)+ B(i, j))/3
tt1=double(r);
tt2=double(g);
tt3=double(b);%目的int最大值255
temp=tt1+tt2+tt3;
afterOrigin5= uint8(temp./3);
subplot(3,3,6),imshow(afterOrigin5),title("平均值法");
%最大值法 Gray(i, j)= max {R(i, j),G(i, j), B(i,j)}
afterOrigin6=uint8(zeros(rows,cols));
for i=1:rows
   for j=1:cols
        temp1=origin(i,j,1);%r
        temp2=origin(i,j,2);%g
        temp3=origin(i,j,3);%b
        temp4=temp1;
        if temp4<temp2
            temp4=temp2;
        elseif temp4<temp3
            temp4=temp3;
        end
        afterOrigin6(i,j)=temp4;
   end
end
subplot(3,3,7),imshow(afterOrigin6),title("最大值法");
