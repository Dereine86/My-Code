clear;

inputPWM20 = 4e-5;
inputPWM20 = 8e-5;
inputPWM30 = 12e-5;
inputPWM40 = 16e-5;
inputPWM50 = 20e-5;

fileName10 = '10percent.txt'
[sampleTime10 ,deltaT10, nHighHl10, nLowHl10, nHighHr10, nLowHr10, speedHr10 ,speedHl10] = importfile(fileName10, 1, 10000)

fileName20 = '20percent.txt'
[sampleTime20 ,deltaT20, nHighHl20, nLowHl20, nHighHr20, nLowHr20, speedHr20 ,speedHl20] = importfile(fileName20, 1, 10000)

fileName30 = '30percent.txt'
[sampleTime30 ,deltaT30, nHighHl30, nLowHl30, nHighHr30, nLowHr30, speedHr30 ,speedHl30] = importfile(fileName30, 1, 10000)

fileName40 = '40percent.txt'
[sampleTime40 ,deltaT40, nHighHl40, nLowHl40, nHighHr40, nLowHr40, speedHr40 ,speedHl40] = importfile(fileName40, 1, 10000)

fileName50 = '50percent.txt'
[sampleTime50 ,deltaT50, nHighHl50, nLowHl50, nHighHr50, nLowHr50, speedHr50 ,speedHl50] = importfile(fileName50, 1, 10000)

fileName60 = '60percent.txt'
[sampleTime60 ,deltaT60, nHighHl60, nLowHl60, nHighHr60, nLowHr60, speedHr60 ,speedHl60] = importfile(fileName60, 1, 10000)

fileName70 = '70percent.txt'
[sampleTime70 ,deltaT70, nHighHl70, nLowHl70, nHighHr70, nLowHr70, speedHr70 ,speedHl70] = importfile(fileName70, 1, 10000)

fileName80 = '80percent.txt'
[sampleTime80 ,deltaT80, nHighHl80, nLowHl80, nHighHr80, nLowHr80, speedHr80 ,speedHl80] = importfile(fileName80, 1, 10000)

mean(speedHl80(find(speedHl80 > 25)))
mean(speedHl70(find(speedHl70 > 25)))
mean(speedHl60(find(speedHl60 > 25)))
mean(speedHl50(find(speedHl50 > 25)))
mean(speedHl40(find(speedHl40 > 22)))
mean(speedHl30(find(speedHl30 > 19)))
mean(speedHl20(find(speedHl20 > 13)))
mean(speedHl10(find(speedHl10 > 5)))
