%均值模糊
%https://blog.csdn.net/qq_40608730/article/details/105560697
function [afterMeanFilter]=MymenFilter(origin)
[rows,cols,~]=size(origin);
N=4;
afterMeanFilter=zeros(rows,cols);
muban=ones(N,N);
muban=(1/(N*N)).*muban;
expand_number=floor(N/2);
expand_img = double(wextend('2D','zpd', origin, expand_number));
for i=1:rows
    for j=1:cols
        ave = sum(   sum( expand_img(i:i+N-1,j:j+N-1) .* muban)   ); 
        afterMeanFilter(i,j) = ave;
    end
end
end