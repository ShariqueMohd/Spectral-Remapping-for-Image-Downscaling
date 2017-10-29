function [ A,b ] = equation( initialW1,initialW2,finalW1,finalW2,location )
%EQUATION Summary of this function goes here
%   Detailed explanation goes here
% x = c2-c1
mu = AlignmentMeasure(initialW1,initialW2,location);
A = mu;
b = -(mu*(finalW1(2)*location(1)-finalW2(2)*location(1)+finalW1(3)*location(2)-finalW2(3)*location(2)));
end

