clc;
close all ;

c=[2,5,3];
a=[2,-7,4; 3,4,-5;7 ,-8, 9];
b=[5;8; 10];


ineq=[0 1 0];



s=eye(size(a,1));
index=find(ineq==1);
s(index,:)=-s(index,:);



objfunc=array2table(c);
objfunc.Properties.VariableNames(1:size(c,2))={'X1','X2','X3'};

sol=[a s b];
table=array2table(sol);
table.Properties.VariableNames(1:size(sol,2))={'X1','X2','X3','S1','S2','S3','XB'};

disp(objfunc);
disp(table);