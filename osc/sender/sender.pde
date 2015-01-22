/**
 * Send two simple values via OSC to another sketch running 
 * on the same machine (receiver)
 * This needs the OscP5 library
 */

import oscP5.*;  // import library
import netP5.*;  

OscP5 oscP5;  
NetAddress remoteLocation;  // stores the location of the receiver

void setup() {
  size(400, 400);
  frameRate(25);

  oscP5 = new OscP5(this, 12000);   // we listen on port 12000, but nobody will send something

  remoteLocation = new NetAddress("127.0.0.1", 12001);   // we send to port 12001 of our own machine 
}


void draw() {
  background(53);
  
  fill(255);
  text("Sender", 20, 30);

  /* Send mouse position as /mouse i i  (two ints) */
  OscMessage mouseMessage = new OscMessage("/mouse");
  mouseMessage.add(mouseX);
  mouseMessage.add(mouseY);
  oscP5.send(mouseMessage, remoteLocation);
  
  /* Send some value as a float */
  float brightness = map(mouseX, 0, width, 0, 1);
  OscMessage brightnessMessage = new OscMessage("/brightness");
  brightnessMessage.add(brightness); 
  oscP5.send(brightnessMessage, remoteLocation);
}
