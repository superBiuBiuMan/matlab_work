%https://blog.csdn.net/Du_Shuang/article/details/102679625
%https://blog.csdn.net/sinat_31987445/article/details/88870757
%https://segmentfault.com/a/1190000012473439
%https://wenku.baidu.com/view/e5ea81b5001ca300a6c30c22590102020640f2e7.html
%双三次插值
origin=double(imread("lenna.png"));
%  origin=[1 2 1 1;                     
%              3 3 1 2; 
%              3 5 4 3; 
%              5 4 5 4;
%              5 6 1 5; 
%              6 5 2 6;
%              8 7 1 2;
%              9 8 3 7];
[rows,cols]=size(origin);
%subplot(1,2,1),imshow(origin,[]),title("原图像");
figure(1),imshow(origin,[]),title("原图");
%v = rem(w,zmf)/zmf; u = rem(h,zmf)/zmf;
scale=2; %缩放因子
%目标行列
afterRows=round(rows*scale);
afterCols=round(cols*scale);
%之后的图片
afterPic=ones(afterRows,afterCols);
%原图像首行
temprowstart = origin(1,:); 
%原图像尾行
temprowend = origin(rows,:);
%整合
temp_origin = [temprowstart;temprowstart;origin;temprowend;temprowend];
%整合后取首列
c = temp_origin(:,1); 
%整合后取尾列
d = temp_origin(:,cols);
%整合
afterExtendPic = [c,c,temp_origin,d,d];

for i = 1:afterRows
	u= rem(i,scale)/scale;
    tempi = floor(i/scale)+2; 
	for j = 1:afterCols
		v=rem(j,scale) /scale ;
        tempj = floor(j/scale)+2;
		A=[S(u+1),S(u),S(u-1),S(u-2)];
		B=afterExtendPdic(tempi-1:tempi+2,tempj-1:tempj+2);
		C=[S(v+1);S(v);S(v-1);S(v-2)]; 
		afterPic(i,j)=A*B*C;
	end
end
%subplot(1,2,2),imshow(afterPic,[]),title("放大后");
figure(2),imshow(afterPic,[]),title("之后");