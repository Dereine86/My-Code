#include "FPGASensors.h"

int FPGASensors::getFPGASensorData(int sensor) {
  int x = 0;
  int y = 0;
  char charX = 0;  
  char charY = 0;
  char searchChar = 0;
  // Depending on which type of sensor data shall be returned, define the char that represents the start char.
  switch (sensor) {
    case (NLOWHR):
      searchChar = 'a';
      break;      
    case (NHIGHHR):
      searchChar = 'c';
      break; 
    case (NLOWVR):
      searchChar = 'e';
      break;       
    case (NHIGHVR):
      searchChar = 'g';
      break;
    case (NLOWHL):      
      searchChar = 'i';
      break;
    case (NHIGHHL):      
      searchChar = 'k';
      break;
    case (NLOWVL):      
      searchChar = 'm';
      break;
    case (NHIGHVL):      
      searchChar = 'o';
      break;         
    case (STATUS):
      searchChar = 'q';
      break;
    case (ACC):
      searchChar = 's';
      break;
    case (LUTIN):
      searchChar = 'u';
      break;
    case (LUTOUT):
      searchChar = 'w';
      break;      
  }

  // Clear the serial buffer.
  while(Serial1.read() >= 0);
  
  
  // Wait for the char that starts the sequence.
  while (charX != searchChar) {
    while (Serial1.available() <= 0);
    charX = Serial1.read();
    if (charX == searchChar) {
      // Initial char has been found. Read the first byte, as soon as it is available.
      while (Serial1.available() <= 0);        
      x = Serial1.read();
    }        
  }
  // Wait for the second byte, then read it.
  while(Serial1.available() <= 0);
  charY = Serial1.read();    
  while(Serial1.available() <= 0);
  y = Serial1.read();
  //Serial.println(y);
    
  y = y << 8; // Merge the two bytes.
  y += x;
  return y;
}

void FPGASensors::readAllFPGASensorData(unsigned int *sensorArray) {
  unsigned int i = 0;
  int tmpValueLowerByte;
  int tmpValueHigherByte;
  char searchChar = 'a';
  while (true) {
    while (Serial1.read() != searchChar);    
    tmpValueLowerByte = Serial1.read();
    while (tmpValueLowerByte < 0)
      tmpValueLowerByte = Serial1.read();
    searchChar += 1;
    while (Serial1.read() != searchChar);    
    tmpValueHigherByte = Serial1.read();
    while (tmpValueHigherByte < 0)
      tmpValueHigherByte = Serial1.read();
    tmpValueHigherByte = tmpValueHigherByte << 8;
    tmpValueHigherByte += tmpValueLowerByte;
    sensorArray[i] = tmpValueHigherByte;
    i++;
    searchChar += 1;
    if (i == SENSORARRAYSIZE - 1)
      break;
  }
}

float FPGASensors::doFloatingCalculation(const unsigned int type, const unsigned long data){
  switch (type) {
    case (ACCELERATION) : {
      float mg = data * 4;
      return (mg * 9.81) / 1000;
    }
    /*
    Cases for one sensor cycle.
    */
    case (SPEEDHRONECYC) : {
      if (data == 65535)
        return 0.0f;
      else
        return ((DELTAPHI30 * FPGACLOCKFREQUENCY * WHEELRADIUS) / (data * DCFHHR)) * 3.6;
    }
    case (SPEEDHLONECYC): {
      if (data == 65535)
        return 0.0f;
      else       
        return ((DELTAPHI30 * FPGACLOCKFREQUENCY * WHEELRADIUS) / (data * DCFHHL)) * 3.6;
    }
    case (SPEEDVLONECYC): {
      if (data == 65535)
        return 0.0f;
      else
        return ((DELTAPHI30 * FPGACLOCKFREQUENCY * WHEELRADIUS) / (data * DCFHVL)) * 3.6;
    }
    case (SPEEDVRONECYC): {
      if (data == 65535)
        return 0.0f;
      else
        return ((DELTAPHI30 * FPGACLOCKFREQUENCY * WHEELRADIUS) / (data * DCFHVR)) * 3.6;
    }
    /*
    Cases for two Sensor-Cycles.
    */
    case (SPEEDHRTWOCYC) : {
      if (data == 131070)
        return 0.0f;
      else
        return ((DELTAPHI60 * FPGACLOCKFREQUENCY * WHEELRADIUS) / data) * 3.6;
    }
    case (SPEEDHLTWOCYC): {
      Serial.println(data);
      if (data == 131070)
        return 0.0f;
      else       
        return ((DELTAPHI60 * FPGACLOCKFREQUENCY * WHEELRADIUS) / data) * 3.6;
    }
    case (SPEEDVLTWOCYC): {
      if (data == 131070)
        return 0.0f;
      else
        return ((DELTAPHI60 * FPGACLOCKFREQUENCY * WHEELRADIUS) / data) * 3.6;
    }
    case (SPEEDVRTWOCYC): {
      if (data == 131070)
        return 0.0f;
      else
        return ((DELTAPHI60 * FPGACLOCKFREQUENCY * WHEELRADIUS) / data) * 3.6;
    }    
  }
}

void FPGASensors::getStatusData(const unsigned int statusData, char* statusHl,
				   char* statusVl, char* statusHr, char *statusVr) {
  *statusHl = (statusData >> 12);
  *statusVl = ((statusData & 0x0F00) >> 8);
  *statusHr = ((statusData & 0x00F0) >> 4);  
  *statusVr = (statusData & 0x000F);  
}

const void FPGASensors::printDebugLine(const unsigned int *sensorValues) {
  for (int i = 0; i < SENSORARRAYSIZE - 1; i++) {
    Serial.print(sensorValues[i]);
    Serial.print('\t');
  }
  Serial.println(sensorValues[SENSORARRAYSIZE - 1]);
}
