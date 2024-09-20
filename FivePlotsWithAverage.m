function [] = FivePlotsWithAverage(Datasheet1_struct,Datasheet2_struct, Datasheet3_struct, Datasheet4_struct, Datasheet5_struct, WhattoplotStr, ATTAv,TimeAv)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

fn=fieldnames(Datasheet1_struct.ATT); % names of cells in datasheet
number_with_name=ismember(fn,WhattoplotStr); %find number of cell which name is b
value_cell_big = struct2cell(Datasheet1_struct.ATT);
value_cell =value_cell_big(number_with_name);
AttitudeArray1 = cell2mat(value_cell);

fn=fieldnames(Datasheet2_struct.ATT); % names of cells in datasheet
number_with_name=ismember(fn,WhattoplotStr); %find number of cell which name is b
value_cell_big = struct2cell(Datasheet2_struct.ATT);
value_cell =value_cell_big(number_with_name);
AttitudeArray2 = cell2mat(value_cell);

fn=fieldnames(Datasheet3_struct.ATT); % names of cells in datasheet
number_with_name=ismember(fn,WhattoplotStr); %find number of cell which name is b
value_cell_big = struct2cell(Datasheet3_struct.ATT);
value_cell =value_cell_big(number_with_name);
AttitudeArray3 = cell2mat(value_cell);

fn=fieldnames(Datasheet4_struct.ATT); % names of cells in datasheet
number_with_name=ismember(fn,WhattoplotStr); %find number of cell which name is b
value_cell_big = struct2cell(Datasheet4_struct.ATT);
value_cell =value_cell_big(number_with_name);
AttitudeArray4 = cell2mat(value_cell);

fn=fieldnames(Datasheet5_struct.ATT); % names of cells in datasheet
number_with_name=ismember(fn,WhattoplotStr); %find number of cell which name is b
value_cell_big = struct2cell(Datasheet5_struct.ATT);
value_cell =value_cell_big(number_with_name);
AttitudeArray5 = cell2mat(value_cell);


figure 
plot(Datasheet1_struct.ATT.TimeS-2, AttitudeArray1);
hold on
plot(Datasheet2_struct.ATT.TimeS-2, AttitudeArray2);
hold on
plot(Datasheet3_struct.ATT.TimeS-2, AttitudeArray3);
hold on
plot(Datasheet4_struct.ATT.TimeS-2, AttitudeArray4);
hold on
plot(Datasheet5_struct.ATT.TimeS-2, AttitudeArray5);
hold on
plot(TimeAv-2,ATTAv, 'LineWidth', 3);
hold off 

tit= [WhattoplotStr, ' - Plot to check average function'];
title(tit);
ylabel('Attitude [deg]');
xlabel('Time [s]');
legend('1', '2', '3', '4', '5', 'Av');

end