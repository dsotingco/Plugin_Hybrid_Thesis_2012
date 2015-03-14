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

SPLIT_MPGE_CD_FTP = initmat;
SPLIT_MPGE_CD_HWFET = initmat;
SPLIT_MPGE_CD_US06 = initmat;

SPLIT_MPGE_CS_FTP = initmat;
SPLIT_MPGE_CS_HWFET = initmat;
SPLIT_MPGE_CS_US06 = initmat;

%end initialization

%Charge-depleting mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            filename = ['SPLIT_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_0_' 'CD' '.mat'];
            thedata = importdata(filename);
            SPLIT_MPGE_CD_FTP(bindex,mindex,eindex) = thedata(10,1);
            SPLIT_MPGE_CD_HWFET(bindex,mindex,eindex) = thedata(10,2);
            SPLIT_MPGE_CD_US06(bindex,mindex,eindex) = thedata(10,4);
        end
    end
end

%Charge-sustaining mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            filename = ['SPLIT_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_0_' 'CS' '.mat'];
            thedata = importdata(filename);
            SPLIT_MPGE_CS_FTP(bindex,mindex,eindex) = thedata(10,1);
            SPLIT_MPGE_CS_HWFET(bindex,mindex,eindex) = thedata(10,2);
            SPLIT_MPGE_CS_US06(bindex,mindex,eindex) = thedata(10,4);
        end
    end
end

save('SPLIT_MPGE_CD_FTP','SPLIT_MPGE_CD_FTP');
save('SPLIT_MPGE_CD_HWFET','SPLIT_MPGE_CD_HWFET');
save('SPLIT_MPGE_CD_US06','SPLIT_MPGE_CD_US06');

save('SPLIT_MPGE_CS_FTP','SPLIT_MPGE_CS_FTP');
save('SPLIT_MPGE_CS_HWFET','SPLIT_MPGE_CS_HWFET');
save('SPLIT_MPGE_CS_US06','SPLIT_MPGE_CS_US06');

toc