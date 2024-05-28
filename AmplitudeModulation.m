% By Morad T. (IAET)
% Morad.TFarouk@gmail.com

clc
close all
clear variables


SignalFreq = 10; % 1 to 20 Hz for easy visualization
CarrierFreq = 10*SignalFreq; %Carrier is kept at 10 times the basbeband to allow large BW margin
SamplingFreq = 20*CarrierFreq; %Sampling is 20 times the Carrier to keep high resolution
SamplingTime = 1/SamplingFreq; 

%Signal Amplitudes:

DC_Offset = 2;
Baseband_Signal_Amplitude = 1;
Carrier_Amplitude = 1;


Time = 0:SamplingTime:1-SamplingTime; %Time Vector
Baseband_Signal = DC_Offset + Baseband_Signal_Amplitude*cos(2*pi*SignalFreq*Time); %Modulation or Modulating Signal
Carrier = Carrier_Amplitude*cos(2*pi*CarrierFreq*Time);
%Carrier = 1
AM_Signal = Baseband_Signal.*Carrier;

%Paramters:

Modulation_Index = Baseband_Signal_Amplitude/DC_Offset;
Baseband_Signal_Power = bandpower(Baseband_Signal - DC_Offset);
AM_Signal_Power = bandpower(Baseband_Signal);


%figure()
%subplot(12,1,[1 2 3 4]);
subplot 211
plot(Time, AM_Signal, LineWidth=1)
xlim([0, 0.5])
title("Time Domain", ...
    ['Signal Frequency = ', num2str(SignalFreq), ' Hz', '     ', ...
    'Carrier Frequency = ', num2str(CarrierFreq), ' Hz','     ', ...
    'Modulation Index (\mu) = ', num2str(Modulation_Index)])
xlabel("Time (sec.)")
ylabel("S_A_M(t)")
grid
hold on
[UpperEnvelope, LowerEnvelope] = envelope(AM_Signal);
plot(Time, UpperEnvelope)
%plot(Time, LowerEnvelope)


FourierTransform = fft(AM_Signal)/length(Time);
DS_Spectrum = [FourierTransform(2:end) FourierTransform(1) FourierTransform(2:end)];
DS_Freq = 1-SamplingFreq:SamplingFreq-1;


%plot(DS_Freq,abs(DS_Spectrum))
%xlim([-SamplingFreq/2, SamplingFreq/2])

SS_Spectrum = [FourierTransform(1) 2*FourierTransform(2:end)];
SS_Freq = 0:SamplingFreq-1;

%subplot(12,1,[7 8 9 10]);
subplot 212
plot(SS_Freq,abs(SS_Spectrum))
xlim([0, SamplingFreq/2])
title("Frequency Domain", ...
    ['Baseband Power = ', num2str(Baseband_Signal_Power), '     ', ...
    'Carrier Power = ', num2str(DC_Offset^2), '     ', ...
    'Total Power = ' num2str(AM_Signal_Power), '     ', ...
    'Efficiency (\eta) = ', num2str(Baseband_Signal_Power/AM_Signal_Power)])
xlabel("Frequency (Hz)")
ylabel("S_A_M(F)")


%Name = subplot(12,1,12);
%text(0,0,"By Morad Tamer (IAET) Morad.TFarouk@gmail.com")
%set(Name, 'Visible', 'off')
%title("Morad")
