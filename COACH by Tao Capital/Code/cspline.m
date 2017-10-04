% A Matlab function that takes T, K, v, k, t intepolate values in T,K,v
% and extrapolate the volatilities based on cubic spline
% Input!
% T: vector of time
% v: vector of Black-Scholes ISD for FX Market
% Output: a vector of extrapolate volatilities for 0.25, 0.5, 0.75, 1, 2, 3
% the vol of year 1-2
function [ epv ] = cspline(T,v)
    xq=[0.25, 0.5, 0.75, 1, 2, 3] ;
    epv=[ spline(T,v,xq) ] ;
end

