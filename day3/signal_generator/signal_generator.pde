void setup() {  
  size(500, 500); 
  smooth();
}

void draw() {
  background(255);
  
  fill(255, 69,  0);
  noStroke();
  
  float time = millis() / 1000.0;   // from milliseconds to seconds
    
  // Change here for example sineWave to squareWave for a different signal...
  float signal = sineWave(time, 1.5);  // 1.5 Hertz. Signal is between -1, +1
  // Change end

  float y = map(signal, -1, 1, 0, height);
  ellipse(width * 0.5, y, 20, 20);
}

/** A sine wave. Time is in seconds, frequency in hertz */ 
float sineWave(float time, float frequency) {
  return sin(time * TWO_PI * frequency); 
}

/** A triangle wave. Time is in seconds, frequency in hertz */ 
float triangleWave(float time, float frequency) {
  float period = (1.0 / frequency);
  return abs((time % period) - 0.5 * period) * frequency * 4.0 - 1.0;
}

/** A sawtooth wave. Time is in seconds, frequency in hertz */ 
float sawtoothWave(float time, float frequency) {
  float p = time * frequency;
  return (p % 1.0) * 2.0 - 1.0;
}

/** A square wave. Time is in seconds, frequency in hertz */ 
float squareWave(float time, float frequency) {  
  return signum(sin(time * TWO_PI * frequency));
}

/** The sign of a value. Returns -1 for negative values, 0 for 0 and 1 for positive values */
float signum(float value) {
  if (value == 0.0) return 0;
  else if (value > 0.0) return 1;
  else return -1;
}
