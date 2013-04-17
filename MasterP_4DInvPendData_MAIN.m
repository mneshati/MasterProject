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
Urange=28;
Ustep=7;
%-----------------------------
m=10; %mass of the moving particle
T=0.0001; %sampling time
K=10000000; %(K*sampling time) is the time that results are read
%-----------------------------
dl=1; %discretized steps on the l vector 
dv=1; %discretized steps on the v vector
da=1;
dw=1;
CL=1; %dataclass coordinat initial value of L 
CV=1; %dataclass coordinat initial value of V 
CA=1;
CW=1;
TempA=[]; %auxiliary variable to calculate distances (quality)
TempB=[]; %auxiliary variable to calculate distances (quality)
TempC=[];
TempD=[];
Uc=1; %actuting variable counter(tells which input has been applied)
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
for L0=-0.4:0.1:0.4 %loop for going to each single discretized point on the L axis
    for V0=-6:1.5:6 %loop for going to each single discretized point on the V axis
        for A0=(-pi):(pi/4):pi
            for W0=-2*pi:(pi/2):2*pi
                SV0=[L0 ; V0 ; A0 ; W0];%initial state variable
                FullData(CL,CV,CA,CW).CurrPoint=SV0; 
                %current point saved in Discrete Points dataclass
                %CurrPoint=[];DisToNei=[];
                NeiCartesian=[L0     L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl    L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl     L0     L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl      L0      L0   L0+dl   L0+dl   L0+dl    L0    L0-dl  L0-dl  L0-dl    L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl     L0     L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl       L0     L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl    L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl     L0     L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl;                                                              
                              V0   V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv  V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv     V0   V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv      V0    V0+dv  V0+dv     V0    V0-dv   V0-dv  V0-dv    V0   V0+dv  V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv     V0   V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv       V0   V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv  V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv     V0   V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv;                        
                            A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da    A0     A0     A0     A0    A0      A0     A0     A0    A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da     A0-da  A0-da  A0-da   A0-da   A0-da   A0-da  A0-da  A0-da  A0-da    A0     A0     A0     A0    A0      A0     A0     A0    A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da     A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da    A0     A0     A0     A0    A0      A0     A0     A0    A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da;                         
                            W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw   W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw  W0-dw      W0      W0     W0      W0      W0      W0     W0     W0     W0     W0     W0     W0     W0    W0      W0     W0     W0      W0     W0     W0     W0     W0     W0     W0     W0     W0      W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw   W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw  W0+dw];                   
                %neighbour point cartesian coordinate,ex. coordinate of neighbour(i)=[n(1,i),n(2,i)]
                NeiDataClassCo=[CL    CL   CL+1  CL+1  CL+1   CL   CL-1  CL-1  CL-1   CL   CL+1  CL+1  CL+1   CL   CL-1  CL-1  CL-1    CL    CL   CL+1  CL+1  CL+1   CL   CL-1  CL-1  CL-1      CL    CL   CL+1   CL+1   CL+1    CL   CL-1  CL-1  CL-1   CL   CL+1  CL+1  CL+1   CL   CL-1  CL-1  CL-1    CL    CL   CL+1  CL+1  CL+1   CL   CL-1  CL-1  CL-1      CL    CL   CL+1  CL+1  CL+1   CL   CL-1  CL-1  CL-1   CL   CL+1  CL+1  CL+1   CL   CL-1  CL-1  CL-1    CL    CL   CL+1  CL+1  CL+1   CL   CL-1  CL-1  CL-1;                                                              
                                CV   CV+1  CV+1   CV   CV-1  CV-1  CV-1   CV   CV+1  CV+1  CV+1   CV   CV-1  CV-1  CV-1   CV   CV+1    CV   CV+1  CV+1   CV   CV-1  CV-1  CV-1   CV   CV+1      CV   CV+1  CV+1    CV    CV-1   CV-1  CV-1   CV   CV+1  CV+1  CV+1   CV   CV-1  CV-1  CV-1   CV   CV+1    CV   CV+1  CV+1   CV   CV-1  CV-1  CV-1   CV   CV+1      CV   CV+1  CV+1   CV   CV-1  CV-1  CV-1   CV   CV+1  CV+1  CV+1   CV   CV-1  CV-1  CV-1   CV   CV+1    CV   CV+1  CV+1   CV   CV-1  CV-1   CV    CV   CV+1;                        
                               CA-1  CA-1  CA-1  CA-1  CA-1  CA-1  CA-1  CA-1  CA-1   CA    CA    CA    CA    CA    CA    CA    CA    CA+1  CA+1  CA+1  CA+1  CA+1  CA+1  CA+1  CA+1  CA+1     CA-1  CA-1  CA-1   CA-1   CA-1   CA-1  CA-1  CA-1  CA-1   CA    CA    CA    CA    CA    CA    CA    CA    CA+1  CA+1  CA+1  CA+1  CA+1  CA+1  CA+1  CA+1  CA+1     CA-1  CA-1  CA-1  CA-1  CA-1  CA-1  CA-1  CA-1  CA-1   CA    CA    CA    CA    CA    CA    CA    CA    CA+1  CA+1  CA+1  CA+1  CA+1  CA+1  CA+1  CA+1  CA+1;                         
                               CW-1  CW-1  CW-1  CW-1  CW-1  CW-1  CW-1  CW-1  CW-1  CW-1  CW-1  CW-1  CW-1  CW-1  CW-1  CW-1  CW-1   CW-1  CW-1  CW-1  CW-1  CW-1  CW-1  CW-1  CW-1  CW-1      CW    CW    CW     CW     CW     CW    CW    CW    CW    CW    CW    CW    CW    CW    CW    CW    CW     CW    CW    CW    CW    CW    CW    CW    CW    CW      CW+1  CW+1  CW+1  CW+1  CW+1  CW+1  CW+1  CW+1  CW+1  CW+1  CW+1  CW+1  CW+1  CW+1  CW+1  CW+1  CW+1   CW+1  CW+1  CW+1  CW+1  CW+1  CW+1  CW+1  CW+1  CW+1];     
                %neighbour data class spatial coordinates 
                %this is done to make it easy to reach the neighbour using dataclass easily
                %plot(l0,v0,'ko','linewidth',2); %plot the neighbouring hood point 
                %hold on
                for U=-Urange:Ustep:Urange %loop of applying every single actuating variable
                    SV=[L0 ; V0 ; A0 ; W0]; %next state variable vector, initialization
                    for Kc=1:1:K*T  % we chek the result after (K*sampling time) seconds
                        SV=(Ad*SV)+(Bd*U); %next state variable vector
                    end
                    % plot(SV(1,1),SV(2,1),'x','linewidth',9); %plot the next state variable
                    % hold on
                    % xlabel('L')
                    % ylabel('V')
