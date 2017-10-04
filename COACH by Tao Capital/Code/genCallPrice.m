function [ theCallPrice ] = genCallPrice( FXPath, aStrike, aR, aT) 
    theCallPrice = exp(-aR * aT) * mean( max(FXPath(:, aT * 52 + 1) - aStrike, 0)) ; 
end 