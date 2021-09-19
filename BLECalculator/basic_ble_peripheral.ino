/*
 * 
 * File:        basic_ble_peripheral
 * Description: Implements a basic BLE peripheral for device testing
 * Author:      Rob Kerr (mail@robkerr.com)
 * Date:        6 AUG 2021
 * 
 */
#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEServer.h>

#define PERIPHERAL_NAME                "Test Peripheral"
#define SERVICE_UUID                "EBC0FCC1-2FC3-44B7-94A8-A08D0A0A5079"
#define CHARACTERISTIC_INPUT_UUID   "C1AB2C55-7914-4140-B85B-879C5E252FE5"
#define CHARACTERISTIC_OUTPUT_UUID  "643954A4-A6CC-455C-825C-499190CE7DB0"

// Current value of output characteristic persisted here
static uint8_t outputData[1];

// Output characteristic is used to send the response back to the connected phone
BLECharacteristic *pOutputChar;

// Class defines methods called when a device connects and disconnects from the service
class ServerCallbacks: public BLEServerCallbacks {
    void onConnect(BLEServer* pServer) {
        Serial.println("BLE Client Connected");
    }
    void onDisconnect(BLEServer* pServer) {
        BLEDevice::startAdvertising();
        Serial.println("BLE Client Disconnected");
    }
};

class InputReceivedCallbacks: public BLECharacteristicCallbacks {
    void onWrite(BLECharacteristic *pCharWriteState) {
        uint8_t *inputValues = pCharWriteState->getData();

        

        switch(inputValues[2]) {
          case 0x00: // add
            Serial.printf("Adding:   %02x %02x\r\n", inputValues[0], inputValues[1]);  
            outputData[0] = inputValues[0] + inputValues[1];  
            break;
          case 0x01: // subtract
            Serial.printf("Subtracting:   %02x %02x\r\n", inputValues[0], inputValues[1]);  
            outputData[0] = inputValues[0] - inputValues[1];  
            break;
          default: // multiply
            Serial.printf("Multiplying:   %02x %02x\r\n", inputValues[0], inputValues[1]);  
            outputData[0] = inputValues[0] * inputValues[1];  
        }
        
        Serial.printf("Sending response:   %02x\r\n", outputData[0]);  
        
        pOutputChar->setValue((uint8_t *)outputData, 1);
        pOutputChar->notify();
    }
};

void setup() {
  // Use the Arduino serial monitor set to this baud rate to view BLE peripheral logs 
  Serial.begin(115200);
  Serial.println("Begin Setup BLE Service and Characteristics");

  // Configure thes server

  BLEDevice::init(PERIPHERAL_NAME);
  BLEServer *pServer = BLEDevice::createServer();

  // Create the service
  BLEService *pService = pServer->createService(SERVICE_UUID);

  // Create a characteristic for the service
  BLECharacteristic *pInputChar = pService->createCharacteristic(
                              CHARACTERISTIC_INPUT_UUID,                                        
                              BLECharacteristic::PROPERTY_WRITE_NR | BLECharacteristic::PROPERTY_WRITE);

  pOutputChar = pService->createCharacteristic(
                              CHARACTERISTIC_OUTPUT_UUID,
                              BLECharacteristic::PROPERTY_READ | BLECharacteristic::PROPERTY_NOTIFY);

                                       

  // Hook callback to report server events
  pServer->setCallbacks(new ServerCallbacks());
  pInputChar->setCallbacks(new InputReceivedCallbacks());

  // Initial characteristic value
  outputData[0] = 0x00;
  pOutputChar->setValue((uint8_t *)outputData, 1);

  // Start the service
  pService->start();

  // Advertise the service
  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_UUID);
  pAdvertising->setScanResponse(true);
  pAdvertising->setMinPreferred(0x06);  
  pAdvertising->setMinPreferred(0x12);
  BLEDevice::startAdvertising();

  Serial.println("BLE Service is advertising");
}

void loop() {
  // put your main code here, to run repeatedly:
  delay(2000);
}
