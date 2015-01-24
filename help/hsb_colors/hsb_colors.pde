color myColor;   // hier aktueller Wert des Signals...

void setup() {
  size(600, 600);

  myColor = color(23, 69, 55);
}


void draw() {
  background(50);

  fill(myColor);
  noStroke();
  rect(50, 50, 100, 100);

  float hue = hue(myColor) / 255.0;
  float saturation = saturation(myColor) / 255.0;
  float brightness = brightness(myColor) / 255.0;

  fill(brightness * 255.0);
  rect(150, 150, 100, 100);
}
