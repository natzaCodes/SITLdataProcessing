function [DataTable] = CreateDataTable(FlightAverage_struct,SimAverage_struct)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%S=load('Roll_Flight_Av1_positive_Struct.AvManeuvers.mat');


%% Equalize vectors' lenght by equalizing time vectors
TimeFlight=FlightAverage_struct.AvManeuvers.Time;
FlightMatrix = FlightAverage_struct.AvManeuvers.Matrix;
FlightAverage = FlightAverage_struct.AvManeuvers.Values;
TimeSim = SimAverage_struct.AvManeuvers.Time;
SimAverage = SimAverage_struct.AvManeuvers.Values;

deltaLenght = abs(size(TimeFlight)-size(TimeSim));
shorterLenght = min(size(TimeFlight),size(TimeSim));
a = size(TimeFlight);
b = size(TimeSim);

if a(2)>shorterLenght(2)
    TimeFlight(:,1:deltaLenght(2))=[];
    FlightMatrix(1:deltaLenght(2),:)=[];
    FlightAverage(1:deltaLenght(2),:)=[];
end
if b(2)>shorterLenght(2)
    SimAverage(1:deltaLenght(2),:)=[];
end

MatrixSize = size(FlightMatrix); 
%disp(MatrixSize(2))
if MatrixSize(2)==3
    colNames = ["Time", "Flight1", "Flight2", "Flight3", "AverageFlight", "Simulation"];
elseif MatrixSize(2)==4
    colNames = ["Time", "Flight1", "Flight2", "Flight3", "Flight4", "AverageFlight", "Simulation"];
else
    colNames = ["Time", "Flight1", "Flight2", "Flight3", "Flight4", "Flight5", "AverageFlight", "Simulation"];
end 

data = [TimeFlight' FlightMatrix,FlightAverage, SimAverage];

DataTable = array2table(data, 'VariableNames',colNames);

end