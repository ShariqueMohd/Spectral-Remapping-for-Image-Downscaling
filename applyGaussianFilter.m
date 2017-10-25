function [res] = applyGaussianFilter(Im, Filter, m, n)
    Size = size(Im);
    res = zeros(Size);
    [x,y] = size(Filter);
    x = (x+1)/2;
    y = (y+1)/2;
    for k=1:Size(3)
        for i=1:Size(1)
            for j=1:Size(2)
                res(i,j,k) = Im(i,j,k) * Filter (i-m+x,j-n+y);
            end
        end
    end
end