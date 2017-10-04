function [ theHt0, theThetaT ] = tuneHazardPathParameter( aZ, aMarketCDSSpread, aAlpha, aSigma, aT )
%TUNEHAZARDPATHPARAMETER tune Hazard Path Parameter based on the 
%   
initVal = [0.02, 0.01, 0.01, 0.01];
optimRes = fminsearch(@(x) genLossVal(x, aZ, aMarketCDSSpread, aAlpha, aSigma, aT), initVal);
theHt0 = optimRes(1);
theThetaT = optimRes(2:end);

end

function [theLossVal] = genLossVal(x, aZ, marketSpread, aAlpha, aSigma, aT)
ht0 = x(1);
thetat = repelem(x(2:end), 52);
hPath = genHazardRate(aZ, aAlpha, thetat, aSigma, ht0, aT);
modelSpread(1) = genCDSSpread( hPath(:, 2:52*1+1), 1/52, .25);
modelSpread(2) = genCDSSpread( hPath(:, 2:52*2+1), 1/52, .25);
modelSpread(3) = genCDSSpread( hPath(:, 2:52*3+1), 1/52, .25);
theLossVal     = sum( (modelSpread - marketSpread) .^ 2);
end