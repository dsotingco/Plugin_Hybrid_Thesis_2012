%   GETMINMSRP - Returns the minimum MSRP of a PHEV.  This model is based
%   on adding the costs of batteries, motors, and ultracapacitors to the
%   MSRP of a conventional vehicle with the same power output from its
%   drivetrain.  
%   BAT is the battery energy, in kWh
%   MOTOR is the motor peak power, in kW
%   ENGINE is the engine peak power, in kW
%   UCAPS is the number of ultracapacitors (based on Maxwell PC2500
%       ultracapacitor - the data sheet is available online.  It is rated
%       at 2700 F, 8400 J, continuous power output of 1.563 kW


function res = getMinMSRP(bat,motor,engine,ucaps)
PE = motor./bat;    %power-to-energy ratio
totalPower = motor + engine;

convMSRP = getMSRP(totalPower);
batteryCost = getBatteryCost(motor,bat,'argonneMidModel');
motorCost = getMotorCost(motor);
engineCost = getEngineCost(engine);
ucapCost = getUcapCost(ucaps);

res = round(convMSRP + batteryCost + motorCost + engineCost + ucapCost);
end







