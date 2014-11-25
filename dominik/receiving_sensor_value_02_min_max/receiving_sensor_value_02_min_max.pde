/**
 * Receives the sensor value sent over network.
 * The current value will be stored in sensorValue.
 * This also keeps track of the minimum and maximum values.
 *
 * This sketch needs the OscP5 library:
 * http://www.sojamo.de/libraries/oscP5/
 * 
 * Press any key to reset the min and max values.
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;  // Receiver

float sensorValue = 0.5;
float prevSensorValue = 0.5;

float minValue = 1.0;
float maxValue = 0.0;

PFont font;


void setup() {
  size(400, 400);
  frameRate(60);

  font = loadFont("Futura-Medium-14.vlw");

  oscP5 = new OscP5(this, "239.0.0.1", 7777);  // Sets up the receiver...
}


void draw() {
  background(52);

  minValue = min(sensorValue, minValue);
  maxValue = max(sensorValue, maxValue);

  float diameter = map(sensorValue, 0.0, 1.0, 20, width);
  float diameterMin = map(minValue, 0.0, 1.0, 20, width);
  float diameterMax = map(maxValue, 0.0, 1.0, 20, width);

  noStroke();
  fill(255);
  ellipse(width * 0.5, height * 0.5, diameter, diameter);

  stroke(255, 69, 0);
  noFill();
  ellipse(width * 0.5, height * 0.5, diameterMin, diameterMin);
  ellipse(width * 0.5, height * 0.5, diameterMax, diameterMax);

  textFont(font);
  text("Sensor Value: " + nf(sensorValue, 0, 3), 20, 40);
  text("Min: " + nf(minValue, 0, 3), 20, 60);
  text("Max: " + nf(maxValue, 0, 3), 20, 80);
}


void keyPressed() {
  minValue = 1.0;  // reset
  maxValue = 0.0;
}


/** 
 * Handles the incoming data from the network and stores the sensor value.
 * No need to change anything here below.
 */
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/light") && theOscMessage.checkTypetag("f")) {
    prevSensorValue = sensorValue;
    sensorValue = theOscMessage.get(0).floatValue();
  } 
  else {
    print("### Unknown an osc message.");
    print(" addrpattern: "+theOscMessage.addrPattern());
    println(" typetag: "+theOscMessage.typetag());
  }
}

