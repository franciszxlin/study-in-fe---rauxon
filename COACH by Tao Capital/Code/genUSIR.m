% This script will fit Nelson-Siegel function to Fit Bond Market Data and
% interpolate the yield curve
% Assumption: datenum('01-Mar-2014') is the settle date for the yield curve
% Input: a datenum variable, 
% Output: a 1*2 matrix with the interpolated USD and EUR risk free rates
function [ rate ] = genUSIR( interval )
    date = datestr(datenum('01-Mar_2004')+interval*360) ; 
    Settle = repmat(datenum('01-Mar-2004'), [5,1]); 
    Maturity = [datenum('01-Mar-2005'); datenum('01-Mar-2006');
                datenum('01-Mar-2007'); datenum('01-Mar=2008'); 
                datenum('01-Mar_2009')] ;         
    r_usd = [1.22; 1.98; 2.74; 3.02; 3.50]/100 ;                
    CleanPriceUSD = zeros(5,1) ; 
    for i = 1:5
        CleanPriceUSD(i,1) = 100 * (1 + r_usd(i,1))^(-i) ;
    end
    CouponRate = zeros(5,1) ;
    InstrumentsUSD = [Settle Maturity CleanPriceUSD CouponRate] ; 
    NSModelUSD = IRFunctionCurve.fitNelsonSiegel('Zero',datenum('01-Mar-2004'),InstrumentsUSD) ; 
    rate = getParYields(NSModelUSD, date) ;
end

