function res = getUS06MPG(bat,motor,engine,modecode)
    %modecode: 1 for CS, 2 for EV
    load US06_MPG_CS;
    load US06_MPG_EV;
    bats = [5 15 25];
    motors = [50 100 150];
    engines = [50 75];
    %ucaps = [0];
    [batmat,motmat,engmat] = ndgrid(bats,motors,engines);
    if modecode==1
        res = interpn(batmat,motmat,engmat,US06_MPG_CS,bat,motor,engine);
    elseif modecode==2
        res = interpn(batmat,motmat,engmat,US06_MPG_EV,bat,motor,engine);
    end
end