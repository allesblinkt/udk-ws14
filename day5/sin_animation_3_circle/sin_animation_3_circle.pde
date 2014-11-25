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

  float x = cos(time * TWO_PI * 0.5) * 150.0;
  float y = sin(time * TWO_PI * 0.5) * 150.0;

  ellipse(x, y, 5, 5);
}

