function [Img] = Reconstruction(Imagename, Q)
	
	I=im2double(imread(Imagename));
	I=rgb2gray(I);
	S=fftshift(fft2(I));

	R=S-Q;
	B=(sum(sum(S.*S))-sum(sum(R.*R)))/sum(sum(Q.*Q));
	b=sqrt(B);

	Img=R + b*Q;
end