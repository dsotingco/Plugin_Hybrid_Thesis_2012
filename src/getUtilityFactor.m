%GETUTILITYFACTOR - Returns either the fleet utility factor (FUF) or the
%multiple-day individual utility factor (MDIUF) as a function of
%charge-depleting range.  Utility factor is defined as the number of miles
%driven in charge-depleting mode divided by the total number of miles
%driven.  Results are based on work from SAE Standard J2841,
%which used data from the US Department of Transportation (DOT) National
%Highway Transportation Survey (2001) that included data from 84,000
%vehicles over a 4-week travel period.
%GETUTILITYFACTOR(CDRANGE,TYPE)
%   CDRANGE is the charge-depleting range (in miles) of the PHEV vehicle.  Data for these fits is valid for 0 to 400 miles.
%   TYPE is a string specifying the type of data you want.  Your choices
%   are:
%       'FUF' - Fleet utility factor.  Use for predicting performance of a
%           fleet of PHEVs.  FUF is weighted towards long-distance trips/
%       'MDIUF' - Multiple-day individual utility factor.  Use for
%           predicting performance for the average driver.

function res = getUtilityFactor(CDrange,type)
    switch type
        case 'FUF'
            %Fleet Utility Factor fit
            norm_dist_FUF = 399.9;
            C_FUF = [10.52 -7.282 -26.37 79.08 -77.36 26.07];
                %maxerror_FUF = 0.00391;
            y = CDrange./norm_dist_FUF;
            sum = 0;
            for index = 1:length(C_FUF)
                sum = sum + C_FUF(index).*y.^index;
            end
            res = 1 - exp(-sum);
        case 'MDIUF'
            %Multiple-day individual utility factor fit
            norm_dist_MDIUF = 400;
            C_MDIUF = [1.31e1 -1.87e1 5.22 8.15 3.53 -1.34 -4.01 -3.9 -1.15 3.88];
                %maxerror_MDIUF = 3.88;
            z = CDrange./norm_dist_MDIUF;
            sum = 0;
            for index = 1:length(C_MDIUF)
                sum = sum + C_MDIUF(index).*z.^index;
            end
            res = 1 - exp(-sum);
    end
end