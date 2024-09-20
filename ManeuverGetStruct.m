function [Maneuver] = ManeuverGetStruct(dataSheet, TimePoint,deltaTimeBefore, deltaTimeAfter)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

Maneuver_fixed = dataSheet.getSlice([TimePoint-deltaTimeBefore,TimePoint+deltaTimeAfter], 'TimeS');  

%file free of ardupilog dependency
Maneuver = Maneuver_fixed.getStruct();


% Maneuver starts at zero time
Maneuver.ATT.TimeS = Maneuver.ATT.TimeS - TimePoint + deltaTimeBefore;
Maneuver.RCIN.TimeS = Maneuver.RCIN.TimeS - TimePoint + deltaTimeBefore;
Maneuver.RCUT.TimeS = Maneuver.RCOU.TimeS - TimePoint + deltaTimeBefore;


%Maneuver2 = Maneuver2_fixed.getStruct(); 
%Maneuver2.ATT.TimeS = Maneuver2.ATT.TimeS -TimeEndPoint + cutting.deltaTimeBefore;
%Maneuver2.RCIN.TimeS = Maneuver2.RCIN.TimeS -TimeEndPoint + cutting.deltaTimeBefore;
%Maneuver2.RCIN.C2 = PWM2deg(Maneuver2.RCIN.C2,maxDeflectionCtrlSurf, trimCtrlSurf);



end