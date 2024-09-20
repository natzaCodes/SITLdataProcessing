clc;
clearvars -except log6 log8 SG2_1 SG2_2 SG2_3;
close all;

% Choose a file .log: 
%just as Ardupilog() you have to select a file manually
log6 = Ardupilog('source/log6.bin');
log8 = Ardupilog('source/log8.bin');
SG2_1 = Ardupilog('source/SG2_1_AfterFlightTesting.bin');
SG2_2 = Ardupilog('source/SG2_2AfterflightTesting.bin');
SG2_3 = Ardupilog('source/SG2_3AfterFlightTesting.bin');
% Now we plot everything we want. Plotting is done with seperate functions
% so we avoid mess in the code. 

%% All of the plots are automatically saved!!!
savein= 'source\Plots\';
saveinDataFile = 'source\';
% General formula is ['C:\FinalFolder\']


%% Plots maneuvers
%Plotting positions so we can see when maneuvers happened and how
%trajectory looked like. 

%PositionPlots(<datasheet name>, <datasheet name but string>, savein)
%PositionPlots(log, 'log', savein);  

%% Slicing data
% Slicing data can be useful in case we have more than one flight per data
% set. We do not ude it otherwise.

% NewDataSheet= DataSheet.getSlice([from,to],[whatwise]);
%Flight1 = log.getSlice([240,400], 'TimeS');  
%Flight2 = log.getSlice([430,500], 'TimeS');
   

%% Plotting two data series on one plot
% useful for comparing attitudes' and deflections' input-output responses; 
% and attitudes based on PID tunning from simulation and flight. 
% PLOTS OVER TIME

WhatOnThePlot1 = 'ATT/DesRoll';
WhatOnThePlot2 = 'ATT/Roll';
PlotName = 'Comparison of Roll for log6';

%TwoPlotsMaker(WhatOnThePlot1,WhatOnThePlot2,log6, PlotName, savein);
%TwoPlotsMaker('ATT/DesPitch','ATT/Pitch',log6, 'Comparison of Pitch - negative only- for log6', savein);
%TwoPlotsMaker('ATT/DesPitch','ATT/Pitch',log8, 'Comparison of Pitch - positive only- for log8', savein);
%TwoPlotsMaker('ATT/DesRoll','ATT/Roll',SG2_1, 'Comparison of Roll for SG2.1', savein);
%TwoPlotsMaker('ATT/DesPitch','ATT/Pitch',SG2_2, 'Comparison of Pitch - negative only- for SG2_2', savein);
%TwoPlotsMaker('ATT/DesPitch','ATT/Pitch',SG2_3, 'Comparison of Pitch - positive only- for SG2.3', savein);

%% --- Plotting maneuvers responses for sim- and flight- tunning ---

% ---Get struct of a single maneuver---

%% Roll Positive
Roll1_Flight_Av1_positive_Struct = ManeuverGetStruct(log6, 245.239+0.037-0.03747, 2,3);
Roll2_Flight_Av1_positive_Struct = ManeuverGetStruct(log6, 273.683+0.037, 2,3);
Roll3_Flight_Av1_positive_Struct = ManeuverGetStruct(log6, 307.558+0.037+0.0028, 2,3);
Roll4_Flight_Av1_positive_Struct = ManeuverGetStruct(log6, 325.439+0.037+0.044, 2,3);
Roll5_Flight_Av1_positive_Struct = ManeuverGetStruct(log6, 358.485+0.037-0.03747, 2,3);
[Roll_Flight_Av1_positive_Struct.AvManeuvers.Values, Roll_Flight_Av1_positive_Struct.AvManeuvers.Time, Roll_Flight_Av1_positive_Struct.AvManeuvers.Matrix]...
    = AverageArray(Roll1_Flight_Av1_positive_Struct,Roll2_Flight_Av1_positive_Struct,Roll3_Flight_Av1_positive_Struct,Roll4_Flight_Av1_positive_Struct,Roll5_Flight_Av1_positive_Struct, 'Roll', 2,3,40);


Roll1_Sim_Av1_positive_Struct = ManeuverGetStruct(SG2_1, 543.799+0.023, 2,3);
Roll2_Sim_Av1_positive_Struct = ManeuverGetStruct(SG2_1, 557.441, 2,3);
Roll3_Sim_Av1_positive_Struct = ManeuverGetStruct(SG2_1, 575.336, 2,3);
Roll4_Sim_Av1_positive_Struct = ManeuverGetStruct(SG2_1, 676.413, 2,3);
Roll5_Sim_Av1_positive_Struct = ManeuverGetStruct(SG2_1, 749.826, 2,3);
[Roll_Sim_Av1_positive_Struct.AvManeuvers.Values, Roll_Sim_Av1_positive_Struct.AvManeuvers.Time, Roll_Sim_Av1_positive_Struct.AvManeuvers.Matrix]...
    = AverageArray(Roll1_Sim_Av1_positive_Struct,Roll2_Sim_Av1_positive_Struct,Roll3_Sim_Av1_positive_Struct,Roll4_Sim_Av1_positive_Struct,Roll5_Sim_Av1_positive_Struct, 'Roll', 2,3,40);


[FitFun2.Roll_positive(:,1)] = modelFit(Roll1_Flight_Av1_positive_Struct, 'Roll', 'DesRoll',Roll_Flight_Av1_positive_Struct,Roll_Sim_Av1_positive_Struct);
[FitFun2.Roll_positive(:,2)] = modelFit(Roll2_Flight_Av1_positive_Struct, 'Roll', 'DesRoll',Roll_Flight_Av1_positive_Struct,Roll_Sim_Av1_positive_Struct);
[FitFun2.Roll_positive(:,3)] = modelFit(Roll3_Flight_Av1_positive_Struct, 'Roll', 'DesRoll',Roll_Flight_Av1_positive_Struct,Roll_Sim_Av1_positive_Struct);
[FitFun2.Roll_positive(:,4)] = modelFit(Roll4_Flight_Av1_positive_Struct, 'Roll', 'DesRoll',Roll_Flight_Av1_positive_Struct,Roll_Sim_Av1_positive_Struct);
[FitFun2.Roll_positive(:,5)] = modelFit(Roll5_Flight_Av1_positive_Struct, 'Roll', 'DesRoll',Roll_Flight_Av1_positive_Struct,Roll_Sim_Av1_positive_Struct);

DataTable = CreateDataTable(Roll_Flight_Av1_positive_Struct,Roll_Sim_Av1_positive_Struct);
temp = [saveinDataFile,'Roll_positive.mat'];
save(temp,'DataTable');



%% Roll negative
Roll1_Flight_Av1_negative_Struct = ManeuverGetStruct(log6, 148.598, 2,3);
Roll2_Flight_Av1_negative_Struct = ManeuverGetStruct(log6, 263.084, 2,3);
Roll3_Flight_Av1_negative_Struct = ManeuverGetStruct(log6, 317.638, 2,3);
Roll4_Flight_Av1_negative_Struct = ManeuverGetStruct(log6, 505.960, 2,3);
[Roll_Flight_Av1_negative_Struct.AvManeuvers.Values, Roll_Flight_Av1_negative_Struct.AvManeuvers.Time,Roll_Flight_Av1_negative_Struct.AvManeuvers.Matrix ]...
    = AverageArray(Roll1_Flight_Av1_negative_Struct,Roll2_Flight_Av1_negative_Struct,Roll3_Flight_Av1_negative_Struct,Roll4_Flight_Av1_negative_Struct,Roll4_Flight_Av1_negative_Struct, 'Roll', 2,3,40);


Roll1_Sim_Av1_negative_Struct = ManeuverGetStruct(SG2_1, 912.798+0.000352, 2,3);
Roll2_Sim_Av1_negative_Struct = ManeuverGetStruct(SG2_1, 932.372, 2,3);
Roll3_Sim_Av1_negative_Struct = ManeuverGetStruct(SG2_1, 950.796+0.000352, 2,3);
Roll4_Sim_Av1_negative_Struct = ManeuverGetStruct(SG2_1, 971.127, 2,3);
Roll5_Sim_Av1_negative_Struct = ManeuverGetStruct(SG2_1, 1005.210-0.00028, 2,3);
[Roll_Sim_Av1_negative_Struct.AvManeuvers.Values, Roll_Sim_Av1_negative_Struct.AvManeuvers.Time, Roll_Sim_Av1_negative_Struct.AvManeuvers.Matrix]...
    = AverageArray(Roll1_Sim_Av1_negative_Struct,Roll2_Sim_Av1_negative_Struct,Roll3_Sim_Av1_negative_Struct,Roll4_Sim_Av1_negative_Struct,Roll5_Sim_Av1_negative_Struct, 'Roll', 2,3,40);

[FitFun2.Roll_negative(:,1)] = modelFit(Roll1_Flight_Av1_negative_Struct, 'Roll', 'DesRoll',Roll_Flight_Av1_negative_Struct,Roll_Sim_Av1_negative_Struct);
[FitFun2.Roll_negative(:,2)] = modelFit(Roll2_Flight_Av1_negative_Struct, 'Roll', 'DesRoll',Roll_Flight_Av1_negative_Struct,Roll_Sim_Av1_negative_Struct);
[FitFun2.Roll_negative(:,3)] = modelFit(Roll3_Flight_Av1_negative_Struct, 'Roll', 'DesRoll',Roll_Flight_Av1_negative_Struct,Roll_Sim_Av1_negative_Struct);
[FitFun2.Roll_negative(:,4)] = modelFit(Roll4_Flight_Av1_negative_Struct, 'Roll', 'DesRoll',Roll_Flight_Av1_negative_Struct,Roll_Sim_Av1_negative_Struct);

DataTable = CreateDataTable(Roll_Flight_Av1_negative_Struct,Roll_Sim_Av1_negative_Struct);
temp = [saveinDataFile,'Roll_negative.mat'];
save(temp,'DataTable');

%% Pitch positive
%Pitch1_Flight_Av2_positive_Struct = ManeuverGetStruct(log8, 259.414, 2,3); %19.6
%Pitch2_Flight_Av2_positive_Struct = ManeuverGetStruct(log8, 289.493, 2,3); %19.3
%Pitch3_Flight_Av2_positive_Struct = ManeuverGetStruct(log8, 321.455, 2,3); %19.6
%Pitch4_Flight_Av2_positive_Struct = ManeuverGetStruct(log8, 364.733+0.0456, 2,3); %20.2

Pitch1_Flight_Av1_positive_Struct = ManeuverGetStruct(log8, 214.533, 2,3); %20.1 
Pitch2_Flight_Av1_positive_Struct = ManeuverGetStruct(log8, 336.414, 2,3); %20.3
Pitch3_Flight_Av1_positive_Struct = ManeuverGetStruct(log8, 364.779, 2,3); %20.2
[Pitch_Flight_Av1_positive_Struct.AvManeuvers.Values, Pitch_Flight_Av1_positive_Struct.AvManeuvers.Time, Pitch_Flight_Av1_positive_Struct.AvManeuvers.Matrix]...
    = AverageArray(Pitch1_Flight_Av1_positive_Struct,Pitch2_Flight_Av1_positive_Struct,Pitch3_Flight_Av1_positive_Struct,Pitch3_Flight_Av1_positive_Struct,Pitch3_Flight_Av1_positive_Struct, 'Pitch', 2,3,20);


Pitch1_Sim_Av_positive_Struct = ManeuverGetStruct(SG2_3, 238.299, 2,3); %20.17
Pitch2_Sim_Av_positive_Struct = ManeuverGetStruct(SG2_3, 461.713, 2,3); %20.37
Pitch3_Sim_Av_positive_Struct = ManeuverGetStruct(SG2_3, 487.108, 2,3); %20.17
Pitch4_Sim_Av_positive_Struct = ManeuverGetStruct(SG2_3, 524.446+0.024, 2,3); %19.97
[Pitch_Sim_Av_positive_Struct.AvManeuvers.Values, Pitch_Sim_Av_positive_Struct.AvManeuvers.Time,  Pitch_Sim_Av_positive_Struct.AvManeuvers.Matrix]...
    = AverageArray(Pitch1_Sim_Av_positive_Struct,Pitch2_Sim_Av_positive_Struct,Pitch3_Sim_Av_positive_Struct,Pitch4_Sim_Av_positive_Struct,Pitch4_Sim_Av_positive_Struct, 'Pitch', 2,3,20);

[FitFun2.Pitch_positive(:,1)] = modelFit(Pitch1_Flight_Av1_positive_Struct, 'Pitch', 'DesPitch',Pitch_Flight_Av1_positive_Struct,Pitch_Sim_Av_positive_Struct);
[FitFun2.Pitch_positive(:,2)] = modelFit(Pitch2_Flight_Av1_positive_Struct, 'Pitch', 'DesPitch',Pitch_Flight_Av1_positive_Struct,Pitch_Sim_Av_positive_Struct);
[FitFun2.Pitch_positive(:,3)] = modelFit(Pitch3_Flight_Av1_positive_Struct, 'Pitch', 'DesPitch',Pitch_Flight_Av1_positive_Struct,Pitch_Sim_Av_positive_Struct);

DataTable = CreateDataTable(Pitch_Flight_Av1_positive_Struct,Pitch_Sim_Av_positive_Struct);
temp = [saveinDataFile,'Pitch_positive.mat'];
save(temp,'DataTable');

%% Pitch negative
Pitch1_Flight_Av_negative_Struct = ManeuverGetStruct(log6, 120.639, 2,3); %18.6
Pitch2_Flight_Av_negative_Struct = ManeuverGetStruct(log6, 450.883, 2,3); %18.4
Pitch3_Flight_Av_negative_Struct = ManeuverGetStruct(log6, 496.839, 2,3); %18.3
[Pitch_Flight_Av_negative_Struct.AvManeuvers.Values, Pitch_Flight_Av_negative_Struct.AvManeuvers.Time, Pitch_Flight_Av_negative_Struct.AvManeuvers.Matrix]...
    = AverageArray(Pitch1_Flight_Av_negative_Struct,Pitch2_Flight_Av_negative_Struct,Pitch3_Flight_Av_negative_Struct,Pitch3_Flight_Av_negative_Struct,Pitch3_Flight_Av_negative_Struct, 'Pitch', 2,3,20);


Pitch1_Sim_Av_negative_Struct = ManeuverGetStruct(SG2_2, 2885.350, 2,3); %18.52
Pitch2_Sim_Av_negative_Struct = ManeuverGetStruct(SG2_2, 2948.470, 2,3); %18.52
Pitch3_Sim_Av_negative_Struct = ManeuverGetStruct(SG2_2, 2978.740, 2,3); %18.52
Pitch4_Sim_Av_negative_Struct = ManeuverGetStruct(SG2_2, 3017.030, 2,3); %18.52
Pitch5_Sim_Av_negative_Struct = ManeuverGetStruct(SG2_2, 3035.690+0.0335, 2,3); %18.52
[Pitch_Sim_Av_negative_Struct.AvManeuvers.Values, Pitch_Sim_Av_negative_Struct.AvManeuvers.Time, Pitch_Sim_Av_negative_Struct.AvManeuvers.Matrix]...
    = AverageArray(Pitch1_Sim_Av_negative_Struct,Pitch2_Sim_Av_negative_Struct,Pitch3_Sim_Av_negative_Struct,Pitch4_Sim_Av_negative_Struct,Pitch5_Sim_Av_negative_Struct, 'Pitch', 2,3,20);

[FitFun2.Pitch_negative(:,1)] = modelFit(Pitch1_Flight_Av_negative_Struct, 'Pitch', 'DesPitch',Pitch_Flight_Av_negative_Struct,Pitch_Sim_Av_negative_Struct);
[FitFun2.Pitch_negative(:,2)] = modelFit(Pitch2_Flight_Av_negative_Struct, 'Pitch', 'DesPitch',Pitch_Flight_Av_negative_Struct,Pitch_Sim_Av_negative_Struct);
[FitFun2.Pitch_negative(:,3)] = modelFit(Pitch3_Flight_Av_negative_Struct, 'Pitch', 'DesPitch',Pitch_Flight_Av_negative_Struct,Pitch_Sim_Av_negative_Struct);

DataTable = CreateDataTable(Pitch_Flight_Av_negative_Struct,Pitch_Sim_Av_negative_Struct);
temp = [saveinDataFile,'Pitch_negative.mat'];
save(temp,'DataTable');

%Include here which plots you take into account for intersection

%WhereIntersection(Roll1_Flight_Av1_positive_Struct,Roll2_Flight_Av1_positive_Struct,Roll3_Flight_Av1_positive_Struct,Roll4_Flight_Av1_positive_Struct,Roll5_Flight_Av1_positive_Struct, 'Roll');
%FivePlotsWithAverage(Roll1_Flight_Av1_positive_Struct,Roll2_Flight_Av1_positive_Struct,Roll3_Flight_Av1_positive_Struct,Roll4_Flight_Av1_positive_Struct,Roll5_Flight_Av1_positive_Struct, 'Roll', Roll_Flight_Av1_positive_Struct.AvManeuvers.Values, Roll_Flight_Av1_positive_Struct.AvManeuvers.Time);

%WhereIntersection(Roll1_Sim_Av1_positive_Struct,Roll2_Sim_Av1_positive_Struct,Roll3_Sim_Av1_positive_Struct,Roll4_Sim_Av1_positive_Struct,Roll5_Sim_Av1_positive_Struct, 'Roll');
%FivePlotsWithAverage(Roll1_Sim_Av1_positive_Struct,Roll2_Sim_Av1_positive_Struct,Roll3_Sim_Av1_positive_Struct,Roll4_Sim_Av1_positive_Struct,Roll5_Sim_Av1_positive_Struct, 'Roll', Roll_Sim_Av1_positive_Struct.AvManeuvers.Values, Roll_Sim_Av1_positive_Struct.AvManeuvers.Time);

%WhereIntersection(Roll1_Flight_Av1_negative_Struct,Roll2_Flight_Av1_negative_Struct,Roll3_Flight_Av1_negative_Struct,Roll4_Flight_Av1_negative_Struct,Roll4_Flight_Av1_negative_Struct, 'Roll');
%FivePlotsWithAverage(Roll1_Flight_Av1_negative_Struct,Roll2_Flight_Av1_negative_Struct,Roll3_Flight_Av1_negative_Struct,Roll4_Flight_Av1_negative_Struct,Roll4_Flight_Av1_negative_Struct, 'Roll', Roll_Flight_Av1_negative_Struct.AvManeuvers.Values, Roll_Flight_Av1_negative_Struct.AvManeuvers.Time);

%WhereIntersection(Roll1_Sim_Av1_negative_Struct,Roll2_Sim_Av1_negative_Struct,Roll3_Sim_Av1_negative_Struct,Roll4_Sim_Av1_negative_Struct,Roll4_Sim_Av1_negative_Struct, 'Roll');
%FivePlotsWithAverage(Roll1_Sim_Av1_negative_Struct,Roll2_Sim_Av1_negative_Struct,Roll3_Sim_Av1_negative_Struct,Roll4_Sim_Av1_negative_Struct,Roll5_Sim_Av1_negative_Struct, 'Roll', Roll_Sim_Av1_negative_Struct.AvManeuvers.Values, Roll_Sim_Av1_negative_Struct.AvManeuvers.Time);

%WhereIntersection(Pitch1_Flight_Av1_positive_Struct,Pitch2_Flight_Av1_positive_Struct,Pitch3_Flight_Av1_positive_Struct,Pitch3_Flight_Av1_positive_Struct,Pitch3_Flight_Av1_positive_Struct, 'Pitch');
%FivePlotsWithAverage(Pitch1_Flight_Av1_positive_Struct,Pitch2_Flight_Av1_positive_Struct,Pitch3_Flight_Av1_positive_Struct,Pitch3_Flight_Av1_positive_Struct,Pitch3_Flight_Av1_positive_Struct, 'Pitch', Pitch_Flight_Av1_positive_Struct.AvManeuvers.Values, Pitch_Flight_Av1_positive_Struct.AvManeuvers.Time);

%WhereIntersection(Pitch1_Sim_Av_positive_Struct,Pitch2_Sim_Av_positive_Struct,Pitch3_Sim_Av_positive_Struct,Pitch4_Sim_Av_positive_Struct,Pitch4_Sim_Av_positive_Struct, 'Pitch');
%FivePlotsWithAverage(Pitch1_Sim_Av_positive_Struct,Pitch2_Sim_Av_positive_Struct,Pitch3_Sim_Av_positive_Struct,Pitch4_Sim_Av_positive_Struct,Pitch4_Sim_Av_positive_Struct, 'Pitch', Pitch_Sim_Av_positive_Struct.AvManeuvers.Values, Pitch_Sim_Av_positive_Struct.AvManeuvers.Time);

%WhereIntersection(Pitch1_Flight_Av_negative_Struct,Pitch2_Flight_Av_negative_Struct,Pitch3_Flight_Av_negative_Struct,Pitch3_Flight_Av_negative_Struct,Pitch3_Flight_Av_negative_Struct, 'Pitch');
%FivePlotsWithAverage(Pitch1_Flight_Av_negative_Struct,Pitch2_Flight_Av_negative_Struct,Pitch3_Flight_Av_negative_Struct,Pitch3_Flight_Av_negative_Struct,Pitch3_Flight_Av_negative_Struct, 'Pitch', Pitch_Flight_Av_negative_Struct.AvManeuvers.Values, Pitch_Flight_Av_negative_Struct.AvManeuvers.Time);

%WhereIntersection(Pitch1_Sim_Av_negative_Struct,Pitch2_Sim_Av_negative_Struct,Pitch3_Sim_Av_negative_Struct,Pitch4_Sim_Av_negative_Struct,Pitch5_Sim_Av_negative_Struct, 'Pitch');
%FivePlotsWithAverage(Pitch1_Sim_Av_negative_Struct,Pitch2_Sim_Av_negative_Struct,Pitch3_Sim_Av_negative_Struct,Pitch4_Sim_Av_negative_Struct,Pitch5_Sim_Av_negative_Struct, 'Pitch', Pitch_Sim_Av_negative_Struct.AvManeuvers.Values, Pitch_Sim_Av_negative_Struct.AvManeuvers.Time);


%Look at the plot and choose start and end of intersection

%}


