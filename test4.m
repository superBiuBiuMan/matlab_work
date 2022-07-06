close all
clear 
clc
src_image = imread('椒盐图.png');
image = rgb2gray(src_image);
[m, n] = size(image);
%模板大小
k = 3;
myFilter = zeros(k, k, 'uint8');
for i = 1 : k
    for j = 1 : k
        myFilter(i, j) = 1;
    end
end
[image2, image3] = spacelFilter(image, myFilter);
image4 = medfilt2(image, [3 3]);
figure(1)
imshow(image), title('原图像');
figure(2)
imshow(image2), title('3*3均值滤波图像');
saveas(2,'均值.bmp');
figure(3)
imshow(image3), title('3*3中值滤波图像');
saveas(3,'中值.bmp');
figure(4)
imshow(image4), title('matlab自带的中值滤波图像');
saveas(4,'m中值.bmp');