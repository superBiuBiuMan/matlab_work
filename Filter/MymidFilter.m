%中值模糊
%https://blog.csdn.net/qq_36359022/article/details/80116137
function [afterMidFilter]=MymidFilter(origin)
[rows,cols,~]=size(origin);
N=5;
afterMidFilter=zeros(rows,cols);
temp=floor(N/2);
expand_img = wextend('2D','zpd', origin, temp);%扩展0
for i=1:rows
    for j=1:cols 
        selectArea=expand_img(i:i+N-1,j:j+N-1);
        %转列
        temp1=selectArea(:);
        middle=median(temp1);
        afterMidFilter(i,j) = middle;
    end
end
afterMidFilter=uint8(afterMidFilter());
end