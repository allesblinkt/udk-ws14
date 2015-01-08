void setup() {
  size(600, 600);
}


void draw() {
  background(50);
  
  stroke(255);
  noFill();
  randomSeed(24);

  int segments = 200;
  beginShape();
  for (int i = 0; i < segments; i++) {
    float x = map(i, 0, segments - 1, 0, width);
    float p = map(i, 0, segments - 1, 0.0, 1.0);  // 0.0 for left, 1.0 for right...
    
    float y = noise(p * 30.0) * 200.0 + random(-10, 10);   // try changing the factor (30.0) in noise
    //float y = random(0, 200.0);   // alternative: pure randomness
    
    float envelope = cos(p * TWO_PI)* -0.5 + 0.5;  // bell shaped falloff  (0.0 -> 1.0 -> 0.0) 
    //float envelope = p;   // alternative: linear
    
    y = envelope * y;  // apply envelope
    y = height - y;   // from the bottom...
    
    vertex(x, y);
  }

  endShape();
}
