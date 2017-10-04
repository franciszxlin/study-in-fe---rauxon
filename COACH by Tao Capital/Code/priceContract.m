function [ thePrice, theVaR, theShortFall ] = priceContract( aDowngradeEvent, aDefaultEvent, aFXPath )
%VALUATECONTRACT The value of the contract
[n, N] = size(aDowngradeEvent);

currentValue = zeros(n, 1);
interestRate = genUSIR((1:N) / 52);

for i = 1:n
    if sum(aDefaultEvent(i, :) > 0)
        defaultTime = find(aDefaultEvent(i,:), 1, 'first') - 1;
        % If not out-of-blue
        if sum(aDowngradeEvent(i, 1: defaultTime) > 0)
            currentValue(i) =  exp(- interestRate(defaultTime) * defaultTime / 52) * (aFXPath(i, defaultTime + 1) - 1.024) * 0.75;
        end
    end
end
thePrice = mean(currentValue);
metric   = calcVarAndShortfall(currentValue, 0.95);
theVaR   = metric(1);
theShortFall = metric(2);
end

