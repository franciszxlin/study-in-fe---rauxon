clear, clc;
% All of the simulation is based on the weekly
rng(1);
warning('off');
% Part 1: Fine tuning the theta(t) and h_t0
aMarketCDSSpread = [0.005, 0.0055, 0.0058];
aZ = normrnd(0, 1, 1000, 156);
[h_t0, theta_t] = tuneHazardPathParameter( aZ, aMarketCDSSpread, 0.85, 0.65, 3 ); % The tuned H_t0 = 0.3%, Theta_t = [1.38%, 0.57%, 1.06%]

theHazardPath = genHazardRate( aZ, 0.85, repelem([0.0138, 0.0057, 0.0106], 52), 0.8, 0.003, 3 );

% Part 2: Use Hull's Equation to get the BBB cutoff

% Importance sampling
m = .3;
RNDerivative = exp(-m * aZ  - .5 * m^2);
theSampledHazardPath = genHazardRate( aZ + m, 0.85, repelem([0.0138, 0.0057, 0.0106], 52), 0.8, 0.003, 3 );

cutoff         = repelem(theDefaultProb(1:3), 52);
downgradeEvent = theHazardPath(:, 2:end) > cutoff;
defaultEvent   = getDefaultEvent( theSampledHazardPath, 1/52);

% Part 3: Generate the FX rate path
% Clibrate optimal volatility matrix based on market implied Black Scholes
% ISD

FXZ = normrnd(0, 1, 1000, 156) ; 
FXInit = 1.2233 ;
strikeVec = [1.2233, 1.2233, 1.2233] ; 
Tvec = [0.25, 0.5, 1] ; 
implVolVec = [0.1135, 0.112, 0.111] ; 
initMatrix = [0.1135, 0.112, 0.111,0.15,0.16,0.17]; 
TCutoff = [ 13, 26, 39, 52, 104 ] ;
% Model calibration: trained the optimal matrix
trainedVolVector = fminsearch(@(x) optimizeVolMatrix(x, FXZ, FXInit,strikeVec,Tvec,implVolVec, TCutoff), initMatrix) ; 

trainedVolVector(5) = trainedVolVector(4) ;
trainedVolVector(6) = trainedVolVector(4) ;

% generate trained FX paths to use for risk management
trainedFXPath = genFXPath( FXInit, FXZ, trainedVolVector, TCutoff ) ; 


% Part 4: Generate the 