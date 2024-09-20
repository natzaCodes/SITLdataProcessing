function [] = PositionPlots(datasheet, datasheetstr, savein)

%% Plot of maneuvers to figure out when menuver happened
%{
subplot(4,1,1);
plot(datasheet.GPS.Lng, datasheet.GPS.Lat)
ylabel('Lattitude');
xlabel('Longitude');
grid on;

subplot(4,1,2);
plot(datasheet.GPS.TimeS, datasheet.GPS.Alt)
ylabel('Altitude');
xlabel('t [s]');
grid on;

subplot(4,1,3); 
plot(datasheet.GPS.TimeS, datasheet.GPS.Lng)
ylabel('Longtude');
xlabel('t [s]');
grid on;

subplot(4,1,4);
plot(datasheet.GPS.TimeS, datasheet.GPS.Lat)
ylabel('Lattitude');
xlabel('t [s]');
grid on;

temp = [savein,'TrajectoryMulti_for_',datasheetstr,'.fig'];
saveas(gcf,temp);

figure
plot3(datasheet.GPS.Lng, datasheet.GPS.Lat,datasheet.GPS.Alt);
ylabel('Lattitude');
xlabel('Longtude');
zlabel('Altitude');

temp = [savein,'Trajectory3D_for_',datasheetstr,'.fig'];
saveas(gcf,temp);
%}

secondPlot = datasheet.plot('RCIN/C1','g');
thirdPlot=datasheet.plot('RCOU/C1','r', secondPlot);
%datasheet.plot('RCOU/C3','b', thirdPlot);
grid on;
title('Aileron PWM signal comparison');
ylabel('PWM signal');
xlabel('Time [s]');
legend('Input', 'Output');

temp = [savein,'Deflections_ailerons_',datasheetstr,'.fig'];
saveas(gcf,temp);


secondPlot = datasheet.plot('RCIN/C2','g');
datasheet.plot('RCOU/C2','r', secondPlot);
grid on;
title('Elevator PWM signal comparison');
ylabel('PWM signal');
xlabel("Time [s]");
legend('Input', 'Output');

temp = [savein,'Deflections_elevators_',datasheetstr,'.fig'];
saveas(gcf,temp);

end