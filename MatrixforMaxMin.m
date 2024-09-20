function [MaxMinMatrix,time] = MatrixforMaxMin(Lenght,Datasheet1_struct, Datasheet2_struct, Datasheet3_struct, Datasheet4_struct, Datasheet5_struct, WhattoMatrixStr)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


fn=fieldnames(Datasheet1_struct.Intersection1); % names of cells in datasheet
number_with_name=ismember(fn,WhattoMatrixStr); %find number of cell which name is b
value_cell_big = struct2cell(Datasheet1_struct.Intersection1);
value_cell =value_cell_big(number_with_name);
AttitudeArray1 = cell2mat(value_cell);

fn=fieldnames(Datasheet2_struct.Intersection1); % names of cells in datasheet
number_with_name=ismember(fn,WhattoMatrixStr); %find number of cell which name is b
value_cell_big = struct2cell(Datasheet2_struct.Intersection1);
value_cell =value_cell_big(number_with_name);
AttitudeArray2 = cell2mat(value_cell);

fn=fieldnames(Datasheet3_struct.Intersection1); % names of cells in datasheet
number_with_name=ismember(fn,WhattoMatrixStr); %find number of cell which name is b
value_cell_big = struct2cell(Datasheet3_struct.Intersection1);
value_cell =value_cell_big(number_with_name);
AttitudeArray3 = cell2mat(value_cell);

fn=fieldnames(Datasheet4_struct.Intersection1); % names of cells in datasheet
number_with_name=ismember(fn,WhattoMatrixStr); %find number of cell which name is b
value_cell_big = struct2cell(Datasheet4_struct.Intersection1);
value_cell =value_cell_big(number_with_name);
AttitudeArray4 = cell2mat(value_cell);

fn=fieldnames(Datasheet5_struct.Intersection1); % names of cells in datasheet
number_with_name=ismember(fn,WhattoMatrixStr); %find number of cell which name is b
value_cell_big = struct2cell(Datasheet5_struct.Intersection1);
value_cell =value_cell_big(number_with_name);
AttitudeArray5 = cell2mat(value_cell);


%fprintf("minL=");
%disp(min(Lenght));

%fprintf("L=");
%disp(Lenght(1));
if Lenght(1)>min(Lenght)
    Datasheet1_struct.Intersection1.Time(min(Lenght)+1:end)=[];
    AttitudeArray1(min(Lenght)+1:end)=[];
end

%disp(Lenght(2));
if Lenght(2)>min(Lenght)
    AttitudeArray2(min(Lenght)+1:end)=[];
end

%disp(Lenght(3));
if Lenght(3)>min(Lenght)
    AttitudeArray3(min(Lenght)+1:end)=[];
end

%disp(Lenght(4));
if Lenght(4)>min(Lenght)
    AttitudeArray4(min(Lenght)+1:end)=[]; 
end

%disp(Lenght(5));
if Lenght(5)>min(Lenght)
    AttitudeArray5(min(Lenght)+1:end)=[];
end 

time = Datasheet1_struct.Intersection1.Time;
MaxMinMatrix = [AttitudeArray1 AttitudeArray2 AttitudeArray3 AttitudeArray4 AttitudeArray5];

end