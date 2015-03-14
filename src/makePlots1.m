%makePlots1.m

clear all;
close all;

ucapSpace = 25:100;
bat1 = 16;
mot1 = 111;
eng1 =  62;

mpge1 = getData('SPLITDUAL','MPGE','COMBINED','MDIUF',bat1,mot1,eng1,ucapSpace);
mpge1a(1:length(ucapSpace)) = getData('SPLIT','MPGE','COMBINED','MDIUF',bat1,mot1,eng1,0);
mpge2 = getData('PARALLEL2ESS','MPGE','COMBINED','MDIUF',bat1,mot1,eng1,ucapSpace);
mpge2a(1:length(ucapSpace)) = getData('PARALLEL','MPGE','COMBINED','MDIUF',bat1,mot1,eng1,0);
mpge3(1:length(ucapSpace)) = getData('SERIES','MPGE','COMBINED','MDIUF',bat1,mot1,eng1,0);

figure;
hold on;
plot(ucapSpace,squeeze(mpge1),'k--','LineWidth',3);
plot(ucapSpace,squeeze(mpge1a),'k-','LineWidth',2);
plot(ucapSpace,squeeze(mpge2),'r--','LineWidth',3);
plot(ucapSpace,squeeze(mpge2a),'r-','LineWidth',2);
plot(ucapSpace,squeeze(mpge3),'g-','LineWidth',2);
legend('SPLITDUAL','SPLIT','PARALLEL2ESS','PARALLEL','SERIES');
xlabel('Ultracapacitors');
ylabel('MPGE');

mpgecs1 = getData('SPLITDUAL','MPG','COMBINED','CS',bat1,mot1,eng1,ucapSpace);
mpgecs1a(1:length(ucapSpace)) = getData('SPLIT','MPG','COMBINED','CS',bat1,mot1,eng1,0);
mpgecs2 = getData('PARALLEL2ESS','MPG','COMBINED','CS',bat1,mot1,eng1,ucapSpace);
mpgecs2a(1:length(ucapSpace)) = getData('PARALLEL','MPG','COMBINED','CS',bat1,mot1,eng1,0);
mpgecs3(1:length(ucapSpace)) = getData('SERIES','MPG','COMBINED','CS',bat1,mot1,eng1,0);

figure;
hold on;
plot(ucapSpace,squeeze(mpgecs1),'k--','LineWidth',3);
plot(ucapSpace,squeeze(mpgecs1a),'k-','LineWidth',2);
plot(ucapSpace,squeeze(mpgecs2),'r--','LineWidth',3);
plot(ucapSpace,squeeze(mpgecs2a),'r-','LineWidth',2);
plot(ucapSpace,squeeze(mpgecs3),'g-','LineWidth',2);
legend('SPLITDUAL','SPLIT','PARALLEL2ESS','PARALLEL','SERIES');
xlabel('Ultracapacitors');
ylabel('MPG-CS');

accel1(1:length(ucapSpace)) = getData('SERIES','ACCELTIME','COMBINED','CD',bat1,mot1,eng1,0);
accel2(1:length(ucapSpace)) = getData('PARALLEL','ACCELTIME','COMBINED','CD',bat1,mot1,eng1,0);
accel3(1:length(ucapSpace)) = getData('SPLIT','ACCELTIME','COMBINED','CD',bat1,mot1,eng1,0);
accel4 = getData('PARALLEL2ESS','ACCELTIME','COMBINED','CD',bat1,mot1,eng1,ucapSpace);
accel5 = getData('SPLITDUAL','ACCELTIME','COMBINED','CD',bat1,mot1,eng1,ucapSpace);

figure;
hold on;
plot(ucapSpace,squeeze(accel1),'k--','LineWidth',3);
plot(ucapSpace,squeeze(accel2),'b--','LineWidth',3);
plot(ucapSpace,squeeze(accel3),'g--','LineWidth',3);
plot(ucapSpace,squeeze(accel4),'b.-','LineWidth',2);
plot(ucapSpace,squeeze(accel5),'g.-','LineWidth',2);
legend('SERIES','PARALLEL','SPLIT','PARALLEL2ESS','SPLITDUAL');
xlabel('Ultracapacitors');
ylabel('0-60 mph Acceleration Time (s)');

carb1(1:length(ucapSpace)) = getData('SERIES','CO2','COMBINED','MDIUF',bat1,mot1,eng1,0);
carb2(1:length(ucapSpace)) = getData('PARALLEL','CO2','COMBINED','MDIUF',bat1,mot1,eng1,0);
carb3(1:length(ucapSpace)) = getData('SPLIT','CO2','COMBINED','MDIUF',bat1,mot1,eng1,0);
carb4 = getData('PARALLEL2ESS','CO2','COMBINED','MDIUF',bat1,mot1,eng1,ucapSpace);
carb5 = getData('SPLITDUAL','CO2','COMBINED','MDIUF',bat1,mot1,eng1,ucapSpace);

figure;
hold on;
plot(ucapSpace,squeeze(carb1),'k--','LineWidth',3);
plot(ucapSpace,squeeze(carb2),'b--','LineWidth',3);
plot(ucapSpace,squeeze(carb3),'g--','LineWidth',3);
plot(ucapSpace,squeeze(carb4),'b.-','LineWidth',2);
plot(ucapSpace,squeeze(carb5),'g.-','LineWidth',2);
legend('SERIES','PARALLEL','SPLIT','PARALLEL2ESS','SPLITDUAL');
xlabel('Ultracapacitors');
ylabel('Carbon Dioxide (g/mi.)');

%%
cdr1(1:length(ucapSpace)) = getData('SERIES','CDRANGE','COMBINED','CD',bat1,mot1,eng1,0);
cdr2(1:length(ucapSpace)) = getData('PARALLEL','CDRANGE','COMBINED','CD',bat1,mot1,eng1,0);
cdr3(1:length(ucapSpace)) = getData('SPLIT','CDRANGE','COMBINED','CD',bat1,mot1,eng1,0);
cdr4 = getData('PARALLEL2ESS','CDRANGE','COMBINED','CD',bat1,mot1,eng1,ucapSpace);
cdr5 = getData('SPLITDUAL','CDRANGE','COMBINED','CD',bat1,mot1,eng1,ucapSpace);

figure;
hold on;
plot(ucapSpace,squeeze(cdr1),'k--','LineWidth',3);
plot(ucapSpace,squeeze(cdr2),'b--','LineWidth',3);
plot(ucapSpace,squeeze(cdr3),'g--','LineWidth',3);
plot(ucapSpace,squeeze(cdr4),'b.-','LineWidth',2);
plot(ucapSpace,squeeze(cdr5),'g.-','LineWidth',2);
legend('SERIES','PARALLEL','SPLIT','PARALLEL2ESS','SPLITDUAL');
xlabel('Ultracapacitors');
ylabel('Charge-depleting range (mi.)');
