aa=imread('jy.png');
[ROW,COL]=size(aa);
for r = 2:1:ROW-1
    for c = 2:1:COL-1
        Mean_Img(r,c) = (aa(r-1, c-1) + aa(r-1, c) + aa(r-1, c+1) + aa(r, c-1) + aa(r, c) + aa(r, c+1) + aa(r+1, c-1) + aa(r+1, c) + aa(r+1, c+1)) / 9;
    end
end
imshow(Mean_Img,[]);