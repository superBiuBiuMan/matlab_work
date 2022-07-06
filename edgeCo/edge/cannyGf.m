I=imread('666.jpg');       %读取当前路径下的图片
subplot(2,2,1);
imshow(I);
title('原始图像')
I1=rgb2gray(I);
subplot(2,2,2);
imshow(I1);
title('灰度图像');
I2=edge(I1,'canny');
subplot(2,2,3);
imshow(I2);
title('canny算子分割结果');