%获得输入数据维度
inputData=double(rgb2gray(imread("666.jpg")));
[m,n] = size(inputData);
%创建协方差矩阵
COVMAT = zeros(m,m);
%取得每维数据平均值
E = zeros(m,1);
for i = 1:m
    E(i) = mean(inputData(i,:));
end
%计算协方差
for i = 1:m
    for j = 1:m
       COVMAT(i,j) = ((inputData(i,:)-E(i))*(inputData(j,:)-E(j))')./(n-1);
    end
end
