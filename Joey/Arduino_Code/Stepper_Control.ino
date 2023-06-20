#define PUL 3
#define DIR 2

unsigned long dT;
float timeold;
float t = 0;
unsigned long eachstep = 500;

void setup() {
  // put your setup code here, to run once:
  pinMode(PUL, OUTPUT);
  pinMode(DIR, OUTPUT);

  Serial.begin(115200);
  
}

void loop() {
  // put your main code here, to run repeatedly:
  dT = millis() - timeold;
  t = t + (0.001f*dT);
  timeold = millis();
  
  while (t < 10) {
    dT = millis() - timeold;
    t = t + (0.001f*dT);
    timeold = millis();
    
    while (t < 5) {
      dT = millis() - timeold;
      t = t + (0.001f*dT);
      timeold = millis();

      digitalWrite(DIR, HIGH);
      digitalWrite(PUL, HIGH);
      delayMicroseconds(eachstep);
      digitalWrite(PUL, LOW);
      delayMicroseconds(eachstep);    
      Serial.println("Going");
      
    }

      digitalWrite(DIR, LOW);
      digitalWrite(PUL, HIGH);
      delayMicroseconds(eachstep);
      digitalWrite(PUL, LOW);
      delayMicroseconds(eachstep);
      Serial.println("Going Back");
  }

  Serial.println("End");
  delay(1000);
  t = 0;
  timeold = millis();

}