function [nMat] = getNeighbourLog(Im,x,y)
    Temp = abs(Im);
    nMat = zeros(3,3);
    [N, M] = size(Im);
    for i=-1:1
        for j=-1:1
            X=x+i; Y=y+j;
            if X>0 && Y>0 && X<=N && Y<=M
                nMat(i+2,j+2) = Temp(X,Y);
            end
        end
    end
end