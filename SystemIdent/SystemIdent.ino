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
#define DOFLOATS true
#define PRINTTIMES false
#define DEBUGLINES true
#define LOGFILES false
#define WIFI_ENABLED false
#define READALLSENSORDATA false
#define READSEPERATESENSORDATA true

// Some global variables and objects, that are used in the program.
const int chipSelect = 4; // chipselect for SD-Card
boolean sdCardPresent = false; // saves, if a SD-Card is present or not
char ssid[] = "CAR";     //  the network SSID (name) 
char pass[] = "CARCARCAR";    // the network password
IPAddress server(192,168,0,101);    // Ip adress object of the server
Telemetry telemetry(ssid, pass);
long sampleTime;


/* The setup function of the program. Here the serial communication to the
Host-PC is started. Furthermore the SD-Card is initialized and the WiFi-Connection
is initialized.
*/
void setup()
{
  // Uart Configuration
  Serial.begin(9600);
}

// The Main Loop of the program.
void loop() {
  unsigned int nHighHr;
  unsigned int nHighHl;
    
  float speedHl;
  float speedHr;

  long deltaT;
 
 // The variable to measure the loop time.  
 long t1 = millis();

  // Read the Sensor data with the readSeperate Method.
 long sensorReadingTimeSeperate = millis();
 if (READSEPERATESENSORDATA) {
   Serial1.begin(9600);
   nHighHr = FPGASensors::getFPGASensorData(NHIGHHR);
   nHighHl = FPGASensors::getFPGASensorData(NHIGHHL);
   Serial1.end();
 }
 
 if (Serial.read() == 's') {
   sampleTime = 0;
   Serial.println("Start sampling!");
 }
 
 deltaT = millis() - t1;
 sampleTime = sampleTime + deltaT;
 
 // Print the sample time.
 Serial.print(sampleTime);
 Serial.print('\t');
 Serial.print(deltaT);
 Serial.print('\t');
 
 if (DOFLOATS) {
   speedHl = FPGASensors::doFloatingCalculation(SPEEDHL, nHighHl);
   speedHr = FPGASensors::doFloatingCalculation(SPEEDHR, nHighHr);
 }
 
 sensorReadingTimeSeperate = millis() - sensorReadingTimeSeperate; 
 // If activated print the sensor values on the serial-console of the Host-PC
 if (DEBUGLINES && READSEPERATESENSORDATA) {
    Serial.print(nHighHl);
    Serial.print('\t');
    Serial.print(nHighHr);
    Serial.print('\t');
    Serial.print(speedHr);
    Serial.print('\t');
    Serial.println(speedHl);
  }


}
