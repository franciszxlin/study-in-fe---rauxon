function [ theDefaultProb ] = getDefaultProb( aCDSSpread, aR)
%GETDEFAULTPROB Hull's Equaltion for gross simplification
%Input:
%   - aCDSSpread: a vector of CDS Spread

theDefaultProb = aCDSSpread / (1-aR);

end