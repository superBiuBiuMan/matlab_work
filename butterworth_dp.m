%https://blog.csdn.net/qq_20823641/article/details/51854660?utm_source=blogxgwz4
%https://blog.csdn.net/qq_37431083/article/details/105209119
%理想低频滤波
function[butterworth_dp_out]=butterworth_dp(img)
    [M,N]=size(img);
    picf=fftshift(img);
    D0=20;%定义通道半径
    n=5;
    butterworth_dp_out=zeros(M,N);
    for u=1:M
		for v=1:N
			D=sqrt( ( u-(M/2) )^2  + ( v-(N/2) ) ^2 ) ;
			H=1/( 1+  ( (D0/D)^(2*n) )   );
            butterworth_dp_out(u,v)=H*picf(u,v);
		end
    end
end
