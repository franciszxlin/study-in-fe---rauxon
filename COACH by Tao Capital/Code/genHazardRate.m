function [ theHazardRatePath ] = genHazardRate( aZ, aAlpha, aThetaT, aSigma, aH0, aT )
%GENHAZARDRATE Generate the hazard rate path based on the Tuned theta
%   Input:
%       - aAlpha: a constant that
%       - aThetaT: a Vector of theta that 
%       - aSigma: the sigma term in the volatility
%       - aH0: the starting point
%   Output:
%       - theHazardRatePath: the simulated path for the hazard rate
%   Formula:
%       dh_t = alpha * (theta(t) - h_t)dt + sigma * h_t dWt

[n, nSteps] = size(aZ);
theHazardRatePath = zeros(n, nSteps + 1);
theHazardRatePath(:, 1) = aH0;
dT = aT / nSteps;
for i = 2:nSteps + 1
    theHazardRatePath(:, i) = theHazardRatePath(:, i - 1) + aAlpha * (aThetaT(i - 1) - theHazardRatePath(:, i - 1)) .* dT + aSigma * theHazardRatePath(:, i - 1) .* sqrt(dT) .* aZ(:, i - 1); 
end

end

