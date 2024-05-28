F_Sampling = 10;
T_Sampling = 1/F_Sampling;
F_Signal = 1;

t = 0:T_Sampling:1;
sinewave = sin(2*pi*F_Signal*t);
plot(t, sinewave)
hold on
stairs(t, sinewave)