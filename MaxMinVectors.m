function [timeUltimate,functionUltimate] = MaxMinVectors(Matrix,Time)
%UNTITLED4 Outputs array with max and min values of the given vectors
%% Arrays go: time->reversed(time); maxStart-maxEnd-minEnd-minStart 

array_size = size(Matrix);
row_number = array_size(1);

for i = 1:row_number

    minVal(i,1) = min(Matrix(i,:));
    maxVal(i,1) = max(Matrix(i,:));

end


functionUltimate=[maxVal; flip(minVal)];
timeUltimate = [Time; flip(Time)];



%a=min(Maneuver1_forPatch.ATT.Pitch,Maneuver2_forPatch.ATT.Pitch);
%e=max(Maneuver1_forPatch.ATT.Pitch,Maneuver2_forPatch.ATT.Pitch);

%timeUltimate = [Maneuver1_forPatch.ATT.TimeS; flip(Maneuver1_forPatch.ATT.TimeS)];
%functionUltimate=[a;flip(e)];

end