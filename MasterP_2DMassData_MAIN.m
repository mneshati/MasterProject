clear
clc
close all
%-----------------------------
% L= length (position)
% V= Velocity (speed)
% U= actuating variable (input)
% SV= state variable
% c as a suffix= counter
%-----------------------------
Urange=200;
Ustep=50;
%-----------------------------
m=10; %mass of the moving particle
T=0.001; %sampling time
K=100000; %(K*sampling time) is the time that results are read
dl=1; %discretized steps on the l vector 
dv=2; %discretized steps on the v vector
CL=1; %dataclass coordinat initial value of L 
CV=1; %dataclass coordinat initial value of V 
Uc=1; %actuting variable counter(tells which input has been applied)
%we have 10 actuating variables -200:50:200
%-----------------------------
A = [0 1;0 0]; %system matrix
B = [0;1/m]; 
C =[1 0];
Cd = C; 
[Ad,Bd]=c2d(A,B,T); %discretized system
TempA=[]; %auxiliary variable to calculate distances (quality)
TempB=[]; %auxiliary variable to calculate distances (quality)
%-----------------------------
for L0=-4:1:4 %loop for going to each single discretized point on the L axis
    for V0=-8:2:8 %loop for going to each single discretized point on the V axis
        SV0=[L0 ; V0];%initial state variable
        FullData(CL,CV).CurrPoint=SV0; 
        %current point saved in Discrete Points dataclass
        %CurrPoint=[];DisToNei=[];
        NeiCartesian=[L0   L0+dl  L0+dl  L0+dl   L0   L0-dl  L0-dl  L0-dl;
                    V0+dv  V0+dv    V0   V0-dv V0-dv  V0-dv    V0   V0+dv];
        %neighbour point cartesian coordinate,ex. coordinate of neighbour(i)=[n(1,i),n(2,i)]
        for U=-Urange:Ustep:Urange %loop of applying every single actuating variable
            SV=[L0 ; V0]; %next state variable vector, initialization
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
            for i=1:8
                TempA(i)=abs(L-NeiCartesian(1,i));     
                TempB(i)=abs(V-NeiCartesian(2,i));
                DistanceTo(i)=sqrt((TempA(i)^2)+(TempB(i)^2)); %distance (transition quality) to neighbour(i) 
                FullData(CL,CV).DisToNei(i,Uc)=DistanceTo(i);%save each distance(quality)for the specific U 
           end
           Uc=Uc+1;
       end
       Uc=1;
       CV=CV+1;
    end
    CV=1;
    CL=CL+1;
end

for i=1:81
    for j=1:81
        DijFullData(i,j).Q=inf;
        DijFullData(i,j).U=inf;
        %DijFullData(i,j).Q=Quality,DijFullData(i,j).U=actuating variable,
    end
end

for CL0=1:9
    for CV0=1:9
        TableCoX=((CL0-1)*9)+CV0; %Number indicating the point, points numbered from 1 to 81
        NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                       CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
        for i=1:8
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            if (CL>0 & CV>0 & CL<10 & CV<10)
                [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
                TableCoY=((CL-1)*9)+CV;
                DijFullData(TableCoX,TableCoY).Q=MinDis;
                TempC=FindU(InputIndCausedMinDis);
                DijFullData(TableCoX,TableCoY).U=TempC;
            else
                break
            end
        end
    end
end
disp ' 2DMassData MAIN SUCCESSFULL '
%{
for (CL0=1)
    for (CV0=2:8)
        TableCoX=((CL0-1)*9)+CV0;
        NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                           CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
        for i=1:5
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
    end
    for (CV0=1)
        TableCoX=((CL0-1)*9)+CV0;
        NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                       CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
        for i=1:3
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
    end
    for (CV0=9)
         TableCoX=((CL0-1)*9)+CV0;
         NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                        CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
        for i=3:5
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
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
        TableCoX=((CL0-1)*9)+CV0;
        NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                       CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
        for i=1
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));    
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
        for i=5:8
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
    end
    for (CV0=1)
        TableCoX=((CL0-1)*9)+CV0;
        NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                           CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
        for i=7:8
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
        for i=1
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
    end
    for (CV0=9)
        TableCoX=((CL0-1)*9)+CV0;
        NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                           CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
        for i=5:7
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
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
        TableCoX=((CL0-1)*9)+CV0;
        NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                       CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
        for i=1:3
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
            CL=NeiDataClassCo(1,i);
            CV=NeiDataClassCo(2,i);
            TableCoY=((CL-1)*9)+CV;
            DijFullData(TableCoX,TableCoY).Q=MinDis;
            TempC=FindU(InputIndCausedMinDis);
            DijFullData(TableCoX,TableCoY).U=TempC;
        end
        for i=7:8
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
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
        TableCoX=((CL0-1)*9)+CV0;
        NeiDataClassCo=[CL0    CL0+1  CL0+1 CL0+1    CL0    CL0-1 CL0-1 CL0-1;
                       CV0+1   CV0+1   CV0  CV0-1   CV0-1   CV0-1  CV0  CV0+1];
        for i=3:7
            [MinDis InputIndCausedMinDis]=min(FullData(CL0,CV0).DisToNei(i,:));
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
disp ' 2D Data MAIN '

    