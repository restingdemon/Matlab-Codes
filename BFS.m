clc;
close all;
a=[-1,1,1,0;1,1,0,1];
b=[1;2];
c=[1,2,0,0];
[m n]=size(a);
nCm=nchoosek(n,m);
pair=nchoosek(1:n,m);
sol=[];
for i=1:nCm
    y=zeros(n,1);
    B=a(:,pair(i,:));
    
    x=B\b;
    if all(x>=0 & x~=inf &x~=-inf)
        y(pair(i,:))=x;
        sol=[sol y]
    end
end
sol=sol';
for i=1:length(sol)
    obj(i,:)=sum(sol(i,:).*c);
end
[p,loc]=max(obj);
fprintf('the optimal value is %f\n',p);
fprintf('the optimal solution is');
disp(sol(loc,:));
    