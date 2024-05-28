clc
close all
clear variables

BinaryData = [0 1 1 0 1 1 1 1 0 1 1 0 0 0 1]
Time = 0:length(BinaryData)-1
Clock = square(2*pi*Time)

plot(Clock)