%% Plot Pitch positive
%{
figure 
plot(Pitch1_Flight_Av1_positive_Struct.ATT.TimeS-2, Pitch1_Flight_Av1_positive_Struct.ATT.Pitch, 'b');
hold on
plot(Pitch2_Flight_Av1_positive_Struct.ATT.TimeS-2, Pitch2_Flight_Av1_positive_Struct.ATT.Pitch, 'b');
hold on
plot(Pitch3_Flight_Av1_positive_Struct.ATT.TimeS-2, Pitch3_Flight_Av1_positive_Struct.ATT.Pitch, 'b');
hold on
plot(Pitch1_Flight_Av1_positive_Struct.ATT.TimeS-2, Pitch1_Flight_Av1_positive_Struct.ATT.DesPitch,'Color', "#7E2F8E",'LineWidth', 2);
hold on


plot(Pitch1_Sim_Av_positive_Struct.ATT.TimeS-2, Pitch1_Sim_Av_positive_Struct.ATT.Pitch, 'r');
hold on
plot(Pitch2_Sim_Av_positive_Struct.ATT.TimeS-2, Pitch2_Sim_Av_positive_Struct.ATT.Pitch, 'r');
hold on
plot(Pitch3_Sim_Av_positive_Struct.ATT.TimeS-2, Pitch3_Sim_Av_positive_Struct.ATT.Pitch, 'r');
hold on
plot(Pitch4_Sim_Av_positive_Struct.ATT.TimeS-2, Pitch4_Sim_Av_positive_Struct.ATT.Pitch, 'r');
hold on
plot(Pitch1_Sim_Av_positive_Struct.ATT.TimeS-2, Pitch1_Sim_Av_positive_Struct.ATT.DesPitch, 'k','LineWidth', 2);

hold off
grid on

title('Pitch angle step response for for P=0.17 I=0.203 D=0.0067 FF=0.203');
ylabel('Pitch [deg]');
xlabel('Time [s]');
legend('Flight Pitch', '', '', 'Flight Desired Pitch', 'Simulation Pitch', '', '', '', 'Simulation Desired Pitch');

temp = [savein,'Pitch_positive_big_comparison','1','.fig'];
saveas(gcf,temp);


%% Plot Pitch negative

figure 
plot(Pitch1_Flight_Av_negative_Struct.ATT.TimeS-2, Pitch1_Flight_Av_negative_Struct.ATT.Pitch, 'b');
hold on
plot(Pitch2_Flight_Av_negative_Struct.ATT.TimeS-2, Pitch2_Flight_Av_negative_Struct.ATT.Pitch, 'b');
hold on
plot(Pitch3_Flight_Av_negative_Struct.ATT.TimeS-2, Pitch3_Flight_Av_negative_Struct.ATT.Pitch, 'b');
hold on
plot(Pitch1_Flight_Av_negative_Struct.ATT.TimeS-2, Pitch1_Flight_Av_negative_Struct.ATT.DesPitch,'Color', "#7E2F8E",'LineWidth', 2);
hold on


plot(Pitch1_Sim_Av_negative_Struct.ATT.TimeS-2, Pitch1_Sim_Av_negative_Struct.ATT.Pitch, 'r');
hold on
plot(Pitch2_Sim_Av_negative_Struct.ATT.TimeS-2, Pitch2_Sim_Av_negative_Struct.ATT.Pitch, 'r');
hold on
plot(Pitch3_Sim_Av_negative_Struct.ATT.TimeS-2, Pitch3_Sim_Av_negative_Struct.ATT.Pitch, 'r');
hold on
plot(Pitch4_Sim_Av_negative_Struct.ATT.TimeS-2, Pitch4_Sim_Av_negative_Struct.ATT.Pitch, 'r');
hold on
plot(Pitch5_Sim_Av_negative_Struct.ATT.TimeS-2, Pitch5_Sim_Av_negative_Struct.ATT.Pitch, 'r');
hold on
plot(Pitch1_Sim_Av_negative_Struct.ATT.TimeS-2, Pitch1_Sim_Av_negative_Struct.ATT.DesPitch, 'k','LineWidth', 2);

hold off
grid on

title('Pitch angle step response for for P=0.17 I=0.203 D=0.0067 FF=0.203');
ylabel('Pitch [deg]');
xlabel('Time [s]');
legend('Flight Pitch', '', '', 'Flight Desired Pitch', 'Simulation Pitch', '', '', '','', 'Simulation Desired Pitch');

temp = [savein,'Pitch_negative_big_comparison','1','.fig'];
saveas(gcf,temp);

%% Plot Roll positive

figure 
plot(Roll1_Flight_Av1_positive_Struct.ATT.TimeS-2, Roll1_Flight_Av1_positive_Struct.ATT.Roll, 'b');
hold on
plot(Roll2_Flight_Av1_positive_Struct.ATT.TimeS-2, Roll2_Flight_Av1_positive_Struct.ATT.Roll, 'b');
hold on
plot(Roll3_Flight_Av1_positive_Struct.ATT.TimeS-2, Roll3_Flight_Av1_positive_Struct.ATT.Roll, 'b');
hold on
plot(Roll4_Flight_Av1_positive_Struct.ATT.TimeS-2, Roll4_Flight_Av1_positive_Struct.ATT.Roll, 'b');
hold on
plot(Roll5_Flight_Av1_positive_Struct.ATT.TimeS-2, Roll5_Flight_Av1_positive_Struct.ATT.Roll, 'b');
hold on
plot(Roll1_Flight_Av1_positive_Struct.ATT.TimeS-2, Roll1_Flight_Av1_positive_Struct.ATT.DesRoll,'Color', "#7E2F8E",'LineWidth', 2);
hold on


plot(Roll1_Sim_Av1_positive_Struct.ATT.TimeS-2, Roll1_Sim_Av1_positive_Struct.ATT.Roll, 'r');
hold on
plot(Roll2_Sim_Av1_positive_Struct.ATT.TimeS-2, Roll2_Sim_Av1_positive_Struct.ATT.Roll, 'r');
hold on
plot(Roll3_Sim_Av1_positive_Struct.ATT.TimeS-2, Roll3_Sim_Av1_positive_Struct.ATT.Roll, 'r');
hold on
plot(Roll4_Sim_Av1_positive_Struct.ATT.TimeS-2, Roll4_Sim_Av1_positive_Struct.ATT.Roll, 'r');
hold on
plot(Roll5_Sim_Av1_positive_Struct.ATT.TimeS-2, Roll5_Sim_Av1_positive_Struct.ATT.Roll, 'r');
hold on
plot(Roll1_Sim_Av1_positive_Struct.ATT.TimeS-2, Roll1_Sim_Av1_positive_Struct.ATT.DesRoll, 'k','LineWidth', 2);

hold off
grid on

title('Roll angle step response for for P=0.131 I=0.131 D=0.005 FF=0.274');
ylabel('Roll [deg]');
xlabel('Time [s]');
legend('Flight Roll', '', '','','', 'Flight Desired Roll', 'Simulation Roll', '', '', '','', 'Simulation Desired Roll');

temp = [savein,'Roll_positive_big_comparison','1','.fig'];
saveas(gcf,temp);


%% Plot Roll negative

figure 
plot(Roll1_Flight_Av1_negative_Struct.ATT.TimeS-2, Roll1_Flight_Av1_negative_Struct.ATT.Roll, 'b');
hold on
plot(Roll2_Flight_Av1_negative_Struct.ATT.TimeS-2, Roll2_Flight_Av1_negative_Struct.ATT.Roll, 'b');
hold on
plot(Roll3_Flight_Av1_negative_Struct.ATT.TimeS-2, Roll3_Flight_Av1_negative_Struct.ATT.Roll, 'b');
hold on
plot(Roll4_Flight_Av1_negative_Struct.ATT.TimeS-2, Roll4_Flight_Av1_negative_Struct.ATT.Roll, 'b');
hold on
plot(Roll1_Flight_Av1_negative_Struct.ATT.TimeS-2, Roll1_Flight_Av1_negative_Struct.ATT.DesRoll,'Color', "#7E2F8E",'LineWidth', 2);
hold on


plot(Roll1_Sim_Av1_negative_Struct.ATT.TimeS-2, Roll1_Sim_Av1_negative_Struct.ATT.Roll, 'r');
hold on
plot(Roll2_Sim_Av1_negative_Struct.ATT.TimeS-2, Roll2_Sim_Av1_negative_Struct.ATT.Roll, 'r');
hold on
plot(Roll3_Sim_Av1_negative_Struct.ATT.TimeS-2, Roll3_Sim_Av1_negative_Struct.ATT.Roll, 'r');
hold on
plot(Roll4_Sim_Av1_negative_Struct.ATT.TimeS-2, Roll4_Sim_Av1_negative_Struct.ATT.Roll, 'r');
hold on
plot(Roll5_Sim_Av1_negative_Struct.ATT.TimeS-2, Roll5_Sim_Av1_negative_Struct.ATT.Roll, 'r');
hold on
plot(Roll1_Sim_Av1_negative_Struct.ATT.TimeS-2, Roll1_Sim_Av1_negative_Struct.ATT.DesRoll, 'k','LineWidth', 2);

hold off
grid on

title('Roll angle step response for for P=0.131 I=0.131 D=0.005 FF=0.274');
ylabel('Roll [deg]');
xlabel('Time [s]');
legend('Flight Roll', '', '','', 'Flight Desired Roll', 'Simulation Roll', '', '', '','', 'Simulation Desired Roll');

temp = [savein,'Roll_negative_big_comparison','1','.fig'];
saveas(gcf,temp);
%}

