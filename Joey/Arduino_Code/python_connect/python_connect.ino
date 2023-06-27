// demo: CAN-BUS Shield, send data
// demo: CAN-BUS Shield, receive data with check mode
// loovee@seeed.cc

//#include <Servo.h>

#include <SPI.h>
#define CAN_2515

// Set SPI CS Pin according to your hardware

#if defined(SEEED_WIO_TERMINAL) && defined(CAN_2518FD)
// For Wio Terminal w/ MCP2518FD RPi Hat：
// Channel 0 SPI_CS Pin: BCM 8
// Channel 1 SPI_CS Pin: BCM 7
// Interupt Pin: BCM25
const int SPI_CS_PIN  = BCM8;
const int CAN_INT_PIN = BCM25;
#else

// For Arduino MCP2515 Hat:
// the cs pin of the version after v1.1 is default to D9
// v0.9b and v1.0 is default D10
const int SPI_CS_PIN = 9;
const int CAN_INT_PIN = 2;
#endif

#ifdef CAN_2515
#include "mcp2515_can.h"
mcp2515_can CAN(SPI_CS_PIN); // Set CS pin
#endif

// Motor Limits
#define P_MIN -12.5f
#define P_MAX 12.5f
#define V_MIN -50.0f  // AK70-10 24V
#define V_MAX 50.0f
#define T_MIN -25.0f   // AK70-10
#define T_MAX 25.0f
#define KP_MIN 0.0f
#define KP_MAX 500.0f
#define KD_MIN 0.0f
#define KD_MAX 5.0f

//float p_des = 0.0;     // AK70-10
//float v_des = 0.0;
//float t_ff = 0.0;
//float kp = 0.0;
//float kd = 2.0;




void setup() {
    SERIAL_PORT_MONITOR.begin(115200);
    //while(!Serial){};
    //while (!SERIAL_PORT_MONITOR) {}

    while (CAN_OK != CAN.begin(CAN_1000KBPS)) {             // init can bus : baudrate = 500k
        SERIAL_PORT_MONITOR.println("CAN init fail, retry...");
        delay(100);
    }
    SERIAL_PORT_MONITOR.println("CAN init ok!");
    
   
}
byte Collect[9];
uint8_t command[8];

void loop() {
  if (Serial.available() >= 9) {
    Serial.readBytes(Collect, 9);
    unsigned int id = (unsigned int)Collect[0];
    for (int i = 1; i < 9; i++) {
      command[i-1] = Collect[i];
    }

    
//    for (int i = 0; i < 9; i++) {
//      Serial.print(Name[i], HEX);
//      Serial.print(" ");
//    }
//    Serial.println();
//    if (Serial.available()) { // check if there is data available to read
//    uint8_t M1 = Serial.read(); // read the uint8_t value from the serial port
    CAN.sendMsgBuf(id, 0, 8, command);

    if (CAN_MSGAVAIL == CAN.checkReceive()) {         // check if data coming
        unsigned char len = 0;
        unsigned char buf[8];
        CAN.readMsgBuf(&len, buf);
        unsigned int id = buf[0];
        unsigned int p_int = (buf[1] << 8) | buf[2];
        unsigned int v_int = (buf[3] << 4) | (buf[4] >> 4);
        unsigned int i_int = ((buf[4] & 0xF) << 8) | buf[5];
        
        Serial.print(id); // send the response uint8_t value back to the serial portSerial.write(response); // send the response uint8_t value back to the serial port
        Serial.print(" ");
        Serial.print(p_int);
        Serial.print(" ");
        Serial.print(v_int);
        Serial.print(" ");
        Serial.println(i_int);
    }
    else {
      Serial.println("");
    }
}
    
}