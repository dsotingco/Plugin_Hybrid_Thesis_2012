%readVehiclePowerCost.m

clear all;
close all;

[vpcnum,vpctext,vpcraw] = xlsread('vehiclePowerCostRelationship.xlsx');

%format of vpcnum:
%first column is engine power, in horsepower
%second column is engine power, in kW
%third column is MSRP, in dollars



%extract the data less than 150 kW (about 200 hp)
[m,n] = size(vpcnum);
counter = 0;
for index = 1:m
    if(vpcnum(index,2)<=150)
        counter = counter + 1;
    end
end

vpcsmall = zeros(counter,3);
vpcbig = zeros(m-counter,3);
sindex = 1;
bindex = 1;

for index = 1:m
    if(vpcnum(index,2)<=150)
        vpcsmall(sindex,:) = vpcnum(index,:);
        sindex = sindex + 1;
    else
        vpcbig(bindex,:) = vpcnum(index,:);
        bindex = bindex + 1;
    end
end

x1 = [74.6 150]; %linear region
y1 = 177.4.*x1 - 2104; %linear fit: R^2 = 0.5558

x2 = [150 240.958]; %nonlinear region
y2 = [max(y1) max(y1)];

figure;
hold on;
plot(vpcnum(:,2),vpcnum(:,3),'k.','MarkerSize',15);
plot(x1,y1,'r-','LineWidth',2);
plot(x2,y2,'r-','LineWidth',2);
xlabel('Engine Power (kW)');
ylabel('MSRP($)');

% figure;
% hold on;
% plot(vpcsmall(:,2),vpcsmall(:,3),'k.');
% plot(x1,y1,'r-','LineWidth',2);
% xlabel('Engine Power (kW)');
% ylabel('MSRP($)');
% 
% figure;
% hold on;
% plot(vpcbig(:,2),vpcbig(:,3),'k.');
% plot(x2,y2,'r-','LineWidth',2);
% xlabel('Engine Power (kW)');
% ylabel('MSRP($)');
