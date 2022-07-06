
f=imread('666.jpg');
f=rgb2gray(f);
f=double(f);
%f=f/255;都可以
%高斯滤波，平滑图像，去除高频噪点
G=fspecial('gaussian',13,2);
f_gaussian=imfilter(f,G,'same');
figure(1),imshow(f_gaussian);

%使用Sobel算子计算梯度
S_x=fspecial('sobel');
f_sobel_x=imfilter(f_gaussian,S_x,'replicate');
S_y=S_x';
f_sobel_y=imfilter(f_gaussian,S_y,'replicate');
f_sobel_amp=sqrt(f_sobel_x.^2+f_sobel_y.^2);
f_sobel_ang=atan(f_sobel_y./f_sobel_x);%注意arctan函数的值域为-pi/2到pi/2，即f_sobel_ang中的值只会在这两个数之间
figure(2),imshow(f_sobel_amp);
figure(3),imshow(f_sobel_ang);

%非最大值抑制
%将4个基本边缘方向的角度值存放在向量direction中
%       90  45
%       0
%           -45
direction=[-45 0 45 90];
%将4个基本边缘方向的角度值对应的邻域中相对于中心像素位置的平移量保存在2维矩阵direction_offset中
%    1  -1
%    1   0
%    1   1
%    0   1
direction_offset=[1 -1;1 0;1 1;0 1];
%将角度单位转成弧度单位
direction=direction/180*pi;
%将f_sobel_ang中的弧度值转化进-67.5度对应的弧度到90度对应的弧度范围间
f_sobel_ang_trans=zeros(size(f_sobel_ang));
for i=1:size(f_sobel_ang,1)
    for j=1:size(f_sobel_ang,2)
        if f_sobel_ang(i,j)<-67.5/180*pi
            f_sobel_ang_trans(i,j)=f_sobel_ang(i,j)+pi;
        else
            f_sobel_ang_trans(i,j)=f_sobel_ang(i,j);
        end
    end
end
f_sobel_ang_appro=zeros(size(f_sobel_ang));%保存弧度近似的结果
%寻找与f_sobel_ang_trans中的每个弧度最近的向量direction中的弧度对应的索引值，并将近似弧度的索引值保存在f_sobel_ang_appro中
for i=1:size(f_sobel_ang_trans,1)
    for j=1:size(f_sobel_ang_trans,2)
        [~,indices]=min(abs(f_sobel_ang_trans(i,j)-direction));
        f_sobel_ang_appro(i,j)=indices;
    end
end
f_sup=zeros(size(f,1)+2,size(f,2)+2);%保存最大值抑制的结果
%在f_sobel_amp的任一3x3邻域中判断邻域中心值是否全部大于沿近似角度方向和反方向上的两个邻域值。
%为避免滑窗时溢出，先进行图像边界填充
f_sobel_amp=padarray(f_sobel_amp,[1,1],'replicate');
%为方便角度信息使用，对f_sobel_ang_appro进行图像边界填充
f_sobel_ang_appro=padarray(f_sobel_ang_appro,[1,1],'replicate');
for i=2:size(f_sobel_amp,1)-1
    for j=2:size(f_sobel_amp,2)-1
        %邻域像素的坐标计算
        a(1,:)=[i,j]+direction_offset(f_sobel_ang_appro(i,j),:);
        a(2,:)=[i,j]-direction_offset(f_sobel_ang_appro(i,j),:);        
        if f_sobel_amp(i,j) >= f_sobel_amp(a(1,1),a(1,2)) && ... %a(1)为行数，a(2)为列数
           f_sobel_amp(i,j) >= f_sobel_amp(a(2,1),a(2,2)) 
            f_sup(i,j)=f_sobel_amp(i,j);
        else
            f_sup(i,j)=0;
        end
    end
end
%将最大值抑制结果的尺寸调整成输入图像的尺寸
f_sup=f_sup(2:size(f_sup,1)-1,2:size(f_sup,2)-1);
figure(4),imshow(f_sup);

%滞后阈值处理
%Canny建议低阈值：高阈值=1：3
low=0.04;
high=0.1;
f_sup_low=(f_sup>=low);%储存强边缘+弱边缘
f_sup_high=(f_sup>=high);%储存强边缘
f_sup_thresh=f_sup_low-f_sup_high;%储存弱边缘，即low<=f_sup_thresh<=high
figure(5),imshow(f_sup_thresh);
figure(6),imshow(f_sup_high);

%边缘连接操作
%由于需要对图像进行3x3邻域的滑窗操作，所以需要扩展图像大小
f_sup_thresh=padarray(f_sup_low,[1,1],'replicate');
f_sup_high=padarray(f_sup_high,[1,1],'replicate');
f_sup_conn=zeros(size(f_sup_thresh));
neigh=[-1 -1;-1 0;-1 1;0 -1;0 1;1 -1;1 0;1 1];%8邻域坐标偏移模板
for i=2:size(f_sup_conn,1)-1
    for j=2:size(f_sup_conn,2)-1
        %判断在第i行，第j列是否存在强边缘
         if f_sup_high(i,j)==1
             %若存在，则将该点看作是边缘点，显示在f_sup_conn中
             f_sup_conn(i,j)=1;
             %在点(i,j)的8邻域中进行操作，检查是否存在弱边缘点
             for k=1:8
                 %若8邻域中的某一点是弱边缘点，则将该点看做是边缘点，显示在f_sup_conn中
                 if f_sup_thresh(i+neigh(k,1),j+neigh(k,2))==1
                     f_sup_conn(i+neigh(k,1),j+neigh(k,2))=1;
                 end
             end
         end
    end
end
f_sup_conn=f_sup_conn(2:size(f_sup_conn,1)-1,2:size(f_sup_conn,2)-1);
figure(7),imshow(f_sup_conn);

%对比
f_comparison=edge(f,'canny',[low,high],2);
figure(8),imshow(f_comparison);

