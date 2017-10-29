function [Img] = Reconstruction(Imagename, Q)
	
	Siz = size(rgb2gray(Imagename));
	Filter=getGaussianFilter(Siz(1),Siz(2),2.0);
    res = zeros(Siz);
    [x,y] = size(Filter);
    x = (x+1)/2;
    y = (y+1)/2;
    for m=1:Siz(1)
        for n=1:Siz(2)
            A=C(m,n);
            for k=1:lenght(A)
                B=A{1};
                [Result] = createWaveImage(B,Siz);
                %FIl=FIlter(((x-m):(x-m+Size(1)))((y-n):(y-n+Size(2))));
                %r=FIL.*Result;
                res=res+Result;
            end
        end
    end
    Fil=Filter.*Filter;
    res=res.*Fil;
    S=rgb2gray(im2double(imread(Imagename)));
    q=S-res;
    b=(sum(sum(S.*S))-sum(sum(q.*q)))/(sum(sum(res.*res)));
	Img=q + b*res;
end