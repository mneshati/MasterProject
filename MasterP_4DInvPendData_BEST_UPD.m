clear
clc
close all
%-----------------------------
% system matrices:
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
%-----------------------------
[row,dim]=size(A);
neiNo=(3^dim)-1;
Lstart=0.4;   % L= Length (position)
Vstart=2;     % V= Velocity (speed)
Astart=pi;    % A= Angle
Wstart=10*pi; % W= Angular Velocity
SVstepRate=8;  % SV= state variable
axisLength=(SVstepRate*2)+1;
Ustart=2;      % U= actuating variable (Input=Speed)
UstepRate=4;
%-----------------------------
dl=(Lstart/SVstepRate); %discretized steps on the l vector 
dv=(Vstart/SVstepRate); %discretized steps on the v vector
da=(Astart/SVstepRate); %discretized steps on the a vector
dw=(Wstart/SVstepRate); %discretized steps on the w vector
CL=1; %dataclass coordinat initial value of L 
CV=1; %dataclass coordinat initial value of V 
CA=1; %dataclass coordinat initial value of A 
CW=1; %dataclass coordinat initial value of W 
Uc=1; %actuting variable counter(tells which input has been applied)
%-----------------------------
for L0=(-Lstart):(Lstart/SVstepRate):(Lstart) 
    for V0=(-Vstart):(Vstart/SVstepRate):(Vstart) 
        for A0=(-Astart):(Astart/SVstepRate):(Astart)
            for W0=(-Wstart):(Wstart/SVstepRate):(Wstart)
                
                SV0=[L0 ; V0 ; A0 ; W0];
                %FullData(CL,CV,CA,CW).CurrPoint=SV0; 
                %CurrPoint=[];DisToNei=[];
                NeiCartesian=[    L0   L0+dl  L0+dl  L0+dl   L0   L0-dl  L0-dl  L0-dl   L0     L0    L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl   L0-dl   L0      L0    L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl   L0-dl   L0     L0    L0+dl   L0+dl  L0+dl    L0    L0-dl  L0-dl  L0-dl    L0       L0    L0+dl   L0+dl   L0+dl    L0     L0-dl   L0-dl   L0-dl    L0      L0    L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl   L0     L0    L0+dl   L0+dl  L0+dl    L0    L0-dl  L0-dl  L0-dl    L0       L0    L0+dl   L0+dl   L0+dl    L0     L0-dl   L0-dl   L0-dl    L0      L0    L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl;
                                V0+dv  V0+dv    V0   V0-dv V0-dv  V0-dv   V0   V0+dv    V0    V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0    V0+dv   V0     V0+dv  V0+dv   V0    V0-dv  V0-dv  V0-dv    V0    V0+dv   V0    V0+dv  V0+dv    V0    V0-dv  V0-dv   V0-dv    V0   V0+dv    V0     V0+dv   V0+dv     V0    V0-dv   V0-dv   V0-dv    V0     V0+dv    V0     V0+dv  V0+dv   V0    V0-dv  V0-dv  V0-dv   V0    V0+dv   V0    V0+dv  V0+dv    V0    V0-dv  V0-dv   V0-dv    V0   V0+dv    V0     V0+dv   V0+dv     V0    V0-dv   V0-dv   V0-dv    V0     V0+dv    V0     V0+dv  V0+dv   V0    V0-dv  V0-dv  V0-dv   V0    V0+dv;
                                  A0    A0      A0    A0     A0    A0     A0     A0    A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da   A0+da  A0-da   A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da   A0-da   A0     A0     A0      A0     A0      A0      A0     A0    A0     A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0-da   A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da   A0     A0     A0      A0     A0      A0      A0     A0    A0     A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0-da   A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da;
                                  W0    W0      W0    W0     W0    W0     W0     W0     W0     W0      W0     W0     W0     W0    W0      W0      W0    W0       W0    W0     W0      W0     W0     W0     W0      W0   W0+dw  W0+dw  W0+dw   W0+dw  W0+dw  W0+dw   W0+dw  W0+dw  W0+dw   W0+dw   W0+dw   W0+dw   W0+dw   W0+dw   W0+dw   W0+dw   W0+dw   W0+dw   W0+dw   W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0-dw  W0-dw  W0-dw   W0-dw  W0-dw  W0-dw   W0-dw  W0-dw  W0-dw   W0-dw   W0-dw   W0-dw   W0-dw   W0-dw   W0-dw   W0-dw   W0-dw   W0-dw   W0-dw   W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw ];       
                for U=-Ustart:(Ustart/UstepRate):Ustart 
                    SV=[L0 ; V0 ; A0 ; W0]; 
                    for Kc=1:1:K*T  
                        SV=(Ad*SV)+(Bd*U); 
                    end
                    for i=1:neiNo
                        DistanceTo=sqrt(((abs(SV(1,1)-NeiCartesian(1,i)))^2)+((abs(SV(2,1)-NeiCartesian(2,i)))^2)+((abs(SV(3,1)-NeiCartesian(3,i)))^2)+((abs(SV(4,1)-NeiCartesian(4,i)))^2)); %distance (transition quality) to neighbour(i) 
                        FullData(CL,CV,CA,CW).DisToNei(i,Uc)=DistanceTo;%save each distance(quality)for the specific U 
                    end
                    Uc=Uc+1;
                end
                Uc=1;
                CW=CW+1;
            end
            CW=1;
            CA=CA+1;
        end
        CA=1;
        CV=CV+1
    end
    CV=1;
    CL=CL+1
