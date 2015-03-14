%MODEL is a string: choices are:
%'argonneShortModel','argonneLongModel','argonneMidModel','nrelModel'
function kwhprice = getBatteryCostPerKwh(P,E,model)
PE = P./E;
    switch model
        case 'argonneShortModel'
            kwhprice = 32.*PE + 600;
        case 'argonneLongModel'  
            kwhprice = 20.*PE + 125;
        case 'argonneMidModel'
            kwhprice = (getBatteryCostPerKwh(P,E,'argonneShortModel') + getBatteryCostPerKwh(P,E,'argonneLongModel'))./2;
        case 'nrelModel'
            kwhprice = 11.1.*PE + 211.1;
    end
    %Short-term and long-term Argonne models are from: "Maximizing Net
    %Present Value of a SERIES PHEV by Optimizing Battery Size and Vehicle
    %Control Parameters", R. Vijayagopal, J. Kwon, A. Rousseau, P. Maloney
    %(2010)
    %Mid-term Argonne model is calculated by averaging Argonne short-term
    %and long-term models.
    %NREL model is from "Cost-Benefit Analysis of Plug-in Hybrid Electric
    %Vehicle Technology", A. Simpson (2006)
end