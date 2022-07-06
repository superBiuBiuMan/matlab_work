
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear,clc,close all;
I=imread('fft1.png');
figure;imshow(I),title('ԭʼͼ��');
figure;imhist(I);title('�Ҷ�ֱ��ͼ');
% impixel
[m,n]=size(I);               %����ͼ���С
for i=1:m  
    for j=1:n
        if I(i,j)<70
           I(i,j)=255;
       end
    end
end
figure;imshow(I);title('��ȡ�ڱ߽���ͼ��');  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I1=imread('fft1.png');       %��ȡͼ��
I1=rgb2gray(I1);              %ת��Ϊ�Ҷ�ͼ��
%��ͼ�����߽�
[m,n]=size(I1);                   %����ͼ���С
for i=1:m  
    for j=1:n
        if I1(i,j)<70
           I1(i,j)=255;
       end
    end
end
figure;imshow(I1);title('����߽��ͼ��');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����Houhg�任��ԭ����Բ�ĺͰ뾶
% for i=1:m
%     for j=1:n
%         if I1(i,j)>240
%             I1(i,j)=255;
%         else  I1(i,j)=0;
%         end
%     end
% end
% J=edge(I1,'roberts');
%���Բ�ĺͰ뾶�ֱ�Ϊ��104,96��88
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����Բ��ȡ����Ĥ����
for i=1:m
    for j=1:n
        if (i-104)*(i-104)+(j-96)*(j-96)>88*88
            I1(i,j)=255;
        end 
    end
end
figure;imshow(I1);title('ɾ��Բ�����ͼ��');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����ȡ���ͼ���������С���ֽ⡣����ʡ���˹�һ�����衣
%��������С���ֽ�
[c,s]=wavedec2(I1,3,'sym4');
%��ȡ�ֽ��ĵ�Ƶϵ��
A1=appcoef2(c,s,'sym4',1);
A2=appcoef2(c,s,'sym4',2);
A3=appcoef2(c,s,'sym4',3);
%��ȡ�ֽ���һ��ĸ�Ƶϵ��
H1=detcoef2('h',c,s,1);
V1=detcoef2('v',c,s,1);
D1=detcoef2('d',c,s,1);
%��ȡ�ֽ��ڶ���ĸ�Ƶϵ��
H2=detcoef2('h',c,s,2);
V2=detcoef2('v',c,s,2);
D2=detcoef2('d',c,s,2);
%��ȡ�ֽ�������ĸ�Ƶϵ��
H3=detcoef2('h',c,s,3);
V3=detcoef2('v',c,s,3);
D3=detcoef2('d',c,s,3);
%�ϲ���ʾ���ֽ���ϵ��
%�Ե������ϵ�����кϲ���ʾ
W1=[A3,H3
    V3,D3];
figure;imshow(W1,[]);title('�ֽ�������ϵ��');
%���ݵ������ϵ���Եڶ�����кϲ���ʾ
W1=imresize(W1,[55 53]); %�����ϲ����ͼ���С
W2=[W1,H2
    V2,D2];
figure;imshow(W2);title('�ֽ�ڶ����ϵ��');
%���ݵڶ���ĺϲ�ϵ�����е�һ������ݺϲ���ʾ
W2=imresize(W2,[103 100]);%�����ڶ�������ݴ�С
W=[W2,H1
   V1,D1];
figure;imshow(W);title('С���ֽ��ÿ�������');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���������ֵ�ĸ���

A3=floor(A3);   %�����ݵ���Ϊ����
[m n]=size(A3); %����A3�Ĵ�С
%�����ֵ
[m1,i]=max(A3);             
[m2,j]=max(m1); %m2�����ֵ
%����Сֵ 
[m3,i]=min(A3);
[m4,j]=min(m3);%m4����Сֵ
%����һ����洢������ֵ�ĸ���
for x=1:m2-m4+1
    a(x)=0;
end
%�������ֵ�ĸ���
[m n]=size(A3);
 for i=1:m
    for j=1:n
       a(A3(i,j)-m4+1)=a(A3(i,j)-m4+1)+1;
    end
 end
%ȥ��������ĵ�
t=1;
for x=1:m2-m4+1
    if a(x)~=0
        b(t)=a(x);
        t=t+1;
    end
end
%��������صĸ���
for x=1:t-1
     b(x)=b(x)/(m*n)
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�û������������������ظ��ʱ���
b=fliplr(sort(b));%����������
T=b;             
[m,n]=size(b);
B=zeros(n,n-1);%�յı��������
 for i=1:n
    B(i,1)=T(i);%���ɱ����ĵ�һ��
 end
 r=B(i,1)+B(i-1,1);%�������Ԫ�����
 T(n-1)=r;
 T(n)=0;
 T=fliplr(sort(T));
 t=n-1;
 for j=2:n-1%���ɱ�������������
    for i=1:t
        B(i,j)=T(i);
    end
        K=find(T==r);
        B(n,j)=K(end);%�ӵڶ��п�ʼ��ÿ�е����һ��Ԫ�ؼ�¼����Ԫ���ڸ��е�λ��
        r=(B(t-1,j)+B(t,j));%�������Ԫ�����
        T(t-1)=r;            %����ߵ�ֵ���ں���
        T(t)=0;          %�����һ�������
        T=fliplr(sort(T));  %���½��н�������
        t=t-1;
 end
END1=sym('[0,1]');%�����һ�е�Ԫ�ر���
END=END1;
t=3;
d=1;
for j=n-2:-1:1  %�ӵ����ڶ��п�ʼ���ζԸ���Ԫ�ر���
    for i=1:t-2
        if i>1 & B(i,j)==B(i-1,j)
            d=d+1;
        else
            d=1;
        end
        B(B(n,j+1),j+1)=-1;
        temp=B(:,j+1);

        x=find(temp==B(i,j));
        END(i)=END1(x(d));
    end
    y=B(n,j+1);
    END(t-1)=[char(END1(y)),'0'];%�����к�С�ĸ�������0
    END(t)=[char(END1(y)),'1'];  %�����к�С�ĸ�������1
    t=t+1;
    END1=END;
end
END %��ʾ������










