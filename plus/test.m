
Img= imread('666.jpg'); 
if length(size(Img))>2
    Img=rgb2gray(Img);  
end
 
%绘制原始图像的直方图
[height,width]=size(Img);  
[counts1, x] = imhist(Img,256);  
counts2 = counts1/height/width;
figure(1),
subplot(1,2,1),
imshow(Img);title('原始图像');
subplot(1,2,2),
stem(x, counts2); title('原始图像直方图');
 
%统计每个灰度的像素值累计数目
NumPixel = zeros(1,256);%统计各灰度数目，共256个灰度级  
for i = 1:height  
    for j = 1: width  
    %对应灰度值像素点数量+1  
    %NumPixel的下标是从1开始，而图像像素的取值范围是0~255，所以用NumPixel(Img(i,j) + 1)  
    NumPixel(Img(i,j) + 1) = NumPixel(Img(i,j) + 1) + 1;  
    end  
end  
 
%将频数值算为频率
ProbPixel = zeros(1,256);  
for i = 1:256  
    ProbPixel(i) = NumPixel(i) / (height * width * 1.0);  
end  
 
%函数cumsum来计算cdf，并将频率（取值范围是0.0~1.0）映射到0~255的无符号整数
CumuPixel = cumsum(ProbPixel);  
CumuPixel = uint8(255 .* CumuPixel + 0.5); 
 
%直方图均衡。赋值语句右端，Img(i,j)被用来作为CumuPixel的索引
for i = 1:height  
    for j = 1: width  
        Img(i,j) = CumuPixel(Img(i,j)+1);  
    end  
end  
 
%显示更新后的直方图
figure(2),
subplot(1,2,1),
imshow(Img); title('直方图均衡化图像'); 
[counts1, x] = imhist(Img,256);  
counts2 = counts1/height/width;  
subplot(1,2,2),
stem(x, counts2); title('直方图均衡化后图像的直方图');

