function [alphaDash] = getAlphaDash(FGIm,a,b,QVal)
    %FGIm = Image of Fourier of Gaussian of size m x n
    %Qval = Q value at a,b 
    [m, n] = size(FGIm);
    alphaDash = exp(QVal);
    Temp = 0.0;
    for i=-1:1
        for j=-1:1
            
            x =-2*a +i*m;
            y = -2*b +j*n;
            x = mod(x,m);
            y = mod(y,n);
            x = x+1;
            y = y+1;
            Temp = Temp + abs(FGIm(x,y));
        end
    end
    % needed to add g(0,0), added FGIm(1,1)
    %                           ^Check
    Temp = Temp + FGIm(1,1);
    alphaDash = alphaDash/Temp;
end