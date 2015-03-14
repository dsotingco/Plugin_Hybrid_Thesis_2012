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

SERIES_ACCELTIME_CD = initmat;
SERIES_ACCELTIME_CS = initmat;
SERIES_QUARTERMILETIME_CD = initmat;
SERIES_QUARTERMILETIME_CS = initmat;

%end initialization

%Charge-depleting mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            filename = ['series_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_0_' 'CD' '.mat'];
            thedata = importdata(filename);
            %0-60mph acceleration time and quarter-mile time
            SERIES_ACCELTIME_CD(bindex,mindex,eindex) = thedata(1,1);
            SERIES_QUARTERMILETIME_CD(bindex,mindex,eindex) = thedata(3,1);
        end
    end
end


%Charge-sustaining mode
for bindex = 1:length(bats)
    for mindex = 1:length(motors)
        for eindex = 1:length(engines)
            filename = ['series_' num2str(bats(bindex)) '_' num2str(motors(mindex)) '_' num2str(engines(eindex)) '_0_' 'CS' '.mat'];
            thedata = importdata(filename);
            %0-60mph acceleration time and quarter-mile time
            SERIES_ACCELTIME_CS(bindex,mindex,eindex) = thedata(1,1);
            SERIES_QUARTERMILETIME_CS(bindex,mindex,eindex) = thedata(3,1);
        end
    end
end

save('SERIES_ACCELTIME_CD','SERIES_ACCELTIME_CD');
save('SERIES_ACCELTIME_CS','SERIES_ACCELTIME_CS');
save('SERIES_QUARTERMILETIME_CD','SERIES_QUARTERMILETIME_CD');
save('SERIES_QUARTERMILETIME_CS','SERIES_QUARTERMILETIME_CS');

toc