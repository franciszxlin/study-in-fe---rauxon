function [ theLocalVol ] = localVol( aT, aTCutoff, aLVVector )
% LocalVol: a function to generate local volatility
%    Inputs:
%         - aT: (double) a point in time
%         - aTCutoff:   a vector of cutoff time (n) 
%         - aLVVector:  the appropriate local volatilities (n+1)
for i = 1:length(aTCutoff)
    if aT <= aTCutoff(i)
        LVVector = aLVVector(i) ; 
        break
    end
end
if aT > aTCutoff(end)
    LVVector = aLVVector(end) ; 
end 
theLocalVol = LVVector ;
end 