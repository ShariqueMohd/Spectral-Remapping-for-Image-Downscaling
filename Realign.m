function [ Result ] = Realign( olderWaves,newWaves )
%REALIGN Summary of this function goes here
%   Detailed explanation goes here
waveNum = 0;
for i = 1:size(olderWaves,1)
    for j = 1:size(olderWaves(i),1)
        for k = 1:size(olderWaves(i,j),1)
%             assuming format to be [alpha,a,b,c] adding wave number to
%             each
            waveNum = waveNum+1;
            olderWaves(i,j,k) =[olderWaves(i,j,k),waveNum];
            newWaves(i,j,k) =[newWaves(i,j,k),waveNum];
        end
    end
end
totalEquations = 0;
for i = 1:size(olderWaves,1)
    for j = 1:size(olderWaves(i),1)
        exterior = 0;
        if(i>1)
            exterior = exterior + size(olderWaves(i-1,j));
        end
        if(j>1)
            exterior = exterior + size(olderWaves(i,j-1));
        end
        current = (size(olderWaves(i,j))*(size(olderWaves(i,j))-1))/2;
        totalEquations = totalEquations+current;
        totalEquations = totalEquations+exterior*(size(olderWaves(i,j)));
    end
end
A = spalloc(totalEquations,waveNum,2*totalEquations);
B = zeros(totalEquations,1);
Equation = 0;
for i = 1:size(olderWaves,1)
    for j = 1:size(olderWaves(i),1)
        for k = 1:size(olderWaves(i,j))
            currentOldWave = olderWave(i,j,k);
            currentNewWave = newWaves(i,j,k);
            if(i>1)
                for l = 1:size(olderWaves(i-1,j))
                    tempOldWave = olderWaves(i-1,j,l);
                    tempNewWave = newWaves(i-1,j,l);
                    [a,b] = equation(currentOldWave,tempOldWave,currentNewWave,tempNewWave,[i-0.5,j]);
                    Equation = Equation+1;
                    A(Equation,tempOldWave(5)) = -a;
                    A(Equation,currentOldWave(5)) = a;
                    B(Equation) = b;
                    
                end
            end
            if(j>1)
                for l = 1:size(olderWaves(i,j-1))
                    tempOldWave = olderWaves(i,j-1,l);
                    tempNewWave = newWaves(i,j-1,l);
                    [a,b] = equation(currentOldWave,tempOldWave,currentNewWave,tempNewWave,[i,j-0.5]);
                    Equation = Equation+1;
                    A(Equation,tempOldWave(5)) = -a;
                    A(Equation,currentOldWave(5)) = a;
                    B(Equation) = b;
                    
                end
            end
            for l = i+1:size(olderWaves(i,j))
                tempOldWave = olderWaves(i,j,l);
                tempNewWave = newWaves(i,j,l);
                [a,b] = equation(currentOldWave,tempOldWave,currentNewWave,tempNewWave,[i,j]);
                Equation = Equation+1;
                A(Equation,tempOldWave(5)) = -a;
                A(Equation,currentOldWave(5)) = a;
                B(Equation) = b;
            end
        end
    end
end
x = lsqnonneg(A,B);
for i = 1:size(olderWaves,1)
    for j = 1:size(olderWaves(i),1)
        for k = 1:size(olderWaves(i,j),1)
%             assuming format to be [alpha,a,b,c,waveNum]
            newWaves(i,j,k,4) =x(newWaves(i,j,k,5));
        end
    end
end
Result = newWaves;
end

