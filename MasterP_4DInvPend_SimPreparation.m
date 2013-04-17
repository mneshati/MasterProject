clc
%{
for i = 1:size(DijData,1)
y(i) = DijData(i,41).U(1);
end
u = reshape(y,[9,9]);
flipud(u');
%}

for SCL=1:1:9
    for SCV=1:1:9
        for SCA=1:1:9
            for SCW=1:1:9
                SU(SCL,SCV,SCA,SCW)=DijData(SCL,SCV,SCA,SCW).U(1);
            end
        end
    end
end
disp ' 4D Sim Preparation '
        