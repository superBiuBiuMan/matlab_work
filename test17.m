%plus2
clear,clc,close all;
    I=imread('fft1.png');
    I=rgb2gray(I);
    I=im2double(I);
    [x,y] = size(I);
    Ax = ones(x,y);
    ans = ones(x,y);
    com = 0+1i;
    % 对每一列进行DFT  
    for m=1:y
        Ax(:,m) = fft(I(:,m));

    % 对每一行进行DFT    
    for k=1:x
        ans(k,:) = fft(Ax(k,:));
    end
    F=fftshift(ans);
    F= abs(F);
    F=log(F+1);
    figure(7);
    imshow(F,[]);
    end
