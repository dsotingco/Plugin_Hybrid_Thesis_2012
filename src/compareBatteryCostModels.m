%compare battery cost models

clear all;
close all;

PE = 2:1:30; %power-to-energy ratio in 1/h
argonneShortModel = 32.*PE + 600;
argonneLongModel = 20.*PE + 125;
argonneMidModel = (argonneShortModel + argonneLongModel)./2;
nrelModel = 11.1.*PE + 211.1;

figure;
hold on;
plot(136/16,500,'k*','MarkerSize',20);  %Volt
plot(90/24,750,'ko','MarkerSize',20);   %Leaf
plot(200/53,680,'k+','MarkerSize',20);  %Roadster
plot(PE,argonneShortModel,'b.-','LineWidth',2);
plot(PE,argonneLongModel,'co--','LineWidth',2);
plot(PE,argonneMidModel,'rs:','LineWidth',2);
plot(PE,nrelModel,'m+-.','LineWidth',2);
xlabel('Power-to-Energy Ratio (1/h)');
ylabel('Battery Cost ($/kWh)');
legend('Chevy Volt','Nissan Leaf','Tesla Roadster','Argonne Short-Term Model','Argonne Long-Term Model','Argonne Mid-Term Model','NREL Model');
