/** A Lissajous generator, but this time static. 
  * The x and y frequencies can be changed by moving the mouse.
  * The phase shift between the two signals can be changed with the up and down keys. */

PFont font;

int resolution = 1000;
float phaseShift = HALF_PI;

void setup() {
  size(600, 600);

  font = loadFont("Futura-Medium-14.vlw");
}

void draw() {
  background(23);

  float frequencyX = map(mouseX, 0, width, 0.2, 1.0);
  float frequencyY = map(mouseY, 0, height, 0.2, 1.0);

  noFill();
  stroke(200);

  beginShape();
  for (int i = 0; i < resolution; i++) {
    float t = map(i, 0, resolution, 0, 10.0);  // not the real time, but synthesized
    float valueX = sineWave(t, frequencyX);   // try different signals!
    float valueY = sineWave(t, frequencyY, phaseShift);

    float x = map(valueX, -1, 1, 20, width - 20);
    float y = map(valueY, -1, 1, 20, height - 20);

    vertex(x, y);
  }

  endShape();

  noStroke();
  fill(200);
  textFont(font);

  text("Frequency X: " + nf(frequencyX, 0, 2) + " Hz", 20, 30);
  text("Frequency Y: " + nf(frequencyY, 0, 2) + " Hz", 20, 50);
  text("Phase Shift: " + nf(phaseShift / PI, 0, 2) + " PI", 20, 70);
}

void keyPressed() {
  if (key == CODED && keyCode == UP) {
    phaseShift = phaseShift + 0.01 * PI;
  } 

  if (key == CODED && keyCode == DOWN) {
    phaseShift = phaseShift - 0.01 * PI;
  } 

  if (key == ' ') {
    phaseShift = HALF_PI;
  }
}

