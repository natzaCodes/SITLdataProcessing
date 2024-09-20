function [ConvertedValue] = PWM2deg(valueToConvert, maxDeflection, trim)
%UNTITLED function to convert PWM value to degrees
%   Useful to compare PWM of Deflection with their real values

ConvertedValue = (valueToConvert-trim)/500*maxDeflection;
end