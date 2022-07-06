%https://zhuanlan.zhihu.com/p/192937271
 clear,clc,close all;
img0=imread("D:\develop\matlab\bin\fft1.png");
img0=rgb2gray(img0);
 img1=double(img0);
 [M,N]=size(img1);
%  M长 N宽
% F=G1*f*G2(f为原始的,G1,G2为) 矩阵相乘 
% 也就说每一个点都F(u,v)=G1(x,y)*f(x,y)*G2(x,y);
 j=0+1i;
 G1=zeros(M,M);
 for a=1:M
	for b=1:M
	   G1(a,b)= exp(   ( -j*2*pi*( a * b )  )/M  );
	end
 end
G2=zeros(N,N);
 for a=1:N
	for b=1:N
	   G2(a,b)= exp(   ( -j*2*pi*( a * b )  )/N  );
	end
 end
newImage=G1*img1;
newImage=newImage*G2;
F=fftshift(newImage);

