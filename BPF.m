close all
clear variables

F0 = 40e3;
BW = 10e3;
Q = F0/BW;
Gain = 1;
C3 = 1e-9;
C4 = C3;
k = 2*pi*F0*C3;
R1 = 1/(Gain*k)
R2 = 1/((2*Q-Gain)*k)
R5 = (2*Q)/k

Num = [-1/(R1*C4), 0];
Den = [1, (C3 + C4)/(C3*C4*R5), 1/(C3*C4*R5)*(1/R1 + 1/R2)];

%a1 = 250732;
Omeag0 = 2*pi*40000;
H0 = -1



%Num = [-H0*Omeag0/Q, 0];
%Den = [1, Omeag0/Q, Omeag0^2]


TFunction = tf(Num,Den)
%[Gm,Pm,Wcg,Wcp] = 
margin(TFunction)
%mag = abs(TFunction)
%plot(mag)
%bode(TFunction)