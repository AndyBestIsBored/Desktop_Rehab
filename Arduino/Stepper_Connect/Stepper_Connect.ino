

const int stepPin = 6;
const int dirPin = 7;
const int enPin = 8;

const int topButtonPin = 2;
const int bottomButtonPin = 3;

int dir = HIGH;

const double power = 0.9;    


void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  while (!Serial) {
    ;  // wait for serial port to connect. Needed for native USB port only
  }

  pinMode(stepPin,OUTPUT); 
  pinMode(dirPin,OUTPUT);
  pinMode(enPin,OUTPUT);
  
  
  digitalWrite(enPin,LOW);
  digitalWrite(dirPin,dir);

  attachInterrupt(digitalPinToInterrupt(topButtonPin), topButtonPressed, RISING); 
  attachInterrupt(digitalPinToInterrupt(bottomButtonPin), bottomButtonPressed, RISING); 
}

void loop() {
  // put your main code here, to run repeatedly:
  
  if (Serial.available() > 0) {
    char input = Serial.read();
    int command = input - '0';
    switch (command) {
      case 1:
        digitalWrite(dirPin,HIGH);
        analogWrite(stepPin, power*255);
        dir = HIGH;;
        break;
      case 2:
        analogWrite(stepPin, 0);
        break;
      case 3:
        digitalWrite(dirPin,LOW);
        analogWrite(stepPin, power*255);
        dir = LOW;
        break;
    }
  }

}

void topButtonPressed()
{
  Serial.println(5);
}

void bottomButtonPressed()
{
  Serial.println(4);
}
