clear;
hold off;

inputPWM20 = 8e-5;
inputPWM30 = 12e-5;
inputPWM50 = 19e-5;

fileName20 = '20percent.txt'
[sampleTime20, deltaT20, nHighHl20, nHighHr20, speedHr20, speedHl20] = importfile(fileName20, 1, 10000)

fileName30 = '30percent.txt'
[sampleTime30, deltaT30, nHighHl30, nHighHr30, speedHr30, speedHl30] = importfile(fileName30, 1, 10000)

fileName50 = '50percent.txt'
[sampleTime50, deltaT50, nHighHl50, nHighHr50, speedHr50, speedHl50] = importfile(fileName50, 1, 10000)

i20 = find(speedHl20 > 0)
speedHl20 = speedHl20(i20(1) - 1 : i20(end))

i30 = find(speedHl30 > 0)
speedHl30 = speedHl30(i30(1) - 1 : i30(end))

speedHl50 = speedHl50 - speedHl50(1)
i50 = find(speedHl50 > 0)
speedHl50 = speedHl50(i50(1) - 1 : i50(end))

lengthOfVectors = min([length(speedHl20), length(speedHl30), ...
    length(speedHl50)]);
speedHl20 = speedHl20(1 : lengthOfVectors);
speedHl30 = speedHl30(1 : lengthOfVectors);
speedHl50 = speedHl50(1 : lengthOfVectors);

sampleTime20 = sampleTime20(i20(1) - 1 : i20(end))
sampleTime20 = sampleTime20(1 : lengthOfVectors);
sampleTime20 = sampleTime20 - sampleTime20(1);
deltaT20 = deltaT20(i20(1) - 1 : i20(end))
deltaT20 = deltaT20(1 : lengthOfVectors);
input20 = zeros(length(deltaT20),1);
input20(2:end) = inputPWM20;


sampleTime30 = sampleTime30(i30(1) - 1 : i30(end))
sampleTime30 = sampleTime30(1 : lengthOfVectors);
sampleTime30 = sampleTime30 - sampleTime30(1);
deltaT30 = deltaT30(i30(1) - 1 : i30(end))
deltaT30 = deltaT30(1 : lengthOfVectors);
input30 = zeros(length(sampleTime30),1);
input30(2:end) = inputPWM30;


sampleTime50 = sampleTime50(i50(1) - 1 : i50(end))
sampleTime50 = sampleTime50(1 : lengthOfVectors);
sampleTime50 = sampleTime50 - sampleTime50(1);
deltaT50 = deltaT50(i50(1) - 1 : i50(end))
deltaT50 = deltaT50(1 : lengthOfVectors);
input50 = zeros(length(sampleTime50),1);
input50(2:end) = inputPWM50;


plotyy(sampleTime20, speedHl20, sampleTime20, input20)
hold all;
plotyy(sampleTime30, speedHl30, sampleTime30, input30)
plotyy(sampleTime50, speedHl50, sampleTime50, input50)

% identification of an ARX model using the prediction error method
[a_pem, b_pem] = arx_pem(speedHl30, input30, 2)
sys_pem = tf(b_pem, [1 a_pem], 63);

% t.f. of the identified model
% simulation of the identified model using the measured input
sampleTimeSim = [0 : 63 : 63 * lengthOfVectors - 1];

speedHl20Pem = lsim(sys_pem, input20, sampleTimeSim);

speedHl30Pem = lsim(sys_pem, input30, sampleTimeSim);

speedHl50Pem = lsim(sys_pem, input50, sampleTimeSim);

hold off
% plot of the speed velocity
subplot(2, 2, 2);
plot(sampleTimeSim, speedHl30Pem);
hold all
plot(sampleTime30, speedHl30);

subplot(2, 2, 3);
plot(sampleTimeSim, speedHl50Pem);
hold all
plot(sampleTime50, speedHl50);

subplot(2, 2, 1);
plot(sampleTimeSim, speedHl20Pem);
hold all
plot(sampleTime20, speedHl20);


%% Maximum likelihood estimation
ord = 2;

x0 = [a_pem b_pem speedHl30' input30']'; % initial value for the MLE

tic
x = lsqnonlin(@(x)siso_residual(x,...
speedHl30, input30, ord, 10, 0.25e-5, ord), x0);
toc

a_mle = x(1:ord)'; % ARX coefficient for the regressive terms
b_mle = x(ord+1:2*ord)'; % ARX coefficients for the exhgenous inputs
sys_mle = tf(b_mle, [1 a_mle], 63); % t.f. of the identified model
% simulation of the identified model using the measure input
speedHl30ML = lsim(sys_mle, input30, sampleTimeSim);
speedHl20ML = lsim(sys_mle, input20, sampleTimeSim);
speedHl50ML = lsim(sys_mle, input50, sampleTimeSim);

figure;
hold off
subplot(2, 2, 2);
plot(sampleTimeSim, speedHl30ML);
hold all
plot(sampleTime30, speedHl30);

subplot(2, 2, 3);
plot(sampleTimeSim, speedHl50ML);
hold all
plot(sampleTime50, speedHl50);

subplot(2, 2, 1);
plot(sampleTimeSim, speedHl20ML);
hold all
plot(sampleTime20, speedHl20);