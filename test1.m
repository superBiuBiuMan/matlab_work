%clear,clc,close all;
%origin=rgb2gray(imread('fft1.png'));   %图片1 
origin=rgb2gray(imread('tom.jpg'));   %图片1 
afterFFT=MyFFT(origin); %FFT后返回FFT

%自己编写方法处理
afterbutterworthD=dream_dp(afterFFT); %使用理想滤波器处理低频

%origin1=rgb2gray(imread('666.jpg'));  %图片2
origin1=rgb2gray(imread('phone.jpg'));  %图片2
afterFFT1=MyFFT(origin1);
afterbutterworthG=dream_gp(afterFFT1); %使用理想滤波器处理高频

pngDP=real(MyIFFT(ifftshift(afterbutterworthD))); %获取图片1低频-反傅里叶变换展示图片(real获取实部数据)
pngGP=real(MyIFFT(ifftshift(afterbutterworthG))); %获取图片2高频-反傅里叶变换展示图片(real获取实部数据)
%官方方式处理

    %处理图片1  低频
gfafterpngDP=dream_dp(fft2(origin));
gfpngDP=real(ifft2(ifftshift(gfafterpngDP)));

    %处理图片2 高频
gfafterpngGP=dream_gp(fft2(origin1));
gfpngGP=real(ifft2(ifftshift(gfafterpngGP)));

%混合图像 图片1和图片2进行混合,图片1低频,图片2高频
[rows,cols]=size(origin);
pngHygrid=zeros(rows,cols);%预热
for i=1:rows
   for j=1:cols
        pngHygrid(i,j)=pngDP(i,j)+pngGP(i,j);
   end
end

subplot(2,3,1),imshow(origin),title("原图像");
subplot(2,3,2),imshow(pngDP,[]),title("经过反傅里叶后的低频 图片1");
subplot(2,3,3),imshow(pngGP,[]),title("经过反傅里叶后的高频 图片2 ");
subplot(2,3,4),imshow(gfpngDP,[]),title("经过反傅里叶后的低频官方的 图片1");
subplot(2,3,5),imshow(gfpngGP,[]),title("经过反傅里叶后的高频官方的 图片2");
subplot(2,3,6),imshow(pngHygrid,[]),title("图片1,图片2 混合图像");