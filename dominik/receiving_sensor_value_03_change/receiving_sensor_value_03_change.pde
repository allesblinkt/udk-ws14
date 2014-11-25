/**
 * Receives the sensor value sent over network.
 * The current value will be stored in sensorValue.
 * This also keeps calculates the change between current 
 * and previous sensor reading.
 *
 * This sketch needs the OscP5 library:
 * http://www.sojamo.de/libraries/oscP5/
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;  // Receiver

float sensorValue = 0.5;
float prevSensorValue = 0.5;

float change = 0.0;

PFont font;


void setup() {
  size(400, 400);
  frameRate(60);

  font = loadFont("Futura-Medium-14.vlw");

  oscP5 = new OscP5(this, "239.0.0.1", 7777);  // Sets up the receiver...
}


void draw() {
  background(52);

  change = sensorValue - prevSensorValue;

  float diameter = map(sensorValue, 0.0, 1.0, 20, width - 50);

  noStroke();
  fill(255);
  ellipse(width * 0.5, height * 0.5 - 25, diameter, diameter);

  float changeBarWidth = map(change, 0.0, 0.2, 0, width * 0.5);   // change is small
  rect(width * 0.5, height - 20,  changeBarWidth, 20);

  textFont(font);
  text("Sensor Value: " + nf(sensorValue, 0, 3), 20, 40);
  text("Change: " + nf(change, 0, 3), 20, 60);
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

