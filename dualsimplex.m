clc
clear
C=[-3; -5];
isMin=1;
A=[-1 -3; -1 -1];
B=[-3; -2];
n=size(A, 1);
temp1=eye(n);
d=zeros(1, n+1);

t=[C' d];
mat=[A(:, :) temp1(:, :) B(:, :)];
bv=size(A, 2)+1:size(mat, 2)-1;

ZjCj=t(bv)*mat-t;

%Apply dual simplex
while true
  if mat(:, end)>=0
    break
  end

  leavingVar=find(mat(:, end)==min(mat(:, end)));

  enteringVar=ZjCj./mat(leavingVar, :);
  enteringVar=enteringVar(1:end-1);
  enteringVar(find(enteringVar>=0))=-inf;
  enteringVar=find(enteringVar==max(enteringVar));

  bv(leavingVar)=enteringVar;

  k=mat(leavingVar, enteringVar);
  mat(leavingVar, :)=mat(leavingVar, :)/k;
  for i=1:size(mat, 1)
    if i~=leavingVar
      mat(i, :)=mat(i, :) - mat(i, enteringVar)*mat(leavingVar, :);
    end
  end
  ZjCj=ZjCj-ZjCj(enteringVar)*mat(leavingVar, :);

end
soln=zeros(1, size(mat, 2)-1);
soln(bv)=mat(:, end);

t=t(1:end-1);
Z=soln*t';
if isMin==1
  Z=Z*-1;
end

finalTable=[soln(:, :) Z]
table1=array2table(finalTable);
table1.Properties.VariableNames(1:size(finalTable, 2))={'x1', 'x2', 's1', 's2', 'min(Z)'}