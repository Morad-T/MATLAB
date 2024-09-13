clc
clear
%format longG;

% Input Paramters
LineFrequency = 50; % Hz
NominalAC_In = [85, 265]; % Volts RMS
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


V_Avg = 0.5.*(NominalInputPeakVoltage+V_Dropout);
I_LoadAvg = P_Load./V_Avg; % Amperes
V_Ripple = NominalInputPeakVoltage-V_Dropout;
V_RipplePercent = V_Ripple./NominalInputPeakVoltage
C_Bulk_HalfwaveRectifier = I_LoadAvg.*DischargingTime_HalfWaveRectifier./V_Ripple
C_Bulk_FullwaveRectifier = I_LoadAvg.*DischargingTime_FullWaveRectifier./V_Ripple

%u = symunit;
%C__ = C_Bulk_FullwaveRectifier*u.F

%CT = num2sip(C_Bulk_FullwaveRectifier)