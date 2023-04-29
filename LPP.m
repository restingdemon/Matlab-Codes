clc;
close all;

A=input("Enter coefficient of constraints");
B=input("Enter RHS of constraints");
x1=0:0.1:max(B);
x21=(B(1)-(A(1,1)*x1))/A(1,2);
x22=(B(2)-(A(2,1)*x1))/A(2,2);
x21=max(0,x21);
x22=max(0,x22);
plot(x1,x21,"r",x1,x22,"g");
xlabel("X-axis");
ylabel("Y-axis");
legend("2x1+4x2=8","3x1+5x2=15");
Sol=[];
for i=1:length(A)
    A1=A(i,:);
    B1=B(i);
    for j=i+1:length(A)
        A2=A(j,:);C=input("Enter coefficient of objective function");
        B2=B(j);
        A3=[A1;A2];
        B3=[B1;B2];
        X=A3\B3;
        Sol=[Sol X];
    end
end
Sol

