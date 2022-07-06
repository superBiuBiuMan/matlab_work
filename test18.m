clear,clc,close all;
%// Load an image
Orig = im2double((imread('fft1.png')));
Orig = rgb2gray(Orig);

%// Transform
Orig_T = dct2(Orig);
%// Split between high- and low-frequency in the spectrum (*)
cutoff = round(0.5 * 256);
High_T = fliplr(tril(fliplr(Orig_T), cutoff));
Low_T = Orig_T - High_T;
%// Transform back
High = idct2(High_T);
Low = idct2(Low_T);
%// Plot results
figure, colormap gray
subplot(3,2,5), imshow(Low,[]);
subplot(3,2,6), imshow(High,[]);