%% FLight Average + Sim Average + Flight Maneuvers plots
%{
%% Plot Pitch positive

figure 
plot(Pitch1_Flight_Av1_positive_Struct.ATT.TimeS-2, Pitch1_Flight_Av1_positive_Struct.ATT.Pitch, 'b');
hold on
plot(Pitch2_Flight_Av1_positive_Struct.ATT.TimeS-2, Pitch2_Flight_Av1_positive_Struct.ATT.Pitch, 'b');
hold on
plot(Pitch3_Flight_Av1_positive_Struct.ATT.TimeS-2, Pitch3_Flight_Av1_positive_Struct.ATT.Pitch, 'b');
hold on
plot(Pitch1_Flight_Av1_positive_Struct.ATT.TimeS-2, Pitch1_Flight_Av1_positive_Struct.ATT.DesPitch,'Color', "#7E2F8E",'LineWidth', 2);
hold on
plot(Pitch1_Sim_Av_positive_Struct.ATT.TimeS-2, Pitch1_Sim_Av_positive_Struct.ATT.DesPitch, 'k','LineWidth', 2);
hold on


plot(Pitch_Flight_Av1_positive_Struct.AvManeuvers.Time-2,Pitch_Flight_Av1_positive_Struct.AvManeuvers.Values, 'b','LineStyle','-.','LineWidth', 3);
hold on
plot(Pitch_Sim_Av_positive_Struct.AvManeuvers.Time-2, Pitch_Sim_Av_positive_Struct.AvManeuvers.Values, 'r','LineStyle','-.','LineWidth', 3);


hold off
grid on

title('Pitch angle step response for for P=0.17 I=0.203 D=0.0067 FF=0.203');
ylabel('Pitch [deg]');
xlabel('Time [s]');
legend('Flight Pitch', '', '', 'Flight Desired Pitch', 'Simulation Desired Pitch', 'mean Flight Pitch', 'mean Simulation Pitch');

temp = [savein,'Pitch_positive_big_comparison_with_averages','1','.fig'];
saveas(gcf,temp);


%% Plot Pitch negative

figure 
plot(Pitch1_Flight_Av_negative_Struct.ATT.TimeS-2, Pitch1_Flight_Av_negative_Struct.ATT.Pitch, 'b');
hold on
plot(Pitch2_Flight_Av_negative_Struct.ATT.TimeS-2, Pitch2_Flight_Av_negative_Struct.ATT.Pitch, 'b');
hold on
plot(Pitch3_Flight_Av_negative_Struct.ATT.TimeS-2, Pitch3_Flight_Av_negative_Struct.ATT.Pitch, 'b');
hold on
plot(Pitch1_Flight_Av_negative_Struct.ATT.TimeS-2, Pitch1_Flight_Av_negative_Struct.ATT.DesPitch,'Color', "#7E2F8E",'LineWidth', 2);
hold on
plot(Pitch1_Sim_Av_negative_Struct.ATT.TimeS-2, Pitch1_Sim_Av_negative_Struct.ATT.DesPitch, 'k','LineWidth', 2);
hold on


plot(Pitch_Flight_Av_negative_Struct.AvManeuvers.Time-2,Pitch_Flight_Av_negative_Struct.AvManeuvers.Values, 'b','LineStyle','-.','LineWidth',3);
hold on
plot(Pitch_Sim_Av_negative_Struct.AvManeuvers.Time-2, Pitch_Sim_Av_negative_Struct.AvManeuvers.Values, 'r','LineStyle','-.','LineWidth', 3);



hold off
grid on

title('Pitch angle step response for for P=0.17 I=0.203 D=0.0067 FF=0.203');
ylabel('Pitch [deg]');
xlabel('Time [s]');
legend('Flight Pitch', '', '', 'Flight Desired Pitch', 'Simulation Desired Pitch', 'mean Flight Pitch', 'mean Simulation Pitch');

temp = [savein,'Pitch_negative_big_comparison_with_averages','1','.fig'];
saveas(gcf,temp);

%% Plot Roll positive

figure 
plot(Roll1_Flight_Av1_positive_Struct.ATT.TimeS-2, Roll1_Flight_Av1_positive_Struct.ATT.Roll, 'b');
hold on
plot(Roll2_Flight_Av1_positive_Struct.ATT.TimeS-2, Roll2_Flight_Av1_positive_Struct.ATT.Roll, 'b');
hold on
plot(Roll3_Flight_Av1_positive_Struct.ATT.TimeS-2, Roll3_Flight_Av1_positive_Struct.ATT.Roll, 'b');
hold on
plot(Roll4_Flight_Av1_positive_Struct.ATT.TimeS-2, Roll4_Flight_Av1_positive_Struct.ATT.Roll, 'b');
hold on
plot(Roll5_Flight_Av1_positive_Struct.ATT.TimeS-2, Roll5_Flight_Av1_positive_Struct.ATT.Roll, 'b');
hold on
plot(Roll1_Flight_Av1_positive_Struct.ATT.TimeS-2, Roll1_Flight_Av1_positive_Struct.ATT.DesRoll,'Color', "#7E2F8E",'LineWidth', 2);
hold on
plot(Roll1_Sim_Av1_positive_Struct.ATT.TimeS-2, Roll1_Sim_Av1_positive_Struct.ATT.DesRoll, 'k','LineWidth', 2);
hold on


plot(Roll_Flight_Av1_positive_Struct.AvManeuvers.Time-2,Roll_Flight_Av1_positive_Struct.AvManeuvers.Values, 'b','LineStyle','-.','LineWidth', 3);
hold on
plot(Roll_Sim_Av1_positive_Struct.AvManeuvers.Time-2, Roll_Sim_Av1_positive_Struct.AvManeuvers.Values, 'r','LineStyle','-.','LineWidth', 3);


hold off
grid on

title('Roll angle step response for for P=0.131 I=0.131 D=0.005 FF=0.274');
ylabel('Roll [deg]');
xlabel('Time [s]');
legend('Flight Roll', '', '','','', 'Flight Desired Roll', 'Simulation Desired Roll', 'mean Flight Roll', 'mean Simulation Roll');

temp = [savein,'Roll_positive_big_comparison_with_averages','1','.fig'];
saveas(gcf,temp);


%% Plot Roll negative

figure 
plot(Roll1_Flight_Av1_negative_Struct.ATT.TimeS-2, Roll1_Flight_Av1_negative_Struct.ATT.Roll, 'b');
hold on
plot(Roll2_Flight_Av1_negative_Struct.ATT.TimeS-2, Roll2_Flight_Av1_negative_Struct.ATT.Roll, 'b');
hold on
plot(Roll3_Flight_Av1_negative_Struct.ATT.TimeS-2, Roll3_Flight_Av1_negative_Struct.ATT.Roll, 'b');
hold on
plot(Roll4_Flight_Av1_negative_Struct.ATT.TimeS-2, Roll4_Flight_Av1_negative_Struct.ATT.Roll, 'b');
hold on
plot(Roll1_Flight_Av1_negative_Struct.ATT.TimeS-2, Roll1_Flight_Av1_negative_Struct.ATT.DesRoll,'Color', "#7E2F8E",'LineWidth', 2);
hold on
plot(Roll1_Sim_Av1_negative_Struct.ATT.TimeS-2, Roll1_Sim_Av1_negative_Struct.ATT.DesRoll, 'k','LineWidth', 2);
hold on


plot(Roll_Flight_Av1_negative_Struct.AvManeuvers.Time-2,Roll_Flight_Av1_negative_Struct.AvManeuvers.Values, 'b','LineStyle','-.','LineWidth', 3);
hold on
plot(Roll_Sim_Av1_negative_Struct.AvManeuvers.Time-2, Roll_Sim_Av1_negative_Struct.AvManeuvers.Values, 'r','LineStyle','-.','LineWidth', 3);



hold off
grid on

title('Roll angle step response for for P=0.131 I=0.131 D=0.005 FF=0.274');
ylabel('Roll [deg]');
xlabel('Time [s]');
legend('Flight Roll', '', '','', 'Flight Desired Roll', 'Simulation Desired Roll', 'mean Flight Roll', 'mean Simulation Roll');

temp = [savein,'Roll_negative_big_comparison_with_averages','1','.fig'];
saveas(gcf,temp);

%}

