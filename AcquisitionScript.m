
%vna=gpib('ni',0,16); % NI USB/GPIB
vna=gpib('agilent',7,16); % Agilent USB/GPIB

vna.InputBufferSize=4e6;
vna.Timeout=10;
fopen(vna);

fprintf(vna,'IDN?');
fscanf(vna);

%% 8753D VNA
fprintf(vna,'STAR?');                                                       %asks for the start frequency point
sdata.fstart=str2double(fscanf(vna));                                       %reads the start frequency point
fprintf(vna,'STOP?');                                                       %asks for the stop frequency point
sdata.fstop=str2double(fscanf(vna));                                        %reads the stop frequency point
fprintf(vna,'POIN?');                                                       %asks for the number of frequency points
fpoints=str2double(fscanf(vna));                                            %reads the number of frequency points
sdata.freq=linspace(sdata.fstart,sdata.fstop,fpoints);                      %creates an array with the frequency points
fprintf(vna,'S11;');                                                        %selects the S11 trace
fprintf(vna,'FORM4;');                                                      %defines the data format as ASCII floating point
fprintf(vna,'SING;OPC?');                                                   %requests a single sweep
fscanf(vna);
fprintf(vna,'OUTPDATA;');                                                   %asks to output the corrected data of the active channel
tmps11=fscanf(vna,'%f,%f\n',[2,fpoints]);                                   %reads to output the corrected data of the active channel
tmps11 = tmps11';
tmps11_comp = tmps11(:,1)+1i*tmps11(:,2);                                   %creates a vector with complex (a+j*b) data


f = figure;
a = axes(f); plot(a,sdata.freq/1e9,20*log10(abs(tmps11_comp))); grid
xlabel('Frequency (GHz)');
ylabel('|S_{11}|^2 (dB)');
title('Reflection coefficient')

fclose(vna)


% %% PNA
% fprintf(vna,'DISP:WIND:TRAC:DEL'); %deletes old traces
% fprintf(vna,'DISPLAY:WINDOW1:STATE OFF'); %deletes old window
% fprintf(vna,'DISPLAY:WINDOW1:STATE ON'); %creates a new window
% fprintf(vna,'calculate:parameter:define meas_1,s11'); %assigns the S11 trace to the meas_1 parameter
% fprintf(vna,'DISPlay:WINDOW1:trace1:feed meas_1'); %assigns the meas_1 parameter to the new trace and visualizes it
% fprintf(vna,'init:imm'); %defines the acquisition trigger
% fprintf(vna,'*OPC?'); %asks if the previous operation has completed
% fscanf(vna); %reads a 1 when the previous operation has completed
% fprintf(vna,'CALC:PAR:SEL meas_1');%selects the meas_1 as the output parameter
% fprintf(vna,'calc1:data? SDATA'); );%asks for the corrected data on the selected parameter
% tmps11 = str2num(fscanf(vna)); );%reads the data from the VNA
% s11_comp =(tmps11(1:2:end))+1i*(tmps11(2:2:end)); %creates a vector with complex (a+j*b) data

