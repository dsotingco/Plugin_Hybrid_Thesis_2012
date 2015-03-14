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

PARALLEL_MPGE_CD_FTP = initmat;
PARALLEL_MPGE_CD_HWFET = initmat;
PARALLEL_MPGE_CD_US06 = initmat;

PARALLEL_MPGE_CS_FTP = initmat;
PARALLEL_MPGE_CS_HWFET = initmat;
PARALLEL_MPGE_CS_US06 = initmat;

%end initialization

%Charge-depleting mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            filename = ['PARALLEL_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_0_' 'CD' '.mat'];
            thedata = importdata(filename);
            PARALLEL_MPGE_CD_FTP(bindex,mindex,eindex) = thedata(9,1);
            PARALLEL_MPGE_CD_HWFET(bindex,mindex,eindex) = thedata(9,2);
            PARALLEL_MPGE_CD_US06(bindex,mindex,eindex) = thedata(9,4);
        end
    end
end

%Charge-sustaining mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            filename = ['PARALLEL_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_0_' 'CS' '.mat'];
            thedata = importdata(filename);
            PARALLEL_MPGE_CS_FTP(bindex,mindex,eindex) = thedata(9,1);
            PARALLEL_MPGE_CS_HWFET(bindex,mindex,eindex) = thedata(9,2);
            PARALLEL_MPGE_CS_US06(bindex,mindex,eindex) = thedata(9,4);
        end
    end
end

save('PARALLEL_MPGE_CD_FTP','PARALLEL_MPGE_CD_FTP');
save('PARALLEL_MPGE_CD_HWFET','PARALLEL_MPGE_CD_HWFET');
save('PARALLEL_MPGE_CD_US06','PARALLEL_MPGE_CD_US06');

save('PARALLEL_MPGE_CS_FTP','PARALLEL_MPGE_CS_FTP');
save('PARALLEL_MPGE_CS_HWFET','PARALLEL_MPGE_CS_HWFET');
save('PARALLEL_MPGE_CS_US06','PARALLEL_MPGE_CS_US06');

toc