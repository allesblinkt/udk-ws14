float filterX = 0.0;
float filterY = 0.0;


void setup() {
  size(600, 600);
}


void draw() {
  background(0);

  noStroke();

  float strength = 0.9;

  filterX = (strength * filterX) + (1.0 - strength) * mouseX;
  filterY = (strength * filterY) + (1.0 - strength) * mouseY;

  fill(128);
  ellipse(mouseX, mouseY, 30, 30);

  fill(255);
  ellipse(filterX, filterY, 50, 50);
}
