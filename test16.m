%plus1
clear,clc,close all;
    I=imread('fft1.png');
    I=rgb2gray(I);
    I=im2double(I);
    [x,y] = size(I);
    Ax = ones(x,y);
    ans = ones(x,y);
    com = 0+1i;
    % 对每一列进行DFT
    for k =1:x        
        for m=1:y
            sn =0;
            for n =1:x
                sn =sn + I(n,m)*exp(-com*2*pi*k*n/x);
            end
            Ax(k,m) = sn;
        end
    end
    % 对每一行进行DFT
    for l =1:y
        for k =1:x
            sn =0;
            for m=1:y
                sn = sn+Ax(k,m)*exp(-com*2*pi*l*m/y);
            end
            ans(k,l) = sn;
        end
    end    
    F=fftshift(ans);
    F= abs(F);
    F=log(F+1);
    figure(6);
    imshow(F,[]);