%% Quality calculation
                    %at every single point we apply 10 inputs and we find the next
                    %state variable, then we calculate the distance of each to the 8
                    %neighbour points, neighbour 1 to 8
                    %quality=distance,the smaller the distance the higher the quality
                    L=SV(1,1);%current state variable
                    V=SV(2,1);%current state variable
                    A=SV(3,1);
                    W=SV(4,1);
                    for i=1:78
                    TempA(i)=abs(L-NeiCartesian(1,i));     
                    TempB(i)=abs(V-NeiCartesian(2,i));
                    TempC(i)=abs(V-NeiCartesian(3,i));
                    TempD(i)=abs(V-NeiCartesian(4,i));
                    DistanceTo(i)=sqrt((TempA(i)^2)+(TempB(i)^2)+(TempC(i)^2)+(TempD(i)^2)); %distance (transition quality) to neighbour(i) 
                    FullData(CL,CV,CA,CW).DisToNei(i,Uc)=DistanceTo(i);%save each distance(quality) 
%% Data Process
%{
                    [MinDis MinDisNeiInd]=min(FullData(CL,CV,CA,CW).DisToNei(:,Uc));
                    %find the smallest distance for this U we are applying
                    %=find the best quality for this U we are applying
                    ProcessedData(CL,CV,CA,CW).DisToBestNei(1,Uc)=MinDis;
                    %we define best neighbour as the neighbour which we have
                    %the least distance to it
                    %put the minimum distance in 1st row which was for the best nei
                    ProcessedData(CL,CV,CA,CW).UToBestNei(1,Uc)=U;
                    %put the relevant U in the 2nd row
                    ProcessedData(CL,CV,CA,CW).BestNeiInd(1,Uc)=MinDisNeiInd;
                    %save the best neighbour index(1,2,...,8)
                    ProcessedData(CL,CV,CA,CW).BestNeiCartesian(:,Uc)=[NeiCartesian(1,ProcessedData(CL,CV,CA,CW).BestNeiInd(1,Uc));NeiCartesian(2,ProcessedData(CL,CV,CA,CW).BestNeiInd(1,Uc));NeiCartesian(3,ProcessedData(CL,CV,CA,CW).BestNeiInd(1,Uc));NeiCartesian(4,ProcessedData(CL,CV,CA,CW).BestNeiInd(1,Uc))];
                    %save the cartesian coordinate of the best neighbour
                    ProcessedData(CL,CV,CA,CW).BestNeiDataClassCo(:,Uc)=[NeiDataClassCo(1,ProcessedData(CL,CV,CA,CW).BestNeiInd(1,Uc));NeiDataClassCo(2,ProcessedData(CL,CV,CA,CW).BestNeiInd(1,Uc));NeiDataClassCo(3,ProcessedData(CL,CV,CA,CW).BestNeiInd(1,Uc));NeiDataClassCo(4,ProcessedData(CL,CV,CA,CW).BestNeiInd(1,Uc))];
                    %save the data class coordinate of the best neighbour
                    %ProcessedData(CL,CV).DisOfBestNeiToZero(1,Uc)=sqrt((NeiCartesian(1,ProcessedData(CL,CV).BestNeiInd(1,Uc)))^2+(NeiCartesian(2,ProcessedData(CL,CV).BestNeiInd(1,Uc)))^2);
                    %save the distance of best neighbour choosed, to pint(0,0)
                    %ProcessedData(CL,CV).BestNeiFullData(1,Uc)=ProcessedData(CL,CV).DisToBestNei(1,Uc);
                    %distance to best neighbour saved row1
                    %ProcessedData(CL,CV).BestNeiFullData(2,Uc)=ProcessedData(CL,CV).UToBestNei(1,Uc);
                    %U to best neighbour saved row2
                    %ProcessedData(CL,CV).BestNeiFullData(3,Uc)=ProcessedData(CL,CV).BestNeiInd(1,Uc);
                    %index of best neighbour saved row3
                    %ProcessedData(CL,CV).BestNeiFullData(4,Uc)=ProcessedData(CL,CV).BestNeiCartesian(1,Uc);
                    %L of best neighbour saved row4
                    %ProcessedData(CL,CV).BestNeiFullData(5,Uc)=ProcessedData(CL,CV).BestNeiCartesian(2,Uc);
                    %V of best neighbour saved row5
                    %ProcessedData(CL,CV).BestNeiFullData(6,Uc)=ProcessedData(CL,CV).BestNeiDataClassCo(1,Uc);
                    %CL of best neighbour saved row6
                    %ProcessedData(CL,CV).BestNeiFullData(7,Uc)=ProcessedData(CL,CV).BestNeiDataClassCo(2,Uc);
                    %CV of best neighbour saved row7
%}
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

