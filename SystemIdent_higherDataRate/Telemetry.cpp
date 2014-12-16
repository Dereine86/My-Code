#include "Telemetry.h"
#include <WiFi.h>


Telemetry::Telemetry(char* ssid, char* pass) {
  _ssid = ssid;
  _pass = pass;
  _wiFiStatus = WL_IDLE_STATUS;
} 

void Telemetry::connectWithLan() {
  while (_status != WL_CONNECTED) {
    // Attempt to connect using WPA2 encryption:
    Serial.println("Attempting to connect to WPA network...");
    _status = WiFi.begin(_ssid, _pass);

    // If connection could not be established, print error and try again in 1000msecs
    if (_status != WL_CONNECTED) { 
      Serial.println("Couldn't get a wifi connection");
      delay(1000);
    } 
    // If you are connected, print out info about the connection:
    else {
      Serial.println("Connected to network");
      break;
    }
  }	
}

int Telemetry::connectWithServer(IPAddress server) {
  WiFiClient _client;
  _server = server;
  if (_status == WL_CONNECTED) {
    if(_client.connect(_server, TCPPORT))
      _connected = true;
      Serial.println("Connected to Server");
    return 1;
  }
  return -1;
}

int Telemetry::sendWifiData(int& acc, unsigned int& nHighHr, unsigned int& nHighVr, unsigned int& nHighHl,
                            unsigned int& nHighVl) {
  if (!_client.connected()) {
    Serial.println("Error, no connection to a tcp-server!");
    if (_client.connect(_server, TCPPORT))
      Serial.println("Connection reestablished!");
    else
      return -1;
  }
  char tcpPacket[1400];
  char accChar[6];
  char nHighHrChar[6];
  char nHighVrChar[6];
  char nHighVlChar[6];
  char nHighHlChar[6];
  
  // Build the tcp-Packet, by converting the sensor data to strings.
  dtostrf(acc, 5, 2, accChar);
  ltoa(nHighHr, nHighHrChar, 10);
  ltoa(nHighVr, nHighVrChar, 10);
  ltoa(nHighVl, nHighVlChar, 10);
  ltoa(nHighHl, nHighHlChar, 10);
  
  sprintf(tcpPacket, "ba %s bc %s bd %s be %s bf %s", accChar, nHighHrChar, nHighVrChar, nHighVlChar, nHighHlChar);
  Serial.println("Sending TCP-Packet:");
  Serial.println(tcpPacket);
  _client.print(tcpPacket);
  return 1;
}
