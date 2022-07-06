bb=imread('jy.png');
A=fspecial('average',[5 5]); %生成系统预定义的
Y=filter2(A,bb);           %用生成的滤波器进行滤波,并归一化
figure,imshow(Y,[]),title('用系统函数进行均值滤波后的结果'); %显示滤波后的图象