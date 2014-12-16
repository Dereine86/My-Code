/*
Main Program for the ABS-System. Containing the setup function and the main loop.
Functions for Reading the Sensor Data and send WiFi Data can be found in the classes.
Johannes Scherle 2013 johannes.scherle@gmail.com
*/

// Include the necessary libraries.
#include <SD.h> // SD-Card library
#include <WiFi.h> // WiFi library
#include "FPGASensors.h" // Sensor Reading libraray.
#include "Telemetry.h"// Telemetry library.

// The different parts of the program can be activated or deactivated here.
#define DOFLOATS false
#define PRINTTIMES false
#define DEBUGLINES true
#define LOGFILES false
#define WIFI_ENABLED false
#define READALLSENSORDATA true
#define READSEPERATESENSORDATA false

// Some global variables and objects, that are used in the program.
const int chipSelect = 4; // chipselect for SD-Card
boolean sdCardPresent = false; // saves, if a SD-Card is present or not
char ssid[] = "CAR";     //  the network SSID (name) 
char pass[] = "CARCARCAR";    // the network password
IPAddress server(192,168,0,101);    // Ip adress object of the server
Telemetry telemetry(ssid, pass);

/* The setup function of the program. Here the serial communication to the
Host-PC is started. Furthermore the SD-Card is initialized and the WiFi-Connection
is initialized.
*/
void setup()
{
  // Uart Configuration
  Serial.begin(9600);
  
  // the hardware SS pin 10
  // must be left as an output 
  // or the SD library functions will not work. 
  pinMode(10, OUTPUT);
  
  // SDCard initialization
  if (!SD.begin(chipSelect))
  {
    sdCardPresent = false;
  }
  else 
  {
    sdCardPresent = true;
  }
  
  //Setup WiFi Connection
  if(WIFI_ENABLED) {
    telemetry.connectWithLan();
    telemetry.connectWithServer(server);
  }
}

