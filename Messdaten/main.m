clear;
hold off;

inputPWM10 = 4e-5;
inputPWM20 = 8e-5;
inputPWM30 = 12e-5;
inputPWM40 = 16e-5
inputPWM50 = 20e-5;


%% Reading the input Data

fileName20 = '20percent.txt'
[sampleTime20 ,deltaT20, nHighHl20, nLowHl20, nHighHr20, nLowHr20, speedHr20 ,speedHl20] = importfile(fileName20, 1, 10000)

fileName30 = '30percent.txt'
[sampleTime30 ,deltaT30, nHighHl30, nLowHl30, nHighHr30, nLowHr30, speedHr30 ,speedHl30] = importfile(fileName30, 1, 10000)

fileName40 = '40percent.txt'
[sampleTime40 ,deltaT40, nHighHl40, nLowHl40, nHighHr40, nLowHr40, speedHr40 ,speedHl40] = importfile(fileName40, 1, 10000)

fileName50 = '50percent.txt'
[sampleTime50 ,deltaT50, nHighHl50, nLowHl50, nHighHr50, nLowHr50, speedHr50 ,speedHl50] = importfile(fileName50, 1, 10000)

% %% Filter and offset correct the data
% speedHl20 = speedHl20(find(~isnan(speedHl20)))
% speedHl20 = speedHl20 - speedHl20(1)
% i20 = find(speedHl20 > 0)
% speedHl20 = speedHl20(i20(1) - 1 : i20(end))
[speedHl20 i20] = filterAndCorrect(speedHl20);

% speedHl30 = speedHl30(find(~isnan(speedHl30)))
% speedHl30 = speedHl30 - speedHl30(1)
% i30 = find(speedHl30 > 0)
% speedHl30 = speedHl30(i30(1) - 1 : i30(end))
[speedHl30 i30] = filterAndCorrect(speedHl30);


% speedHl50 = speedHl50(find(~isnan(speedHl50)))
% speedHl50 = speedHl50 - speedHl50(1)
% i50 = find(speedHl50 > 0)
% speedHl50 = speedHl50(i50(1) - 1 : i50(end))
[speedHl50 i50] = filterAndCorrect(speedHl50);

lengthOfVectors = min([length(speedHl20), length(speedHl30), ...
    length(speedHl50)]);
speedHl20 = speedHl20(1 : lengthOfVectors);
speedHl30 = speedHl30(1 : lengthOfVectors);
speedHl50 = speedHl50(1 : lengthOfVectors);

[sampleTime20 deltaT20 input20] = createTimeAndInput(...
                                           sampleTime20,deltaT20,...
                                           inputPWM20, i20, lengthOfVectors)


[sampleTime30 deltaT30 input30] = createTimeAndInput(...
                                           sampleTime30,deltaT30,...
                                           inputPWM30, i30, lengthOfVectors)
                                       
[sampleTime50 deltaT50 input50] = createTimeAndInput(...
                                           sampleTime50,deltaT50,...
                                           inputPWM50, i50, lengthOfVectors)
                                       
deltaT = mean([mean(deltaT20) mean(deltaT30) mean(deltaT50)]);

%% Plot the step responses
close all;
figure;
subplot(3, 1, 1);
[AX,H1,H2] = plotyy(sampleTime20, speedHl20, sampleTime20, input20);

set(AX(2),'YLim',[0 30e-5])
set(get(AX(1),'Ylabel'),'string','Speed in km / h')
set(get(AX(2),'Ylabel'),'string','PWM-Input in s')

subplot(3, 1, 2);
[AX,H1,H2] = plotyy(sampleTime30, speedHl30, sampleTime30, input30);
set(AX(2),'YLim',[0 30e-5])
set(get(AX(1),'Ylabel'),'string','Speed in km / h')
set(get(AX(2),'Ylabel'),'string','PWM-Input in s')

subplot(3, 1, 3);
[AX,H1,H2] = plotyy(sampleTime50, speedHl50, sampleTime50, input50);
set(AX(2),'YLim',[0 30e-5])
set(get(AX(1),'Ylabel'),'string','Speed in km / h')
set(get(AX(2),'Ylabel'),'string','PWM-Input in s')

%% identification of an ARX model using the prediction error method
[a_pem, b_pem] = arx_pem(speedHl30, input30, 5)
sys_pem = tf(b_pem, [1 a_pem], deltaT);

% t.f. of the identified model
% simulation of the identified model using the measured input
sampleTimeSim = [0 : deltaT : deltaT * lengthOfVectors - 1];

speedHl20Pem = lsim(sys_pem, input20, sampleTimeSim);

speedHl30Pem = lsim(sys_pem, input30, sampleTimeSim);

