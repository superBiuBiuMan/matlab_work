clear ,clc;
sourcePic=imread('666.jpg');%图像读入
sourcePic=rgb2gray(sourcePic);
grayPic=mat2gray(sourcePic);%实现图像的矩阵归一化操作

[m,n]=size(grayPic);

newGrayPic=grayPic;

LaplacianNum=0;%经Laplacian操作得到的每个像素的值

LaplacianThreshold=0.2;%设定阈值

for j=2:m-1 %进行边界提取

    for k=2:n-1

        LaplacianNum=abs(4*grayPic(j,k)-grayPic(j-1,k)-grayPic(j+1,k)-grayPic(j,k+1)-grayPic(j,k-1));

        if(LaplacianNum > LaplacianThreshold)

            newGrayPic(j,k)=255;

        else

            newGrayPic(j,k)=0;

        end

    end

end

figure,imshow(newGrayPic);

title('Laplacian算子的处理结果')