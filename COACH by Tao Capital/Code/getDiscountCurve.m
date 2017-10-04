function [ theDiscountCurve ] = getDiscountCurve( maxT )
%GETDISCOUNTCURVE Summary of this function goes here
%   Detailed explanation goes here
N = maxT * 52;
timeVec = linspace(0, maxT, N)';
if exist('disCurve.mat')
    savedCurve = load('disCurve.mat','disCurve');
    savedCurve = savedCurve.disCurve;
    theDiscountCurve = savedCurve(1: N);
else
    interestRate  =  genUSIR(timeVec);
    theDiscountCurve = exp( - interestRate .* timeVec);
end
end
