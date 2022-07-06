function[dream_lp_out]=dream_lp(img)
    [height,width]=size(img);
   % Y1=fftshift(fft2(double(img)));
    Y1=MyFFT(img);
    Y1=ifftshift(Y1);
   % [img,revertclass]=tofloat(img);
   % [f1,f2]=freqspace([height,width],'meshgrid');
    [x,y]=freqspace([height,width]);
    [f1,f2]=meshgrid(x,y);
    H=ones(height,width);
    %%%%%%%    理想低通滤波器
    D0=0.1;  %%%截止频率
    D=sqrt(f1.^2+f2.^2);
    H(D>D0)=0;
    H(D<D0)=1;
    
    %for i=1:height
    %    for j=1:width
    %       if D(i,j)>D0
    %           H(i,j)=0;
    %       else
    %           H(i,j)=1;
    %       end
    %   end
    %end
   dream_lp_out=Y1.*H;
   %%%%%%%%
   %dream_lp_out=revertclass(dream_lp_out);
%    dream_lp_out=uint8(real(IFTF2(ifftshift(dream_lp_out))));
end
