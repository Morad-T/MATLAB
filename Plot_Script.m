R = 100;
Current = 0:10:100;
Power = Current.^2 * R:0.1:1;
plot(Current,Power); xlabel('Current [mA]'); ylabel('Power [W]'); text(50,0.5,'\leftarrow Current @ 500mW = 50mA','FontSize',12);