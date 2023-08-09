#include <Button.h>

const int stepPin = 6;
const int dirPin = 7;
const int enPin = 8;

const int topButtonPin = 2;
const int bottomButtonPin = 3;
const int powerButtonPin = 4;

int dir = HIGH;

bool on = false;

const double power = 0.9;

int inByte = 0;    

Button powerButton(powerButtonPin);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  while (!Serial) {
    ;  // wait for serial port to connect. Needed for native USB port only
  }

  pinMode(stepPin,OUTPUT); 
  pinMode(dirPin,OUTPUT);
  pinMode(enPin,OUTPUT);
  
  powerButton.begin();
  
  digitalWrite(enPin,LOW);
  digitalWrite(dirPin,dir);

  attachInterrupt(digitalPinToInterrupt(topButtonPin), topButtonPressed, RISING); 
  attachInterrupt(digitalPinToInterrupt(bottomButtonPin), bottomButtonPressed, RISING); 
}

void loop() {
  // put your main code here, to run repeatedly:
  if (powerButton.released())
  {
		on = !on;
  }
  if (on == true)
  {
    analogWrite(stepPin, power*255);
  }
  else{
    analogWrite(stepPin, 0);
  }
  if (Serial.available() > 0) {
    inByte = Serial.read();
    switch (inByte) {
      case 1:
        digitalWrite(dirPin,HIGH);
        dir = HIGH;;
        break;
      case 2:
        analogWrite(stepPin, 0);
        break;
      case 3:
        digitalWrite(dirPin,LOW);
        dir = LOW;
        break;
    }
  }

}

void topButtonPressed()
{
  digitalWrite(dirPin,HIGH);
  dir = HIGH;
  Serial.write(5);
}

void bottomButtonPressed()
{
  digitalWrite(dirPin,LOW);
  dir = LOW;
  Serial.write(4);
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('A');  // send a capital A
    delay(300);
  }
}