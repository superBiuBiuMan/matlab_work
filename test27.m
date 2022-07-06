img=rgb2gray(imread('fft1.png'));
img=fft2(img);
img1=double(img);
 [height,width]=size(img1);
 T=zeros(height,width);
 imaginary_num=0+1i;
 % 对每一列进行傅里叶逆变换
 for a=0:height-1
     for b=0:width-1
              Fu=0;
         for c=0:height-1
             Fu=Fu+img1(c+1,b+1)*exp(imaginary_num*2*pi*c*a/height);
         end
         T(a+1,b+1)=Fu/height;
     end
 end
 %   对每一行进行傅里叶逆变换
  for a=0:width-1
     for b=0:height-1
              Fu=0;
         for c=0:width-1
             Fu=Fu+T(b+1,c+1)*exp(imaginary_num*2*pi*c*a/width);
         end
         TT(b+1,a+1)=Fu/width;
     end
  end