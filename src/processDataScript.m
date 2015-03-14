
%Volt stuff
    vbat = 16;
    vmot = 111;
    veng = 62;
    vucap = 0;

    %pack the data
    voltconfig(1) = vbat;
    voltconfig(2) = vmot;
    voltconfig(3) = veng;
    voltconfig(4) = vucap;

    %read these off Volt_EV_mode.xlsx: electric consumption in kWh / 100mi for
    %FTP, HWFET, UDDS, US06
    voltdata(1) = 26.478;
    voltdata(2) = 25.782;
    voltdata(3) = 26.355;
    voltdata(4) = 40.437;

    %MPGs
    voltdata(5) = getRawData('SERIES','MPG_CD_FTP',vbat,vmot,veng,vucap);
    voltdata(6) = getRawData('SERIES','MPG_CD_HWFET',vbat,vmot,veng,vucap);
    voltdata(7) = getRawData('SERIES','MPG_CD_US06',vbat,vmot,veng,vucap);

    %CO2
    voltdata(8) = getRawData('SERIES','CO2_CS_FTP',vbat,vmot,veng,vucap);
    voltdata(9) = getRawData('SERIES','CO2_CS_HWFET',vbat,vmot,veng,vucap);
    voltdata(10) = getRawData('SERIES','CO2_CS_US06',vbat,vmot,veng,vucap);
    
    disp(' ');
    disp('Volt Data: ');
    processData(voltconfig,voltdata);

%Prius PHEV stuff
    pbat = 4.4;
    pmot = 60;
    peng = 73;
    pucap = 0;
    
    %pack the data
    priusconfig(1) = pbat;
    priusconfig(2) = pmot;
    priusconfig(3) = peng;
    priusconfig(4) = pucap;
    
    %read these off Prius_EV_mode.xlsx: electric consumption in kWh / 100
    %mi for FTP, HWFET, UDDS, US06
    priusdata(1) = 23.579;
    priusdata(2) = 24.56;
    priusdata(3) = 22.642;
    priusdata(4) = 40.975;
    
    %MPGs
    priusdata(5) = getRawData('SPLIT','MPG_CD_FTP',pbat,pmot,peng,pucap);
    priusdata(6) = getRawData('SPLIT','MPG_CD_HWFET',pbat,pmot,peng,pucap);
    priusdata(7) = getRawData('SPLIT','MPG_CD_US06',pbat,pmot,peng,pucap);
    
    %CO2
    priusdata(8) = getRawData('SPLIT','CO2_CS_FTP',pbat,pmot,peng,pucap);
    priusdata(9) = getRawData('SPLIT','CO2_CS_HWFET',pbat,pmot,peng,pucap);
    priusdata(10) = getRawData('SPLIT','CO2_CS_US06',pbat,pmot,peng,pucap);
    
    disp(' ');
    disp('Prius Data: ');
    processData(priusconfig,priusdata);
    
%Karma stuff
    kbat = 20.1;
    kmot = 300;
    keng = 194;
    kucap = 0;
    
    %pack the data
    karmaconfig(1) = kbat;
    karmaconfig(2) = kmot;
    karmaconfig(3) = keng;
    karmaconfig(4) = kucap;
    
    %read these off Karma_EV_mode.xlsx
    karmadata(1) = 28.117;
    karmadata(2) = 25.93;
    karmadata(3) = 28.401;
    karmadata(4) = 39.385;
    
    %MPGs: read these off Karma_CS_mode.xlsx
    karmadata(5) = 31.44;
    karmadata(6) = 33.76;
    karmadata(7) = 24.37;
    
    %CO2: read these off Karma_CS_mode.xlsx
    karmadata(8) = 379.64;
    karmadata(9) = 353.52;
    karmadata(10) = 489.82;
    
    disp(' ');
    disp('Karma Data: ');
    processData(karmaconfig,karmadata);