clc
close all
clear variables

%BinArray = [0 1 0 1 1 0 0 1 0 1 1 0 0 1 0 1 0 1 1 0 0 0 0 1 ...
%            0 1 1 1 0 0 1 0 0 0 1 0 0 0 0 0 0 0 1 1 0 0 1 1 ...
%            0 0 1 0 0 0 0 0 0 1 0 0 0 0 1 1 0 1 1 0 1 1 1 1 ...
%            0 1 1 0 1 1 0 1 0 1 1 0 1 1 0 1];

BinArray = [0 1 0 0 0 1 0 1 0 1 0 0 0 0 1 1 0 1 0 0 0 1 0 1 0 0 1 0 0 0 0 0 0 1 0 0 0 1 0 0 0 1 1 0 0 1 0 1 0 1 1 1 0 0 0 0 0 1 1 0 0 0 0 1 0 1 1 1 0 0 1 0 0 1 1 1 0 1 0 0 0 1 1 0 1 1 0 1 0 1 1 0 0 1 0 1 0 1 1 0 1 1 1 0 0 1 1 1 0 1 0 0];  
TimeArray = 0:length(BinArray)-1;

SampleMultiplier = 10;

HSBinArray = 0:length(BinArray)*SampleMultiplier-1;
for X = 1:length(BinArray)
    for N = 1:SampleMultiplier 
        %Index = X*10-9+N;
        HSBinArray(X*SampleMultiplier-SampleMultiplier+N) = BinArray(X);
    end
end

%figure
subplot 211
stairs(BinArray, LineWidth=1)
ylim([-1, 2])
grid
xticks(0:8:112)
set(gca, "FontSize", 16)

%figure
subplot 212
NoisySignal = HSBinArray + 0.25*randn(size(HSBinArray));
plot(NoisySignal, LineWidth=1)
ylim([-1, 2])
grid
xticks(0:80:1120)
%xticklabels([0 8 16 24 32 40 48 56 64 72 80 88])
%xt = get(gca, 'XTick');
set(gca, 'XTickLabel', get(gca, 'XTick')/10)
set(gca, "FontSize", 16)