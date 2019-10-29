%{
This exammple assumes connection:
1+ to V+
1- to GND
This example turns on the power supply and sets it to 1.7V and then reads 
back the value
%}
%% Setup
import clib.libm2k.libm2k.*
m2k = devices.m2kOpen();

%% Calibrate
m2k.calibrateADC();

% Will turn on the power supply if we need smth to measure
ps = m2k.getPowerSupply();
ps.enableChannel(0,true);
ps.pushChannel(0,1.7);

% Setup analog in
ain = m2k.getAnalogIn();
ain.enableChannel(0,true)
disp(ain.getVoltage(0))

devices.deviceCloseAll();

clear m2k