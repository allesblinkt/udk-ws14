/**
  * Reads recorded sensor values from a a file and loops
  * through them. 
  * The current value will be stored in sensorValue.
  * Have a look in the *data* folder for more recorded signals 
  * of the pendulum.
  */
  
String fileToLoad = "stable_to_unstable.txt";

float sensorValue = 0.5;
float prevSensorValue = 0.5;

PFont font;

float values[];
int pointer = 0;


void setup() {
  size(400, 400);
  frameRate(60);
  
  font = loadFont("Futura-Medium-14.vlw");

  values = loadValues(fileToLoad);
}


void draw() {
  background(52);
  
  prevSensorValue = sensorValue;
  
  pointer = (pointer + 1) % values.length;
  sensorValue = values[pointer];
  
  float diameter = map(sensorValue, 0.0, 1.0, 20, width);
  
  noStroke();
  fill(255);
  
  ellipse(width * 0.5, height * 0.5, diameter, diameter);
  
  textFont(font);
  text("Sensor Value: " + nf(sensorValue, 0, 3), 20, 40);
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
