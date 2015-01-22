/**
 * Receive two simple values sent via OSC from another sketch running 
 * on the same machine (sender)
 * This needs the OscP5 library
 */

import oscP5.*;  // import library
import netP5.*;  

OscP5 oscP5;

int remoteMouseX = 0;
int remoteMouseY = 0;
float brightness = 0;

void setup() {
  size(400, 400);
  frameRate(25);

  oscP5 = new OscP5(this, 12001);   // listen for OSC on port 12001
  
  /* Register (plug) messages, so OscP5 calls those functions with *magic* */
  oscP5.plug(this, "mouseMessage", "/mouse");  // messages with name mouse will call mouseMessage
  oscP5.plug(this, "brightnessMessage", "/brightness");
}

void draw() {
  background(brightness * 255.0); 
  
  fill(255);
  text("Receiver", 20, 30);
  
  fill(255);
  noStroke();
  ellipse(remoteMouseX, remoteMouseY, 20, 20);
}

/** 
 * Will be called by OscP5 when there is a message /mouse 
 * with two ints
 */
void mouseMessage(int x, int y) {
  //println("I received a mouse message! Wooohooo! " + x + " " + y);
  
  remoteMouseX = x;
  remoteMouseY = y;
}

/** 
 * Will be called by OscP5 when there is a message /brightness 
 * with one float 
 */
void brightnessMessage(float b) {
  //println("Brightness: " + b);
  
  brightness = b;
}

/**
 * Uncomment below to see all messages and their types 
 * received 
 */
void oscEvent(OscMessage message) {
  // print("Received osc message: ");
  // print(message.addrPattern());
  // print(" typetag: ");
  // println(message.typetag());
}
