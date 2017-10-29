function [ output_args ] = Remap( WavesMap,R )
%REMAP Summary of this function goes here
%   Detailed explanation goes here
reMappedWavesMap = WavesMap;
for waveRows = reMappedWavesMap
    for waves = waveRows
        for wave = waves
%             assuming format to be [alpha,a,b,c]
            magnitude = wave(2).wave(2)+wave(3)*wave(3);
            magnitude = sqrt(magnitude);
            wave(2:3) = wave(2:3)/magnitude;
            newCoeff = 0.4/R;
            wave(2:3) = wave(2:3)*newCoeff;
        end
    end
end
end

