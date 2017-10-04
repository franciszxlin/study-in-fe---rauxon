function [ loss ] = optimizeVolMatrix( aVol, aZ, aInitVal, aStrikePriceVec, aTVec, aImplVolTargetVec, aTCutoff)
% OPTIMIZEVOL function
FXPath = genFXPath( aInitVal, aZ, aVol, aTCutoff) ; 
implVolVec=zeros(size(aStrikePriceVec)) ; 

for i=1:length(implVolVec)
    tempCall = genCallPrice( FXPath, aStrikePriceVec(i), 0 , aTVec(i)) ; 
    implVolVec(i) = blsimpv( aInitVal, aStrikePriceVec(i), 0 , aTVec(i), tempCall) ; 
end

loss = sum( (implVolVec - aImplVolTargetVec).^2 ); 
end