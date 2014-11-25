/** Reads the value of an light dependent resistor 
  * (i.e. light sensor) and sends the value over Serial
  * as plain text (ASCII) followed by a line break (\c\n)
  */

void setup() {
  Serial.begin(115200);  // quick
  
  pinMode(2, OUTPUT);  // we take 5V from pin 2
  digitalWrite(2, HIGH);
}


void loop() {  
  int sensorValue = analogRead(A0);
  
  Serial.println(sensorValue, DEC);  // send as plain text
  delay(20);  // 1000ms / 20ms = ca. 50 Hz 
}
