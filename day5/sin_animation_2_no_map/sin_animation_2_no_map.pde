void setup() {
  size(600, 600); 
  smooth();
}


void draw() {
  background(50);
  noStroke();

  translate(width * 0.5, height * 0.5);

  fill(255, 69, 0);
  ellipse(0, 0, 20, 20);

  fill(255);
  
  float time = millis() / 1000.0;

  ellipse(cos(time * TWO_PI * 1.5) * 100.0 + 100.0, 0, 50, 50);
  ellipse(-cos(time * TWO_PI * 1.0) * 100.0 - 100.0, 0, 50, 50);
}

