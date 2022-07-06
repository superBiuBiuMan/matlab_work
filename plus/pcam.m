%https://www.cnblogs.com/geeksongs/p/11190295.html 转置
%https://blog.csdn.net/guyuealian/article/details/68487833基本概念
%https://blog.csdn.net/re_call/article/details/117533590步骤
%https://blog.csdn.net/guyuealian/article/details/68487833
%https://blog.csdn.net/lanyuelvyun/article/details/82384179
%%所有样本X减去样本均值m，再乘以协方差矩阵（散步矩阵）的特征向量V，即为样本的主成份SCORE
%样本矩阵
originData=[1 2 1 1;                     
            3 3 1 2; 
            3 5 4 3; 
            5 4 5 4;
            5 6 1 5; 
            6 5 2 6;
            8 7 1 2;
            9 8 3 7];
k=2;
[rows,cols]=size(originData);
%中心化
everyAverage=sum(originData)/rows;
AoriginData=originData;
for i=1:cols
   AoriginData(:,i)=originData(:,i)-everyAverage(i);
end
%求协方差矩阵
xfcData=(AoriginData'*AoriginData )/ (rows-1);

%特征向量V 特征值D
[V,D]=eigs(xfcData);


Score=(originData-everyAverage)*V;

pcaData=Score(:,1:2);


