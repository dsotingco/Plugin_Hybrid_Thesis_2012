%Generates tables of data from the raw converted .mat files.

clear all;
close all;

tic;

bats = [5 15 25];
motors = [50 100 150];
engines = [50 75];
% ucaps = [0 25 50 75 100];

% modestr = {'CS' 'EV'};

%begin initialization

initmat = zeros(length(bats),length(motors),length(engines)); 
%these matrices are all the same dimensions so they can be initialized to
%the same thing

PARALLEL_ACCELTIME_CD = initmat;
PARALLEL_ACCELTIME_CS = initmat;
PARALLEL_QUARTERMILETIME_CD = initmat;
PARALLEL_QUARTERMILETIME_CS = initmat;

%end initialization

%Charge-depleting mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            filename = ['parallel_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_0_' 'CD' '.mat'];
            thedata = importdata(filename);
            %0-60mph acceleration time and quarter-mile time
            PARALLEL_ACCELTIME_CD(bindex,mindex,eindex) = thedata(1,1);
            PARALLEL_QUARTERMILETIME_CD(bindex,mindex,eindex) = thedata(3,1);
        end
    end
end


%Charge-sustaining mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            filename = ['parallel_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_0_' 'CS' '.mat'];
            thedata = importdata(filename);
            %0-60mph acceleration time and quarter-mile time
            PARALLEL_ACCELTIME_CS(bindex,mindex,eindex) = thedata(1,1);
            PARALLEL_QUARTERMILETIME_CS(bindex,mindex,eindex) = thedata(3,1);
        end
    end
end

save('PARALLEL_ACCELTIME_CD','PARALLEL_ACCELTIME_CD');
save('PARALLEL_ACCELTIME_CS','PARALLEL_ACCELTIME_CS');
save('PARALLEL_QUARTERMILETIME_CD','PARALLEL_QUARTERMILETIME_CD');
save('PARALLEL_QUARTERMILETIME_CS','PARALLEL_QUARTERMILETIME_CS');

toc