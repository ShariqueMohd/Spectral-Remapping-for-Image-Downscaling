function [ result ] = inverseGaborTransform( transform,windowFilter )
result = zeros([size(transform,1),size(transform,2)]);
for i = 1:size(transform,1)
    for j=1:size(transform,2)
        temp1 = transform(i,j,:,:);
        temp1=squeeze(temp1);
        temp = ifft2(temp1).*(circshift(windowFilter,[i-1,j-1]));
        result = result+temp;
    end
end
end

