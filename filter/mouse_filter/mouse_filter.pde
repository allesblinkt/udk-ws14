/**
 * Filter the mouse coordinates with a low-pass filter, to
 * make them very smooth and slow
 */

float filteredX = 0.0;
float filteredY = 0.0;


void setup() {
  size(600, 600);
}


void draw() {
  background(0);

  noStroke();

  float strength = 0.9;  // strength of the filter (0.0 = no effect, 0.999 = super smooth)

  filteredX = (strength * filteredX) + (1.0 - strength) * mouseX;
  filteredY = (strength * filteredY) + (1.0 - strength) * mouseY;

  fill(128);
  ellipse(mouseX, mouseY, 30, 30);

  fill(255);
  ellipse(filteredX, filteredY, 50, 50);
}
