function [ theBondRating ] = convertHazardRateToBondRating( aHazardRatePath, aCutoff )
%CONVERTHAZARDRATETOBONDRATING convert the Hazard Rate Path to Bond Rating
%   The N of hazard rate path should match the length of cutoff matrix
%   If the hazard rate is higher than the cutoff, the it is BBB rate at the
%   time
theBondRating = aHazardRatePath > aCutoff;
end

