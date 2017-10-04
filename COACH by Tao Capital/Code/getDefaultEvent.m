function [ theDefaultEvent ] = getDefaultEvent( aHazardPath, aDT )
%GETDEFAULTEVENT Summary of this function goes here
%   Detailed explanation goes here

[n, N] = size(aHazardPath);
U      = rand(n, N);
theDefaultEvent = U < (aHazardPath * aDT);

end

