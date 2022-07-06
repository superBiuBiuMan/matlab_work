rgb=imread('椒盐图.png');

J1=imnoise(rgb,'salt & pepper',0.02);

J2=imnoise(J1,'gaussian',0,0.01);

h1=fspecial('average',[3,3]);

h2=fspecial('average',[5,5]);

h3=fspecial('average',[7,7]);

rgb1=imfilter(J2,h1);

rgb2=imfilter(J2,h2);

rgb3=imfilter(J2,h3);

figure;

subplot(2,3,1);imshow(rgb)

title('原图像');

subplot(2,3,2);imshow(J2)

title('加入噪声后的图像');

subplot(2,3,4);imshow(rgb1)

title('3*3均值滤波图像');

subplot(2,3,5);imshow(rgb2)

title('5*5均值滤波图像');

subplot(2,3,6);imshow(rgb3)

title('7*7均值滤波图像');