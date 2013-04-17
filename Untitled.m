i=1;
axisLength=17;
for i1=1:axisLength
    for i2=1:axisLength
        for i3=1:axisLength
            for i4=1:axisLength
                for i5=1:axisLength
                    for i6=1:axisLength
                        for i7=1:axisLength
                            for i8=1:axisLength
                                DijFullData(i1,i2,i3,i4).Q(i5,i6,i7,i8)=inf;
                                DijFullData(i1,i2,i3,i4).U(i5,i6,i7,i8)=inf;
                                i=i+1
                            end
                        end
                    end
                end 
            end
            i3
        end
        i2
    end
    i1
end