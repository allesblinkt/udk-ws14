import peasy.*;

PeasyCam cam;

void setup() {
  size(600, 600, P3D);
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
}

void draw() {
  background(50);

  lights();

  noStroke();
  fill(255);

  float time = millis() / 1000.0;
  box(50);
  translate(100, 50);
  rotateY(time * TWO_PI * 1.5);
  box(20);
}
