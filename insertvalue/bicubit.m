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
figure(1),imshow(origin,[]),title("原图");
scale=2;
afterRows=round(rows*scale);
afterCols=round(cols*scale);
afterPic=ones(afterRows,afterCols);

temprowstart = origin(1,:); 
temprowend = origin(rows,:);
temp_origin = [temprowstart;temprowstart;origin;temprowend;temprowend];
tempcolstart = temp_origin(:,1); 
tempcolend = temp_origin(:,cols);
afterExtendPic = [tempcolstart,tempcolstart,temp_origin,tempcolend,tempcolend];


%s插值核 卷积
for i = 1:afterRows
	u= rem(i,scale);
	for j = 1:afterCols
		v=rem(j,scale) ;
        %取比他小的临近整数
        tempi = floor(i/scale)+2; 
        tempj = floor(j/scale)+2;
        A=[S(u+1),S(u),S(u-1),S(u-2)];
		B=afterExtendPic(tempi-1:tempi+2,tempj-1:tempj+2);
		C=[S(v+1);S(v);S(v-1);S(v-2)]; 
		afterPic(i,j)=A*B*C;
	end
end
figure(2),imshow(afterPic,[]),title("之后");

