f=imread('666.jpg');
f=rgb2gray(f);
subplot(221),imshow(f),title('原图');
ff=fspecial('sobel');
j=filter2(ff,f);
subplot(222),imshow(j),title('Sobel算子锐化结果');