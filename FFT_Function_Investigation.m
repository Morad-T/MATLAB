clc
close all
clear variables

time = 0:0.001:1-0.001;
Fs = 1/0.001;
signal = cos(2*pi*time*100).*cos(2*pi*time*10);
%plot(time, signal);

DSspectra = fft(signal)./length(time);
spectra = 2.*DSspectra(1:length(DSspectra)/2);
DSfreq = Fs*(0:length(DSspectra)-1)/length(time)
freq = Fs*(0:length(spectra)-1)/length(time)



%plot(abs(spectra));
subplot 211
plot(DSfreq,abs(DSspectra));
%Freq = 
subplot 212
plot(freq,abs(spectra));