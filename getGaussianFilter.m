function [GF] = getGaussianFilter(N, M, sigma)
    Size = max(N,M);
    GF = fspecial('gaussian',2*Size+1,sigma);
end