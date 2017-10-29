function [ waves ] = GetWaves( Image,filter )
fftImage = fft(Image);
fftFilter = fft(filter);
waves = [];
maxAlpha = -1;
currentMag = sum(sum(fftImage.*fftImage));
while size(waves)<10
    
    maxLocation = getMaxFFTPixel(fftImage);
    maxLocation = maxLocation-1;
    a = maxLocation(1)/size(fftImage(1));
    b = maxLocation(2)/size(fftImage(2));
    alphaDash = getAlphaDash(fftImage,a,b,log(abs(fftImage(maxLocation+1))));
    maxAlpha = max(maxAlpha,alphaDash);
    if alphaDash<maxAlpha/4
        break;
    end
    waveImage = createWaveImage([alphaDash,a,b,0],size(Image));
    fwaveImage = filter.*waveImage;
    fftWaveImage = fft(fwaveImage);
    d = sum(sum(fftWaveImage.*fftImage));
    c1 = atan2(-real(d),imag(d));
    c2 = atan2(real(d),-imag(d));
    f1 = cos(c1)*real(d)-sin(c1)*imag(d);
    f2 = cos(c2)*real(d)-sin(c2)*imag(d);
    if f1>f2
        wave(4) = mod((c1/(2*pi)),1);
    else
        wave(4) = mod((c2/(2*pi)),1);
    end
    waveImage = createWaveImage(wave,size(Image));
    fwaveImage = filter.*waveImage;
    fftWaveImage = fft(fwaveImage);
    fftImage = fftImage-fftWaveImage;
    Mag = sum(sum(fftImage.*fftImage));
    if Mag>=currentMag
        break;
    end
    currentMag = Mag;
    waves = [waves;wave]
end
end