speedHl50Pem = lsim(sys_pem, input50, sampleTimeSim);

figure
hold off
% plot of the speed velocity
subplot(3, 1, 1);
plot(sampleTimeSim, speedHl20Pem);
hold all
plot(sampleTime20, speedHl20);

subplot(3, 1, 2);
plot(sampleTimeSim, speedHl30Pem);
hold all
plot(sampleTime30, speedHl30);

subplot(3, 1, 3);
plot(sampleTimeSim, speedHl50Pem);
hold all
plot(sampleTime50, speedHl50);



%% Maximum likelihood estimation
% ord = 5;
% 
% x0 = [a_pem b_pem speedHl30' input30']'; % initial value for the MLE
% 
% tic
% x = lsqnonlin(@(x)siso_residual(x,...
% speedHl30, input30, ord, 10, 0.25e-5, ord), x0);
% toc
% 
% a_mle = x(1:ord)'; % ARX coefficient for the regressive terms
% b_mle = x(ord+1:2*ord)'; % ARX coefficients for the exhgenous inputs
% sys_mle = tf(b_mle, [1 a_mle], 63); % t.f. of the identified model
% % simulation of the identified model using the measure input
% % speedHl30ML = lsim(sys_mle, input30, sampleTimeSim);
% % speedHl20ML = lsim(sys_mle, input20, sampleTimeSim);
% % speedHl50ML = lsim(sys_mle, input50, sampleTimeSim);
% % 
% % figure;
% % hold off
% % subplot(2, 2, 2);
% % plot(sampleTimeSim, speedHl30ML);
% % hold all
% % plot(sampleTime30, speedHl30);
% % 
% % subplot(2, 2, 3);
% % plot(sampleTimeSim, speedHl50ML);
% % hold all
% % plot(sampleTime50, speedHl50);
% % 
% % subplot(2, 2, 1);
% % plot(sampleTimeSim, speedHl20ML);
% % hold all
% % plot(sampleTime20, speedHl20);

%% Try to correct the pwmInputs
pwmSteps = [8e-5, 12e-5, 20e-5];
measurements = {speedHl20, speedHl30, speedHl50};
%initialLogCoeff = -1e-5;
%initialLogBase = 5; 
%initialX = [initialLogCoeff; initialLogBase];
%res = residuallog(sys_pem, sampleTimeSim, measurements, pwmSteps, initialX);
%values = lsqnonlin(@(x)residuallog(sys_pem, sampleTimeSim, measurements, pwmSteps, x), initialX)

initialRootCoeff = 1;
initialRootFactor = 2;
initialX = [initialRootCoeff; initialRootFactor];
values = lsqnonlin(@(x)residualroot(sys_pem, sampleTimeSim, measurements, pwmSteps, x), initialX)

rootCoeff = values(1);
rootFactor = values(2);

modPwmStep20 = rootCoeff * (inputPWM20).^(1 / rootFactor);
input20Mod = zeros(length(sampleTime20), 1);
input20Mod(2 : end) = modPwmStep20;

%modPwmStep30 = values(1) * log10(inputPWM30) / log10(values(2));
modPwmStep30 = rootCoeff * (inputPWM30).^(1 / rootFactor);
input30Mod = zeros(length(sampleTime30), 1);
input30Mod(2 : end) = modPwmStep30;

% modPwmStep40 = rootCoeff * (inputPWM40).^(1 / rootFactor);
% input40Mod = zeros(length(sampleTime40), 1);
% input40Mod(2 : end) = modPwmStep40;

%modPwmStep50 = values(1) * log10(inputPWM50) / log10(values(2));
modPwmStep50 = rootCoeff * (inputPWM50).^(1 / rootFactor);
input50Mod = zeros(length(sampleTime50), 1);
input50Mod(2 : end) = modPwmStep50;


simValuesMod20 = lsim(sys_pem, input20Mod, sampleTimeSim);
simValuesMod30 = lsim(sys_pem, input30Mod, sampleTimeSim);
% = lsim(sys_pem, input40Mod, sampleTimeSim);
simValuesMod50 = lsim(sys_pem, input50Mod, sampleTimeSim);

figure
subplot(3, 1, 1);
hold all
plot(sampleTime20, speedHl20);
plot(sampleTimeSim, simValuesMod20);

subplot(3, 1, 2);
hold all
plot(sampleTime30, speedHl30);
plot(sampleTimeSim, simValuesMod30);

% figure
% plot(sampleTimeSim, speedHl40Pem); 
% hold all
% plot(sampleTime40, speedHl40);
% plot(sampleTimeSim, simValuesMod40);

subplot(3, 1, 3);
hold all
plot(sampleTime50, speedHl50);
plot(sampleTimeSim, simValuesMod50);