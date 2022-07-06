
clc,close all;
f=imread('666.jpg');
u=rgb2gray(f);
F=double(f);
U=double(u);
[H,W]=size(u);
uSobel=u;
% ms=0;
% ns=0;
for i=2:H-1
    for j=2:W-1
    Gx=(   U(i+1,j-1)+2*U(i+1,j)+F(i+1,j+1)  )   -(   U(i-1,j-1)+2*U(i-1,j)+F(i-1,j+1)   );
    Gy=(U(i-1,j+1)+2*U(i,j+1)+F(i+1,j+1))-(U(i-1,j-1)+2*U(i,j-1)+F(i+1,j-1));
   
    uSobel(i,j)=sqrt(Gx^2+Gy^2);
    
%    ms=ms+uSobel(i,j);
%   ns=ns+(uSobel(i,j)-ms)^2;
    end
    
end
%     ms=ms/(H*W);
%     ns=ns/(H*W);
subplot(1,2,1);imshow(f);title('原图');
subplot(1,2,2);imshow(im2uint8(uSobel));title('Sobel处理后');
% S=[ms ns];