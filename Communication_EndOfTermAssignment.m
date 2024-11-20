close all

%% Raised Cosine

Bitrate = 1; % in bits per second, assuming 1 symbol corresponds to 1 bit
T_Pulse = 1/Bitrate; 
SamplingTime = 0.001; % in seconds
SamplingFrequency = 1/SamplingTime;

StartTime = -4;
EndTime = 4;


%https://engineering.purdue.edu/~ee538/SquareRootRaisedCosine.pdf



Time = StartTime:SamplingTime:EndTime-SamplingTime; %to create coherent even numbered array
Frequency = -2/T_Pulse:SamplingTime:2/T_Pulse-SamplingTime;

figure
for r = [0, 0.25, 0.5, 1]
    RaisedCosine_t = (1./T_Pulse).*sinc(Time./T_Pulse).*(cos(pi.*r.*Time./T_Pulse))./(1-(2.*r.*Time./T_Pulse).^2);
    specialcase = find(RaisedCosine_t==Inf);
    RaisedCosine_t(specialcase) = (pi/(4*T_Pulse)) * sinc(1/(2*r));
    plot(Time,RaisedCosine_t,LineWidth=1.5)
    hold on
end
legend('r=0', 'r=0.25', 'r=0.5', 'r=1')
title('Rasied Cosine in Time Domain')
xlabel('Time')

figure
for r = [0, 0.25, 0.5, 1]
    RaisedCosine_f = zeros(1,length(Frequency));
    ConditionIndicies = find(abs(Frequency) > (1-r)/(2*T_Pulse) & abs(Frequency) <= (1+r)/(2*T_Pulse));
    RaisedCosine_f(ConditionIndicies) = 0.5 * (1 + cos((pi*T_Pulse./r).*(abs(Frequency(ConditionIndicies))-(1-r)/(2*T_Pulse))));
    ConditionIndicies = find(abs(Frequency) <= (1-r)/(2*T_Pulse));
    RaisedCosine_f(ConditionIndicies) = 1;
    plot(Frequency,RaisedCosine_f,LineWidth=1.5)
    hold on
end
legend('r=0', 'r=0.25', 'r=0.5', 'r=1')
title('Rasied Cosine in Frequency Domain')
xlabel('Frequency')


%% Line Coding


%BitSequence = [0 1 0 0 1 1 0 1 0 1 1 0 1 1 1 1];
Bitrate = 1;
WaveformSamples = 10;
SamplingFrequency = WaveformSamples*Bitrate;
SequenceLength = 10000;
RandomSequence = rand(1,SequenceLength)>0.5;
Amplitude = 1;

Samples = 0:SequenceLength*WaveformSamples-1;


NRZ=[];
for index=1:length(RandomSequence)
    if  RandomSequence(index)==1
        NRZ = [NRZ [ones(1,WaveformSamples)]*Amplitude];
    elseif RandomSequence(index)==0
        NRZ = [NRZ [ones(1,WaveformSamples)]*0];
    end
end


figure
subplot 211
stairs(Samples,NRZ, LineWidth=1.5)
title('NRZ Encoding')
ylabel('Amplitude')
xlim([1, 80])
subplot 212
pspectrum(NRZ,SamplingFrequency)
title('Power Spectral Density')


Manchester=[];
for index=1:length(RandomSequence)
    if  RandomSequence(index)==1
        Manchester = [Manchester [ones(1,WaveformSamples/2) -1*ones(1,WaveformSamples/2)]*Amplitude];
    elseif RandomSequence(index)==0
        Manchester = [Manchester [-1*ones(1,WaveformSamples/2) ones(1,WaveformSamples/2)]*Amplitude];
    end
end


figure
subplot 211
stairs(Samples,Manchester, LineWidth=1.5)
xlim([1, 80])
title('Manchester Encoding')
ylabel('Amplitude')
subplot 212
pspectrum(Manchester,SamplingFrequency)
title('Power Spectral Density')

AMI=[];
for index=1:length(RandomSequence)
    if RandomSequence(index)==1
        AMI = [AMI [ones(1,WaveformSamples)]*Amplitude];
        Amplitude = -Amplitude; % Invert amplitude for each 1
    elseif RandomSequence(index)==0
        AMI = [AMI [ones(1,WaveformSamples)]*0];
    end
end

figure
subplot(2, 1, 1)
stairs(Samples, AMI, LineWidth=1.5)
xlim([1, 80])
title('AMI Encoding')
ylabel('Amplitude')
subplot(2, 1, 2)
pspectrum(AMI, SamplingFrequency)
% xlabel('Frequency')
% ylabel('Power')
title('Power Spectral Density')


figure
hold on
pspectrum(NRZ,SamplingFrequency)
pspectrum(Manchester,SamplingFrequency)
pspectrum(AMI, SamplingFrequency)
title('Power Spectral Density Comparison')
legend('NRZ', 'Manchester', 'AMI')
%% Unscuccessful (but definitely helpful) Attempts

