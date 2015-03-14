%makePlots3.m
%contours instead of surf

clear all;
close all;

%%
%electrical consumption (kWh / 100 mi.) vs. ultracapacitors, for Volt-like
%split configuration
ucaps = [0 25 50 75 100];
EC = [28.063 11.424 10.783 9.763 9.31]; %kWh / 100 mi.
mpge = 100./(EC./33.7);
Wh = ucaps.*8.4.*0.2778;

figure;

subplot(2,1,1), plot(Wh,EC,'k.-','LineWidth',2);
xlabel('Ultracapacitor Capacity (Wh)');
ylabel('Electrical Consumption (kWh / 100 mi.)');
grid on;

subplot(2,1,2), plot(Wh,mpge,'k.-','LineWidth',2);
xlabel('Ultracapacitor Capacity (Wh)');
ylabel('MPGe');
grid on;

%%
%CO2 vs battery kWh
bat1 = 5:1e-1:25;
mot1 = 111;
eng1 = 60;
u1 = 0;

co2a = getData('SERIES','CO2','COMBINED','FUF',bat1,mot1,eng1,u1);
co2b = getData('PARALLEL','CO2','COMBINED','FUF',bat1,mot1,eng1,u1);
co2c = getData('SPLIT','CO2','COMBINED','FUF',bat1,mot1,eng1,u1);

figure;
hold on;
plot(bat1,co2a,'k-','LineWidth',3);
plot(bat1,co2b,'b--','LineWidth',3);
plot(bat1,co2c,'r:','LineWidth',3);
xlabel('Battery Capacity (kWh)');
ylabel('CO2 Emissions (g / mi.)');
legend('SERIES','PARALLEL','SPLIT');

%%
%CDrange vs battery kWh
cdr1 = getData('SERIES','CDRANGE','COMBINED','CD',bat1,mot1,eng1,u1);
cdr2 = getData('PARALLEL','CDRANGE','COMBINED','CD',bat1,mot1,eng1,u1);
cdr3 = getData('SPLIT','CDRANGE','COMBINED','CD',bat1,mot1,eng1,u1);

figure;
hold on;
plot(bat1,cdr1,'k-','LineWidth',3);
plot(bat1,cdr2,'b--','LineWidth',3);
plot(bat1,cdr3,'r:','LineWidth',3);
xlabel('Battery Capacity (kWh)');
ylabel('Charge-depleting Range (mi.)');
legend('SERIES','PARALLEL','SPLIT');

%%
%Charge-depleting MPGe vs. motor and engine power
bat2 = 16;
mot2 = 50:1e0:150;
eng2 = 50:1e0:75;
u2 = 0;

[m2,e2] = meshgrid(mot2,eng2);
mpge2a = getData('SERIES','MPGE','COMBINED','CD',bat2,mot2,eng2,u2);
mpge2b = getData('PARALLEL','MPGE','COMBINED','CD',bat2,mot2,eng2,u2);
mpge2c = getData('SPLIT','MPGE','COMBINED','CD',bat2,mot2,eng2,u2);

figure;
[C,h] = contour(eng2,mot2,squeeze(mpge2a));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('Charge-depleting MPGe (Series)');
colorbar;

figure;
[C,h] = contour(eng2,mot2,squeeze(mpge2b));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('Charge-depleting MPGe (Parallel)');
colorbar;

figure;
[C,h] = contour(eng2,mot2,squeeze(mpge2c));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('Charge-depleting MPGe (Split)');
colorbar;

%%
%Charge-sustaining MPG vs. motor and engine power
mpg1 = getData('SERIES','MPG','COMBINED','CS',bat2,mot2,eng2,u2);
mpg2 = getData('PARALLEL','MPG','COMBINED','CS',bat2,mot2,eng2,u2);
mpg3 = getData('SPLIT','MPG','COMBINED','CS',bat2,mot2,eng2,u2);

figure;
[C,h] = contour(eng2,mot2,squeeze(mpg1));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('Charge-sustaining MPG (Series)');
colorbar;

figure;
[C,h] = contour(eng2,mot2,squeeze(mpg2));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('Charge-sustaining MPG (Parallel)');
colorbar;

figure;
[C,h] = contour(eng2,mot2,squeeze(mpg3));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('Charge-sustaining MPG (Split)');
colorbar;

