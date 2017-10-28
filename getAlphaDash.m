function [alphaDash] = getAlphaDash(FGIm,a,b,QVal)
    %FGIm = Image of Fourier of Gaussian of size m x n
    %Qval = Q value at a,b 
    [m, n] = size(FGIm);
    alphaDash = exp(QVal);
    Temp = 0.0;
    for i=-1:1
        for j=-1:1
            x = -2*a+i; y = -2*b+j;
            if x<=0 
                x = x + m;
            end
            if y<=0
                y = y + n;
            end
            Temp = Temp + FGIm(x,y);
        end
    end
    % needed to add g(0,0), added FGIm(1,1)
    %                           ^Check
    Temp = Temp + FGIm(1,1);
    alphaDash = alphaDash/Temp;
end