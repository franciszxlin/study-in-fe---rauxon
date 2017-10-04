function [ theSpread ] = genCDSSpread( aHazardPath, aDeltaT, aRecoveryRate )
%GENCDSSPREAD From the simulated hazard rate path to CDS spread
%   - aHazardPath: Hazard rate path
%   - aDeltaT: 1/52

[n, N] = size(aHazardPath);
expiry = N/52;
deannualHPath       = aHazardPath * aDeltaT;
survivalRate        = cumprod( 1 - deannualHPath , 2);
defaultProb         = - diff([ones(n , 1) , survivalRate], 1, 2);

initSpread = 0.02 * ones(n, 1);
options = optimset('Display','off');
finalSpread = fsolve( @(x) getBuyerSellerDiff(x , survivalRate, aRecoveryRate, defaultProb, expiry) , initSpread, options);
theSpread  = mean(finalSpread) * 52;
end

function [theDiff] = getBuyerSellerDiff(initSpread, survivalRate , aRecoveryRate, defaultProb, expiry)
    buyerPayment =  initSpread .*survivalRate;
    sellerPayoff = (1 - aRecoveryRate) .* defaultProb;
    discountRate = getDiscountCurve(expiry)';
    pvBuyer     = sum( buyerPayment .* discountRate, 2);
    pvSeller    = sum( sellerPayoff .* discountRate, 2);
    theDiff     = pvBuyer - pvSeller;
end