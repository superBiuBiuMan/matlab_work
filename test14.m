%官方
clear,clc,close all;
    I=imread('fft3.png');
    I=rgb2gray(I);
    I=im2double(I);
    F=fft2(I);
    F=fftshift(F);
    F=abs(F);
    T=log(F+1);
    figure(4);
    subplot(2,2,1),imshow(T,[]);
    I1=imread('图片1_看图王.png');
    I1=rgb2gray(I1);
    I1=im2double(I1);
    F1=fft2(I1);
    F1=fftshift(F1);
    F1=abs(F1);
    T1=log(F1+1);
    figure(4);
    subplot(2,2,2),imshow(T1,[]);
    
    temp=T./T1;
    temp2=uint8(ifft2(temp));
    subplot(2,2,3),imshow(temp2);
    
    
    