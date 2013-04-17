clear
clc
close all
%-----------------------------
% L= length (position)
% V= Velocity (speed)
% A= Angle
% W= Angular Velocity
% U= actuating variable (input)
% SV= state variable
% c as a suffix= counter
%-----------------------------
Urange=40;
Ustep=10;
%-----------------------------
m=10; %m=10 mass of the moving particle  
T=0.0001; %T=0.001 sampling time 
K=10000000; %K=100000 (K*sampling time) is the time that results are read 
dl=1; %discretized steps on the l vector 
dv=1; %discretized steps on the v vector
da=1; %discretized steps on the a vector
dw=1; %discretized steps on the w vector
CL=1; %dataclass coordinat initial value of L 
CV=1; %dataclass coordinat initial value of V 
CA=1; %dataclass coordinat initial value of A 
CW=1; %dataclass coordinat initial value of W 
Uc=1; %actuting variable counter(tells which input has been applied)
%we have 10 actuating variables -200:50:200
TempA=[]; %auxiliary variable to calculate distances (quality)
TempB=[]; %auxiliary variable to calculate distances (quality)
TempC=[]; %auxiliary variable to calculate distances (quality)
TempD=[]; %auxiliary variable to calculate distances (quality)
%-----------------------------
% system matrices:
g = 9.81; %gravity acceleration(m/s^2)
l = 0.5 ; %length of pendulum(m)
b = 0.02; %m
kP = 1; %model of motor behaviour: PT1(m/s)
T1 = 0.0395; %model of motor behaviour: PT1(s)
c = 6/(7*l + (b^2)/l);
A = [   0           1       0       0 
        0         -1/T1     0       0
        0           0       0       1
        0         c/T1     g*c      0   ];
B = [   0
      kP/T1
        0
     -c*kP/T1  ];
 C = [   1   0   0   0   ];
[Ad,Bd]=c2d(A,B,T); %discretized system
Cd = C; 
%-----------------------------
for L0=-4:1:4 %loop for going to each single discretized point on the L axis
    for V0=-8:2:8 %loop for going to each single discretized point on the V axis
        for A0=(-pi):(pi/4):(pi)
            for W0=(-2*pi):(pi/2):(2*pi)

                SV0=[L0 ; V0 ; A0 ; W0];%initial state variable
                FullData(CL,CV,CA,CW).CurrPoint=SV0; 
                %current point saved in Discrete Points dataclass
                %CurrPoint=[];DisToNei=[];
                NeiCartesian=[    L0   L0+dl  L0+dl  L0+dl   L0   L0-dl  L0-dl  L0-dl   L0     L0    L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl   L0-dl   L0      L0    L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl   L0-dl   L0     L0    L0+dl   L0+dl  L0+dl    L0    L0-dl  L0-dl  L0-dl    L0       L0    L0+dl   L0+dl   L0+dl    L0     L0-dl   L0-dl   L0-dl    L0      L0    L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl   L0     L0    L0+dl   L0+dl  L0+dl    L0    L0-dl  L0-dl  L0-dl    L0       L0    L0+dl   L0+dl   L0+dl    L0     L0-dl   L0-dl   L0-dl    L0      L0    L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl;
                                V0+dv  V0+dv    V0   V0-dv V0-dv  V0-dv   V0   V0+dv    V0    V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0    V0+dv   V0     V0+dv  V0+dv   V0    V0-dv  V0-dv  V0-dv    V0    V0+dv   V0    V0+dv  V0+dv    V0    V0-dv  V0-dv   V0-dv    V0   V0+dv    V0     V0+dv   V0+dv     V0    V0-dv   V0-dv   V0-dv    V0     V0+dv    V0     V0+dv  V0+dv   V0    V0-dv  V0-dv  V0-dv   V0    V0+dv   V0    V0+dv  V0+dv    V0    V0-dv  V0-dv   V0-dv    V0   V0+dv    V0     V0+dv   V0+dv     V0    V0-dv   V0-dv   V0-dv    V0     V0+dv    V0     V0+dv  V0+dv   V0    V0-dv  V0-dv  V0-dv   V0    V0+dv;
                                  A0    A0      A0    A0     A0    A0     A0     A0    A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da   A0+da  A0-da   A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da   A0-da   A0     A0     A0      A0     A0      A0      A0     A0    A0     A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0-da   A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da   A0     A0     A0      A0     A0      A0      A0     A0    A0     A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0+da   A0-da   A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da;
                                  W0    W0      W0    W0     W0    W0     W0     W0     W0     W0      W0     W0     W0     W0    W0      W0      W0    W0       W0    W0     W0      W0     W0     W0     W0      W0   W0+dw  W0+dw  W0+dw   W0+dw  W0+dw  W0+dw   W0+dw  W0+dw  W0+dw   W0+dw   W0+dw   W0+dw   W0+dw   W0+dw   W0+dw   W0+dw   W0+dw   W0+dw   W0+dw   W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0-dw  W0-dw  W0-dw   W0-dw  W0-dw  W0-dw   W0-dw  W0-dw  W0-dw   W0-dw   W0-dw   W0-dw   W0-dw   W0-dw   W0-dw   W0-dw   W0-dw   W0-dw   W0-dw   W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw ];       
                %neighbour point cartesian coordinate,ex. coordinate of neighbour(i)=[n(1,i),n(2,i)]
                for U=-Urange:Ustep:Urange %loop of applying every single actuating variable
                    SV=[L0 ; V0 ; A0 ; W0]; %next state variable vector, initialization
                   %{
                    if abs(U)==200
                       K=1000;
                    elseif abs(U)==150
                           K=1100;
                    elseif K==1200;
                    end
                    %}
                    for Kc=1:1:K*T  % we chek the result after (K*sampling time) seconds
                        SV=(Ad*SV)+(Bd*U); %next state variable vector
                    end
                %% Quality calculation
                    %at every single point we apply 9 inputs and we find the next
                    %state variable, then we calculate the distance of each to the 8
                    %neighbour points, neighbour 1 to 8
                    %quality=distance,the smaller the distance the higher the quality
                    L=SV(1,1);%current state variable (position)
                    V=SV(2,1);%current state variable (velocity)
                    A=SV(3,1);%current state variable (angle)
                    W=SV(4,1);%current state variable (angular velocity)
                    for i=1:80
                        TempA=abs(L-NeiCartesian(1,i));     
                        TempB=abs(V-NeiCartesian(2,i));
                        TempC=abs(A-NeiCartesian(3,i));
                        TempD=abs(W-NeiCartesian(4,i));
                        DistanceTo=sqrt((TempA^2)+(TempB^2)+(TempC^2)+(TempD^2)); %distance (transition quality) to neighbour(i) 
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
        CV=CV+1;
    end
    CV=1;
    CL=CL+1;
