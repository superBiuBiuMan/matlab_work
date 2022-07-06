%中值模糊

origin=imread('jy.png');
subplot(1,2,1),imshow(origin),title("原图像");
kuhanshu=medfilt2(origin,[4 4]);
subplot(1,2,2),imshow(kuhanshu),title("中值滤波后的图像");