for i=1:6561
    for j=1:6561
        DijFullData(i,j).Q=50000;
        DijFullData(i,j).U=50000;
    end
end

for CL0=1:9
    for CV0=1:9
        for CA0=1:9
            for CW0=1:9
                for i=1:78
                    TableCoX=((CL0-1)*729)+((CV0-1)*81)+((CA0-1)*9)+CW0;
                    [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0,CA0,CW0).DisToNei(i,:));
                    NeiDataClassCo=[CL0    CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1  CL0-1   CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1  CL0-1    CL0    CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1  CL0-1      CL0    CL0   CL0+1   CL0+1   CL0+1    CL0   CL0-1  CL0-1  CL0-1   CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1  CL0-1    CL0    CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1  CL0-1      CL0    CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1  CL0-1   CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1  CL0-1    CL0    CL0   CL0+1  CL0+1  CL0+1   CL0   CL0-1  CL0-1  CL0-1;                                                              
                                    CV0   CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0   CV0+1  CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0   CV0+1    CV0   CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0   CV0+1      CV0   CV0+1  CV0+1    CV0    CV0-1   CV0-1  CV0-1   CV0   CV0+1  CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0   CV0+1    CV0   CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0   CV0+1      CV0   CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0   CV0+1  CV0+1  CV0+1   CV0   CV0-1  CV0-1  CV0-1   CV0   CV0+1    CV0   CV0+1  CV0+1   CV0   CV0-1  CV0-1   CV0    CV0   CV0+1;                        
                                   CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1   CA0    CA0    CA0    CA0    CA0    CA0    CA0    CA0    CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1     CA0-1  CA0-1  CA0-1   CA0-1   CA0-1   CA0-1  CA0-1  CA0-1  CA0-1   CA0    CA0    CA0    CA0    CA0    CA0    CA0    CA0    CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1     CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1  CA0-1   CA0    CA0    CA0    CA0    CA0    CA0    CA0    CA0    CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1  CA0+1;                         
                                   CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1   CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1      CW0    CW0    CW0     CW0     CW0     CW0    CW0    CW0    CW0    CW0    CW0    CW0    CW0    CW0    CW0    CW0    CW0     CW0    CW0    CW0    CW0    CW0    CW0    CW0    CW0    CW0      CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1   CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1];     
              
                    CL=NeiDataClassCo(1,i);
                    CV=NeiDataClassCo(2,i);
                    CA=NeiDataClassCo(3,i);
                    CW=NeiDataClassCo(4,i);
                    if (CL<=0 | CV<=0 | CA<=0 | CW<=0 | CL>10 | CV>10 | CA>10 | CW>10)
                        break
                    else
                    TableCoY=((CV-1)*729)+((CV-1)*81)+((CA-1)*9)+CW;
                    DijFullData(TableCoX,TableCoY).Q=MinDis;
                    TempC=FindU_InvPend(InputIndCausedMinDis);
                    DijFullData(TableCoX,TableCoY).U=TempC;
                    end
                end
            end
        end
    end
