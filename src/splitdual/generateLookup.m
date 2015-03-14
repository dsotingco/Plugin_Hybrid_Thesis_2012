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

SPLITDUAL_MPG_CD_FTP = initmat;
SPLITDUAL_MPG_CD_HWFET = initmat;
SPLITDUAL_MPG_CD_US06 = initmat;

SPLITDUAL_MPG_CS_FTP = initmat;
SPLITDUAL_MPG_CS_HWFET = initmat;
SPLITDUAL_MPG_CS_US06 = initmat;

SPLITDUAL_CO2_CD_FTP = initmat;
SPLITDUAL_CO2_CD_HWFET = initmat;
SPLITDUAL_CO2_CD_US06 = initmat;

SPLITDUAL_CO2_CS_FTP = initmat;
SPLITDUAL_CO2_CS_HWFET = initmat;
SPLITDUAL_CO2_CS_US06 = initmat;

SPLITDUAL_ELEC_CD_FTP = initmat;
SPLITDUAL_ELEC_CD_HWFET = initmat;
SPLITDUAL_ELEC_CD_US06 = initmat;

SPLITDUAL_CDRANGE = initmat;


%end initialization

%Charge-depleting mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            for uindex = 1:length(ucaps)
                filename = ['splitdual_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_' num2str(ucaps(uindex)) '_CD' '.mat'];
                thedata = importdata(filename);
                %MPG
                SPLITDUAL_MPG_CD_FTP(bindex,mindex,eindex,uindex) = thedata(4,1);
                SPLITDUAL_MPG_CD_HWFET(bindex,mindex,eindex,uindex) = thedata(4,2);
                SPLITDUAL_MPG_CD_US06(bindex,mindex,eindex,uindex) = thedata(4,4);
                %CO2
                SPLITDUAL_CO2_CD_FTP(bindex,mindex,eindex,uindex) = thedata(6,1);
                SPLITDUAL_CO2_CD_HWFET(bindex,mindex,eindex,uindex) = thedata(6,2);
                SPLITDUAL_CO2_CD_US06(bindex,mindex,eindex,uindex) = thedata(6,4);
                %electric consumption - division by 10 is to convert Wh/mi. to
                %kWh/100mi.
                SPLITDUAL_ELEC_CD_FTP(bindex,mindex,eindex,uindex) = thedata(11,1)./10;
                SPLITDUAL_ELEC_CD_HWFET(bindex,mindex,eindex,uindex) = thedata(11,2)./10;
                SPLITDUAL_ELEC_CD_US06(bindex,mindex,eindex,uindex) = thedata(11,4)./10;
                %Charge-depleting range from UDDS - assumed SOC envelope of
                %0.65
                SPLITDUAL_CDRANGE(bindex,mindex,eindex,uindex) = 0.65.*1000.*bats(bindex)./thedata(11,3);
            end
        end
    end
end


%Charge-sustaining mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            for uindex = 1:length(ucaps)
                filename = ['splitdual_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_' num2str(ucaps(uindex)) '_CS' '.mat'];
                thedata = importdata(filename);
                %MPG
                SPLITDUAL_MPG_CS_FTP(bindex,mindex,eindex,uindex) = thedata(4,1);
                SPLITDUAL_MPG_CS_HWFET(bindex,mindex,eindex,uindex) = thedata(4,2);
                SPLITDUAL_MPG_CS_US06(bindex,mindex,eindex,uindex) = thedata(4,4);
                %CO2
                SPLITDUAL_CO2_CS_FTP(bindex,mindex,eindex,uindex) = thedata(6,1);
                SPLITDUAL_CO2_CS_HWFET(bindex,mindex,eindex,uindex) = thedata(6,2);
                SPLITDUAL_CO2_CS_US06(bindex,mindex,eindex,uindex) = thedata(6,4);
            end
        end
    end
end


save('SPLITDUAL_MPG_CD_FTP','SPLITDUAL_MPG_CD_FTP');
save('SPLITDUAL_MPG_CD_HWFET','SPLITDUAL_MPG_CD_HWFET');
save('SPLITDUAL_MPG_CD_US06','SPLITDUAL_MPG_CD_US06');

save('SPLITDUAL_MPG_CS_FTP','SPLITDUAL_MPG_CS_FTP');
save('SPLITDUAL_MPG_CS_HWFET','SPLITDUAL_MPG_CS_HWFET');
save('SPLITDUAL_MPG_CS_US06','SPLITDUAL_MPG_CS_US06');

save('SPLITDUAL_CO2_CD_FTP','SPLITDUAL_CO2_CD_FTP');
save('SPLITDUAL_CO2_CD_HWFET','SPLITDUAL_CO2_CD_HWFET');
save('SPLITDUAL_CO2_CD_US06','SPLITDUAL_CO2_CD_US06');

save('SPLITDUAL_CO2_CS_FTP','SPLITDUAL_CO2_CS_FTP');
save('SPLITDUAL_CO2_CS_HWFET','SPLITDUAL_CO2_CS_HWFET');
save('SPLITDUAL_CO2_CS_US06','SPLITDUAL_CO2_CS_US06');

save('SPLITDUAL_ELEC_CD_FTP','SPLITDUAL_ELEC_CD_FTP');
save('SPLITDUAL_ELEC_CD_HWFET','SPLITDUAL_ELEC_CD_HWFET');
save('SPLITDUAL_ELEC_CD_US06','SPLITDUAL_ELEC_CD_US06');

save('SPLITDUAL_CDRANGE','SPLITDUAL_CDRANGE');

toc