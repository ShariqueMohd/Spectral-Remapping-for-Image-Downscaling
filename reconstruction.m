function [Img] = reconstruction(image, newWaves,oldWaves,windowFilter)
	
	s=image;
    res = reconstructionFromWaves(oldWaves);
    q=s-res;
    r = reconstructionFromWaves(newWaves);
    A = sum(sum(r.*(conj(r))));
    B = 2*sum(sum(q.*(conj(r))));
    C = sum(sum(q.*(conj(q))))-sum(sum(s.*(conj(s))));
    if C < 0
        b=-B+sqrt(B*B-4*A*C);
        b = b/(2*A);
        Img=q + b*r;
    else
        Img = s;
    end
end