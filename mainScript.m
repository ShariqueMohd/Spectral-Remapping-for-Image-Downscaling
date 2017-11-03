function [ result ] = mainScript( image,R,sigma )
%MAINSCRIPT Summary of this function goes here
%   Detailed explanation goes here

windowFilter = getGaussianFilter(size(image,1),size(image,2),sigma);
all_waves = getAllWaves(image,R,windowFilter);
down_scaled_waves= Remap(all_waves,R);
realigned_waves = Realign(all_waves,down_scaled_waves);
result = reconstruction(image,realigned_waves,all_waves,windowFilter);
end

