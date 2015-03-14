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

PARALLEL_MPG_CD_FTP = initmat;
PARALLEL_MPG_CD_HWFET = initmat;
PARALLEL_MPG_CD_US06 = initmat;

PARALLEL_MPG_CS_FTP = initmat;
PARALLEL_MPG_CS_HWFET = initmat;
PARALLEL_MPG_CS_US06 = initmat;

PARALLEL_CO2_CD_FTP = initmat;
PARALLEL_CO2_CD_HWFET = initmat;
PARALLEL_CO2_CD_US06 = initmat;

PARALLEL_CO2_CS_FTP = initmat;
PARALLEL_CO2_CS_HWFET = initmat;
PARALLEL_CO2_CS_US06 = initmat;

PARALLEL_ELEC_CD_FTP = initmat;
PARALLEL_ELEC_CD_HWFET = initmat;
PARALLEL_ELEC_CD_US06 = initmat;

PARALLEL_CDRANGE = initmat;


%end initialization

%Charge-depleting mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            filename = ['PARALLEL_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_0_' 'CD' '.mat'];
            thedata = importdata(filename);
            %NOTE THAT THE ROWS IN THE PARALLEL DATA ARE OFFSET BY ONE ROW
            %AS COMPARED TO THE SERIES DATA
            %MPG
            PARALLEL_MPG_CD_FTP(bindex,mindex,eindex) = thedata(3,1);
            PARALLEL_MPG_CD_HWFET(bindex,mindex,eindex) = thedata(3,2);
            PARALLEL_MPG_CD_US06(bindex,mindex,eindex) = thedata(3,4);
            %CO2
            PARALLEL_CO2_CD_FTP(bindex,mindex,eindex) = thedata(5,1);
            PARALLEL_CO2_CD_HWFET(bindex,mindex,eindex) = thedata(5,2);
            PARALLEL_CO2_CD_US06(bindex,mindex,eindex) = thedata(5,4);
            %electric consumption - division by 10 is to convert Wh/mi. to
            %kWh/100mi.
            PARALLEL_ELEC_CD_FTP(bindex,mindex,eindex) = thedata(10,1)./10;
            PARALLEL_ELEC_CD_HWFET(bindex,mindex,eindex) = thedata(10,2)./10;
            PARALLEL_ELEC_CD_US06(bindex,mindex,eindex) = thedata(10,4)./10;
            %Charge-depleting range from UDDS - assumed SOC envelope of
            %0.65
            PARALLEL_CDRANGE(bindex,mindex,eindex) = 0.65.*1000.*bats(bindex)./thedata(10,3);
        end
    end
end


%Charge-sustaining mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            filename = ['parallel_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_0_' 'CS' '.mat'];
            thedata = importdata(filename);
            %MPG
            PARALLEL_MPG_CS_FTP(bindex,mindex,eindex) = thedata(3,1);
            PARALLEL_MPG_CS_HWFET(bindex,mindex,eindex) = thedata(3,2);
            PARALLEL_MPG_CS_US06(bindex,mindex,eindex) = thedata(3,4);
            %CO2
            PARALLEL_CO2_CS_FTP(bindex,mindex,eindex) = thedata(5,1);
            PARALLEL_CO2_CS_HWFET(bindex,mindex,eindex) = thedata(5,2);
            PARALLEL_CO2_CS_US06(bindex,mindex,eindex) = thedata(5,4);
        end
    end
end


save('PARALLEL_MPG_CD_FTP','PARALLEL_MPG_CD_FTP');
save('PARALLEL_MPG_CD_HWFET','PARALLEL_MPG_CD_HWFET');
save('PARALLEL_MPG_CD_US06','PARALLEL_MPG_CD_US06');

save('PARALLEL_MPG_CS_FTP','PARALLEL_MPG_CS_FTP');
save('PARALLEL_MPG_CS_HWFET','PARALLEL_MPG_CS_HWFET');
save('PARALLEL_MPG_CS_US06','PARALLEL_MPG_CS_US06');

save('PARALLEL_CO2_CD_FTP','PARALLEL_CO2_CD_FTP');
save('PARALLEL_CO2_CD_HWFET','PARALLEL_CO2_CD_HWFET');
save('PARALLEL_CO2_CD_US06','PARALLEL_CO2_CD_US06');

save('PARALLEL_CO2_CS_FTP','PARALLEL_CO2_CS_FTP');
save('PARALLEL_CO2_CS_HWFET','PARALLEL_CO2_CS_HWFET');
save('PARALLEL_CO2_CS_US06','PARALLEL_CO2_CS_US06');

save('PARALLEL_ELEC_CD_FTP','PARALLEL_ELEC_CD_FTP');
save('PARALLEL_ELEC_CD_HWFET','PARALLEL_ELEC_CD_HWFET');
save('PARALLEL_ELEC_CD_US06','PARALLEL_ELEC_CD_US06');

save('PARALLEL_CDRANGE','PARALLEL_CDRANGE');

toc