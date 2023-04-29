%input 
clc;
close all;
variables={'x1','x2','x3','s1','s2','Sol'};
cost=[-2 0 -1 0 0 0];
info=[-1 -1 1;-1 2 -4];
b=[-5;-8];
%creating identity for slack variables
s=eye(size(info,1));
%making combined matrix
A=[info s b];
[m n]=size(info);
%finding basic variable column number
bv=n+1:n+m;
%calculating zj-cj row
zjcj=cost(bv)*A-cost;
%attaching zj0cj row to combined matrix
zcj=[zjcj;A];
%creating simplex table
simptable=array2table(zcj);
simptable.Properties.VariableNames(1:size(zcj,2))=variables;
flag=true;
while flag
    sol=A(:,end);

    if any(sol<0)
        fprintf("Current bfs is not feasible");
%finding leaving variable
        [leavingVar,pvt_row]=min(sol)

% finding entering variable
        row=A(pvt_row,1:end-1);
        Zj=zjcj(:,1:end-1);

        for i=1:size(row,2)
            if row(i)<0
                ratio(i)=abs(Zj(i)./row(i));
            else
                ratio(i)=inf;
            end 
        end

        [minval,pvt_col]=min(ratio)

%update the bv
        bv(pvt_row)=pvt_col;

%dividing pvt_row by pvt_key
        pvt_key=A(pvt_row,pvt_col);
        A(pvt_row,:)=A(pvt_row,:)./pvt_key;

%updating other rows 
        for i=1:size(A,1)
            if i~=pvt_row
                A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:);
            end
        end     

%updating zj-cj
        zjcj=cost(bv)*A-cost

        zcj=[zjcj;A]
%creating simplex table again
        simptable=array2table(zcj);
        simptable.Properties.VariableNames(1:size(zcj,2))=variables;

        else
            flag=false;
            fprintf("Current bfs is feasible");
    end
end

