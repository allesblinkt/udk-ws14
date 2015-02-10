const uint8_t pinSensor = A3;


void setup() {
  Serial.begin(115200);
}


void loop() {
  uint16_t sensorValue = analogRead(pinSensor);
  Serial.println(sensorValue);
  delay(20);
}

