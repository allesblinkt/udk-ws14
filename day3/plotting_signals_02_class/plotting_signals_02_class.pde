/** Takes some signal and displays it on a running plot.
  * This version uses a class for the plotting, so this functionality can be reused... */

SignalPlotter plotter;

void setup() {
  size(600, 300);
  frameRate(60);
  
  plotter = new SignalPlotter(100);  // history of 100 values...
}

void draw() {
  background(23);
 
  float time = millis() / 1000.0;  // to seconds
  float currentValue = sawtoothWave(time, 2);
  
  plotter.put(currentValue);
  plotter.draw(0, 20, width, height - 40);
}

