%Returns engine cost in dollars, as a function of engine peak power in kW.
%Based on model from "Cost-Benefit Analysis of Plug-in Hybrid Electric Vehicle
%Technology" by A. Simpson, NREL
function res = getEngineCost(kW)
res = 14.5.*kW + 531;
end