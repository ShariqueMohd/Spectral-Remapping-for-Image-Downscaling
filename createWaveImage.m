function[Result] = createWaveImage(wave,imageSize)
tempx = 1:imageSize(1);
tempx = repmat(tempx,[imageSize(2),1]);
tempy = 1:imageSize(2);
tempy = tempy';
tempy = repmat(tempy,[1,imageSize(2)]);
arg = tempx*wave(2)+tempy*wave(3) +wave(4);
arg = 2i*pi*arg;
Result = (wave(1)/2)*exp(arg);
Result = real(Result);
Result = Result+(wave(1)/2);
end