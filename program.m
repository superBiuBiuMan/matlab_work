
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear,clc,close all;
I=imread('fft1.png');
figure;imshow(I),title('原始图像');
figure;imhist(I);title('灰度直方图');
% impixel
[m,n]=size(I);               %计算图像大小
for i=1:m  
    for j=1:n
        if I(i,j)<70
           I(i,j)=255;
       end
    end
end
figure;imshow(I);title('提取内边界后的图像');  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I1=imread('fft1.png');       %读取图像
I1=rgb2gray(I1);              %转化为灰度图像
%求图像的外边界
[m,n]=size(I1);                   %计算图像大小
for i=1:m  
    for j=1:n
        if I1(i,j)<70
           I1(i,j)=255;
       end
    end
end
figure;imshow(I1);title('求外边界的图像');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%根据Houhg变换的原理，求圆心和半径
% for i=1:m
%     for j=1:n
%         if I1(i,j)>240
%             I1(i,j)=255;
%         else  I1(i,j)=0;
%         end
%     end
% end
% J=edge(I1,'roberts');
%求出圆心和半径分别为（104,96）88
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%根据圆提取出虹膜部分
for i=1:m
    for j=1:n
        if (i-104)*(i-104)+(j-96)*(j-96)>88*88
            I1(i,j)=255;
        end 
    end
end
figure;imshow(I1);title('删出圆外点后的图像');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%对提取后的图像进行三层小波分解。这里省略了归一化步骤。
%进行三层小波分解
[c,s]=wavedec2(I1,3,'sym4');
%提取分解后的低频系数
A1=appcoef2(c,s,'sym4',1);
A2=appcoef2(c,s,'sym4',2);
A3=appcoef2(c,s,'sym4',3);
%提取分解后第一层的高频系数
H1=detcoef2('h',c,s,1);
V1=detcoef2('v',c,s,1);
D1=detcoef2('d',c,s,1);
%提取分解后第二层的高频系数
H2=detcoef2('h',c,s,2);
V2=detcoef2('v',c,s,2);
D2=detcoef2('d',c,s,2);
%提取分解后第三层的高频系数
H3=detcoef2('h',c,s,3);
V3=detcoef2('v',c,s,3);
D3=detcoef2('d',c,s,3);
%合并显示各分解层的系数
%对第三层的系数进行合并显示
W1=[A3,H3
    V3,D3];
figure;imshow(W1,[]);title('分解第三层的系数');
%根据第三层的系数对第二层进行合并显示
W1=imresize(W1,[55 53]); %调整合并后的图像大小
W2=[W1,H2
    V2,D2];
figure;imshow(W2);title('分解第二层的系数');
%根据第二层的合并系数进行第一层的数据合并显示
W2=imresize(W2,[103 100]);%调整第二层的数据大小
W=[W2,H1
   V1,D1];
figure;imshow(W);title('小波分解后每层的数据');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%计算各像素值的概率

A3=floor(A3);   %把数据调整为整数
[m n]=size(A3); %计算A3的大小
%求最大值
[m1,i]=max(A3);             
[m2,j]=max(m1); %m2是最大值
%求最小值 
[m3,i]=min(A3);
[m4,j]=min(m3);%m4是最小值
%定义一数组存储各像素值的个数
for x=1:m2-m4+1
    a(x)=0;
end
%求各像素值的个数
[m n]=size(A3);
 for i=1:m
    for j=1:n
       a(A3(i,j)-m4+1)=a(A3(i,j)-m4+1)+1;
    end
 end
%去掉零个数的点
t=1;
for x=1:m2-m4+1
    if a(x)~=0
        b(t)=a(x);
        t=t+1;
    end
end
%求各个像素的概率
for x=1:t-1
     b(x)=b(x)/(m*n)
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%用霍夫曼方法对上述像素概率编码
b=fliplr(sort(b));%按降序排列
T=b;             
[m,n]=size(b);
B=zeros(n,n-1);%空的编码表（矩阵）
 for i=1:n
    B(i,1)=T(i);%生成编码表的第一列
 end
 r=B(i,1)+B(i-1,1);%最后两个元素相加
 T(n-1)=r;
 T(n)=0;
 T=fliplr(sort(T));
 t=n-1;
 for j=2:n-1%生成编码表的其他各列
    for i=1:t
        B(i,j)=T(i);
    end
        K=find(T==r);
        B(n,j)=K(end);%从第二列开始，每列的最后一个元素记录特征元素在该列的位置
        r=(B(t-1,j)+B(t,j));%最后两个元素相加
        T(t-1)=r;            %把相边的值排在后面
        T(t)=0;          %把最后一个数清空
        T=fliplr(sort(T));  %重新进行降序排列
        t=t-1;
 end
END1=sym('[0,1]');%给最后一列的元素编码
END=END1;
t=3;
d=1;
for j=n-2:-1:1  %从倒数第二列开始依次对各列元素编码
    for i=1:t-2
        if i>1 & B(i,j)==B(i-1,j)
            d=d+1;
        else
            d=1;
        end
        B(B(n,j+1),j+1)=-1;
        temp=B(:,j+1);

        x=find(temp==B(i,j));
        END(i)=END1(x(d));
    end
    y=B(n,j+1);
    END(t-1)=[char(END1(y)),'0'];%对排列后小的概率数赋0
    END(t)=[char(END1(y)),'1'];  %对排列后小的概率数赋1
    t=t+1;
    END1=END;
end
END %显示编码结果










