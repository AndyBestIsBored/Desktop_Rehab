const int stepPin = 6;
const int dirPin = 7;
const int enPin = 8;

const int leftButtonPin = 2;
const int rightButtonPin = 3;

int dir = HIGH;

const double delayTime = 0.5;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  pinMode(stepPin,OUTPUT); 
  pinMode(dirPin,OUTPUT);
  pinMode(enPin,OUTPUT);
  pinMode(leftButtonPin,INPUT);
  pinMode(rightButtonPin,INPUT);
  
  digitalWrite(enPin,LOW);
  digitalWrite(dirPin,dir);

  while (digitalRead(rightButtonPin) != HIGH)
  {
    digitalWrite(stepPin, HIGH);
    delay(delayTime);
    digitalWrite(stepPin, LOW);
    delay(delayTime); 
  }

  delay(1000);

  double startTime = millis();
  dir = LOW;
  digitalWrite(dirPin,LOW);
  
  while (digitalRead(leftButtonPin) != HIGH)
  {
    digitalWrite(stepPin, HIGH);
    delay(delayTime);
    digitalWrite(stepPin, LOW);
    delay(delayTime); 
  }
  double endTime = millis();

  double duration = (startTime - endTime) / 1000;

  Serial.print("Time Duration: ");
  Serial.println(duration);
}

void loop() {
  // put your main code here, to run repeatedly:
}