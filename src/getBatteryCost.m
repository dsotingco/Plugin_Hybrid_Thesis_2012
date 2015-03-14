%MODEL is a string: choices are:
%'argonneShortModel','argonneLongModel','argonneMidModel','nrelModel'
function res = getBatteryCost(P,E,model)
res = E.*getBatteryCostPerKwh(P,E,model);
    %Short-term and long-term Argonne models are from: "Maximizing Net
    %Present Value of a SERIES PHEV by Optimizing Battery Size and Vehicle
    %Control Parameters", R. Vijayagopal, J. Kwon, A. Rousseau, P. Maloney
    %(2010)
    %Mid-term Argonne model is calculated by averaging Argonne short-term
    %and long-term models.
    %NREL model is from "Cost-Benefit Analysis of Plug-in Hybrid Electric
    %Vehicle Technology", A. Simpson (2006)
end