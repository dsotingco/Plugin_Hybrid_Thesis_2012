%GETDATA - Returns data for PHEVGUI.
%GETDATA(ARCH,DESDATA,CYCLE,MODE,BAT,MOTOR,ENGINE,UCAPS)
%choices for desdata: MPG, MPGE, ELEC, etc.

function res = getData(arch,desdata,cycle,mode,bat,motor,engine,ucaps)
    switch cycle
        case 'FTP'
            rawDesData = [desdata '_' mode '_' cycle];
            res  = getRawData(arch,rawDesData,bat,motor,engine,ucaps);
        case 'HWFET'
            rawDesData = [desdata '_' mode '_' cycle];
            res  = getRawData(arch,rawDesData,bat,motor,engine,ucaps);
        case 'US06'
            rawDesData = [desdata '_' mode '_' cycle];
            res  = getRawData(arch,rawDesData,bat,motor,engine,ucaps);
        case 'CITY'
            newDesData = [mode '_' desdata '_' cycle];
            res = getProcessedData(arch,newDesData,bat,motor,engine,ucaps);
        case 'HIGHWAY'
            newDesData = [mode '_' desdata '_' cycle];
            res = getProcessedData(arch,newDesData,bat,motor,engine,ucaps);
        case 'COMBINED'
            switch mode
                case 'CD'
                    switch desdata
                        case 'CDRANGE'
                            res = getRawData(arch,desdata,bat,motor,engine,ucaps);
                        case {'MPG','MPGE','CO2','ELEC'}
                            newDesData = [mode '_' desdata '_' cycle];
                            res = getProcessedData(arch,newDesData,bat,motor,engine,ucaps);
                        otherwise
                            newDesData = [desdata '_' mode];
                            res = getRawData(arch,newDesData,bat,motor,engine,ucaps);
                    end
                case 'CS'
                    switch desdata
                        case {'MPG','MPGE','CO2','ELEC'}
                            newDesData = [mode '_' desdata '_' cycle];
                            res = getProcessedData(arch,newDesData,bat,motor,engine,ucaps);
                        otherwise
                            newDesData = [desdata '_' mode];
                            res = getRawData(arch,newDesData,bat,motor,engine,ucaps);
                    end
                case 'MDIUF'
                    newDesData = [desdata '_' mode];
                    res = getProcessedData(arch,newDesData,bat,motor,engine,ucaps);
                case 'FUF'
                    newDesData = [desdata '_' mode];
                    res = getProcessedData(arch,newDesData,bat,motor,engine,ucaps);
                otherwise
                    newDesData = [mode '_' desdata '_' cycle];
                    res = getProcessedData(arch,newDesData,bat,motor,engine,ucaps);
            end
    end
end