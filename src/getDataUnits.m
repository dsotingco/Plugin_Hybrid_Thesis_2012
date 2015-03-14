%GETDATAUNITS - Returns the proper units for the type of data.

function res = getDataUnits(data)
    switch data
        case 'MPG'
            res = 'MPG';
        case 'MPGE'
            res = 'MPGe';
        case 'ELEC'
            res = 'kWh / 100 mi.';
        case 'CO2'
            res = 'g / mi.';
        case 'ACCELTIME'
            res = 's';
        case 'QUARTERMILETIME'
            res = 's';
        case 'CDRANGE'
            res = 'mi.';
    end
end