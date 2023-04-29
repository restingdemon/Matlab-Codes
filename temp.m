clc;
clear all;
variables={};
cost=[];
info=[];
b=[];
[m, n]=size(info);
s=eye(m);
A=[info s b];
bv=n+1:n+m;
zjcj=cost(bv)*A-cost;
zcj=[zjcj;A];
simptable=array2table(zcj);
simptable.Properties.VariableNames(size(zcj,2))=variables;
flag=true;
while flag
    if any(zjcj<0)
        fprintf("Not optimal solution");
        [enter_value, pvt_col]=min(zjcj(1,1:end-1));
    sol=A(:,end);
    column=A(:,pvt_col);
    for i=1:m
        if column(i)>0
            ratio(i)=sol(i)./column(i);
        else
            ratio(i)=inf;
        end
    end
    [leaving_value,pvt_row]=min(ratio);
    bv(pvt_row)=pvt_col;
    
    else 
        flag=false;
        fprintf("Optimal solution");
    end
end
