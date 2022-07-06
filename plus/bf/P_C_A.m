function coeff=P_C_A(X,k)
[m,n]=size(X);
meanv=sum(X)/m;
for i=1:n %centralization
    X(:,i)=X(:,i)-meanv(i);
end
S=X'*X/(m-1);
[V,D]=eig(S);
[d,idx]=sort(diag(D));
d=d(end:-1:1);
idx=idx(end:-1:1);
v=V(:,idx);
if sum(v.*v,1)
    k_eig_vector=v(:,1:k);
end
coeff=X*k_eig_vector;


