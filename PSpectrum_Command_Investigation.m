%clc
clear variables
close all


N = 10;
FFTPoints = 2^N;
SamplingFreq = 20e3;
SamplingTime = 1/SamplingFreq;
EndTime = 1e0;


Time = 0:SamplingTime:EndTime-SamplingTime;
Signal = sawtooth(2*pi*Time*1e3);
%Signal = sawtooth(2*pi*Time*200e3,0.5);
%plot(Time,Signal);

SamplePoints = length(Time);
FourierTransform = fft(Signal)/SamplePoints;
Frequency = 0:SamplingFreq/SamplePoints:SamplingFreq-SamplingFreq/SamplePoints;
MeaningfulFrequency = Frequency(1:SamplePoints/2);
SingleSideBand = [FourierTransform(1) 2*FourierTransform(2:SamplePoints/2)];
%plot(Frequency,abs(FourierTransform))
plot(MeaningfulFrequency,abs(SingleSideBand))
SpectrumPower = pspectrum(Signal);
plot(SpectrumPower)





% hold
% [U, L] = envelope(abs(SingleSideBand));
% plot(MeaningfulFrequency,U)
%t = 0:.0001:.0625;
%y = square(2*pi*30*t);
%plot(t,y)