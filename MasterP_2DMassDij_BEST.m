clc
%%Parametrization---------------------
for i=1:9
    for j=1:9
        DijData(i,j).Q=inf;
        DijData(i,j).U=[];
        DijData(i,j).T=[];
        DijData(i,j).F=1;
    end
    %DijData(i,j)= Information of the route from the initial point given [i;j]
    %to the destination
end
DijData(5,5).Q=0;
DijData(5,5).U=0;
DijData(5,5).T=[0;0];
watchF=0;
 for z=1:9
        for a=1:9
            watchF=DijData(a,z).F + watchF;
        end
    end
%%START---------------------
while (watchF>0)
    watchF=0;
    min=inf;
    index_row=1;
    index_column=1;
    for column=1:9
        for row=1:9
            if (DijData(row,column).F == 1 & DijData(row,column).Q < min)
                min=DijData(row,column).Q;
                index_row=row;
                index_column=column;
            end
        end
    end
    CurrNode=[index_row;index_column];
    DijData(index_row,index_column).F=0;
    NeiSet=[CurrNode(1,1)   CurrNode(1,1)+1  CurrNode(1,1)+1  CurrNode(1,1)+1   CurrNode(1,1)   CurrNode(1,1)-1  CurrNode(1,1)-1  CurrNode(1,1)-1;
           CurrNode(2,1)+1  CurrNode(2,1)+1   CurrNode(2,1)   CurrNode(2,1)-1  CurrNode(2,1)-1  CurrNode(2,1)-1   CurrNode(2,1)   CurrNode(2,1)+1];
    for j=1:8
        if (0<NeiSet(1,j) & 10>NeiSet(1,j)& 0<NeiSet(2,j) & 10>NeiSet(2,j))
            if( (DijFullData(NeiSet(1,j),NeiSet(2,j)).Q(CurrNode(1,1),CurrNode(2,1)) + DijData(CurrNode(1,1),CurrNode(2,1)).Q) < (DijData(NeiSet(1,j),NeiSet(2,j)).Q)) 
                DijData(NeiSet(1,j),NeiSet(2,j)).Q=DijFullData(NeiSet(1,j),NeiSet(2,j)).Q(CurrNode(1,1),CurrNode(2,1))+ DijData(CurrNode(1,1),CurrNode(2,1)).Q;
                DijData(NeiSet(1,j),NeiSet(2,j)).T=[CurrNode,DijData(CurrNode(1,1),CurrNode(2,1)).T];
                DijData(NeiSet(1,j),NeiSet(2,j)).U=[DijFullData(NeiSet(1,j),NeiSet(2,j)).U(CurrNode(1,1),CurrNode(2,1)),DijData(CurrNode(1,1),CurrNode(2,1)).U];
            end
        end
    end
    for z=1:9
        for a=1:9
            watchF=DijData(a,z).F + watchF;
        end
    end
    watchF
end
disp ' 2D Dijk BEST '

