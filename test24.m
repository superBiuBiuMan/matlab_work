%官方傅里叶测试
a=imread('fft1.png');
a=rgb2gray(a);
b=fft2(a);
c=fftshift(b);