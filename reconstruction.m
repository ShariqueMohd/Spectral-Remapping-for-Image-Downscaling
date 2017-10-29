function [Img] = Reconstruction(Imagename, Q)
	
	Siz = size(Im);
	Filter=getGaussianFilter(Siz(1),Siz(2),2.0);
    res = zeros(Siz);
    [x,y] = size(Filter);
    x = (x+1)/2;
    y = (y+1)/2;
    for m=1:Siz(1)
        for n1:Siz(2)
            res(i,j,k) = Im(i,j,k) * Filter (i-m+x,j-n+y);
        end
    end
	Img=R + b*Q;
end