%UnipolarNRZ = [0 1 0 0 1 1 0 1 0 1 1 0 1 1 1 1];

%figure
%stairs(NRZ,LineWidth=1.5)
%stairs(Manchester,LineWidth=1.5)
%figure
%pspectrum(NRZ,SamplingFrequency)







%plot(Frequency,RaisedCosine_f)
%(pi*T_Pulse./r).*(abs(Frequency)-(1-r)/(2*T_Pulse))
%RaisedCosine_f = 0.5 * (1 + cos((pi*T_Pulse./r).*(abs(Frequency)-(1-r)/(2*T_Pulse))))



% syms f
% RaisedCosine_f = piecewise( abs(f) <= (1-r)/2*T_Pulse, 1, ...
%                             abs(f) > (1-r)/2*T_Pulse & abs(f) <= (1+r)/2*T_Pulse, 0.5.*(1+cos((pi.*T_Pulse./r).*(abs(f)-((1-r)/2.*T_Pulse)))) ...
%                             , 0 )
% 
% fplot(RaisedCosine_f, [-0.5 0.5])

%RaisedCosine_f = fft(RaisedCosine_t,SamplingPoints/2);
%Frequency = SamplingFreq/SamplingPoints*[0:SamplingPoints-1]
%plot(abs(RaisedCosine_f))



% RaisedCosine_f = piecewise(abs(f) < (1-r)./(2.*T_Pulse), 1, 0.5.*(1+cos((pi.*T_Pulse./r).*(abs(f)-((1-r)/2.*T_Pulse)))),)
% (abs(F)) & ()



% 
% SamplePoints = length(t);
% FourierTransform = fft(RaisedCosine)/SamplePoints;
% Frequency = 0:SamplingFrequency/SamplePoints:SamplingFrequency-SamplingFrequency/SamplePoints;
% MeaningfulFrequency = Frequency(1:SamplePoints/2);
% 
% DS_Spectrum = [FourierTransform(2:end) FourierTransform(1) FourierTransform(2:end)];
% DS_Freq = 1-SamplingFrequency:SamplingFrequency-1;
% 
% figure
% plot(DS_Freq,abs(DS_Spectrum))
% xlim([-SamplingFreq/2, SamplingFreq/2])



%RaisedCosine = piecewiseRaisedCosine(t, T_Pulse, r)


%RaisedCosine(abs(T_Pulse/(2*r*0.001))) = (pi/(4*T_Pulse)) * sinc(1/(2*r))




% 
% 
% for t = 0.49:0.001:0.51
%     if t == T_Pulse/(2*r)
%         RaisedCosine(t) = (pi/(4*T_Pulse)) * sinc(1/(2*r));
%         Cond = 1
%     else
%         RaisedCosine(t) = (1/T_Pulse) * sinc(t/T_Pulse) .* (cos(pi*r*t/T_Pulse)) ./ (1 - (2*r*t/T_Pulse).^2);
%     end
% end



% function RaisedCosine = piecewiseRaisedCosine(t, T_Pulse, r)
%     if t == T_Pulse/(2*r)
%         RaisedCosine = (pi/(4*T_Pulse)) * sinc(1/(2*r));
%         Cond = 1
%     else
%         RaisedCosine = (1/T_Pulse) * sinc(t/T_Pulse) .* (cos(pi*r*t/T_Pulse)) ./ (1 - (2*r*t/T_Pulse).^2);
%     end
% end





%RaisedCosine = RaisedCosinePiecewise(0.5)
%RaisedCosine = cos(pi.*r.*t./T_Pulse)./(1-(2.*r.*t./T_Pulse).^2).*sinc(pi.*t./T_Pulse)
%RaisedCosine = (pi/4*T_Pulse)*sinc(1/2r);

%syms t
%pw = piecewise(cond1,val1,cond2,val2,...,otherwiseVal)
%RaisedCosine = piecewise(T_Pulse./2.*r, (pi./4.*T_Pulse).*sinc(1./2.*r), 1)

%RaisedCosine = piecewise(T_Pulse./2.*r,(pi/(4*T_Pulse))*sinc(1/(2*r)),(1./T_Pulse).*sinc(t./T_Pulse).*(cos(pi.*r.*t./T_Pulse))./(1-(2.*r.*t./T_Pulse).^2))

%RaisedCosine = (1./T_Pulse).*sinc(t./T_Pulse).*(cos(pi.*r.*t./T_Pulse))./(1-(2.*r.*t./T_Pulse).^2)


%function RaisedCosine = RaisedCosinePiecewise(t)
%    if t = T_Pulse./2*r
%        RaisedCosine = (pi/(4*T_Pulse))*sinc(1/(2*r));
%    else
%        RaisedCosine = (1./T_Pulse).*sinc(t./T_Pulse).*(cos(pi.*r.*t./T_Pulse))./(1-(2.*r.*t./T_Pulse).^2);
%    end
%end
