X=double(rgb2gray(imread("666.jpg")));
[m,n]=size(X);
meanv=sum(X)/m;
for i=1:n %centralization
    X(:,i)=X(:,i)-meanv(i);
end
fc=X'*X/(m-1);