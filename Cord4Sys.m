L0=4;
dl=1;
V0=4;
dv=1;
G0=4;
dg=1;
A0=4;
da=1;

NeiCartesian=[L0     L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl    L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl     L0     L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl      L0      L0   L0+dl   L0+dl   L0+dl    L0    L0-dl  L0-dl  L0-dl    L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl     L0     L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl       L0     L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl    L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl     L0     L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl;                                                              
              V0   V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv  V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv     V0   V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv      V0    V0+dv  V0+dv     V0    V0-dv   V0-dv  V0-dv    V0   V0+dv  V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv     V0   V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv       V0   V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv  V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv     V0   V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv;                        
            G0-dg  G0-dg  G0-dg  G0-dg  G0-dg  G0-dg  G0-dg  G0-dg  G0-dg    G0     G0     G0     G0    G0      G0     G0     G0    G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg     G0-dg  G0-dg  G0-dg   G0-dg   G0-dg   G0-dg  G0-dg  G0-dg  G0-dg    G0     G0     G0     G0    G0      G0     G0     G0    G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg     G0-dg  G0-dg  G0-dg  G0-dg  G0-dg  G0-dg  G0-dg  G0-dg  G0-dg    G0     G0     G0     G0    G0      G0     G0     G0    G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg;                         
            A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da   A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da      A0      A0     A0      A0      A0      A0     A0     A0     A0     A0     A0     A0     A0    A0      A0     A0     A0      A0     A0     A0     A0     A0     A0     A0     A0     A0      A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da   A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da  A0+da];                     
 
        
%L= [L0   L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl];
%Lw=[L0+dl  L0+dl  L0+dl   L0    L0-dl  L0-dl  L0-dl];

%V= [V0   V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv];
%Vw=[V0+dv  V0+dv    V0   V0-dv  V0-dv  V0-dv    V0   V0+dv];

%Gb=[G0-dg  G0-dg  G0-dg  G0-dg  G0-dg  G0-dg  G0-dg  G0-dg  G0-dg];
%Gm=[G0-dg  G0-dg  G0-dg  G0-dg  G0-dg  G0-dg  G0-dg  G0-dg];
%Gf=[G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg  G0+dg];

%Ab=[A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da   A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da];
%Aw=[A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da  A0-da];

%NeiCartesian2=[L,Lw,L;V,Vw,V;Gb,Gm,Gf;Ab];
               

