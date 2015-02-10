import processing.serial.*;

Serial serial;                 
String serialBuffer;

float rawValue = 0.0;
float filteredValue = 0.0;

float filterStrength = 0.8;


void setup() {
  size(256, 256);  // Stage size

  String portName = Serial.list()[0];
  serial = new Serial(this, portName, 115200);

  serial.clear();
}

void draw() {
  background(52);
    
  fill(255);
  text(nf(filteredValue, 0, 2), 20, 20);
}

void serialEvent(Serial myPort) {
  int inByte = serial.read();

  if (inByte == '\n') {  // newline
    rawValue = int(serialBuffer);
    filteredValue  = (filterStrength) * filteredValue + (1.0 - filterStrength) * rawValue;
  } else {
    serialBuffer += (char)inByte;
  }
}
