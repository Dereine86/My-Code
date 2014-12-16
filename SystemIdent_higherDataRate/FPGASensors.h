/*
Class implementing the sensor reading functions.
Johannes Scherle 2013 johannes.scherle@gmail.com
*/

#include "Arduino.h"

#ifndef _FPGASENSORS_H_
#define _FPGASENSORS_H_

// Defines and enums that are used in the class.
#define SENSORARRAYSIZE 12
enum sensorsRead {NHIGHHR, NLOWHR, NHIGHVR, NLOWVR, NHIGHHL, NLOWHL, NHIGHVL, NLOWVL, STATUS, ACC, LUTIN, LUTOUT};
enum sensorsFloat {ACCELERATION, SPEEDHLONECYC, SPEEDVLONECYC, SPEEDHRONECYC, SPEEDVRONECYC,
                   SPEEDHLTWOCYC, SPEEDVLTWOCYC, SPEEDHRTWOCYC, SPEEDVRTWOCYC};
#define SENSORARRAYSIZE 12
#define FPGACLOCKFREQUENCY 1000000
#define DELTAPHI30 0.5236
#define DELTAPHI60 1.0472
#define WHEELRADIUS 0.045
#define DCFHHR 0.79
#define DCFHHL 0.83
#define DCFHVR 0.97
#define DCFHVL 0.92

class FPGASensors{
public:
  
  // Function to read the complete sensor data at once.
  static void readAllFPGASensorData(unsigned int *sensorArray);
  
  // Function to read single sensor values.
  static int getFPGASensorData(const int sensor);
  
  // Calculate the speed from the length of the sensor periods
  static float doFloatingCalculation(const unsigned int type, const unsigned long data);

  // Cut out the sensor data for each wheel from the 16 Bit of the status data.
  static void getStatusData(const unsigned int statusData, char *statusHl,
                            char *statusVl, char *statusHr, char *statusVr);
                            
  // Print the sensor data to a host pc. This function takes the sensor array, returned by
  // the readAllFPGASensorData-Function.  
  const static void printDebugLine(const unsigned int *sensorValues);
};

#endif // _FPGASENSORS_H_
