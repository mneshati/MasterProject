clc
%%Parametrization---------------------
for i=1:9
    for j=1:9
        for k=1:9
            for m=1:9
                DijData(i,j,k,m).Q=inf;
                DijData(i,j,k,m).U=[];
                DijData(i,j,k,m).T=[];
                DijData(i,j,k,m).F=1;
            end
        end
    end
end
    %DijData(i,j,k,m)= Information of the route from the initial point given [i;j]
    %to the destination
DijData(5,5,5,5).Q=0;
DijData(5,5,5,5).U=0;
DijData(5,5,5,5).T=[0;0;0;0];
watchF=0;
 for i=1:9
     for j=1:9
         for k=1:9
             for m=1:9
                 watchF=DijData(i,j,k,m).F + watchF;
             end
         end
     end
 end
 
%%START---------------------
while (watchF>0)
    watchF=0;
    min=inf;
    index_row=1;
    index_column=1;
    index_table=1;
    index_space=1;
    for space=1:9
        for table=1:9
            for column=1:9
                 for row=1:9
                    if (DijData(row,column,table,space).F == 1 & DijData(row,column,table,space).Q < min)
                        min=DijData(row,column,table,space).Q;
                        index_row=row;
                        index_column=column;
                        index_table=table;
                        index_space=space;
                    end
                 end
            end
        end
    end
    CurrNode=[index_row;index_column;index_table;index_space]
    DijData(index_row,index_column,index_table,index_space).F=0;
    NeiSet=[CurrNode(1,1)   CurrNode(1,1)+1  CurrNode(1,1)+1  CurrNode(1,1)+1   CurrNode(1,1)   CurrNode(1,1)-1  CurrNode(1,1)-1  CurrNode(1,1)-1    CurrNode(1,1)    CurrNode(1,1)   CurrNode(1,1)+1  CurrNode(1,1)+1  CurrNode(1,1)+1   CurrNode(1,1)   CurrNode(1,1)-1  CurrNode(1,1)-1   CurrNode(1,1)-1   CurrNode(1,1)     CurrNode(1,1)   CurrNode(1,1)+1  CurrNode(1,1)+1  CurrNode(1,1)+1   CurrNode(1,1)   CurrNode(1,1)-1  CurrNode(1,1)-1   CurrNode(1,1)-1   CurrNode(1,1)     CurrNode(1,1)   CurrNode(1,1)+1   CurrNode(1,1)+1  CurrNode(1,1)+1   CurrNode(1,1)    CurrNode(1,1)-1  CurrNode(1,1)-1  CurrNode(1,1)-1    CurrNode(1,1)     CurrNode(1,1)    CurrNode(1,1)+1   CurrNode(1,1)+1   CurrNode(1,1)+1    CurrNode(1,1)    CurrNode(1,1)-1   CurrNode(1,1)-1   CurrNode(1,1)-1    CurrNode(1,1)     CurrNode(1,1)   CurrNode(1,1)+1  CurrNode(1,1)+1  CurrNode(1,1)+1   CurrNode(1,1)   CurrNode(1,1)-1  CurrNode(1,1)-1  CurrNode(1,1)-1   CurrNode(1,1)    CurrNode(1,1)   CurrNode(1,1)+1   CurrNode(1,1)+1  CurrNode(1,1)+1   CurrNode(1,1)    CurrNode(1,1)-1  CurrNode(1,1)-1  CurrNode(1,1)-1    CurrNode(1,1)     CurrNode(1,1)    CurrNode(1,1)+1   CurrNode(1,1)+1   CurrNode(1,1)+1    CurrNode(1,1)    CurrNode(1,1)-1   CurrNode(1,1)-1   CurrNode(1,1)-1    CurrNode(1,1)     CurrNode(1,1)   CurrNode(1,1)+1  CurrNode(1,1)+1  CurrNode(1,1)+1   CurrNode(1,1)   CurrNode(1,1)-1  CurrNode(1,1)-1  CurrNode(1,1)-1;
            CurrNode(2,1)+1  CurrNode(2,1)+1   CurrNode(2,1)   CurrNode(2,1)-1  CurrNode(2,1)-1  CurrNode(2,1)-1   CurrNode(2,1)   CurrNode(2,1)+1    CurrNode(2,1)   CurrNode(2,1)+1  CurrNode(2,1)+1   CurrNode(2,1)   CurrNode(2,1)-1  CurrNode(2,1)-1  CurrNode(2,1)-1   CurrNode(2,1)    CurrNode(2,1)+1   CurrNode(2,1)    CurrNode(2,1)+1  CurrNode(2,1)+1   CurrNode(2,1)   CurrNode(2,1)-1  CurrNode(2,1)-1  CurrNode(2,1)-1   CurrNode(2,1)    CurrNode(2,1)+1   CurrNode(2,1)    CurrNode(2,1)+1  CurrNode(2,1)+1    CurrNode(2,1)   CurrNode(2,1)-1  CurrNode(2,1)-1   CurrNode(2,1)-1   CurrNode(2,1)   CurrNode(2,1)+1    CurrNode(2,1)    CurrNode(2,1)+1   CurrNode(2,1)+1    CurrNode(2,1)    CurrNode(2,1)-1   CurrNode(2,1)-1   CurrNode(2,1)-1    CurrNode(2,1)    CurrNode(2,1)+1    CurrNode(2,1)    CurrNode(2,1)+1  CurrNode(2,1)+1   CurrNode(2,1)   CurrNode(2,1)-1  CurrNode(2,1)-1  CurrNode(2,1)-1   CurrNode(2,1)   CurrNode(2,1)+1   CurrNode(2,1)   CurrNode(2,1)+1  CurrNode(2,1)+1    CurrNode(2,1)   CurrNode(2,1)-1  CurrNode(2,1)-1   CurrNode(2,1)-1   CurrNode(2,1)   CurrNode(2,1)+1    CurrNode(2,1)    CurrNode(2,1)+1   CurrNode(2,1)+1    CurrNode(2,1)    CurrNode(2,1)-1   CurrNode(2,1)-1   CurrNode(2,1)-1    CurrNode(2,1)    CurrNode(2,1)+1    CurrNode(2,1)    CurrNode(2,1)+1  CurrNode(2,1)+1   CurrNode(2,1)   CurrNode(2,1)-1  CurrNode(2,1)-1  CurrNode(2,1)-1   CurrNode(2,1)   CurrNode(2,1)+1;
            CurrNode(3,1)    CurrNode(3,1)    CurrNode(3,1)    CurrNode(3,1)    CurrNode(3,1)    CurrNode(3,1)    CurrNode(3,1)    CurrNode(3,1)    CurrNode(3,1)+1  CurrNode(3,1)+1  CurrNode(3,1)+1  CurrNode(3,1)+1  CurrNode(3,1)+1  CurrNode(3,1)+1  CurrNode(3,1)+1  CurrNode(3,1)+1   CurrNode(3,1)+1  CurrNode(3,1)-1   CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1   CurrNode(3,1)-1   CurrNode(3,1)     CurrNode(3,1)    CurrNode(3,1)     CurrNode(3,1)    CurrNode(3,1)    CurrNode(3,1)     CurrNode(3,1)    CurrNode(3,1)    CurrNode(3,1)    CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)-1   CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1   CurrNode(3,1)    CurrNode(3,1)    CurrNode(3,1)     CurrNode(3,1)    CurrNode(3,1)    CurrNode(3,1)     CurrNode(3,1)    CurrNode(3,1)    CurrNode(3,1)    CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)+1   CurrNode(3,1)-1   CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1  CurrNode(3,1)-1;
            CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)     CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)     CurrNode(4,1)    CurrNode(4,1)     CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)    CurrNode(4,1)     CurrNode(4,1)   CurrNode(4,1)+1   CurrNode(4,1)+1  CurrNode(4,1)+1   CurrNode(4,1)+1  CurrNode(4,1)+1  CurrNode(4,1)+1   CurrNode(4,1)+1  CurrNode(4,1)+1  CurrNode(4,1)+1   CurrNode(4,1)+1   CurrNode(4,1)+1   CurrNode(4,1)+1   CurrNode(4,1)+1   CurrNode(4,1)+1   CurrNode(4,1)+1   CurrNode(4,1)+1   CurrNode(4,1)+1   CurrNode(4,1)+1   CurrNode(4,1)+1   CurrNode(4,1)+1  CurrNode(4,1)+1  CurrNode(4,1)+1  CurrNode(4,1)+1  CurrNode(4,1)+1  CurrNode(4,1)+1  CurrNode(4,1)+1  CurrNode(4,1)+1  CurrNode(4,1)-1  CurrNode(4,1)-1  CurrNode(4,1)-1   CurrNode(4,1)-1  CurrNode(4,1)-1  CurrNode(4,1)-1   CurrNode(4,1)-1  CurrNode(4,1)-1  CurrNode(4,1)-1   CurrNode(4,1)-1   CurrNode(4,1)-1   CurrNode(4,1)-1   CurrNode(4,1)-1   CurrNode(4,1)-1   CurrNode(4,1)-1   CurrNode(4,1)-1   CurrNode(4,1)-1   CurrNode(4,1)-1   CurrNode(4,1)-1   CurrNode(4,1)-1  CurrNode(4,1)-1  CurrNode(4,1)-1  CurrNode(4,1)-1  CurrNode(4,1)-1  CurrNode(4,1)-1  CurrNode(4,1)-1  CurrNode(4,1)-1];       
    for y=1:80
        if (0<NeiSet(1,y) & 10>NeiSet(1,y)& 0<NeiSet(2,y) & 10>NeiSet(2,y)& 0<NeiSet(3,y) & 10>NeiSet(3,y)& 0<NeiSet(4,y) & 10>NeiSet(4,y))
            if( (DijFullData(NeiSet(1,y),NeiSet(2,y),NeiSet(3,y),NeiSet(4,y)).Q(CurrNode(1,1),CurrNode(2,1),CurrNode(3,1),CurrNode(4,1)) + DijData(CurrNode(1,1),CurrNode(2,1),CurrNode(3,1),CurrNode(4,1)).Q) < (DijData(NeiSet(1,y),NeiSet(2,y),NeiSet(3,y),NeiSet(4,y)).Q)) 
                    DijData(NeiSet(1,y),NeiSet(2,y),NeiSet(3,y),NeiSet(4,y)).Q=DijFullData(NeiSet(1,y),NeiSet(2,y),NeiSet(3,y),NeiSet(4,y)).Q(CurrNode(1,1),CurrNode(2,1),CurrNode(3,1),CurrNode(4,1))+ DijData(CurrNode(1,1),CurrNode(2,1),CurrNode(3,1),CurrNode(4,1)).Q;
                    DijData(NeiSet(1,y),NeiSet(2,y),NeiSet(3,y),NeiSet(4,y)).T=[CurrNode,DijData(CurrNode(1,1),CurrNode(2,1),CurrNode(3,1),CurrNode(4,1)).T];
                    DijData(NeiSet(1,y),NeiSet(2,y),NeiSet(3,y),NeiSet(4,y)).U=[DijFullData(NeiSet(1,y),NeiSet(2,y),NeiSet(3,y),NeiSet(4,y)).U(CurrNode(1,1),CurrNode(2,1),CurrNode(3,1),CurrNode(4,1)),DijData(CurrNode(1,1),CurrNode(2,1),CurrNode(3,1),CurrNode(4,1)).U];
                end
        end
    end
    for z=1:9
        for a=1:9
            for b=1:9
                for d=1:9
                     watchF=DijData(d,b,a,z).F + watchF;
                end
            end
        end
    end
    watchF
end
disp ' 4D Dijk BEST '

