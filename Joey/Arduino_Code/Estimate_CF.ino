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

#define l1 0.275f 
#define l2 0.240f 


static uint8_t pos1[8];
static uint8_t pos2[8];

static float t1;
static float t2;

//Impedance
float Dt = 1.0f;
float Kt = 0.5f;


//System
float tout = 0.0;
float p1;
float p2;
float v1;
float v2;
float p1_r; //Desire Angular Motor1
float p2_r; //Desire Angular Motor2


float Fx;
float Fy;
float pi = 3.1416f;

unsigned int id_raw;
float p_raw;
float v_raw;


unsigned long dT;
unsigned long timeold = 0.0f;  // Variable for point time in the last cycle

// CAN to T Motor
unsigned char stmp[8] = {0, 0, 0, 0, 0, 0, 0, 0};
byte MotorModeEnt[8] = {0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFC};
byte MotorModeExt[8] = {0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFD};
byte MotorSetZero[8] = {0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFE};


void setup() {
    SERIAL_PORT_MONITOR.begin(115200);
    //while(!Serial){};
    //while (!SERIAL_PORT_MONITOR) {}

    while (CAN_OK != CAN.begin(CAN_1000KBPS)) {             // init can bus : baudrate = 500k
        SERIAL_PORT_MONITOR.println("CAN init fail, retry...");
        delay(100);
    }
    SERIAL_PORT_MONITOR.println("CAN init ok!");

    
//    CAN.sendMsgBuf(0x01, 0, 8, MotorSetZero);
//    read_data_no_print();   
//    delay(100);    
//    CAN.sendMsgBuf(0x02, 0, 8, MotorSetZero);
//    read_data_no_print();
//    delay(100);
    
    CAN.sendMsgBuf(0x01, 0, 8, MotorModeEnt);
    read_data_no_print();
    CAN.sendMsgBuf(0x02, 0, 8, MotorModeEnt);
    read_data_no_print();
//    delay(100);

    pack_cmd(pos1, 0.0f,0.0f,0.0f,0.0f,0.0f); //(pos,vel,tff,kp,kd)
    pack_cmd(pos2, 0.0f,0.0f,0.0f,0.0f,0.0f); //(pos,vel,tff,kp,kd)

    timeold = millis();
    CAN.sendMsgBuf(0x01, 0, 8, pos1);
    read_data(&id_raw, &p_raw, &v_raw);
    if (id_raw == 1) {
      p1 = p_raw; //Position of Motor 1
      v1 = round(100.0*v_raw)/100.0; //Velocity of Motor 1
    }
    else {
      p2 = -p_raw; //Position of Motor 2
      v2 = -round(100.0*v_raw)/100.0; //Velocity of Motor 2
    }
    CAN.sendMsgBuf(0x02, 0, 8, pos2);
    read_data(&id_raw, &p_raw, &v_raw);
    if (id_raw == 1) {
      p1 = p_raw; //Position of Motor 1
      v1 = round(100.0*v_raw)/100.0; //Velocity of Motor 1
    }
    else {
      p2 = -p_raw; //Position of Motor 2
      v2 = -round(100.0*v_raw)/100.0; //Velocity of Motor 2
    }


    SERIAL_PORT_MONITOR.print("Time ");
    SERIAL_PORT_MONITOR.print(" Theta1 ");
    SERIAL_PORT_MONITOR.print(" Theta2 ");
    SERIAL_PORT_MONITOR.print(" X ");
    SERIAL_PORT_MONITOR.print(" Y ");
    SERIAL_PORT_MONITOR.print(" Command_Torque1 ");
    SERIAL_PORT_MONITOR.print(" Command_Torque2 ");
    SERIAL_PORT_MONITOR.print(" Fx ");
    SERIAL_PORT_MONITOR.println(" Fy");

}


