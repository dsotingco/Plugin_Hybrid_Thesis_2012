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

SPLITDUAL_ACCELTIME_CD = initmat;
SPLITDUAL_ACCELTIME_CS = initmat;
SPLITDUAL_QUARTERMILETIME_CD = initmat;
SPLITDUAL_QUARTERMILETIME_CS = initmat;

%end initialization

%Charge-depleting mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            for uindex = 1:length(ucaps)
                filename = ['splitdual_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_' num2str(ucaps(uindex)) '_CD' '.mat'];
                thedata = importdata(filename);
                %0-60mph acceleration time and quarter-mile time
                SPLITDUAL_ACCELTIME_CD(bindex,mindex,eindex,uindex) = thedata(1,1);
                SPLITDUAL_QUARTERMILETIME_CD(bindex,mindex,eindex,uindex) = thedata(3,1);
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
                %0-60mph acceleration time and quarter-mile time
                SPLITDUAL_ACCELTIME_CS(bindex,mindex,eindex,uindex) = thedata(1,1);
                SPLITDUAL_QUARTERMILETIME_CS(bindex,mindex,eindex,uindex) = thedata(3,1);
            end
        end
    end
end

save('SPLITDUAL_ACCELTIME_CD','SPLITDUAL_ACCELTIME_CD');
save('SPLITDUAL_ACCELTIME_CS','SPLITDUAL_ACCELTIME_CS');
save('SPLITDUAL_QUARTERMILETIME_CD','SPLITDUAL_QUARTERMILETIME_CD');
save('SPLITDUAL_QUARTERMILETIME_CS','SPLITDUAL_QUARTERMILETIME_CS');

toc