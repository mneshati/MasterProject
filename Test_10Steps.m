K=10;
T=0.1;
L0= -4;
V0= -8;
SV0=[L0 ; V0];
U=200;
SV=[L0 ; V0]; 
for Kc=1:1:K*T  
    SV=(Ad*SV)+(Bd*U);
end