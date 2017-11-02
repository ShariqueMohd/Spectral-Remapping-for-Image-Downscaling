function [GF] = getGaussianFilter(N, M, sigma)
    Size = max(N,M);
    GF = fspecial('gaussian',[N,M],sigma);
    GF = fftshift(GF);
end