%{
%% Plot with patch
figure 
plot(Pitch1_Struct.ATT.TimeS-3, Pitch1_Struct.ATT.Pitch);
hold on
plot(Pitch2_Struct.ATT.TimeS-3, Pitch2_Struct.ATT.Pitch);
hold on
plot(Pitch3_Struct.ATT.TimeS-3, Pitch3_Struct.ATT.Pitch);
hold on
plot(Pitch4_Struct.ATT.TimeS-3, Pitch4_Struct.ATT.Pitch);
hold on
plot(Pitch5_Struct.ATT.TimeS-3, Pitch5_Struct.ATT.Pitch);
hold on
plot(Pitch1_Struct.ATT.TimeS-3, Pitch1_Struct.ATT.DesPitch,'LineWidth', 2);
hold on

%fill(TimePitch_Patch-3, MinMaxPitch_Patch, 'g', 'FaceAlpha',0.5);

%fill([Maneuver2_forPatch.ATT.TimeS; flip(Maneuver2_forPatch.ATT.TimeS)], [e; flip(a)], 'g', 'FaceAlpha',0.5)
%plot(Maneuver2_forPatch.ATT.TimeS,e, 'blue');
%plot(Maneuver2_forPatch.ATT.TimeS,a, 'black');
hold off
grid on;
title('Pitch simulated and desired');
ylabel('Pitch [deg]');
xlabel('Time [s]');
legend('Pitch1', 'Pitch2', 'Pitch3', 'Pitch4', 'Pitch5', 'Desired Pitch');

temp = [savein,'Pitch_big_comparison','1','.fig'];
saveas(gcf,temp);
%} 

