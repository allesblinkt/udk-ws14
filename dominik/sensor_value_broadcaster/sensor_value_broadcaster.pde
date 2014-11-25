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

OscP5 oscP5;

SignalPlotter plotter;

PFont font;


void setup() {
  size(500, 500);

  frameRate(60);

  font = loadFont("Futura-Medium-14.vlw");

  println(Serial.list());
  String portName = Serial.list()[5];  // you might need to use a different port...
  println("Chosen port: " + portName);
  serial = new Serial(this, portName, 115200);

  oscP5 = new OscP5(this, "239.0.0.1", 7777);   // multicast

  plotter = new SignalPlotter(600);
}


void draw() {
  background(52);

  /* Receive */
  if (serial.available() > 0) {
    byte[] bytes = serial.readBytesUntil('\n');  // read until new line

    if (bytes != null && bytes.length > 0) {  // if there's data, convert it
      String numberString = new String(bytes);

      rawValue = int(numberString.trim());  // get rid of whitespace characters and parse number
    }
  }

  float transformedValue = constrain(map(rawValue, 900, 400, 0.0, 1.0), 0.0, 1.0);

  /* Draw */
  textFont(font);

  text("Sending at " + nf(frameRate, 0, 2) + " Hz", 20, height - 80);
  text("Raw Sensor Value: " + rawValue, 20, height - 40);
  text("Transformed Sensor Value: " + nf(transformedValue, 0, 3), 20, height - 20);

  float y = map(transformedValue, 0.0, 1.0, height * 0.5, 0); 

  fill(255);
  noStroke();
  ellipse(width, y, 15, 15);

  plotter.put(transformedValue);
  plotter.draw(0, 0, width, height);

  /* Send */
  OscMessage oscMessage = new OscMessage("/light");
  oscMessage.add(transformedValue);
  oscP5.send(oscMessage);
}