end

for i=1:9
    for j=1:9
        for k=1:9
            for m=1:9
                for n=1:9
                    for o=1:9
                        for p=1:9
                            for q=1:9
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

for CL0=1:9
    for CV0=1:9
        for CA0=1:9
            for CW0=1:9
                NeiDataClassCo=[ CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1  CL0-1    CL0    CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1   CL0-1   CL0     CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1   CL0-1   CL0     CL0   CL0+1   CL0+1  CL0+1   CL0    CL0-1  CL0-1  CL0-1    CL0     CL0    CL0+1   CL0+1   CL0+1    CL0    CL0-1   CL0-1   CL0-1    CL0     CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1  CL0-1   CL0    CL0   CL0+1   CL0+1  CL0+1   CL0    CL0-1  CL0-1  CL0-1    CL0     CL0    CL0+1   CL0+1   CL0+1    CL0    CL0-1   CL0-1   CL0-1    CL0     CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1  CL0-1;
                                CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0   CV0+1    CV0   CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0    CV0+1   CV0    CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0    CV0+1   CV0    CV0+1  CV0+1    CV0   CV0-1  CV0-1   CV0-1   CV0   CV0+1    CV0    CV0+1   CV0+1    CV0    CV0-1   CV0-1   CV0-1    CV0    CV0+1    CV0    CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0   CV0+1   CV0   CV0+1  CV0+1    CV0   CV0-1  CV0-1   CV0-1   CV0   CV0+1    CV0    CV0+1   CV0+1    CV0    CV0-1   CV0-1   CV0-1    CV0    CV0+1    CV0    CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0   CV0+1;
                                 CA0    CA0    CA0    CA0    CA0    CA0    CA0    CA0    CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1   CA0+1  CA0-1   CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1   CA0-1   CA0     CA0    CA0     CA0    CA0    CA0     CA0    CA0    CA0    CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0-1   CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1   CA0    CA0    CA0     CA0    CA0    CA0     CA0    CA0    CA0    CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0+1   CA0-1   CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1;
                                 CW0    CW0    CW0    CW0    CW0    CW0    CW0    CW0     CW0    CW0    CW0    CW0    CW0    CW0    CW0    CW0     CW0    CW0     CW0    CW0    CW0    CW0    CW0    CW0    CW0     CW0   CW0+1   CW0+1  CW0+1   CW0+1  CW0+1  CW0+1   CW0+1  CW0+1  CW0+1   CW0+1   CW0+1   CW0+1   CW0+1   CW0+1   CW0+1   CW0+1   CW0+1   CW0+1   CW0+1   CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0-1  CW0-1  CW0-1   CW0-1  CW0-1  CW0-1   CW0-1  CW0-1  CW0-1   CW0-1   CW0-1   CW0-1   CW0-1   CW0-1   CW0-1   CW0-1   CW0-1   CW0-1   CW0-1   CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1 ];       
                for i=1:80
                    CL=NeiDataClassCo(1,i);
                    CV=NeiDataClassCo(2,i);
                    CA=NeiDataClassCo(3,i);
                    CW=NeiDataClassCo(4,i);
                    if (CL>0 & CV>0 & CA>0 & CW>0 & CL<10 & CV<10 & CA<10 & CW<10)
                        [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0,CA0,CW0).DisToNei(i,:));
                        DijFullData(CL0,CV0,CA0,CW0).Q(CL,CV,CA,CW)=MinDis;
                        TempF=FindU(InputIndCausedMinDis);
                        DijFullData(CL0,CV0,CA0,CW0).U(CL,CV,CA,CW)=TempF;
                    end
                end
            end
        end
    end
end
disp ' 4D Data BEST '

    