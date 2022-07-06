picture=rgb2gray(imread('666.jpg')); %读取图像
figure
imshow(picture)
title('原来的图象'); %显示原始图象
I=picture;
%函数部分
%function hist_img = hist_1(I)
    [M, N] = size(I);
    size_img = M*N;
    c = zeros(1,256);%统计每个每个像素值的个数
    b= c;%转化前后的对照表
    %转换为列
    temp = I(:);
    %从小到大排序
    temp = sort(temp);
    
    for i = 1:size_img
        c(temp(i)+1) = c(temp(i)+1)+1;      
    end
    
    
    a = c;%求和
    for i = 2:256
       a(i) = c(i) + a(i-1);
    end
    min_cdf = 10000;
    for i = 1:256
       if a(i)>0
           if a(i) < min_cdf
                min_cdf = a(i);
           end
       end
    end
    for j = 1:256
        if a(j) > 0
             b(j) = round(255*(a(j)-min_cdf)/(size_img-min_cdf));
        end
    end
    for i = 1:M
        for j = 1:N
            I(i,j) = b(I(i,j)+1);
        end       
    end
hist_img = I;
after = hist_img;
figure
imshow(after)
title('变化后图象'); %显示原始图象
