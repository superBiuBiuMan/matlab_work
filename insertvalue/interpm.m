%https://zhuanlan.zhihu.com/p/89409337
%https://www.cnblogs.com/wancy/p/15068519.html
%https://www.freesion.com/article/6113479685/
%https://www.cnblogs.com/wancy/p/15068519.html
%最近邻插值法
origin=double(rgb2gray(imread("fft1.png")));
[rows,cols]=size(origin);
figure(1),imshow(origin,[]),title("原图");
scale=2;
rowsNews=rows*scale;
colsNews=cols*scale;
afterPic=zeros(rowsNews,colsNews);

for i = 1 : rowsNews
    for j = 1 : colsNews
        x = round(1/scale*i);
        y = round(1/scale*j);
        afterPic(i, j) = origin(x, y);
    end
end
figure(2),imshow(afterPic,[]),title("之后");