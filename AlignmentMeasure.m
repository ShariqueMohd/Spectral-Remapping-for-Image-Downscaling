function [ result ] = AlignmentMeasure( W1,W2,location )
%ALIGNMENTMEASURE Summary of this function goes here
%   Detailed explanation goes here
lambda = 0.5;
tempx = [-1,0,1];
tempy = [-1;0;1];
tempx = tempx+location(1);
tempy = tempy+location(2);
tempx = repmat(tempx,3,1);
tempy = repmat(tempy,1,3);
arg1 = W1(2)*tempx+W1(3)*tempy+W1(4);
arg2 = W2(2)*tempx+W2(3)*tempy+W2(4);
arg1 = 2i*pi*arg1;
arg2 = 2i*pi*arg2;
exp1 = W1(1)*exp(arg1);
exp2 = W2(1)*exp(arg2);
del = exp1-exp2;
del = abs(del);
del = del.^2;
del = sum(sum(del));
del = sqrt(del);
del = del/min(W1(1),W2(1));
result = exp(-((del*del)/(lambda*lambda)));
end

