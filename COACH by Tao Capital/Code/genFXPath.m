function [ FXPath ] = genFXPath( aInitVal, aZ, aLVVector, aTCutoff)
deltaT = 1/52 ; 
FXPath = ones(size(aZ, 1), size(aZ,2) + 1) * aInitVal ; 
for i = 2:size(FXPath, 2)
    loVol = localVol( i, aTCutoff, aLVVector );
    usrate = genUSIR( i*deltaT ) ; 
    eurate = genEUIR( i*deltaT ) ;
    FXPath(:, i) = FXPath(:, i-1) .* exp( ((usrate - eurate) - 0.5 * loVol.^2) * deltaT + sqrt(deltaT) * loVol .* aZ(:, i-1)); 
end
end