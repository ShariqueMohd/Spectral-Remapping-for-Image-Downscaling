function [ waves ] = GetWaves( image,windowFilter,R )
fImage = image.*windowFilter;
fftImage = fft2(fImage);
fftFilter = fft2(windowFilter);
Size  =size(image);
waves = [];
maxAlpha = -1;
currentMag = sum(sum(fftImage.*conj(fftImage)));
% imshow(abs(fftImage));
while size(waves)<10
    maxLocation = getMaxFFTPixel(fftImage,R);
    if(maxLocation == -1)
        break;
    end
    maxLocation = maxLocation-1;
    a = maxLocation(2);
    b = maxLocation(1);
    alphaDash = getAlphaDash(fftFilter,b,a,log(abs(fftImage(maxLocation(2)+1,maxLocation(1)+1))));
    maxAlpha = max(maxAlpha,alphaDash);
    if alphaDash<maxAlpha/4
        break;
    end
    wave = [alphaDash,a/Size(2),b/Size(1),0];
    waveFFT = zeros(Size);
    waveFFT(b+1,a+1) = alphaDash*Size(1)*Size(2);
    waveImage = ifft2(waveFFT);
    fwaveImage = windowFilter.*waveImage;
    fftWaveImage = fft2(fwaveImage);
    d = sum(sum(fftWaveImage.*conj(fftImage)));
    c1 = atan2(-imag(d),real(d));
    c2 = atan2(imag(d),-real(d));
    f1 = cos(c1)*real(d)-sin(c1)*imag(d);
    f2 = cos(c2)*real(d)-sin(c2)*imag(d);
    if f1>f2
        wave(4) = mod((c1/(2*pi)),1);
    else
        wave(4) = mod((c2/(2*pi)),1);
    end
%     waveImage = createWaveImage(wave,size(image));
%     imshow(waveImage);
%     fwaveImage = windowFilter.*waveImage;
    fftWaveImage = fftWaveImage*exp(2i*pi*wave(4));
%     imshow(abs(fftWaveImage));
    fftImage = fftImage-fftWaveImage;
%     imshow(abs(fftImage));
    Mag = sum(sum(fftImage.*conj(fftImage)));
    if Mag>=currentMag
        break;
    end
    currentMag = Mag;
    waves = [waves;wave];
    
    
end
end

