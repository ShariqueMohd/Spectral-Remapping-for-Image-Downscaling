function[transform]=gaborTransform(image,windowFilter)
transform = zeros(size(image,1),size(image,2),size(image,1),size(image,2));
for i = 1:size(image,1)
    for j=1:size(image,2)
        arg = image.*(circshift(windowFilter,[i-1,j-1]));
        temp = fft2(arg);
        transform(i,j,:,:) = temp;
    end
end
end