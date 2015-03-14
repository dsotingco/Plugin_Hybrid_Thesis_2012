function res = processData(config,data)
%assumes all-electric operation in CD mode

%unpack config
bat = config(1);
mot = config(2);
eng = config(3);
ucap = config(4);

%unpack data

elec_ftp = data(1);
elec_hwfet = data(2);
elec_udds = data(3);
elec_us06 = data(4);

mpg_ftp = data(5);
mpg_hwfet = data(6);
mpg_us06 = data(7);

co2_ftp = data(8);
co2_hwfet = data(9);
co2_us06 = data(10);

%parameters
SOCenvelope = 0.65;
caf = 0.9;
haf = 0.78;
percentCity = 0.43;
percentHighway = 0.57;
dist_hwfet = 10.26;
dist_us06 = 8.01;
cdrange = SOCenvelope.*bat./(elec_udds./100);
uf = getUtilityFactor(cdrange,'MDIUF');

%pricing assumptions
miles = 15000;
gascost = 3.70;
eleccost = 0.12;

%calculate results

%charge-depleting results
elec_city = (1./caf).*elec_ftp;
elec_hwfet_adj = (1./haf).*elec_hwfet;
elec_hwy = (dist_hwfet.*elec_hwfet_adj + dist_us06.*elec_us06) ./ (dist_hwfet + dist_us06);
elec_combined = percentCity.*elec_city + percentHighway.*elec_hwy;
mpge = 100./(elec_combined./33.7);

%charge-sustaining results
mpg_city = caf.*mpg_ftp;
mpg_hwfet_adj = haf.*mpg_hwfet;
mpg_hwy = (dist_hwfet + dist_us06)./(dist_hwfet./mpg_hwfet_adj + dist_us06./mpg_us06);
mpg_combined = 1 ./ (percentCity./mpg_city + percentHighway./mpg_hwy);
fuelconsump = 100./mpg_combined;

%co2 results
co2_city = co2_ftp;
co2_hwy = (dist_hwfet.*co2_hwfet + dist_us06.*co2_us06) ./ (dist_hwfet + dist_us06);
co2_combined = percentCity.*co2_city + percentHighway.*co2_hwy;
co2_uf = (1 - uf).*co2_combined;

%pricing
msrp = getMinMSRP(bat,mot,eng,ucap);
    cdmiles = uf.*miles;
    csmiles = (1 - uf).*miles;
fuelcost = eleccost.*0.01.*elec_combined.*cdmiles + gascost./mpg_combined.*csmiles;
    avgfuelcost = gascost./22.*miles;
moneysaved5yrs = 5.*(avgfuelcost - fuelcost);

disp(['CD MPGE : ' num2str(mpge)]);
disp(['CD kWh / 100 mi : ' num2str(elec_combined)]);
disp(['CD Range (mi): ' num2str(cdrange)]);
disp(['CS MPG : ' num2str(mpg_combined)]);
disp(['gal / 100 mi : ' num2str(fuelconsump)]);
disp(['CO2 g / mi : ' num2str(co2_uf)]);
disp(['MSRP : ' num2str(msrp)]);
disp(['Annual Fuel Cost : ' num2str(fuelcost)]);
disp(['Fuel Money Saved Over 5 Years : ' num2str(moneysaved5yrs)]);


res = 1;
end