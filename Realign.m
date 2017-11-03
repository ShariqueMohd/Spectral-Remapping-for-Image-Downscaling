function [ Result ] = Realign( olderWaves,newWaves )
%REALIGN Summary of this function goes here
%   Detailed explanation goes here
waveNum = 0;
imageSize = size(newWaves);
imageSize = imageSize(1:2);
for i = 1:imageSize(1)
    for j = 1:imageSize(2)
        waves = olderWaves{i,j};
        number_of_waves = size(waves);
        number_of_waves = number_of_waves(1);
        o = olderWaves{i,j};
        o = [o,0];
        o(:,5)=1:size(o,1);
        o(:,5) = o(:,5)+waveNum;
        olderWaves{i,j} = o;
        
        o = newWaves{i,j};
        o = [o,0];
        o(:,5)=1:size(o,1);
        o(:,5) = o(:,5)+waveNum;
        newWaves{i,j} = o;
        
        waveNum = waveNum + size(o,1);
    end
end
totalEquations = 0;
for i = 1:imageSize(1)
    for j = 1:imageSize(2)
        exterior = 0;
        if(i>1)
            exterior = exterior + size(olderWaves{i-1,j},1);
        end
        if(j>1)
            exterior = exterior + size(olderWaves{i,j-1},1);
        end
        current = (size(olderWaves{i,j},1)*(size(olderWaves{i,j},1)-1))/2;
        totalEquations = totalEquations+current;
        totalEquations = totalEquations+exterior*(size(olderWaves{i,j},1));
    end
end

A = spalloc(totalEquations,waveNum,2*totalEquations);
B = zeros(totalEquations,1);
Equation = 0;
for i = 1:imageSize(1)
    for j = 1:imageSize(2)
        waves = olderWaves{i,j};
        number_of_waves = size(waves);
        number_of_waves = number_of_waves(1);
        for k = 1:number_of_waves

            currentOldWave = olderWaves{i,j,k};
            currentNewWave = newWaves{i,j,k};
            if(i>1)
                for l = 1:size(olderWaves{i-1,j},1)
                    tempOldWave = olderWaves{i-1,j,l};
                    tempNewWave = newWaves{i-1,j,l};
                    [a,b] = equation(currentOldWave,tempOldWave,currentNewWave,tempNewWave,[i-0.5,j]);
                    Equation = Equation+1;
                    A(Equation,tempOldWave(5)) = -a;
                    A(Equation,currentOldWave(5)) = a;
                    B(Equation) = b;
                    
                end
            end
            if(j>1)
                for l = 1:size(olderWaves{i,j-1},1)
                    tempOldWave = olderWaves{i,j-1,l};
                    tempNewWave = newWaves{i,j-1,l};
                    [a,b] = equation(currentOldWave,tempOldWave,currentNewWave,tempNewWave,[i,j-0.5]);
                    Equation = Equation+1;
                    A(Equation,int16(tempOldWave(5))) = -a;
                    A(Equation,currentOldWave(5)) = a;
                    B(Equation) = b;
                    
                end
            end
            for l = i+1:size(olderWaves{i,j},1)
                tempOldWave = olderWaves{i,j,l};
                tempNewWave = newWaves{i,j,l};
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
for i = 1:imageSize(1)
    for j = 1:imageSize(2)
        waves = newWaves{i,j};
        waves(:,4) = x(waves(1,5):waves(end,5));
        newWaves{i,j} = waves;
    end
end
Result = newWaves;
end

