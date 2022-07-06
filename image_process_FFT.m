function image_process_FFT()
[filename, pathname]=uigetfile({'*.jpg;*.tif;*.bmp;*.gif' },'File Selector'); image=imread(strcat(pathname,filename));	%获取一个图像信号
if ndims(image)==3
image=rgb2gray(image);
end
scrsz=get(0,'ScreenSize');
figure('position',[0 0 scrsz(3)-1 scrsz(4)]);
set(gcf,'Name','快速傅里叶变换'); subplot(2,3,1);
imshow(image);
title('原始图像');
subplot(2,3,4); imshow(image);
title('原始图像');
[r,c]=size(image);
%补0至最接近的2的整数次幂array=image;
t=log2(r); t1=floor(t); t2=ceil(t); 
if t1~=t2
    array(2^t2,c)=0;
end
[r1,c1]=size(array); t=log2(c1); t3=floor(t); t4=ceil(t);
if t3~=t4
    array(r1,2^t4)=0;
end
[r1,c1]=size(array);
n=r1/2;
data_col=zeros(1,n,'double');	%按列方向计算时用到的for m=1:n
data_col(m)=exp(-1i*2*pi*(m-1)/r1);
end
n=c1/2;
data_row=zeros(1,n,'double');	%按行方向计算时用到for m=1:n
data_row(m)=exp(-1i*2*pi*(m-1)/r1);
end
array=transform_fft2(array); 
Ft=fftshift(array); 
S1=log(1+abs(Ft)); 
subplot(2,3,2);
imshow(S1,[]);
title('自建FFT2函数结果'); 
array=transform_ifft2(array);
array=abs(array); 
array=array(1:r,1:c); 
subplot(2,3,3);
imshow(array,[]);
title('自建IFFT2结果');
F=fft2(image); 
FC=fftshift(F);
S=log(1+abs(FC));
subplot(2,3,5),imshow(S,[]);
title('内置FFT2结果');
array=ifft2(F); 
array=round(abs(array)); 
subplot(2,3,6);
imshow(array,[]);
title('内置IFFT2结果'); return
function array=transform_fft2(array) array=double(array);
[r1 c1]=size(array); 
for j=1:r1
    array(j,:)=transform_fft(array(j,:));
end
for j=1:c1
    array(:,j)=transform_fft((array(:,j)));
end
N=length(array); n=N/2;
w=zeros(1,n,'double'); 
for m=1:n
    w(m)=exp(-1i*2*pi*(m-1)/N);
end p=log2(N);

    array1=zeros(1,N,'double');
    
for q=1:p
    t1=2^(q-1);
    t2=2^(p-1);
for k=0:(t2/t1-1)
for j=0:(t1-1)
if mod(q,2)==1
data1=array(k*t1+j+1); data2=array(k*t1+j+t2+1); array1(k*t1*2+j+1)=data1+data2; array1(k*t1*2+j+t1+1)=(data1-data2)*w(k*t1+1);

end

else







end


data1=array1(k*t1+j+1); data2=array1(k*t1+j+t2+1); array(k*t1*2+j+1)=data1+data2; array(k*t1*2+j+t1+1)=(data1-data2)*w(k*t1+1);


end
end
if mod(p,2)==1 return
else
end
array1=array; return
function array=transform_ifft2(array) 
    array=conj(array); 
    [r1,c1]=size(array);
for i=1:r1
    array(i,:)=transform_fft(array(i,:));
end
for i=1:c1
    array(:,i)=transform_fft(array(:,i));
end array=array/(r1*c1);