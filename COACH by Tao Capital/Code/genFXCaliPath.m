function[ FXCaliPath ] = genFXCaliPath( aInitVal, aZ, aLVVector, aTCutoff)
deltaT = 1/52 ; 
FXCaliPath = ones(size(aZ, 1), size(aZ,2) + 1) * aInitVal ; 
for i = 2:size(FXCaliPath, 2)
    loVol = localVol( i, aTCutoff, aLVVector ); 
    FXCaliPath(:, i) = FXCaliPath(:, i-1) .* exp( (- 0.5 * loVol.^2) * deltaT + sqrt(deltaT) * loVol .* aZ(:, i-1)) ; 
end 
end
