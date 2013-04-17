%clc

%%Parametrization---------------------
Destin=[5;5]; %Destination, Point (0,0)
NodeSet=[Destin];% NodeSet= A set of all nodes that have to be visited
NodeSetC=2;
for i=1:9
    for j=1:9
        Counter(i,j)=0; % Counts the number of the times a point[i;j] has been visited
    end
end
Counter(5,5)=1;
for i=1:9
    for j=1:9
        DijData(i,j).Q=inf;
        DijData(i,j).U=[];
        DijData(i,j).T=[];
    end
    %DijData(i,j)= Information of the route from the initial point given [i;j]
    %to the destination
end
DijData(5,5).Q=0;
DijData(5,5).U=0;
%DijData(5,5).T=[0;0];
i=0;
j=0;

%%START---------------------

for i=1:inf
    if (0<NodeSet(1,i) & 10>NodeSet(1,i)& 0<NodeSet(2,i) & 10>NodeSet(2,i))
        CurrNode(:,i)=[NodeSet(1,i);NodeSet(2,i)];
        NeiSet=[CurrNode(1,i)   CurrNode(1,i)+1  CurrNode(1,i)+1 CurrNode(1,i)+1   CurrNode(1,i)    CurrNode(1,i)-1  CurrNode(1,i)-1  CurrNode(1,i)-1;
               CurrNode(2,i)+1  CurrNode(2,i)+1  CurrNode(2,i)   CurrNode(2,i)-1  CurrNode(2,i)-1   CurrNode(2,i)-1   CurrNode(2,i)   CurrNode(2,i)+1];
        for y=1:8
            if (0<NeiSet(1,y) & 10>NeiSet(1,y)& 0<NeiSet(2,y) & 10>NeiSet(2,y))
                Counter(NeiSet(1,y),NeiSet(2,y))=Counter(NeiSet(1,y),NeiSet(2,y))+1;
                if (Counter(NeiSet(1,y),NeiSet(2,y))<65)
                    NodeSet(:,NodeSetC)=NeiSet(:,y);
                    NodeSetC=NodeSetC+1;
                end
            end
        end
    end
    for j=1:8
        if (0<NeiSet(1,j) & 10>NeiSet(1,j)& 0<NeiSet(2,j) & 10>NeiSet(2,j))
            if( (DijFullData(NeiSet(1,j),NeiSet(2,j)).Q(CurrNode(1,i),CurrNode(2,i)) + DijData(CurrNode(1,i),CurrNode(2,i)).Q) < (DijData(NeiSet(1,j),NeiSet(2,j)).Q)) 
                DijData(NeiSet(1,j),NeiSet(2,j)).Q=DijFullData(NeiSet(1,j),NeiSet(2,j)).Q(CurrNode(1,i),CurrNode(2,i))+ DijData(CurrNode(1,i),CurrNode(2,i)).Q;
                DijData(NeiSet(1,j),NeiSet(2,j)).T=[CurrNode(:,i),DijData(CurrNode(1,i),CurrNode(2,i)).T];
                DijData(NeiSet(1,j),NeiSet(2,j)).U=[DijFullData(NeiSet(1,j),NeiSet(2,j)).U(CurrNode(1,i),CurrNode(2,i)),DijData(CurrNode(1,i),CurrNode(2,i)).U];
            end
        end
    end
end
disp ' 2D Dijk test18Feb '
