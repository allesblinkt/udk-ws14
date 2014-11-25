/**
 * Reads recorded sensor values from a a file and 
 * broadcasts them via multicast over the local network 
 * as an OSC message in the form of ->  /light 0.4334  <-
 *
 * Have a look in the *data* folder for more recorded signals 
 * of the pendulum.
 *
 * This sketch needs the OscP5 library:
 * http://www.sojamo.de/libraries/oscP5/
 */

import oscP5.*;
import netP5.*;
import processing.serial.*;

String fileToLoad = "stable_to_unstable.txt";

float values[];
int pointer = 0;

OscP5 oscP5;

SignalPlotter plotter;

PFont font;


void setup() {
  size(500, 500);

  frameRate(60);

  font = loadFont("Futura-Medium-14.vlw");

  oscP5 = new OscP5(this, "239.0.0.1", 7777);   // multicast

  plotter = new SignalPlotter(400);

  values = loadValues(fileToLoad);
}


void draw() {
  background(52);

  /* Read next value */
  pointer = (pointer + 1) % values.length;
  float readValue = values[pointer]; 
  
  /* Draw */
  textFont(font);

  text("Sending at " + nf(frameRate, 0, 2) + " Hz", 20, height - 80);
  text("Stored Sensor Value: " + nf(readValue, 0, 3), 20, height - 20);

  float y = map(readValue, 0.0, 1.0, height * 0.5, 0); 

  fill(255);
  noStroke();
  ellipse(width, y, 15, 15);

  plotter.put(readValue);
  plotter.draw(0, 0, width, height);

  /* Send */
  OscMessage oscMessage = new OscMessage("/light");
  oscMessage.add(readValue);
  oscP5.send(oscMessage);
}



/** Loads values from a file and returns the array of values */
float[] loadValues(String theFileName) {
  String lines[] = loadStrings(theFileName);
  
  println("Read " + lines.length + " values");
  
  float loadedValues[] = new float[lines.length];
  
  for (int i = 0; i < lines.length; i++) {
    String line = lines[i];
    
    float value = float(line.trim());
    loadedValues[i] = value;
  }
  
  return loadedValues;
}
