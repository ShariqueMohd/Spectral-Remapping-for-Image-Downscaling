function[result] = reconstructionFromWaves(waves)
imageSize = size(waves);
imageSize = imageSize(1:2);
result = zeros(imageSize(1:2));
Filter=getGaussianFilter(imageSize(1),imageSize(2),2.0);
Fil=Filter.*Filter;
% Fil = Filter;
for m=1:imageSize(1)
    for n=1:imageSize(2)
        A=waves(m,n);
        tempRes = zeros(imageSize);
        for k=1:size(A)
            B=A{1};
            [Result] = createWaveImage(B,imageSize);
%             result(1,1)
            %FIl=FIlter(((x-m):(x-m+Size(1)))((y-n):(y-n+Size(2))));
            %r=FIL.*Result;
            tempRes=tempRes+Result;
        end
        tempRes = tempRes.*circshift(Fil,[m-1,n-1]);
        result  =result+tempRes;
    end
end
end