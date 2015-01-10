import peasy.*;
PeasyCam cam;


int dots = 100;

PVector[] points = new PVector[dots];

int index = 0;

void setup() {
  size(600, 600, P3D);
  
  cam = new PeasyCam(this, 400);
  
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1500);
}

void draw() {
  background(0);

  noFill();
  stroke(255);  


  if (index < dots) {
    PVector vec = new PVector(mouseX, mouseY, 0);
    points[index] = vec;

    index = index + 1;
  }

  beginShape();
  for (int i = 0; i < index; i++) {
    PVector vec = points[i];

    vertex(vec.x, vec.y);
  }
  endShape();
}
