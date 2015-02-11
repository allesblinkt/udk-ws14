/**
  * Reads a sensor value from a connected Arduino and broadcast it 
  * via multicast over the local network as an OSC message in the
  * form of ->  /light 0.4334   <-
  */

import oscP5.*;
import netP5.*;
import processing.serial.*;

Serial serial;
int rawValue = 0;
float filteredValue = 0.0;

float filterStrength = 0.85;
String serialBuffer = "";

OscP5 oscP5;

SignalPlotter plotter;
SignalPlotter filteredPlotter;

PFont font;


void setup() {
  size(500, 500);

  frameRate(60);

  font = loadFont("Futura-Medium-14.vlw");

  println(Serial.list());
  //String portName = Serial.list()[5];  // you might need to use a different port...
  String portName = "/dev/ttyUSB0";  // you might need to use a different port...
  
  println("Chosen port: " + portName);
  serial = new Serial(this, portName, 115200);

  oscP5 = new OscP5(this, "239.0.0.1", 7777);   // multicast

  plotter = new SignalPlotter(600);
  plotter.strokeColor = color(128);
  
  filteredPlotter = new SignalPlotter(600);
  filteredPlotter.strokeColor = color(255);
}


void draw() {
  background(52);

  float transformedValue = constrain(map(rawValue, 0, 522, 1.0, 0.0), 0.0, 1.0);
  filteredValue = (filterStrength) * filteredValue + (1.0 - filterStrength) * transformedValue;

  /* Draw */
  textFont(font);

  text("Sending at " + nf(frameRate, 0, 2) + " Hz", 20, height - 100);
  text("Raw Sensor Value: " + rawValue, 20, height - 60);
  text("Transformed Sensor Value: " + nf(transformedValue, 0, 3), 20, height - 40);
  text("Filtered Sensor Value: " + nf(filteredValue, 0, 3), 20, height - 20);

  float y = map(filteredValue, 0.0, 1.0, height * 0.5, 0); 

  fill(255);
  noStroke();
  ellipse(width, y, 15, 15);

  plotter.put(transformedValue);
  plotter.draw(0, 0, width, height);
  
  filteredPlotter.put(filteredValue);
  filteredPlotter.draw(0, 0, width, height);
  
  /* Send */
  OscMessage oscMessage = new OscMessage("/distance");
  oscMessage.add(filteredValue);
  oscP5.send(oscMessage);
}




void serialEvent(Serial myPort) {
  int inByte = myPort.read();

  if (inByte == '\n') {  // newline
    rawValue = int(trim(serialBuffer));
    serialBuffer = "";
  } else {
    serialBuffer += (char)inByte;
  }
}

