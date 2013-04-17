clc
%-----------------------------
m=10; %mass of the moving particle
T=0.001; %sampling time
K=100000; %(K*sampling time) is the time that results are read
Urange=200;
Ustep=50;
V0range=8;
L0range=4;
dl=1; %discretized steps on the l vector 
dv=2; %discretized steps on the v vector
Uc=1; %actuting variable counter(tells which input has been applied)
%-----------------------------
A = [0 1;0 0]; %system matrix
B = [0;1/m]; 
C =[1 0];
Cd = C; 
[Ad,Bd]=c2d(A,B,T); %discretized system
%-----------------------------
for L0=-L0range:dl:L0range 
    for V0=-V0range:dv:V0range 
        SV0=[L0 ; V0];    
        plot(L0,V0,'ko','linewidth',2); 
        hold on
        for U=-200
            SV=[L0 ; V0]; 
            for Kc=1:1:K*T 
                SV=(Ad*SV)+(Bd*U);
                plot(SV(1,1),SV(2,1),'bx:','linewidth',2); %plot the next state variable
                hold on
            end
            xlabel('L')
            ylabel('V')
         end
         Uc=Uc+1;
    end
    Uc=1;
end
%{
hold on;
for L0=-L0range:dl:L0range 
    for V0=-V0range:dv:V0range 
        SV0=[L0 ; V0];    
        for U=300
            SV=[L0 ; V0]; 
            for Kc=1:1:K*T 
                SV=(Ad*SV)+(Bd*U);
                plot(SV(1,1),SV(2,1),'ys:','linewidth',2); %plot the next state variable
                hold on
            end
            xlabel('L')
            ylabel('V')
         end
         Uc=Uc+1;
    end
    Uc=1;
end
hold on;
for L0=-L0range:dl:L0range 
    for V0=-V0range:dv:V0range 
        SV0=[L0 ; V0];    
        for U=400
            SV=[L0 ; V0]; 
            for Kc=1:1:K*T 
                SV=(Ad*SV)+(Bd*U);
                plot(SV(1,1),SV(2,1),'rd:','linewidth',2); %plot the next state variable
                hold on
            end
            xlabel('L')
            ylabel('V')
         end
         Uc=Uc+1;
    end
    Uc=1;
end
%}
  