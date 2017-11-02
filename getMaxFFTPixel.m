function [res] = getMaxFFTPixel(imFFT,R)
    Im = abs(imFFT);
    [N, M] = size(Im);
    vLimit =int16(N/(2*R));
    hLimit = int16(M/(2*R));
    Im(1:(vLimit),1:(hLimit))=0;
    Im((end-vLimit+1):end,1:(hLimit))=0;
    Im((end-vLimit+1):end,(end-hLimit+1):end)=0;
    Im(1:(vLimit),(end-hLimit+1):end)=0;
    [M,I] = max(Im);
    [M1,I1] = max(M);
    res = [I(I1) I1];
    if M1==0
        res = -1;
    end
end