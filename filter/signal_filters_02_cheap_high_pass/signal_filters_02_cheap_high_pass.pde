/** Applies a very simple high pass filter to the input signal.
  * Displays the raw signal and the filtered result. */

SignalPlotter plotterRaw;
SignalPlotter plotterFiltered;

float oldFilteredValue = 0;
float oldValue = 0;

void setup() {
  size(600, 300);
  frameRate(60);
  
  plotterRaw = new SignalPlotter(200); 
  plotterFiltered = new SignalPlotter(200); 
  plotterFiltered.strokeColor = color(255, 69, 0);  
}

void draw() {
  background(23);
 
  float time = millis() / 1000.0;  // to seconds
  float value = squareWave(time, 1.5);
  //float value = 0.5 * triangleWave(time, 15.0) + sineWave(time, 0.15);
  
  float strength = map(mouseX, 0, width, 0.0, 1.0); 
  float filteredValue = (1.0 - strength) * (oldFilteredValue + value - oldValue);
  oldFilteredValue = filteredValue;
  oldValue = value;
        
  plotterRaw.put(value);
  plotterFiltered.put(filteredValue);

  plotterRaw.draw(0, 0, width, height * 0.5 - 20);
  plotterFiltered.draw(0, height * 0.5, width, height * 0.5 - 20);
}

