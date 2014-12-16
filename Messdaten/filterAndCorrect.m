function [speedOut i] = filterAndCorrect(speed)
%Filter and offset-correct the input data

% Filter out the nans and runaways
speed = speed(find(~isnan(speed)));
speed = speed(find(abs(diff(speed)) < 8));
speed = speed(find(abs(diff(speed)) < 8));

% Correct the initial value and time offset.
speed = speed - speed(1);
i = find(speed > 0);
speedOut = speed(i(1) - 1 : i(end));