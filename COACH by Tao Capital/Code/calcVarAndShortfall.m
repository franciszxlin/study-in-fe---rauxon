% This is a function that takes in a PnL vector to calculate VaR and
% Expected Shortfall based on selected confidence level 
function metric = calcVarAndShortfall(pl,alp)
plsorted=sort(pl) ; 
n = length(pl) ; 
var_pick=ceil(n*alp) ;
var=plsorted(var_pick) ; 
sf=mean(plsorted(var_pick:n)) ;
metric(1)=var ;
metric(2)=sf ; 
end
