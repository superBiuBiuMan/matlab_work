%https://zhuanlan.zhihu.com/p/42122107
%8通道%https://www.iteye.com/blog/854369721-2431134 
%http://www.uml.org.cn/ai/201812212.asp
%非极大值抑制和双阈值%https://blog.csdn.net/weixin_40647819/article/details/91411424
origin=rgb2gray(imread('aaa.png'));
subplot(2,3,1),imshow(origin),title("原图像")
%高斯模糊下
G = fspecial('gaussian', 5, 2);
origin= imfilter(origin,G,'same'); %官方函数实现高斯模糊
subplot(2,3,2),imshow(origin),title("高斯模糊后图像");

%Sobel算子求图片 X,Y梯度值
[rows,cols]=size(origin);
img=im2double(origin); % 数据类型转化uint8-->double，uint8类型参与运算容易溢出
%梯度值
img_sobelX=zeros(rows,cols);
%梯度值
img_sobelY=zeros(rows,cols);
for r=2:rows-1
    for c=2:cols-1
        tempX=-img(r-1,  c-1) + img(r-1, c+1 )-2* img(r, c-1 ) +  2* img(r,  c+1)-img(r+1, c-1 ) +  img(r+1,  c+1);
        img_sobelX(r,c)=abs(tempX);
        tempY=img(r-1,c-1)+2*img(r-1,c ) + img(r-1,c+1 ) -img(r+1,c-1) -2*img(r+1, c) -img(r+1,c+1 );
        img_sobelY(r,c)=abs(tempY);
    end
end
img_sobelAll=img_sobelX+img_sobelY;
%测试使用
%img_sobelTtT=img_sobelX+img_sobelY;
%img_sobelX=img_sobelX(2:end-1,2:end-1);
%img_sobelY=img_sobelY(2:end-1,2:end-1);
%梯度方向(角度值)
imgST=atan(img_sobelX./img_sobelY);
%开始过滤非最大值(非最大抑制) 
%双阈值限制 
THre=0.2;
TLow=0.1;
for r=2:rows-1
    %for r=2:rows-1
    for c=2:cols-1
        %for c=2:cols-1
        %取出3*3矩阵
        temp=img_sobelAll(r-1:r+1,c-1:c+1);
        %矩阵值
        a1=temp(1);a2=temp(2);a3=temp(3);a4=temp(4);a5=temp(5);a6=temp(6);a7=temp(7);a8=temp(8);
        a9=temp(9);
        %判断梯度方向
        %水平边缘 22.5=pi/8  112.5=5*pi/8   157.5=7*pi/8   67.5=3*pi/8
        if( ( abs( imgST(r,c))<(pi/8) ) || ( abs( imgST(r,c))>( 7*(pi/8) ) ) )
            tempArray=[a2,a5,a8];
            maxNumber=max(tempArray);
            if( maxNumber>img_sobelAll(r,c) )
                %抑制
                img_sobelAll(r,c)=0;
            end
            %垂直边缘1
        elseif( ( imgST(r,c) >= (3*(pi/8)) && imgST(r,c) <= (5*(pi/8)) ) || ( imgST(r,c) >= (-5*(pi/8)) && imgST(r,c) <=(-3*(pi/8)) ) )
            tempArray=[a4,a5,a6];
            maxNumber=max(tempArray);
            if( maxNumber>img_sobelAll(r,c) )
                %说明不是边缘 则抑制
                img_sobelAll(r,c)=0;
            end
            %45度边缘
        elseif( ( imgST(r,c) > (5*(pi/8)) && imgST(r,c) <= (7*(pi/8)) )  || ( imgST(r,c)>= (-3*(pi/8)) && imgST(r,c)<= (-pi/8) )   )
            tempArray=[a3,a5,a7];
            maxNumber=max(tempArray);
            if( maxNumber>img_sobelAll(r,c) )
                %抑制
                img_sobelAll(r,c)=0;
            end
            %135度边缘
        elseif( ( imgST(r,c) >= (pi/8) && imgST(r,c) < (3*(pi/8)) )  || ( imgST(r,c) >= (-7*(pi/8)) && imgST(r,c)<(-5*(pi/8))     )  )
            tempArray=[a1,a5,a9];
            maxNumber=max(tempArray);
            if( maxNumber>img_sobelAll(r,c) )
                %抑制
                img_sobelAll(r,c)=0;
            end
        end
        %用双阈值处理
       if(  img_sobelAll(r,c)<TLow )
           %低于阈值 舍弃
           img_sobelAll(r,c)=0;
       elseif( img_sobelAll(r,c)>=THre )
           %高于阈值 标记
           img_sobelAll(r,c)=1;
       else
           %处于中间的
            if( a1>=THre || a2>=THre || a3>=THre || a4>=THre || a6>=THre || a7>=THre || a8>=THre || a9>=THre )
                %标记为边缘
                img_sobelAll(r,c)=1;
            else
                %非边缘
                img_sobelAll(r,c)=0;
            end
       end
    end
end
subplot(2,3,3),imshow(img_sobelAll),title("Canny算子后的图像");
img_sobelGF=edge(origin,'canny');
subplot(2,3,4),imshow(img_sobelGF),title("Canny官方算子后的图像");













