R1 = 1e3;
R3 = 1e4;
R2 = 120;
C = 1.5e-9;

sys=tf([0 R2R3C/(R1+R2) 0],[R1R2R3C^2/(R1+R2) 2R1R2C/(R1+R2) 1]);

fb = bandwidth(sys);
[mag, phase, wout] = bode(sys);
[gpeak, fpeak] = getPeakGain(sys);
