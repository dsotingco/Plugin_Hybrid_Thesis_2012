%Generates tables of data from the raw converted .mat files.

clear all;
close all;

tic;

bats = [5 15 25];
motors = [50 100 150];
engines = [50 75];
% ucaps = [0 25 50 75 100];

modestr = {'CS' 'EV'};

%begin initialization

initmat = zeros(length(bats),length(motors),length(engines)); 
%these matrices are all the same dimensions so they can be initialized to
%the same thing

SPLIT_MPG_CD_FTP = initmat;
SPLIT_MPG_CD_HWFET = initmat;
SPLIT_MPG_CD_US06 = initmat;

SPLIT_MPG_CS_FTP = initmat;
SPLIT_MPG_CS_HWFET = initmat;
SPLIT_MPG_CS_US06 = initmat;

SPLIT_CO2_CD_FTP = initmat;
SPLIT_CO2_CD_HWFET = initmat;
SPLIT_CO2_CD_US06 = initmat;

SPLIT_CO2_CS_FTP = initmat;
SPLIT_CO2_CS_HWFET = initmat;
SPLIT_CO2_CS_US06 = initmat;

SPLIT_ELEC_CD_FTP = initmat;
SPLIT_ELEC_CD_HWFET = initmat;
SPLIT_ELEC_CD_US06 = initmat;

SPLIT_CDRANGE = initmat;


%end initialization

%Charge-depleting mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            filename = ['split_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_0_' 'CD' '.mat'];
            thedata = importdata(filename);
            %MPG
            SPLIT_MPG_CD_FTP(bindex,mindex,eindex) = thedata(4,1);
            SPLIT_MPG_CD_HWFET(bindex,mindex,eindex) = thedata(4,2);
            SPLIT_MPG_CD_US06(bindex,mindex,eindex) = thedata(4,4);
            %CO2
            SPLIT_CO2_CD_FTP(bindex,mindex,eindex) = thedata(6,1);
            SPLIT_CO2_CD_HWFET(bindex,mindex,eindex) = thedata(6,2);
            SPLIT_CO2_CD_US06(bindex,mindex,eindex) = thedata(6,4);
            %electric consumption - division by 10 is to convert Wh/mi. to
            %kWh/100mi.
            SPLIT_ELEC_CD_FTP(bindex,mindex,eindex) = thedata(11,1)./10;
            SPLIT_ELEC_CD_HWFET(bindex,mindex,eindex) = thedata(11,2)./10;
            SPLIT_ELEC_CD_US06(bindex,mindex,eindex) = thedata(11,4)./10;
            %Charge-depleting range from UDDS - assumed SOC envelope of
            %0.65
            SPLIT_CDRANGE(bindex,mindex,eindex) = 0.65.*1000.*bats(bindex)./thedata(11,3);
        end
    end
end


%Charge-sustaining mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            filename = ['split_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_0_' 'CS' '.mat'];
            thedata = importdata(filename);
            %MPG
            SPLIT_MPG_CS_FTP(bindex,mindex,eindex) = thedata(4,1);
            SPLIT_MPG_CS_HWFET(bindex,mindex,eindex) = thedata(4,2);
            SPLIT_MPG_CS_US06(bindex,mindex,eindex) = thedata(4,4);
            %CO2
            SPLIT_CO2_CS_FTP(bindex,mindex,eindex) = thedata(6,1);
            SPLIT_CO2_CS_HWFET(bindex,mindex,eindex) = thedata(6,2);
            SPLIT_CO2_CS_US06(bindex,mindex,eindex) = thedata(6,4);
        end
    end
end


save('SPLIT_MPG_CD_FTP','SPLIT_MPG_CD_FTP');
save('SPLIT_MPG_CD_HWFET','SPLIT_MPG_CD_HWFET');
save('SPLIT_MPG_CD_US06','SPLIT_MPG_CD_US06');

save('SPLIT_MPG_CS_FTP','SPLIT_MPG_CS_FTP');
save('SPLIT_MPG_CS_HWFET','SPLIT_MPG_CS_HWFET');
save('SPLIT_MPG_CS_US06','SPLIT_MPG_CS_US06');

save('SPLIT_CO2_CD_FTP','SPLIT_CO2_CD_FTP');
save('SPLIT_CO2_CD_HWFET','SPLIT_CO2_CD_HWFET');
save('SPLIT_CO2_CD_US06','SPLIT_CO2_CD_US06');

save('SPLIT_CO2_CS_FTP','SPLIT_CO2_CS_FTP');
save('SPLIT_CO2_CS_HWFET','SPLIT_CO2_CS_HWFET');
save('SPLIT_CO2_CS_US06','SPLIT_CO2_CS_US06');

save('SPLIT_ELEC_CD_FTP','SPLIT_ELEC_CD_FTP');
save('SPLIT_ELEC_CD_HWFET','SPLIT_ELEC_CD_HWFET');
save('SPLIT_ELEC_CD_US06','SPLIT_ELEC_CD_US06');

save('SPLIT_CDRANGE','SPLIT_CDRANGE');

toc