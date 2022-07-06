%https://blog.csdn.net/Ciellee/article/details/108359201?utm_medium=distribute.pc_aggpage_search_result.none-task-blog-2~aggregatepage~first_rank_ecpm_v1~rank_aggregation-7-108359201.pc_agg_rank_aggregation&utm_term=%E4%B8%80%E7%BB%B4%E5%82%85%E9%87%8C%E5%8F%B6%E5%8F%98%E6%8D%A2matlab%E5%AE%9E%E7%8E%B0&spm=1000.2123.3001.4430
f=[7,8,9,4,-5,6];
[rows,M]=size(f);
%一维傅里叶正变换
j=0+1i;
%每运算一次F(U),都要从M=0加到M=M-1
F=zeros(1,M);
for u=0:M-1
   F(u+1)=0;
   for x=0:M-1
       F(u+1)=F(u+1)+f(x+1)*( cos( (u*x*2*pi)/M  ) - j*sin( (u*x*2*pi)/M  )  );
   end
end
%一维傅里叶逆变换
%F为傅里叶正变换后的值
%F=ifftshift(F);
f1=zeros(1,M);%逆变换后的值
for x=0:M-1
   temp=0;
   for u=0:M-1
       temp=temp+F(u+1)*( cos( (u*x*2*pi)/M  ) + j*sin( (u*x*2*pi)/M  ) );
   end 
   temp=temp/M;
   f1(x+1)=temp;
end