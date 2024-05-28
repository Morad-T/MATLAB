clc; clear all; close all;

T0 = 4;
T_Sin = 8;
f0 = 1/T0;
Omega0 = (2*pi)/T0;

time = -8:0.001:8;
f_sin = 10*sin((2*pi*time)/T_Sin);
Original_Signal = 10*abs(sin((pi*time)/4));
figure; subplot(6,2,[1,2]);
plot(time,Original_Signal); title('Original Signal');
K = 0:1:8;
%A = (10./(pi+2*pi.*K)) + (10./(pi-2*pi.*K))
A_K = (20./(pi-4*pi.*K.^2));

DC_Term = A_K(0+1).*ones(size(time));
Harmonic1 = A_K(1+1).*cos((Omega0*time.*K(1+1)));
Harmonic2 = A_K(2+1).*cos((Omega0*time.*K(2+1)));
Harmonic3 = A_K(3+1).*cos((Omega0*time.*K(3+1)));
Harmonic4 = A_K(4+1).*cos((Omega0*time.*K(4+1)));
%Harmonic5 = A_K(5+1).*cos((Omega0*time.*K(5+1)));

subplot(6,2,3);  plot(time,DC_Term); title('DC Component');
subplot(6,2,4);  plot(time,DC_Term); title('DC Component Only');
subplot(6,2,5);  plot(time,Harmonic1); title('1^{st} Harmonic');
subplot(6,2,6);  plot(time,DC_Term + 2*(Harmonic1)); title('DC + 1^{st} Harmonic');
subplot(6,2,7);  plot(time,Harmonic2); title('2^{nd} Harmonic');
subplot(6,2,8);  plot(time,DC_Term + 2*(Harmonic1 + Harmonic2)); title('DC + 1^{st} + 2^{nd} Harmonics');
subplot(6,2,9);  plot(time,Harmonic3); title('3^{rd} Harmonic');
subplot(6,2,10); plot(time,DC_Term + 2*(Harmonic1 + Harmonic2 + Harmonic3)); title('DC + 1^{st} + 2^{nd} + 3^{rd} Harmonics');
subplot(6,2,11); plot(time,Harmonic4); title('4^{th} Harmonic');
subplot(6,2,12); plot(time,DC_Term + 2*(Harmonic1 + Harmonic2 + Harmonic3 + Harmonic4)); title('DC + 1^{st} + 2^{nd} + 3^{rd} + 4^{th} Harmonics');

figure;
%subplot(7,2,[13,14]); 
hold on; plot(time,Original_Signal); plot(time,DC_Term + 2*(Harmonic1 + Harmonic2 + Harmonic3));
legend('Original Signal', 'Fourier Constructed Signal', 'Location', 'Southwest');