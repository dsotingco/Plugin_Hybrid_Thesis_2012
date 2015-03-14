%estimateMSRP.m
%Estimates MSRP of a CONVENTIONAL vehicle in dollars, based on total power in kW. 
%Based on fitting a model to data taken from 44 conventional consumer
%vehicles.  
%Valid from 75 to 250 kW.

function res = getMSRP(powerkW)
elmin = 75;
elmax = 250;
cutoff = 150;
res(1:length(powerkW)) = 0;
    for index = 1:length(powerkW)
        if(powerkW(index)<elmin)
            res(index) = 177.4*elmin - 2104;
        elseif(powerkW(index)>=elmin && powerkW(index)<=cutoff)
            res(index) = 177.4*powerkW(index) - 2104;
        else
            res(index) = 177.4*cutoff - 2104;
        end
    end
end