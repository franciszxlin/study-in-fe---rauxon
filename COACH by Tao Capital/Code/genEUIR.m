% This script will fit Nelson-Siegel function to Fit Bond Market Data and
% interpolate the yield curve
% Assumption: datenum('01-Mar-2014') is the settle date for the yield curve
% Input: a datenum variable, 
% Output: a 1*2 matrix with the interpolated USD and EUR risk free rates
function [ rate ] = genEUIR( interval )
    date = datestr(datenum('01-Mar-2004')+interval*360) ; 
    Settle = repmat(datenum('01-Mar-2004'), [5,1]); 
    Maturity = [datenum('01-Mar-2005'); datenum('01-Mar-2006');
                datenum('01-Mar-2007'); datenum('01-Mar=2008'); 
                datenum('01-Mar_2009')] ;                 
    r_eur = [1.98; 2.48; 3.11; 3.25; 3.58]/100 ;        
    CleanPriceEUR = zeros(5,1) ; 
    for i = 1:5
        CleanPriceEUR(i,1) = 100 * (1 + r_eur(i,1))^(-i) ; 
    end
    CouponRate = zeros(5,1) ;
    InstrumentsEUR = [Settle Maturity CleanPriceEUR CouponRate] ; 
    NSModelEUR = IRFunctionCurve.fitNelsonSiegel('Zero',datenum('01-Mar-2004'),InstrumentsEUR) ; 
    rate = getParYields(NSModelEUR, date) ;
    if interval < 1
        rate=0.0198*interval ; 
    end
end