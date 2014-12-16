/*
Class implementing the Telemetry-Function.
Johannes Scherle 2013 johannes.scherle@gmail.com
*/

#ifndef _TELEMETRY_H_
#define _TELEMETRY_H_

#include <WiFi.h>

// Port, that is used to connect to the server. Must of course be the same on the server side.
#define TCPPORT 50000

class Telemetry {
  public:
    // Constructor. Arguments are the ssid and password of the WPA 2 - WLAN
    Telemetry(char* ssid, char* pass);
    
    // Connect to the WLAN.
    void connectWithLan();
    
    // Connect with a TCP-Server. Returns -1 if there is no WLAN-Connection.
    int connectWithServer(IPAddress server);
    
    // Send WiFi Data to the server. Function is overloaded
    int sendWifiData(int& acc, unsigned int& nHighHr, unsigned int& nHighVr, unsigned int& nHighHl,
                            unsigned int& nHighVl);    
    
    boolean _connected;

private:
   int _wiFiStatus;
   int _status;
   char* _ssid;
   char* _pass;
   IPAddress _server;
   WiFiClient _client;
};

#endif // _TELEMETRY_H_
