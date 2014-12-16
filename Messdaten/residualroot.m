function [res] = residualroot(system, sampleTime, ...
    measurements, pwmSteps, x)

rootCoeff = x(1);
rootFactor = x(2);

res = [];

modPwmSteps = rootCoeff * (pwmSteps).^(1 / rootFactor);
  for i = 1 : length(pwmSteps)
    input = zeros(length(sampleTime), 1);
    input(2 : end) = modPwmSteps(i);
    simValues = lsim(system, input, sampleTime);
    %singleRes(i) = sum((measurements{i} - simValues).^2);
    res = [res (measurements{i} - simValues)'];
  end
end