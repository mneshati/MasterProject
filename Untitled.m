clc
clear
T=0.0001; %T=0.001 sampling time 
K=10000000; %K=100000 (K*sampling time) is the time that results are read 
g = 9.81; %gravity acceleration(m/s^2)
l = 0.5 ; %length of pendulum(m)
b = 0.02; %m
kP = 1; %model of motor behaviour: PT1(m/s)
tau = 0.0395; %model of motor behaviour: PT1(s)
c = 6/(7*l + (b^2)/l);
A = [   0           1       0       0 
        0         -1/tau    0       0
        0           0       0       1
        0         c/tau    c*g      0   ];
B = [   0
      kP/tau
        0
     -c*kP/tau  ];
 C = [   1   0   0   0   ];
[Ad,Bd]=c2d(A,B,T); %discretized system
Cd = C; 

funkygenerator(T, K, A, B, C, [-0.4 (0.4/8) 0.4], [-2 2/8 2], [-pi pi/8 pi], [-10*pi 10*pi/8 10*pi] )
