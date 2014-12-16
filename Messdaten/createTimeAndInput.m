function [sampleTimeOut deltaTOut input] = createTimeAndInput(...
                                           sampleTime,deltaT, pwm, i,...
                                           lengthOfVectors)
% createTimeAndInput
% Create time data and an input vector.

sampleTimeOut = sampleTime(i(1) - 1 : i(end))
sampleTimeOut = sampleTimeOut(1 : lengthOfVectors);
sampleTimeOut = sampleTimeOut - sampleTimeOut(1);
deltaTOut = deltaT(i(1) - 1 : i(end))
deltaTOut = deltaTOut(1 : lengthOfVectors);
input = zeros(length(deltaTOut),1);
input(2:end) = pwm;

end

