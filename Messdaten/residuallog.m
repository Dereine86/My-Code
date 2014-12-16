function [res] = residuallog(system, sampleTime, ...
    measurements, pwmSteps, x)

logCoeff = x(1);
logBase = x(2);

res = [];

modPwmSteps = logCoeff * log10(pwmSteps) / log10(logBase);
  for i = 1 : length(pwmSteps)
    input = zeros(length(sampleTime), 1);
    input(2 : end) = modPwmSteps(i);
    simValues = lsim(system, input, sampleTime);
    %singleRes(i) = sum((measurements{i} - simValues).^2);
    res = [res (measurements{i} - simValues)'];
  end
end