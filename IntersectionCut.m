function [TimeNew,AttitudeNew,Length] = IntersectionCut(Maneuver_Struct,Attitude, intersectionStart, intersectionStop)
%UNTITLED Cut data in time slot when maneuvers' responses Start
%intersection and End intersection among each other

%% Call it: [Maneuver_forPatch, Maneuver_forPatch.ATT.AttitudeYouwant] = IntersectionCut(...)

%% This part is needed to write only the name 'Roll' or 'Pitch' as AttitudeYouwant

%fn=fieldnames(Maneuver_Struct.ATT); % names of cells in datasheet
%number_with_name=ismember(fn,AttitudeNameStr); %find number of cell which name is b
%value_cell_big = struct2cell(Maneuver_Struct.ATT);
%value_cell =value_cell_big(number_with_name);
%AttitudeArray = cell2mat(value_cell);

From=find(Maneuver_Struct.ATT.TimeS>intersectionStart, 1);
To=find(Maneuver_Struct.ATT.TimeS>intersectionStop, 1);

TimeNew= Maneuver_Struct.ATT.TimeS(From:To,1);
AttitudeNew = Attitude(From:To,1);
Length = To-From+1;


%b=find(Maneuver2.ATT.TimeS>4.007);
%b=min(b);
%c=find(Maneuver2.ATT.TimeS>7.56, 1 );
%c=min(c);
%Maneuver2_forPatch.ATT.TimeS = Maneuver2.ATT.TimeS(b:c,1);
%Maneuver2_forPatch.ATT.Pitch = Maneuver2.ATT.Pitch(b:c,1);

end