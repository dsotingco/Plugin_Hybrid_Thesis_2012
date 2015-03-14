%Generates tables of data from the raw converted .mat files.

clear all;
close all;

tic;

bats = [5 15 25];
motors = [50 100 150];
engines = [50 75];
ucaps = [25 50 75 100];

% modestr = {'CS' 'EV'};

%begin initialization

initmat = zeros(length(bats),length(motors),length(engines),length(ucaps)); 
%these matrices are all the same dimensions so they can be initialized to
%the same thing

PARALLEL2ESS_ACCELTIME_CD = initmat;
PARALLEL2ESS_ACCELTIME_CS = initmat;
PARALLEL2ESS_QUARTERMILETIME_CD = initmat;
PARALLEL2ESS_QUARTERMILETIME_CS = initmat;

%end initialization

%Charge-depleting mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            for uindex = 1:length(ucaps)
                filename = ['parallel2ess_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_' num2str(ucaps(uindex)) '_CD' '.mat'];
                thedata = importdata(filename);
                %0-60mph acceleration time and quarter-mile time
                PARALLEL2ESS_ACCELTIME_CD(bindex,mindex,eindex,uindex) = thedata(1,1);
                PARALLEL2ESS_QUARTERMILETIME_CD(bindex,mindex,eindex,uindex) = thedata(3,1);
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
                %0-60mph acceleration time and quarter-mile time
                PARALLEL2ESS_ACCELTIME_CS(bindex,mindex,eindex,uindex) = thedata(1,1);
                PARALLEL2ESS_QUARTERMILETIME_CS(bindex,mindex,eindex,uindex) = thedata(3,1);
            end
        end
    end
end

save('PARALLEL2ESS_ACCELTIME_CD','PARALLEL2ESS_ACCELTIME_CD');
save('PARALLEL2ESS_ACCELTIME_CS','PARALLEL2ESS_ACCELTIME_CS');
save('PARALLEL2ESS_QUARTERMILETIME_CD','PARALLEL2ESS_QUARTERMILETIME_CD');
save('PARALLEL2ESS_QUARTERMILETIME_CS','PARALLEL2ESS_QUARTERMILETIME_CS');

toc