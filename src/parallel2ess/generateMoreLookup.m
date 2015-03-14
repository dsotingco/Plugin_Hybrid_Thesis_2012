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

PARALLEL2ESS_MPGE_CD_FTP = initmat;
PARALLEL2ESS_MPGE_CD_HWFET = initmat;
PARALLEL2ESS_MPGE_CD_US06 = initmat;

PARALLEL2ESS_MPGE_CS_FTP = initmat;
PARALLEL2ESS_MPGE_CS_HWFET = initmat;
PARALLEL2ESS_MPGE_CS_US06 = initmat;

%end initialization

%Charge-depleting mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            for uindex = 1:length(ucaps)
                filename = ['PARALLEL2ESS_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_' num2str(ucaps(uindex)) '_CD' '.mat'];
                thedata = importdata(filename);
                PARALLEL2ESS_MPGE_CD_FTP(bindex,mindex,eindex,uindex) = thedata(9,1);
                PARALLEL2ESS_MPGE_CD_HWFET(bindex,mindex,eindex,uindex) = thedata(9,2);
                PARALLEL2ESS_MPGE_CD_US06(bindex,mindex,eindex,uindex) = thedata(9,4);
            end
        end
    end
end


%Charge-sustaining mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            for uindex = 1:length(ucaps)
                filename = ['PARALLEL2ESS_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_' num2str(ucaps(uindex)) '_CS' '.mat'];
                thedata = importdata(filename);
                PARALLEL2ESS_MPGE_CS_FTP(bindex,mindex,eindex,uindex) = thedata(9,1);
                PARALLEL2ESS_MPGE_CS_HWFET(bindex,mindex,eindex,uindex) = thedata(9,2);
                PARALLEL2ESS_MPGE_CS_US06(bindex,mindex,eindex,uindex) = thedata(9,4);
            end
        end
    end
end

save('PARALLEL2ESS_MPGE_CD_FTP','PARALLEL2ESS_MPGE_CD_FTP');
save('PARALLEL2ESS_MPGE_CD_HWFET','PARALLEL2ESS_MPGE_CD_HWFET');
save('PARALLEL2ESS_MPGE_CD_US06','PARALLEL2ESS_MPGE_CD_US06');

save('PARALLEL2ESS_MPGE_CS_FTP','PARALLEL2ESS_MPGE_CS_FTP');
save('PARALLEL2ESS_MPGE_CS_HWFET','PARALLEL2ESS_MPGE_CS_HWFET');
save('PARALLEL2ESS_MPGE_CS_US06','PARALLEL2ESS_MPGE_CS_US06');

toc