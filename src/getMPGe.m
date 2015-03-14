%getMPGe.m
%converts kWh / 100 mi and MPG to a composite MPGe

function res = getMPGe(elec,mpg)
elecgal = elec./33.7;   %equivalent gal / 100 mi
gasgal = 100./mpg;  %gal / 100 mi for gas
sumgal = elecgal + gasgal;
res = 100./sumgal;  %MPGe
end