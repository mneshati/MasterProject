clc
for i=1:81
    for j=1:81
        DijData(i,j).Q=inf;
        DijData(i,j).U=inf;
        DijData(i,j).T=inf;
    end
end
i=0;
j=0;

DijData(41,41).Q=0;
DijData(41,41).U=0;
%DijData(41,41).T=;
Destin=41; %Destination, Point41, Point (0,0)

% DijData(i,j)= Route length from each node to the destination
% DijFullData(i,j)= Distance from each node to it's neighbours
% NeiSet= A set of all 8 neighbours of a node
% NodeSet= A set of all nodes that have to be visited

for i=1:81
    Counter(i)=0;
end

NodeSet=[Destin];
NodeSetC=2;
for i=1:inf

    if (10<NodeSet(i) & NodeSet(i)<72 & NodeSet(i)~=10 & NodeSet(i)~=18 & NodeSet(i)~=27 & NodeSet(i)~=36 & NodeSet(i)~=45 & NodeSet(i)~=54 & NodeSet(i)~=63 & NodeSet(i)~=19 & NodeSet(i)~=28 & NodeSet(i)~=37 & NodeSet(i)~=46 & NodeSet(i)~=55 & NodeSet(i)~=64)
        CurrNode=NodeSet(i);
        NeiSet=[CurrNode-10,CurrNode-9,CurrNode-8,CurrNode-1,CurrNode+1,CurrNode+8,CurrNode+9,CurrNode+10];
        for y=1:8
            Counter(NeiSet(y))=Counter(NeiSet(y))+1;
        end
        for z=1:8
            if (Counter(NeiSet(z))<9)
                NodeSet(NodeSetC)=NeiSet(z);
                NodeSetC=NodeSetC+1;
            end
        end
    end

    if (NodeSet(i)<9 & 1<NodeSet(i))
        CurrNode=NodeSet(i);
        NeiSet=[CurrNode-1,CurrNode+1,CurrNode+8,CurrNode+9,CurrNode+10];
        for y=1:5
            Counter(NeiSet(y))=Counter(NeiSet(y))+1;
        end
        for z=1:5
            if (Counter(NeiSet(z))<9)
                NodeSet(NodeSetC)=NeiSet(z);
                NodeSetC=NodeSetC+1;
            end
        end
    end
    if (NodeSet(i)==1)
        CurrNode=NodeSet(i);
        NeiSet=[CurrNode+1,CurrNode+9,CurrNode+10];
        for y=1:3
            Counter(NeiSet(y))=Counter(NeiSet(y))+1;
        end
        for z=1:3
            if (Counter(NeiSet(z))<9)
                NodeSet(NodeSetC)=NeiSet(z);
                NodeSetC=NodeSetC+1;
            end
        end
     end
     if (NodeSet(i)==9)
         CurrNode=NodeSet(i);
         NeiSet=[CurrNode-1,CurrNode+8,CurrNode+9];
         for y=1:3
             Counter(NeiSet(y))=Counter(NeiSet(y))+1;
         end
         for z=1:3
             if (Counter(NeiSet(z))<9)
                 NodeSet(NodeSetC)=NeiSet(z);
                 NodeSetC=NodeSetC+1;
             end
         end
     end
     if(NodeSet(i)<81 & 73<NodeSet(i))
         CurrNode=NodeSet(i);
         NeiSet=[CurrNode-10,CurrNode-9,CurrNode-8,CurrNode-1,CurrNode+1];
         for y=1:5
             Counter(NeiSet(y))=Counter(NeiSet(y))+1;
         end
         for z=1:5
             if (Counter(NeiSet(z))<9)
                 NodeSet(NodeSetC)=NeiSet(z);
                 NodeSetC=NodeSetC+1;
             end
         end
     end
     if( NodeSet(i)==73 )
         CurrNode=NodeSet(i);
         NeiSet=[CurrNode-9,CurrNode-8,CurrNode+1];
         for y=1:3
             Counter(NeiSet(y))=Counter(NeiSet(y))+1;
         end
         for z=1:3
             if (Counter(NeiSet(z))<9)
                 NodeSet(NodeSetC)=NeiSet(z);
                 NodeSetC=NodeSetC+1;
             end
         end
     end
     if (NodeSet(i)==81)
         CurrNode=NodeSet(i);
         NeiSet=[CurrNode-10,CurrNode-9,CurrNode-1];
         for y=1:3
             Counter(NeiSet(y))=Counter(NeiSet(y))+1;
         end
         for z=1:3
             if (Counter(NeiSet(z))<9)
                 NodeSet(NodeSetC)=NeiSet(z);
                 NodeSetC=NodeSetC+1;
             end
         end
     end

     if (NodeSet(i)==10|NodeSet(i)==19|NodeSet(i)==28|NodeSet(i)==37|NodeSet(i)==46|NodeSet(i)==55|NodeSet(i)==64)
        CurrNode=NodeSet(i);
        NeiSet=[CurrNode-9,CurrNode-8,CurrNode+1,CurrNode+9,CurrNode+10];
        for y=1:3
            Counter(NeiSet(y))=Counter(NeiSet(y))+1;
        end
        for z=1:3
            if (Counter(NeiSet(z))<9)
                NodeSet(NodeSetC)=NeiSet(z);
                NodeSetC=NodeSetC+1;
            end
        end
    end
    if (NodeSet(i)==18|NodeSet(i)==27|NodeSet(i)==36|NodeSet(i)==45|NodeSet(i)==54|NodeSet(i)==63|NodeSet(i)==72)
        CurrNode=NodeSet(i);
        NeiSet=[CurrNode-10,CurrNode-9,CurrNode-1,CurrNode+8,CurrNode+9];
        for y=1:3
            Counter(NeiSet(y))=Counter(NeiSet(y))+1;
        end
        for z=1:3
            if (Counter(NeiSet(z))<9)
                NodeSet(NodeSetC)=NeiSet(z);
                NodeSetC=NodeSetC+1;
            end
        end
    end
    for j=1:y
        if ((DijFullData(NeiSet(j),CurrNode).Q + DijData(CurrNode,Destin).Q)< (DijData(NeiSet(j),Destin).Q))
            DijData(NeiSet(j),Destin).Q=DijFullData(NeiSet(j),CurrNode).Q+ DijData(CurrNode,Destin).Q;
            DijData(NeiSet(j),Destin).T=[CurrNode,DijData(CurrNode,Destin).T];
            DijData(NeiSet(j),Destin).U=[DijFullData(NeiSet(j),CurrNode).U,DijData(CurrNode,Destin).U];
        end
    end
end
disp ' 2D Dijk MAIN '
