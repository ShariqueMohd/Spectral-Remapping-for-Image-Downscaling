function [ allWaves ] = getAllWaves( image,R )
%GETALLWAVES Summary of this function goes here
%   Detailed explanation goes here
sigma = 10;
windowFilter = getGaussianFilter(size(image,1),size(image,2),sigma);
allWaves = cell(size(image,1),size(image,2));
for i = 1:size(image,1)
    for j = 1:size(image,2)
        [i,j]
        allWaves(i,j) = {GetWaves(image,circshift(windowFilter,[i,j]-1),R)};
    end
end

end

