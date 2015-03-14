%GETRAWDATA - Returns raw data output from Autonomie (some numbers may have had units
%changed, but otherwise all data is output from simulation with no
%additional calculations.
%GETRAWDATA(ARCH,DESDATA,BAT,MOTOR,ENGINE,UCAPS)
%   ARCH is an all-caps string specifying architecture.  Your choices are:
%       'SERIES' - Series Fixed-Gear PHEV
%       'PARALLEL' - Parallel Pre-transmission (automatic) PHEV
%       'SPLIT' - Split Midsize PHEV
%       'PARALLEL2ESS' - Parallel Pre-transmission (automatic) PHEV with
%           dual energy storage (i.e. battery and ultracapacitor)
%       'SPLITDUAL' - Split Midsize PHEV with dual energy storage (i.e.
%           battery and ultracapacitor)
%   DESDATA is an all-caps string specifying the data you want.  Choices:
%       'MPG_CD_FTP' - miles per gallon in charge-depleting mode for FTP
%           cycle
%       'MPG_CD_HWFET' - miles per gallon in charge-depleting mode for
%           HWFET cycle
%       'MPG_CD_US06' - miles per gallon in charge-depleting mode for US06
%           cycle
%       'MPG_CS_FTP' - miles per gallon in charge-sustaining mode for FTP
%           cycle
%       'MPG_CS_HWFET' - miles per gallon in charge-sustaining mode for
%           HWFET cycle
%       'MPG_CS_US06' - miles per gallon in charge-sustaining mode for US06
%           cycle
%       'MPGE_CD_FTP' - equivalent miles per gallon in charge-depleting mode for FTP
%           cycle
%       'MPGE_CD_HWFET' - equivalent miles per gallon in charge-depleting mode for
%           HWFET cycle
%       'MPGE_CD_US06' - equivalent miles per gallon in charge-depleting mode for US06
%           cycle
%       'MPGE_CS_FTP' - equivalent miles per gallon in charge-sustaining mode for FTP
%           cycle
%       'MPGE_CS_HWFET' - equivalent miles per gallon in charge-sustaining mode for
%           HWFET cycle
%       'MPGE_CS_US06' - equivalent miles per gallon in charge-sustaining mode for US06
%           cycle
%       'CO2_CD_FTP' - CO2 emissions (in g/mi.) in charge-depleting mode
%           for FTP cycle
%       'CO2_CD_HWFET' - CO2 emissions (in g/mi.) in charge-depleting mode
%           for HWFET cycle
%       'CO2_CD_US06' - CO2 emissions (in g/mi.) in charge-depleting mode
%           for US06 cycle
%       'CO2_CS_FTP' - CO2 emissions (in g/mi.) in charge-sustaining mode
%           for FTP cycle
%       'CO2_CS_HWFET' - CO2 emissions (in g/mi.) in charge-sustaining mode
%           for HWFET cycle
%       'CO2_CS_US06' - CO2 emissions (in g/mi.) in charge-sustaining mode 
%           for US06 cycle  
%       'ELEC_CD_FTP' - electric power consumption (in kWh per 100 mi.) in
%           charge-depleting mode for FTP cycle
%       'ELEC_CD_HWFET' - electric power consumption (in kWh per 100 mi.) in
%           charge-depleting mode for HWFET cycle
%       'ELEC_CD_US06' - electric power consumption (in kWh per 100 mi.) in
%           charge-depleting mode for US06 cycle
%       'CDRANGE' - charge-depleting range, in mi. based on UDDS cycle and
%           an assumed 65% state-of-charge envelope in the battery
%       'ACCELTIME_CD' - acceleration time (in seconds) from 0 to 60 mph in
%           charge-depleting mode
%       'ACCELTIME_CS' - acceleration time (in seconds) from 0 to 60 mph in
%           charge-sustaining mode
%       'QUARTERMILETIME_CD' - time (in seconds) to travel 0.25 mi. in
%           charge-depleting mode
%       'QUARTERMILETIME_CS' - time (in seconds) to travel 0.25 mi. in
%           charge-sustaining mode
%   BAT is the battery energy, in kWh
%   MOTOR is the motor peak power, in kW
%   ENGINE is the engine peak power, in kW
%   UCAPS is the number of ultracapacitors (based on Maxwell PC2500
%       ultracapacitor - the data sheet is available online.  It is rated
%       at 2700 F, 8400 J, continuous power output of 1.563 kW

function res = getRawData(arch,desData,bat,motor,engine,ucaps)
    filename = [arch '_' desData '.mat'];
    thedata = importdata(filename);
    %These are the points where the data was evaluated
    batSpace = [5 15 25];
    motorSpace = [50 100 150];
    engineSpace = [50 75];
    if ucaps == 0
        [batmat,motmat,engmat] = ndgrid(batSpace,motorSpace,engineSpace);
        res = interpn(batmat,motmat,engmat,thedata,bat,motor,engine,'spline');
    else
        ucapSpace = [25 50 75 100];
        [batmat,motmat,engmat,ucapmat] = ndgrid(batSpace,motorSpace,engineSpace,ucapSpace);
        res = interpn(batmat,motmat,engmat,ucapmat,thedata,bat,motor,engine,ucaps,'spline');
    end
end