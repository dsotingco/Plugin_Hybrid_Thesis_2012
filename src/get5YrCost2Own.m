%get5YrCost2Own.m

function res = get5YrCost2Own(arch,bat,motor,engine,ucaps,msrp,miles,gasPrice,elecPrice)

%financing assumptions - use Kelley Blue Book standard assumptions: loan
%APR of 3.99%, 10% down payment based on MSRP, 5-year loan.
P0 = 0.9.*msrp;
APR = 0.0399;
r = APR./12;
N = 60;

%opportunity cost assumptions
interestRate = 0.0047; %average MMA rate from Y! Finance
numYears = 5;

costList(1) = getDepreciation(msrp);
costList(2) = getFuelCost(arch,bat,motor,engine,ucaps,miles,gasPrice,elecPrice);
costList(3) = getFinanceCost(P0,r,N);
costList(4) = getInsuranceCost;
costList(5) = getMaintenanceCost;
costList(6) = getFees(bat,msrp);
costList(7) = getRepairCost;
costList(8) = getOppCost(msrp,interestRate,numYears);
res = round(sum(costList));
end

function res = getDepreciation(msrp)
volt_msrp = 39145;
prius_msrp = 32000;

volt_dep_raw(1,1:5) = [17215 3203 3203 3203 2802]; %KBB
volt_dep_raw(2,1:5) = [14960 3224 3123 3022 2720]; %Y! Autos
volt_dep = volt_dep_raw./volt_msrp;

prius_dep_raw(1,1:5) = [11658 2681 2628 2521 2306]; %Y! Autos
prius_dep = prius_dep_raw./prius_msrp;

phevdep = max([volt_dep; prius_dep]); %from Kelley Blue Book projections on 2012 Chevy Volt
res = sum(phevdep).*msrp;
end

function res = getFuelCost(arch,bat,motor,engine,ucaps,miles,gasPrice,elecPrice)
cdrange = getRawData(arch,'CDRANGE',bat,motor,engine,ucaps);
uf = getUtilityFactor(cdrange,'MDIUF');
CDmiles = uf.*miles;
CSmiles = (1 - uf).*miles;
%the 0.01 below is for converting kWh / 100mi. to kWh / mi.
CDelecFuelCost = elecPrice.*0.01.*getProcessedData(arch,'CD_ELEC_COMBINED',bat,motor,engine,ucaps).*CDmiles;
CDgasFuelCost = gasPrice./getProcessedData(arch,'CD_MPG_COMBINED',bat,motor,engine,ucaps).*CDmiles;
CSgasFuelCost = gasPrice./getProcessedData(arch,'CS_MPG_COMBINED',bat,motor,engine,ucaps).*CSmiles;
res = 5.*(CDelecFuelCost + CDgasFuelCost + CSgasFuelCost);
end

%Returns total interest paid from financing.  P0 is the principal financed,
%r is the rate per payment period (nominally APR/12), and N is the number
%of months.
function res = getFinanceCost(P0,r,N)
p = P0.*r.*(1+r).^N./((1+r).^N-1);
res = p.*N - P0;
end

function res = getInsuranceCost
volt_kbb = [881 881 881 881 881];
volt_y = [1159 1146 1133 1120 1108];
prius_y = [1146 1133 1120 1108 1096];
res = max([sum(volt_kbb) sum(volt_y) sum(prius_y)]);
end

function res = getMaintenanceCost
%these don't seem to depend on msrp, so take the max
volt_kbb = [68 354 68 514 676];
volt_y = [223 223 1368 372 223];
prius_y = [0 87 1176 307 158];
res = max([sum(volt_kbb) sum(volt_y) sum(prius_y)]);
end

%note that this value will probably be negative because of the tax credit
function res = getFees(bat,msrp)
aces_credit = -min(2500+417.*(bat-4),7500); %tax credit from 2009 ACES Act -- negative because it is a credit
salestax = msrp.*0.0627; %average sales tax of 6.27%
%below are only for years 2-5
volt_kbb = [280 280 240 200];
volt_y = [125 130 112 117];
prius_y = [108 112 97 101];
res = aces_credit + salestax + max([sum(volt_kbb) sum(volt_y) sum(prius_y)]);
end

function res = getRepairCost
%these are all about the same (i.e. not percentage of msrp) - about $2000,
%so just take the max
volt_kbb = [0 0 678 678 678];
volt_y = [0 0 380 824 1071];
prius_y = [0 0 357 772 1004];
res = max([sum(volt_kbb) sum(volt_y) sum(prius_y)]);
end

function res = getOppCost(msrp,r,numYears)
res = msrp.*(1+r).^numYears - msrp;
end
