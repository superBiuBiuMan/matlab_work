%https://blog.csdn.net/CGGlove/article/details/110584964
%快速傅里叶逆变换，不够2的整数幂的个数，末尾自动补齐0

%Vector=rgb2gray(imread('fft1.png'));
Vector=png1;
%因为输入的数据可能不是2的整数次幂，补零使得计算更加方便
[m,n]=size(Vector);%输入信号矩阵大小
num=ceil(log2(n));%向上取整
N=2^num;
vector=zeros(m,N);%申请足够大小矩阵
vector(:,1:n)=Vector(:,:);%将变换后的信号输入，不足补零

for lines=1:m%循环行数
    for L=num-1:-1:0%L表示运算等级或者层数
        dis=2^L;%dis表示奇偶组之间的距离
        for id=1:2^(num-L-1) %循环当前层数组数
            %进行同址运算
           for idx=1:dis%循环组内个数
               x1=(id-1)*2*dis+idx;%求得奇数数组的索引值
               x2=(id-1)*2*dis+dis+idx;%对应偶数数组的索引值
            temp1=(vector(lines,x1)+vector(lines,x2))/2;%中间变量保存相应奇偶数组数据
            temp2=(vector(lines,x1)-vector(lines,x2))/2*W(L,(x1-1));
            vector(lines,x1)=temp1;%存入之前地址
            vector(lines,x2)=temp2;
           end
        end
    end
end
%变址运算，逆推回原来位置
for line=1:m%循环行数
    j1 = 0;
    for i = 1 : N%循环个数
        if i < j1 + 1
            tmp = vector(line,j1 + 1);
            vector(line,j1 + 1) = vector(line,i);
            vector(line,i) =tmp;
        end
        k = N / 2;
        while k <= j1
            j1 = j1 - k;
            k = k / 2;
        end
        j1 = j1 + k;
    end
end
ret_val =vector;
function val=W(L,x)%旋转因子当层数为L,索引值为x
val=exp(1j*2*pi*x/2^(L+1));
end


