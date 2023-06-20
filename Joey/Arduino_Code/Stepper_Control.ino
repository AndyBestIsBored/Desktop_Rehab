const int PUL = 8;
const int DIR = 0;
const int ENA = 1;

unsigned long dT;
float timeold;
float t = 0;
unsigned long step = 500;

void setup() {
  // put your setup code here, to run once:
  pinMode(PUL, OUTPUT);
  pinMode(DIR, OUTPUT);
  pinMode(ENA, OUTPUT);

  digitalWrite(ENA, HIGH);
  Serial.begin(115200);
  
}

void loop() {
  // put your main code here, to run repeatedly:
  dT = millis() - timeold;
  t = t + (0.001f*dT);
  timeold = millis();
  
  while (t < 20) {
    dT = millis() - timeold;
    t = t + (0.001f*dT);
    timeold = millis();
    
    while (t < 10) {
      dT = millis() - timeold;
      t = t + (0.001f*dT);
      timeold = millis();
      
      digitalWrite(DIR, HIGH);
      digitalWrite(PUL, HIGH);
      delay(step);
      digitalWrite(PUL, LOW);
      delay(step);    
      Serial.println("Going");
      
    }

    
      digitalWrite(DIR, LOW);
      digitalWrite(PUL, HIGH);
      delay(step);
      digitalWrite(PUL, LOW);
      delay(step);
      Serial.println("Going Back");
  }

  digitalWrite(ENA, LOW);

}