end
%{
for i=1:axisLength
    for j=1:axisLength
        for k=1:axisLength
            for m=1:axisLength
                for n=1:axisLength
                    for o=1:axisLength
                        for p=1:axisLength
                            for q=1:axisLength
                                DijFullData(i,j,k,m).Q(n,o,p,q)=inf;
                                DijFullData(i,j,k,m).U(n,o,p,q)=inf;
                            end
                        end
                    end
                end 
            end
        end
    end
end

for CL0=1:axisLength
    for CV0=1:axisLength
        for CA0=1:axisLength
            for CW0=1:axisLength
                NeiDataClassCo=[ CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1  CL0-1    CL0    CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1   CL0-1   CL0     CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1   CL0-1   CL0     CL0   CL0+1   CL0+1  CL0+1   CL0    CL0-1  CL0-1  CL0-1    CL0     CL0    CL0+1   CL0+1   CL0+1    CL0    CL0-1   CL0-1   CL0-1    CL0     CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1  CL0-1   CL0    CL0   CL0+1   CL0+1  CL0+1   CL0    CL0-1  CL0-1  CL0-1    CL0     CL0    CL0+1   CL0+1   CL0+1    CL0    CL0-1   CL0-1   CL0-1    CL0     CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1  CL0-1;
                                CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0   CV0+1    CV0   CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0    CV0+1   CV0    CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0    CV0+1   CV0    CV0+1  CV0+1    CV0   CV0-1  CV0-1   CV0-1   CV0   CV0+1    CV0    CV0+1   CV0+1    CV0    CV0-1   CV0-1   CV0-1    CV0    CV0+1    CV0    CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0   CV0+1   CV0   CV0+1  CV0+1    CV0   CV0-1  CV0-1   CV0-1   CV0   CV0+1    CV0    CV0+1   CV0+1    CV0    CV0-1   CV0-1   CV0-1    CV0    CV0+1    CV0    CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0   CV0+1;
                                 CA0    CA0    CA0    CA0    CA0    CA0    CA0    CA0    CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1   CA0+1  CA0-1   CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1   CA0-1   CA0     CA0    CA0     CA0    CA0    CA0     CA0    CA0    CA0    CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0-1   CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1   CA0    CA0    CA0     CA0    CA0    CA0     CA0    CA0    CA0    CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0-1   CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1;
                                 CW0    CW0    CW0    CW0    CW0    CW0    CW0    CW0     CW0    CW0    CW0    CW0    CW0    CW0    CW0    CW0     CW0    CW0     CW0    CW0    CW0    CW0    CW0    CW0    CW0     CW0   CW0+1   CW0+1  CW0+1   CW0+1  CW0+1  CW0+1   CW0+1  CW0+1  CW0+1   CW0+1   CW0+1   CW0+1   CW0+1   CW0+1   CW0+1   CW0+1   CW0+1   CW0+1   CW0+1   CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0-1  CW0-1  CW0-1   CW0-1  CW0-1  CW0-1   CW0-1  CW0-1  CW0-1   CW0-1   CW0-1   CW0-1   CW0-1   CW0-1   CW0-1   CW0-1   CW0-1   CW0-1   CW0-1   CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1 ];       
                for i=1:neiNo
                    CL=NeiDataClassCo(1,i);
                    CV=NeiDataClassCo(2,i);
                    CA=NeiDataClassCo(3,i);
                    CW=NeiDataClassCo(4,i);
                    if (CL>0 & CV>0 & CA>0 & CW>0 & CL<(axisLength+1) & CV<(axisLength+1) & CA<(axisLength+1) & CW<(axisLength+1))
                        [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0,CA0,CW0).DisToNei(i,:));
                        DijFullData(CL0,CV0,CA0,CW0).Q(CL,CV,CA,CW)=MinDis;
                        TempF=FindU(InputIndCausedMinDis);
                        DijFullData(CL0,CV0,CA0,CW0).U(CL,CV,CA,CW)=TempF;
                    end
                end
            end
        end
    end
    CL0
end
disp ' 4D Data BEST '
%}

    