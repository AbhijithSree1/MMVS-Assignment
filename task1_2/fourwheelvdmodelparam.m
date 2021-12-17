clc
clear
load('delta1')
clear vd
m=1700;
lf=1.5;
lr=1.5;
J=(0.5*(lf+lr))^2*m;
Jx=800;
hs=0.5;
K=42000;
Cr=5800;
C=1.5;
B=18;
D=2000;
g=9.81;
Cy=95000; %assuming lateral force to be linear
C_A=0.5;