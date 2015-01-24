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

  for (int i = 0; i < dots; i++) {
    points[i] = new PVector(0, 0, 0);
  }
}

void draw() {
  background(0);

  PVector vec = new PVector(mouseX, mouseY, 0);
  points[index] = vec;
  index = index + 1;
  
  if (index >= dots) {
     index = 0; 
  }

  fill(255);
  noStroke();

  lights();

  PVector topVec = new PVector(0, 0, 200);

  /* Draw bottom shape */
  beginShape(TRIANGLES);

  for (int i = 0; i < dots - 1; i++) {
    PVector vecA = topVec;
    PVector vecB = points[i];
    PVector vecC = points[i+1];

    vertex(vecA.x, vecA.y, vecA.z);
    vertex(vecB.x, vecB.y, vecB.z);
    vertex(vecC.x, vecC.y, vecC.z);
  }
  endShape();
}
