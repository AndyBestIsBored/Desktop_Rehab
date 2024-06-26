#include <Button.h>

const int stepPin = 6 ;
const int dirPin = 7;
const int enPin = 8;

const int leftButtonPin = 2;
const int rightButtonPin = 3;
const int powerButtonPin = 4;

int dir = HIGH;

bool on = false;

const double power = 0.9;

Button powerButton(powerButtonPin);

void setup() {
  // put your setup code here, to run once:
  // Serial.begin(9600);

  pinMode(stepPin,OUTPUT); 
  pinMode(dirPin,OUTPUT);
  pinMode(enPin,OUTPUT);
  
  powerButton.begin();
  
  digitalWrite(enPin,LOW);
  digitalWrite(dirPin,dir);

  attachInterrupt(digitalPinToInterrupt(leftButtonPin), leftButtonPressed, RISING); 
  attachInterrupt(digitalPinToInterrupt(rightButtonPin), rightButtonPressed, RISING); 
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
}

void leftButtonPressed()
{
  digitalWrite(dirPin,HIGH);
  dir = HIGH;
}

void rightButtonPressed()
{
  digitalWrite(dirPin,LOW);
  dir = LOW;
}
