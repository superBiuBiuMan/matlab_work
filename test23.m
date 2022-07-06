%https://www.cnblogs.com/mfrbuaa/p/4582317.html
clear,clc,close all;
data=imread('fft1.png');
data=rgb2gray(data);

h = size(data, 1);
w = size(data, 2);
mfft2 = data;

if power(2, log2(h)) ~= h || power(2, log2(w)) ~= w
    disp('JCGuoFFT2 exit: h and w must be the power of 2!')
else
    for i = 1 : h
        mfft2(i, :) = IterativeFFT(mfft2(i, :));
    end
    
    for j = 1 : w
        mfft2(:, j) = IterativeFFT(mfft2(:, j));
    end
end
imshow(mfft2,[]);
