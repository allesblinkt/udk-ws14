/** Takes some signal and displays it on a running plot */

float storage[] = new float[100];
int pointer = 0;

void setup() {
  size(600, 300);
  frameRate(60);
}

void draw() {
  background(23);
 
  float time = millis() / 1000.0;  // to seconds
  float currentValue = sawtoothWave(time, 2);
  
  pointer = (pointer + 1) % storage.length;  // what's the next slot?
  storage[pointer] = currentValue;  // store
 
  noFill();
  stroke(255);
  
  beginShape();
  for (int i = 0; i < storage.length; i++) {
    int index = (i + pointer + 1) % storage.length;  // start at the current and wrap around...
    float value = storage[index];
    float x = map(i, 0, storage.length - 1, 0, width);
    float y = map(value, -1, 1, height - 20, 20);

    vertex(x, y);
  }
  endShape();
}

