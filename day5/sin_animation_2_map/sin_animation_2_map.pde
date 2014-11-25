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

  float x1 = map(cos(time * TWO_PI * 1.5), -1.0, 1.0, 0.0, 200.0);
  ellipse(x1, 0, 50, 50);

  float x2 = map(cos(time * TWO_PI * 1.0), -1.0, 1.0, -200.0, 0.0);  
  ellipse(x2, 0, 50, 50);
}