void loop() {
    

    while (tout < 30) {
      dT = millis()-timeold;   
      tout = tout + (0.001f*dT);
      timeold = millis();
      SERIAL_PORT_MONITOR.print(tout,6);
      SERIAL_PORT_MONITOR.print(" ");
      

      float x_pos = l1*sin(p1) + l2*cos(p2);
      float y_pos = l1*cos(p1) - l2*sin(p2);

  
      //Print Current Pos
      SERIAL_PORT_MONITOR.print(p1,4);
      SERIAL_PORT_MONITOR.print(" ");
      SERIAL_PORT_MONITOR.print(p2,4);
      SERIAL_PORT_MONITOR.print(" ");
      SERIAL_PORT_MONITOR.print(x_pos,4);
      SERIAL_PORT_MONITOR.print(" ");
      SERIAL_PORT_MONITOR.print(y_pos,4);
      SERIAL_PORT_MONITOR.print(" ");


      t1 = 0.0f;
      t2 = 0.0f;
      
      //Real Command
      if (isfinite(t1)) {
        pack_cmd(pos1, 0.0f,0.0f,-t1,0.0f,0.0f); //(pos,vel,tff,kp,kd)   
      }
      else {
        CAN.sendMsgBuf(0x01, 0, 8, MotorModeExt);
        read_data_no_print();
        CAN.sendMsgBuf(0x02, 0, 8, MotorModeExt);
        read_data_no_print();
        Serial.println("t1 Exceed Limit");
        tout = 10;
        break;
      }
      if (isfinite(t2)) {
        pack_cmd(pos2, 0.0f,0.0f,t2,0.0f,0.0f); //(pos,vel,tff,kp,kd)
      }
      else {
        CAN.sendMsgBuf(0x01, 0, 8, MotorModeExt);
        read_data_no_print();
        CAN.sendMsgBuf(0x02, 0, 8, MotorModeExt);
        read_data_no_print();
        Serial.println("t2 Exceed Limit");
        tout = 10;
        break;
      }
            

      SERIAL_PORT_MONITOR.print(t1);
      SERIAL_PORT_MONITOR.print(" ");
      SERIAL_PORT_MONITOR.print(t2);
      SERIAL_PORT_MONITOR.print(" ");


      //-----Estimation-----//
      Fx = ((t1*cos(p1-p2+pi*(2.0f/5.0f))*cos(p2)*(-6.0/2.5e1)+t2*pow(sin(p1),2)*sin(p2+pi/10)*(1.1e1/4.0e1)+t2*cos(p1)*cos(p2+pi/1.0e1)*sin(p1)*(1.1e1/4.0e1))*(5.0e2/3.3e1))/(cos(p1-p2+pi*(2.0/5.0))*(cos(p1)*cos(p2)+sin(p1)*sin(p2)));
      Fy = ((t1*cos(p1-p2+pi*(2.0/5.0))*sin(p2)*(6.0/2.5e1)+t2*pow(cos(p1),2)*cos(p2+pi/1.0e1)*(1.1e+1/4.0e1)+t2*cos(p1)*sin(p1)*sin(p2+pi/1.0e+1)*(1.1e+1/4.0e+1))*(5.0e+2/3.3e+1))/(cos(p1-p2+pi*(2.0/5.0))*(cos(p1)*cos(p2)+sin(p1)*sin(p2)));


      SERIAL_PORT_MONITOR.print(Fx,4);
      SERIAL_PORT_MONITOR.print(" ");
      SERIAL_PORT_MONITOR.println(Fy,4);



  
      CAN.sendMsgBuf(0x01, 0, 8, pos1);
      read_data(&id_raw, &p_raw, &v_raw);
      if (id_raw == 1) {
        p1 = -p_raw; //Position of Motor 1
        v1 = -round(100.0*v_raw)/100.0; //Velocity of Motor 1
      }
      else {
        p2 = p_raw; //Position of Motor 2
        v2 = round(100.0*v_raw)/100.0; //Velocity of Motor 2
      }
      CAN.sendMsgBuf(0x02, 0, 8, pos2);
      read_data(&id_raw, &p_raw, &v_raw);
      if (id_raw == 1) {
        p1 = -p_raw; //Position of Motor 1
        v1 = -round(100.0*v_raw)/100.0; //Velocity of Motor 1
      }
      else {
        p2 = p_raw; //Position of Motor 2
        v2 = round(100.0*v_raw)/100.0; //Velocity of Motor 2
      }



      delay(10);

    }
    
    
    CAN.sendMsgBuf(0x01, 0, 8, MotorModeExt);
    read_data_no_print();
    CAN.sendMsgBuf(0x02, 0, 8, MotorModeExt);
    read_data_no_print();

}

