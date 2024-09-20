function [Average, Time, Matrix] = AverageArray(Datasheet1_struct, Datasheet2_struct, Datasheet3_struct, Datasheet4_struct, Datasheet5_struct, WhattoMatrixStr, deltaTimebefore, deltaTimeafter, maxAngleModule)
%UNTITLED2 This function returns Array with average values for 5 data

%   The function reads deata series for average, interpolates datapoints to
%   find values after interpolation for given timeframe. Creates Matrix
%   with all interpolated datapoints, finds the first datapoint which |value| exceeds 10% of
%   |max angle| and deletes its row with all rows above. Than finds mean
%   values for each Time point and returns it as Average(Array)


fn=fieldnames(Datasheet1_struct.ATT); % names of cells in datasheet
number_with_name=ismember(fn,WhattoMatrixStr); %find number of cell which name is b
value_cell_big = struct2cell(Datasheet1_struct.ATT);
value_cell =value_cell_big(number_with_name);
AttitudeArray1 = cell2mat(value_cell);

fn=fieldnames(Datasheet2_struct.ATT); % names of cells in datasheet
number_with_name=ismember(fn,WhattoMatrixStr); %find number of cell which name is b
value_cell_big = struct2cell(Datasheet2_struct.ATT);
value_cell =value_cell_big(number_with_name);
AttitudeArray2 = cell2mat(value_cell);

fn=fieldnames(Datasheet3_struct.ATT); % names of cells in datasheet
number_with_name=ismember(fn,WhattoMatrixStr); %find number of cell which name is b
value_cell_big = struct2cell(Datasheet3_struct.ATT);
value_cell =value_cell_big(number_with_name);
AttitudeArray3 = cell2mat(value_cell);

fn=fieldnames(Datasheet4_struct.ATT); % names of cells in datasheet
number_with_name=ismember(fn,WhattoMatrixStr); %find number of cell which name is b
value_cell_big = struct2cell(Datasheet4_struct.ATT);
value_cell =value_cell_big(number_with_name);
AttitudeArray4 = cell2mat(value_cell);

fn=fieldnames(Datasheet5_struct.ATT); % names of cells in datasheet
number_with_name=ismember(fn,WhattoMatrixStr); %find number of cell which name is b
value_cell_big = struct2cell(Datasheet5_struct.ATT);
value_cell =value_cell_big(number_with_name);
AttitudeArray5 = cell2mat(value_cell);

Time = linspace(deltaTimebefore, deltaTimebefore+deltaTimeafter, 1000);
vq1= interp1(Datasheet1_struct.ATT.TimeS, AttitudeArray1,Time, 'spline');
vq2= interp1(Datasheet2_struct.ATT.TimeS, AttitudeArray2,Time, 'spline');
vq3= interp1(Datasheet3_struct.ATT.TimeS, AttitudeArray3,Time, 'spline');
vq4= interp1(Datasheet4_struct.ATT.TimeS, AttitudeArray4,Time, 'spline');
vq5= interp1(Datasheet5_struct.ATT.TimeS, AttitudeArray5,Time, 'spline');


if all(size(AttitudeArray3) == size(AttitudeArray4))&&all(AttitudeArray3==AttitudeArray4)
    Matrix = [vq1' vq2' vq3'];
     
elseif all(size(AttitudeArray4) == size(AttitudeArray5))&&all(AttitudeArray4==AttitudeArray5)
    Matrix = [vq1' vq2' vq3' vq4'];
else
    Matrix = [vq1' vq2' vq3' vq4' vq5'];
end 




[~,b] =  find(abs(Matrix')>0.1*maxAngleModule,1); %find where 10% of max angle is reached first time
Matrix(1:b,:)=[]; %Delete data before
Time(1:b)=[];
MatrixSize = size(Matrix);
%Average = zeros(min(Lenght),5);
%size(Matrix)
for i = 1:MatrixSize(1)

    Average(i,1) = mean(Matrix(i,:));

end
%size(Average)
end