%%
%CO2 vs. motor and engine power
mpge3a = getData('SERIES','CO2','COMBINED','FUF',bat2,mot2,eng2,u2);
mpge3b = getData('PARALLEL','CO2','COMBINED','FUF',bat2,mot2,eng2,u2);
mpge3c = getData('SPLIT','CO2','COMBINED','FUF',bat2,mot2,eng2,u2);

figure;
[C,h] = contour(eng2,mot2,squeeze(mpge3a));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('CO2 Emissions, g/mi. (Series)');
colorbar;

figure;
[C,h] = contour(eng2,mot2,squeeze(mpge3b));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('CO2 Emissions, g/mi. (Parallel)');
colorbar;

figure;
[C,h] = contour(eng2,mot2,squeeze(mpge3c));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('CO2 Emissions, g/mi. (Split)');
colorbar;

%%
%CDrange vs. motor and engine power
mpge4a = getData('SERIES','CDRANGE','COMBINED','CD',bat2,mot2,eng2,u2);
mpge4b = getData('PARALLEL','CDRANGE','COMBINED','CD',bat2,mot2,eng2,u2);
mpge4c = getData('SPLIT','CDRANGE','COMBINED','CD',bat2,mot2,eng2,u2);

figure;
[C,h] = contour(eng2,mot2,squeeze(mpge4a));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('Charge-depleting range, mi. (Series)');
colorbar;

figure;
[C,h] = contour(eng2,mot2,squeeze(mpge4b));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('Charge-depleting range, mi. (Parallel)');
colorbar;

figure;
[C,h] = contour(eng2,mot2,squeeze(mpge4c));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('Charge-depleting range, mi. (Split)');
colorbar;

%%
%0-60mph time vs. motor and engine power
at1 = getData('SERIES','ACCELTIME','COMBINED','CD',bat2,mot2,eng2,u2);
at2 = getData('PARALLEL','ACCELTIME','COMBINED','CD',bat2,mot2,eng2,u2);
at3 = getData('SPLIT','ACCELTIME','COMBINED','CD',bat2,mot2,eng2,u2);

figure;
[C,h] = contour(eng2,mot2,squeeze(at1));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('0-60 mph Acceleration Time, s (Series)');
colorbar;

figure;
[C,h] = contour(eng2,mot2,squeeze(at2));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('0-60 mph Acceleration Time, s (Parallel)');
colorbar;

figure;
[C,h] = contour(eng2,mot2,squeeze(at3));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('0-60 mph Acceleration Time, s (Split)');
colorbar;

%%
%0-60mph time vs. motor and engine power, charge-sustaining
at4 = getData('SERIES','ACCELTIME','COMBINED','CS',bat2,mot2,eng2,u2);
at5 = getData('PARALLEL','ACCELTIME','COMBINED','CS',bat2,mot2,eng2,u2);
at6 = getData('SPLIT','ACCELTIME','COMBINED','CS',bat2,mot2,eng2,u2);

figure;
[C,h] = contour(eng2,mot2,squeeze(at4));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('0-60 mph Acceleration Time, s (Series, Charge-sustaining)');
colorbar;

figure;
[C,h] = contour(eng2,mot2,squeeze(at5));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('0-60 mph Acceleration Time, s (Parallel, Charge-sustaining)');
colorbar;

figure;
[C,h] = contour(eng2,mot2,squeeze(at6));
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
view(0,90);
xlabel('Engine Power (kW)');
ylabel('Motor Power (kW)');
title('0-60 mph Acceleration Time, s (Split, Charge-sustaining)');
colorbar;

%%
%pricing plot
bv = 16;
m = 50:1:150;
ev = 60;
uv = 0;

msrp = getMinMSRP(bv,m,ev,uv);
convMSRP = getMSRP(m+ev);
batteryCost = getBatteryCost(m,bv,'argonneMidModel');
motorCost = getMotorCost(m);
engineCost = getEngineCost(ev);

figure;
hold on;
plot(m,msrp,'k-','LineWidth',6);
plot(m,convMSRP,'b--','LineWidth',3);
plot(m,batteryCost,'go-.','LineWidth',3);
plot(m,motorCost,'rs-','LineWidth',3);
plot(m,engineCost,'c+-','LineWidth',3);
% plot(m,convMSRP+batteryCost+motorCost+engineCost,'ro');
xlabel('Motor Power (kW)');
ylabel('Cost ($)');
legend('Total MSRP Model','Base Cost','Battery Cost','Motor Cost','Engine Cost');
grid on;