end
%{
for (CL0=1)
    for (CV0=1)
        for (CA0=1)
            for (CW0=2:8)
                for i=1:21
                    TableCoX=((CV0-1)*729)+((CV0-1)*81)+((CA0-1)*9)+CW0;
                    [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
                    NeiDataClassCo=[CL0    CL0+1  CL0+1  CL0    CL0    CL0+1  CL0+1  CL0    CL0+1  CL0+1  CL0   CL0    CL0+1  CL0+1  CL0    CL0+1  CL0+1  CL0    CL0    CL0+1  CL0+1;                                                              
                                    CV0+1  CV0+1  CV0    CV0    CV0+1  CV0+1  CV0    CV0+1  CV0+1  CV0    CV0   CV0+1  CV0+1  CV0    CV0+1  CV0+1  CV0    CV0    CV0+1  CV0+1  CV0;                        
                                    CA0    CA0    CA0    CA0+1  CA0+1  CA0+1  CA0+1  CA0    CA0    CA0    CA0+1 CA0+1  CA0+1  CA0+1  CA0    CA0    CA0    CA0+1  CA0+1  CA0+1  CA0+1;                         
                                    CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0-1  CW0    CW0    CW0    CW0   CW0    CW0    CW0    CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1];     
                    CL=NeiDataClassCo(1,i);
                    CV=NeiDataClassCo(2,i);
                    CA=NeiDataClassCo(3,i);
                    CW=NeiDataClassCo(4,i);
                    TableCoY=((CV-1)*729)+((CV-1)*81)+((CA-1)*9)+CW;
                    DijFullData(TableCoX,TableCoY).Q=MinDis;
                    TempC=FindU(InputIndCausedMinDis);
                    DijFullData(TableCoX,TableCoY).U=TempC;
                end
            end
            for (CW0=1)
                for i=1:14
                    TableCoX=((CV0-1)*729)+((CV0-1)*81)+((CA0-1)*9)+CW0;
                    [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
                    NeiDataClassCo=[CL0    CL0+1  CL0+1  CL0   CL0    CL0+1  CL0+1  CL0    CL0+1  CL0+1  CL0    CL0    CL0+1  CL0+1;                                                              
                                    CV0+1  CV0+1  CV0    CV0   CV0+1  CV0+1  CV0    CV0+1  CV0+1  CV0    CV0    CV0+1  CV0+1  CV0;                        
                                    CA0    CA0    CA0    CA0+1 CA0+1  CA0+1  CA0+1  CA0    CA0    CA0    CA0+1  CA0+1  CA0+1  CA0+1;                         
                                    CW0    CW0    CW0    CW0   CW0    CW0    CW0    CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1  CW0+1];     
                    CL=NeiDataClassCo(1,i);
                    CV=NeiDataClassCo(2,i);
                    CA=NeiDataClassCo(3,i);
                    CW=NeiDataClassCo(4,i);
                    TableCoY=((CV-1)*729)+((CV-1)*81)+((CA-1)*9)+CW;
                    DijFullData(TableCoX,TableCoY).Q=MinDis;
                    TempC=FindU(InputIndCausedMinDis);
                    DijFullData(TableCoX,TableCoY).U=TempC;
                end
                
                
        end
    for (CV0=9)
        for i=3:5
            TableCoX=((CL0-1)*9)+CV0;
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
            NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                           CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
    end
end
 
for (CL0=9)
    for (CV0=2:8)
        for i=1
            TableCoX=((CL0-1)*9)+CV0;
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
            NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                           CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
        for i=5:8
            TableCoX=((CL0-1)*9)+CV0;
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
            NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                           CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
    end
    for (CV0=1)
        for i=7:8
            TableCoX=((CL0-1)*9)+CV0;
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
            NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                           CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
        for i=1
            TableCoX=((CL0-1)*9)+CV0;
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
            NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                           CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
    end
    for (CV0=9)
        for i=5:7
            TableCoX=((CL0-1)*9)+CV0;
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
            NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                           CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
   end
end
 
for (CV0=1)
    for (CL0=2:8)
        for i=1:3
            TableCoX=((CL0-1)*9)+CV0;
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
            NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                           CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
        for i=7:8
            TableCoX=((CL0-1)*9)+CV0;
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
            NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                           CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
    end
end

for (CV0=9)
    for (CL0=2:8)
        for i=3:7
            TableCoX=((CL0-1)*9)+CV0;
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
            NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                           CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
    end
end
%}
disp ' 4D Data MAIN '


        
    