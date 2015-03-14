function res = getUcapCost(ucaps)
ucapkwh = 8.4.*ucaps./3600;
res = getUcapCostPerKwh(ucaps).*ucapkwh;
end