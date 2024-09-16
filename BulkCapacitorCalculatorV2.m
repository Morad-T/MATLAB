clc
clear
%format longG;

% Input Paramters
LineFrequency = 50; % Hz
NominalAC_In = 230; % Volts RMS
V_Dropout = 20; % Minimum voltage the input capacitor should hold
P_Load = 5; % Watts

Time = 1/LineFrequency; % Seconds

%MaxAC_In = 265; % Volts RMS
%MinAC_In = 85; % Volts RMS
%MaxInputPeakVoltage = sqrt(2)*MaxAC_In; % after rectification assuming no load is present
%MinInputPeakVoltage = sqrt(2)*MinAC_In; % after rectification assuming no load is present

NominalInputPeakVoltage = sqrt(2)*NominalAC_In; % after rectification assuming no load is present
DischargingTime_HalfWaveRectifier = 0.75.*Time+asin(V_Dropout./NominalInputPeakVoltage)./(2*pi*LineFrequency);
DischargingTime_FullWaveRectifier = 0.25.*Time+asin(V_Dropout./NominalInputPeakVoltage)./(2*pi*LineFrequency);

t = 0:0.00001:2*Time;
HalfWaveRectifier = 230*sqrt(2)*sin(2*pi*LineFrequency*t).*((1+square(2*pi*LineFrequency*t))/2);
hold on
plot(t,HalfWaveRectifier)
[PeakVoltage, PeakIndex] = max(HalfWaveRectifier);
PeakTime = t(PeakIndex);
scatter(PeakTime,PeakVoltage,"filled","red")
DropoutIndices = find(abs(HalfWaveRectifier - V_Dropout) <= 0.5);
DropoutTime = t(DropoutIndices(1,3));
scatter(DropoutTime,V_Dropout,"filled","red")
XPoints = [PeakTime DropoutTime];
YPoints = [PeakVoltage V_Dropout];
LinearLine = interp1(XPoints,YPoints,t);
ConnectingLine = max(LinearLine,HalfWaveRectifier);
plot(t,ConnectingLine,"blue")

%FullWaveRectifier = abs(230*sqrt(2)*sin(2*pi*LineFrequency*t));
%plot(t,FullWaveRectifier)

V_Avg = 0.5.*(NominalInputPeakVoltage+V_Dropout);
I_LoadAvg = P_Load./V_Avg; % Amperes
V_Ripple = NominalInputPeakVoltage-V_Dropout;
V_RipplePercent = V_Ripple./NominalInputPeakVoltage
C_Bulk_HalfwaveRectifier = I_LoadAvg.*DischargingTime_HalfWaveRectifier./V_Ripple
C_Bulk_FullwaveRectifier = I_LoadAvg.*DischargingTime_FullWaveRectifier./V_Ripple

%u = symunit;
%C__ = C_Bulk_FullwaveRectifier*u.F
%CT = num2sip(C_Bulk_FullwaveRectifier)

%[PeakVoltage, PeakIndex] = findpeaks(HalfWaveRectifier);
%DropoutTime = interp1(HalfWaveRectifier,t,V_Dropout,"nearest")
%x_index_halfwave = find(HalfWaveRectifier == 20)
%[~, DropoutIndex] = min(abs(HalfWaveRectifier - V_Dropout));
%DropoutTime = t(DropoutIndices(1,3:end));
%plot([PeakTime DropoutTime], [PeakVoltage V_Dropout])
