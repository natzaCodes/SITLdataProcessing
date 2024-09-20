function [] = TwoPlotsMaker(Plot1Input,Plot2Input, dataSheet, plotname, savein)
%UNTITLED Plotting two data series on one plot
%   useful for comparing attitudes' and deflections' input-output responses; 
% and attitudes based on PID tunning from simulation and flight. 
% PLOTS OVER TIME

secondPlot = dataSheet.plot(Plot1Input,'g');
dataSheet.plot(Plot2Input,'r', secondPlot);

grid on;
title(plotname);
yname = [plotname, '[deg]'];
ylabel(yname);
xlabel("Time [s]");
legend(Plot1Input,Plot2Input);

temp = [savein,'TwoPlots',plotname,'.fig'];
saveas(gcf,temp);

end