// The Main Loop of the program.
void loop() {
  
  // The variables for the sensor data.
  unsigned int nLowHr;
  unsigned int nHighHr;
  unsigned int nLowVr;
  unsigned int nHighVr;
  unsigned int nLowHl;
  unsigned int nHighHl;
  unsigned int nLowVl;
  unsigned int nHighVl;
  unsigned int lutin;
  unsigned int lutout;
  int acc;   
  unsigned int statusData;
  
  // The variable to measure the loop time.  
  long loopTime = millis();

  // Read the Sensor data with the readAll Method.
  unsigned int sensorValues[SENSORARRAYSIZE];
  long sensorReadingTimeAll = millis();
  if (READALLSENSORDATA) {
    Serial1.begin(9600);    
    FPGASensors::readAllFPGASensorData(sensorValues);
    Serial1.end();
    // Write the values from the data array in to several variables.
    nLowHr = sensorValues[0];
    nHighHr = sensorValues[1];
    nLowVr = sensorValues[2];
    nHighVr = sensorValues[3];
    nLowHl = sensorValues[4];
    nHighHl = sensorValues[5];
    nLowVl = sensorValues[6];
    nHighVl = sensorValues[7];   
    statusData = sensorValues[8];
    acc = sensorValues[9];
  }  
  sensorReadingTimeAll = millis() - sensorReadingTimeAll;
  unsigned int printTime = millis();
  if (DEBUGLINES && READALLSENSORDATA)
    FPGASensors::printDebugLine(sensorValues);
  printTime = millis() - printTime;
  
  // Read the Sensor data with the readSeperate Method.
 long sensorReadingTimeSeperate = millis();
 if (READSEPERATESENSORDATA) {
   Serial1.begin(9600);
   nLowHr = FPGASensors::getFPGASensorData(NLOWHR);
   nHighHr = FPGASensors::getFPGASensorData(NHIGHHR);
   nLowVr = FPGASensors::getFPGASensorData(NLOWVR);
   nHighVr = FPGASensors::getFPGASensorData(NHIGHVR);
   nLowHl = FPGASensors::getFPGASensorData(NLOWHL);
   nHighHl = FPGASensors::getFPGASensorData(NHIGHHL);
   nLowVl = FPGASensors::getFPGASensorData(NLOWVL);
   nHighVl = FPGASensors::getFPGASensorData(NHIGHVL);
   lutin = FPGASensors::getFPGASensorData(LUTIN);
   lutout = FPGASensors::getFPGASensorData(LUTOUT);
   acc = FPGASensors::getFPGASensorData(ACC);   
   statusData = FPGASensors::getFPGASensorData(STATUS);
   Serial1.end();
 }
 sensorReadingTimeSeperate = millis() - sensorReadingTimeSeperate; 
 // If activated print the sensor values on the serial-console of the Host-PC
 if (DEBUGLINES && READSEPERATESENSORDATA) {
    Serial.print(nLowHl);
    Serial.print('\t');
    Serial.print(nHighHl);
    Serial.print('\t');
    Serial.print(nLowVl);
    Serial.print('\t');
    Serial.print(nHighVl);
    Serial.print('\t'); 
    Serial.print(nLowHr);
    Serial.print('\t');
    Serial.print(nHighHr);
    Serial.print('\t');
    Serial.print(nLowVr);
    Serial.print('\t');
    Serial.println(nHighVr);
  }
  
  /*
  Variables for the floating point calculations and the function calls to do
  do the floating calculation.
  */
  float speedHl;
  float speedHr;
  float speedVl;
  float speedVr;
  float acceleration;  
  unsigned int floatTime = millis();
  if (DOFLOATS) {
    speedHl = FPGASensors::doFloatingCalculation(SPEEDHL, nHighHl);
    speedHr = FPGASensors::doFloatingCalculation(SPEEDHR, nHighHr);
    speedVl = FPGASensors::doFloatingCalculation(SPEEDVL, nHighVl);
    speedVr = FPGASensors::doFloatingCalculation(SPEEDVR, nHighVr);
    acceleration = FPGASensors::doFloatingCalculation(ACCELERATION, acc);
    Serial.println(speedVr);
  }
  floatTime = millis() - floatTime;
  
  // Send the WiFi Data.   
  long wiFiTime = millis();
  if (WIFI_ENABLED) {
    telemetry.sendWifiData(acc, nHighHr, nHighVr, nHighHl, nHighVl);
  }
  wiFiTime = millis() - wiFiTime;  
  
  
  // Get the status data for each wheel.
  char statusHl;
  char statusVl;
  char statusHr;
  char statusVr;
  FPGASensors::getStatusData(statusData, &statusHl, &statusVl, &statusHr, &statusVr);
  /*
  Serial.println((int) statusVr);
  Serial.println((int) statusVl);
  Serial.println((int) statusHl);  
  Serial.println((int) statusHr);    
  */
  
  // Log the sensor on the sd-card.
  long logTime = millis();
  if (LOGFILES) {
    if(sdCardPresent = true) {
      File logFile = SD.open("Logfile.txt", FILE_WRITE);
      logFile.print(nLowHl);
      logFile.print('\t');
      logFile.print(nHighHl);
      logFile.print('\t');
      if (DOFLOATS) {
        logFile.print(speedHl);
        logFile.print('\t');
      }
      logFile.print((int) statusHl);
      logFile.print('\t');
      logFile.print(nLowHr);
      logFile.print('\t');
      logFile.print(nHighHr);
      logFile.print('\t'); 
      if (DOFLOATS) {
        logFile.print(speedHr);
        logFile.print('\t');
      }
      logFile.print((int) statusHr);
      logFile.print('\t');
      logFile.print(nLowVl);
      logFile.print('\t');
      logFile.print(nHighVl);
      logFile.print('\t'); 
      if (DOFLOATS) {
        logFile.print(speedVl);
        logFile.print('\t');
      }
      logFile.print((int) statusVl);
      logFile.print('\t');
      logFile.print(nLowVr);
      logFile.print('\t'); 
      logFile.print(nHighVr);
      logFile.print('\t');    
      if (DOFLOATS) {
        logFile.print(speedVr);
        logFile.print('\t');      
      }
      logFile.println((int) statusVr);
      logFile.close();    
    }
  }
  logTime = millis() - logTime;
  loopTime = millis() - loopTime;
  
  // Print the measured times.
  if (PRINTTIMES) {
    Serial.print("Time to read sensor data with All-Method: ");
    Serial.println(sensorReadingTimeAll);    
    Serial.print("Time to read sensor data with Seperate-Method: ");
    Serial.println(sensorReadingTimeSeperate);    
    Serial.print("Time to print the data: ");
    Serial.println(printTime);
    Serial.print("Time to do floating point operations: ");
    Serial.println(floatTime);
    Serial.print("Time to send data via WiFi: ");
    Serial.println(wiFiTime);
    Serial.print("Time to log data: ");
    Serial.println(logTime);
    Serial.print("Complete loop time: ");
    Serial.println(loopTime);
  }
}
