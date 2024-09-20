function [FitFunction,FlightDesManeuver] = modelFit(Flight_Struct, WhichATT, DesATTstr, FlightAverage_struct,SimAverage_struct)
%UNTITLED3 Claculates model fit in %
%   
fn=fieldnames(Flight_Struct.ATT); % names of cells in datasheet
number_with_name=ismember(fn,WhichATT); %find number of cell which name is b
value_cell_big = struct2cell(Flight_Struct.ATT);
value_cell =value_cell_big(number_with_name);
AttitudeArray1 = cell2mat(value_cell);

fn=fieldnames(Flight_Struct.ATT); % names of cells in datasheet
number_with_name=ismember(fn,DesATTstr); %find number of cell which name is b
value_cell_big = struct2cell(Flight_Struct.ATT);
value_cell =value_cell_big(number_with_name);
DesAttitudeArray1 = cell2mat(value_cell);


%% Equalize vectors' leght by equalizing time vectors
TimeFlight=FlightAverage_struct.AvManeuvers.Time;
FlightAverage = FlightAverage_struct.AvManeuvers.Values;
TimeSim = SimAverage_struct.AvManeuvers.Time;
SimAverage = SimAverage_struct.AvManeuvers.Values;

deltaLenght = abs(size(TimeFlight)-size(TimeSim));
shorterLenght = min(size(TimeFlight),size(TimeSim));
a = size(TimeFlight);
b = size(TimeSim);

if a(2)>shorterLenght(2)
    TimeFlight(:,1:deltaLenght(2))=[];
    FlightAverage(1:deltaLenght(2),:)=[];
end
if b(2)>shorterLenght(2)
    TimeSim(:,1:deltaLenght(2))=[];
    SimAverage(1:deltaLenght(2),:)=[];
end
FlightSingleManeuver= interp1(Flight_Struct.ATT.TimeS, AttitudeArray1,TimeFlight, 'spline');
FlightDesManeuver= max(DesAttitudeArray1);
%{
figure 
plot(TimeFlight, FlightAverage);
hold on
plot(TimeSim, SimAverage);
hold on
plot(TimeFlight, FlightSingleManeuver);
hold on
plot(TimeFlight, FlightDesManeuver);
hold off
legend('AvFLight', 'AvSIm', 'Flight', 'DesATT');
%}
%%  Eq no 2.21 p.20 from: https://liu.diva-portal.org/smash/get/diva2:1314593/FULLTEXT01.pdf
% Euclidean norm - gives the ordinary distance from the origin to the point
numeratorEuclidean = norm(FlightSingleManeuver-SimAverage);
denumaratorEuclidean = norm(FlightSingleManeuver-FlightAverage);
FitFunction(1) = 100*(1-numeratorEuclidean/denumaratorEuclidean);

%% F2 simple offset average method
numeratorF2 = abs(FlightAverage-SimAverage);
ErrorF2 = abs(numeratorF2./FlightAverage);
FitFunction(2) = mean(-(ErrorF2)+1)*100;

%% F3 rmse value
FitFunction(3) = rms(SimAverage-FlightAverage);

%% F4 rmse/rms for errors model using Euclidean norm
Error1 = abs(FlightAverage-FlightDesManeuver);
Error2 = abs(SimAverage-FlightDesManeuver);
numeratorF4 = norm(Error1-Error2);
DenumeratorF4 = norm(Error1);
FitFunction(4) = (1-(numeratorF4/DenumeratorF4))*100;

%% F5 rmse/rms for errors model; should be the same as F2
Up1 = rms(Error1-Error2);
Down1 = rms(Error1);
FitFunction(5) = (1-(Up1/Down1))*100;

%% F6 rmse/rms model Flight vs Sim - we agreeed to use this one
Up2 = rms(FlightAverage-SimAverage);
Down2 = rms(FlightAverage);
FitFunction(6) = (1-(Up2/Down2))*100;

end