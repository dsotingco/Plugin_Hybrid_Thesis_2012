%Generates tables of data from the raw converted .mat files.

clear all;
close all;

tic;

bats = [5 15 25];
motors = [50 100 150];
engines = [50 75];
ucaps = [25 50 75 100];

modestr = {'CS' 'EV'};

%begin initialization

initmat = zeros(length(bats),length(motors),length(engines),length(ucaps)); 
%these matrices are all the same dimensions so they can be initialized to
%the same thing

PARALLEL2ESS_MPG_CD_FTP = initmat;
PARALLEL2ESS_MPG_CD_HWFET = initmat;
PARALLEL2ESS_MPG_CD_US06 = initmat;

PARALLEL2ESS_MPG_CS_FTP = initmat;
PARALLEL2ESS_MPG_CS_HWFET = initmat;
PARALLEL2ESS_MPG_CS_US06 = initmat;

PARALLEL2ESS_CO2_CD_FTP = initmat;
PARALLEL2ESS_CO2_CD_HWFET = initmat;
PARALLEL2ESS_CO2_CD_US06 = initmat;

PARALLEL2ESS_CO2_CS_FTP = initmat;
PARALLEL2ESS_CO2_CS_HWFET = initmat;
PARALLEL2ESS_CO2_CS_US06 = initmat;

PARALLEL2ESS_ELEC_CD_FTP = initmat;
PARALLEL2ESS_ELEC_CD_HWFET = initmat;
PARALLEL2ESS_ELEC_CD_US06 = initmat;

PARALLEL2ESS_CDRANGE = initmat;


%end initialization

%Charge-depleting mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            for uindex = 1:length(ucaps)
                filename = ['parallel2ess_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_' num2str(ucaps(uindex)) '_CD' '.mat'];
                thedata = importdata(filename);
                %MPG
                PARALLEL2ESS_MPG_CD_FTP(bindex,mindex,eindex,uindex) = thedata(3,1);
                PARALLEL2ESS_MPG_CD_HWFET(bindex,mindex,eindex,uindex) = thedata(3,2);
                PARALLEL2ESS_MPG_CD_US06(bindex,mindex,eindex,uindex) = thedata(3,4);
                %CO2
                PARALLEL2ESS_CO2_CD_FTP(bindex,mindex,eindex,uindex) = thedata(5,1);
                PARALLEL2ESS_CO2_CD_HWFET(bindex,mindex,eindex,uindex) = thedata(5,2);
                PARALLEL2ESS_CO2_CD_US06(bindex,mindex,eindex,uindex) = thedata(5,4);
                %electric consumption - division by 10 is to convert Wh/mi. to
                %kWh/100mi.
                PARALLEL2ESS_ELEC_CD_FTP(bindex,mindex,eindex,uindex) = thedata(10,1)./10;
                PARALLEL2ESS_ELEC_CD_HWFET(bindex,mindex,eindex,uindex) = thedata(10,2)./10;
                PARALLEL2ESS_ELEC_CD_US06(bindex,mindex,eindex,uindex) = thedata(10,4)./10;
                %Charge-depleting range from UDDS - assumed SOC envelope of
                %0.65
                PARALLEL2ESS_CDRANGE(bindex,mindex,eindex,uindex) = 0.65.*1000.*bats(bindex)./thedata(10,3);
            end
        end
    end
end


%Charge-sustaining mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            for uindex = 1:length(ucaps)
                filename = ['parallel2ess_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_' num2str(ucaps(uindex)) '_CS' '.mat'];
                thedata = importdata(filename);
                %MPG
                PARALLEL2ESS_MPG_CS_FTP(bindex,mindex,eindex,uindex) = thedata(3,1);
                PARALLEL2ESS_MPG_CS_HWFET(bindex,mindex,eindex,uindex) = thedata(3,2);
                PARALLEL2ESS_MPG_CS_US06(bindex,mindex,eindex,uindex) = thedata(3,4);
                %CO2
                PARALLEL2ESS_CO2_CS_FTP(bindex,mindex,eindex,uindex) = thedata(5,1);
                PARALLEL2ESS_CO2_CS_HWFET(bindex,mindex,eindex,uindex) = thedata(5,2);
                PARALLEL2ESS_CO2_CS_US06(bindex,mindex,eindex,uindex) = thedata(5,4);
            end
        end
    end
end


save('PARALLEL2ESS_MPG_CD_FTP','PARALLEL2ESS_MPG_CD_FTP');
save('PARALLEL2ESS_MPG_CD_HWFET','PARALLEL2ESS_MPG_CD_HWFET');
save('PARALLEL2ESS_MPG_CD_US06','PARALLEL2ESS_MPG_CD_US06');

save('PARALLEL2ESS_MPG_CS_FTP','PARALLEL2ESS_MPG_CS_FTP');
save('PARALLEL2ESS_MPG_CS_HWFET','PARALLEL2ESS_MPG_CS_HWFET');
save('PARALLEL2ESS_MPG_CS_US06','PARALLEL2ESS_MPG_CS_US06');

save('PARALLEL2ESS_CO2_CD_FTP','PARALLEL2ESS_CO2_CD_FTP');
save('PARALLEL2ESS_CO2_CD_HWFET','PARALLEL2ESS_CO2_CD_HWFET');
save('PARALLEL2ESS_CO2_CD_US06','PARALLEL2ESS_CO2_CD_US06');

save('PARALLEL2ESS_CO2_CS_FTP','PARALLEL2ESS_CO2_CS_FTP');
save('PARALLEL2ESS_CO2_CS_HWFET','PARALLEL2ESS_CO2_CS_HWFET');
save('PARALLEL2ESS_CO2_CS_US06','PARALLEL2ESS_CO2_CS_US06');

save('PARALLEL2ESS_ELEC_CD_FTP','PARALLEL2ESS_ELEC_CD_FTP');
save('PARALLEL2ESS_ELEC_CD_HWFET','PARALLEL2ESS_ELEC_CD_HWFET');
save('PARALLEL2ESS_ELEC_CD_US06','PARALLEL2ESS_ELEC_CD_US06');

save('PARALLEL2ESS_CDRANGE','PARALLEL2ESS_CDRANGE');

toc