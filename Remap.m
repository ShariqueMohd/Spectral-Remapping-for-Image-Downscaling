function [ reMappedWavesMap ] = Remap( WavesMap,R )
%REMAP Summary of this function goes here
%   Detailed explanation goes here
reMappedWavesMap = WavesMap;
imageSize = size(reMappedWavesMap);
imageSize = imageSize(1:2);
for i = 1:imageSize(1)
    for j = 1:imageSize(2)
        waves = reMappedWavesMap{i,j};
        number_of_waves = size(waves);
        number_of_waves = number_of_waves(1);
        for k=1:number_of_waves
%             assuming format to be [alpha,a,b,c]
            wave = waves(k,:);
            magnitude = wave(2)*wave(2)+wave(3)*wave(3);
            magnitude = sqrt(magnitude);
            wave(2:3) = wave(2:3)/magnitude;
            newCoeff = 0.4/R;
            wave(2:3) = wave(2:3)*newCoeff;
            reMappedWavesMap{i,j,k} = wave;
        end
    end
end
end