void pack_cmd(uint8_t *bufs, float p_des,float v_des,float t_ff,float kp,float kd) {
  unsigned int p_int = float_to_uint(p_des,P_MIN,P_MAX,16);  
  unsigned int v_int = float_to_uint(v_des,V_MIN,V_MAX,12);
  unsigned int t_int = float_to_uint(t_ff,T_MIN,T_MAX,12);
  unsigned int kp_int = float_to_uint(kp,KP_MIN,KP_MAX,12);
  unsigned int kd_int = float_to_uint(kd,KD_MIN,KD_MAX,12);
  
  bufs[0] = p_int >> 8;
  bufs[1] = p_int & 0xFF;
  bufs[2] = v_int >> 4;
  bufs[3] = ((v_int & 0xF) << 4) | (kp_int >> 8);
  bufs[4] = kp_int & 0xFF;
  bufs[5] = kd_int >> 4;
  bufs[6] = ((kd_int & 0xF) << 4) | (t_int >> 8);
  bufs[7] = t_int & 0xFF;
}

void read_data(unsigned int* id, float* p, float* v){
  unsigned char len = 0;
  unsigned char buf[8];

  if (CAN_MSGAVAIL == CAN.checkReceive()) {         // check if data coming

    CAN.readMsgBuf(&len, buf);    // read data,  len: data length, buf: data buf
        
    //unsigned int canId = CAN.getCanId();
    *id = buf[0];
    unsigned int p_int2 = (buf[1] << 8) | buf[2];
    unsigned int v_int2 = (buf[3] << 4) | (buf[4] >> 4);
    unsigned int i_int2 = ((buf[4] & 0xF) << 8) | buf[5];

    *p = round(10000.0*uint_to_float(p_int2,P_MIN,P_MAX,16))/10000.0;
    *v = round(10000.0*uint_to_float(v_int2,V_MIN,V_MAX,12))/10000.0;

//    Serial.print(id);
//    Serial.print(" ");
//    Serial.print(p);
//    Serial.print(" ");
//    Serial.println(v);
  }
}


float read_data_no_print(){
  unsigned char len = 0;
  unsigned char buf[8];

  if (CAN_MSGAVAIL == CAN.checkReceive()) {         // check if data coming

    CAN.readMsgBuf(&len, buf);    // read data,  len: data length, buf: data buf
        
    //unsigned int canId = CAN.getCanId();
    unsigned int id = buf[0];
    unsigned int p_int2 = (buf[1] << 8) | buf[2];
    unsigned int v_int2 = (buf[3] << 4) | (buf[4] >> 4);
    unsigned int i_int2 = ((buf[4] & 0xF) << 8) | buf[5];

    float p = uint_to_float(p_int2,P_MIN,P_MAX,16);
    float v = uint_to_float(v_int2,V_MIN,V_MAX,12);
  }
}



unsigned int float_to_uint(float x, float x_min, float x_max, unsigned int bits) {
  //convert a float to an unsigned int, given range and number of bits  ///
  float span = x_max-x_min;
  float offset = x-x_min;
  
  unsigned int pgg = 0;
  if(bits == 12){
    pgg = (unsigned int)((offset/span)*4095.0f);
  }
  if(bits == 16){
    pgg = (unsigned int)((offset/span)*65535.0f);
  }
  return pgg;
}

float uint_to_float(unsigned int x_int, float x_min, float x_max, unsigned int bits) {
  //convert unsingned int to float, given range and number of bits ///
  float span = x_max-x_min;
  float pgg = 0;
  if(bits == 12){
    pgg = (float)(x_int*span/4095.0f) + x_min;
  }
  if(bits == 16){
    pgg = (float)(x_int*span/65535.0f) + x_min;
  }
  return pgg;
}
