import peasy.*;

PeasyCam cam;

WaterColumnSolver water;

int R_SIZE = 50;
int C_SIZE = 50;

void setup() {

  size(600, 600, P3D);
  water = new WaterColumnSolver(R_SIZE, C_SIZE, 100);

  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);  
}


void draw() {
  background(52);
  
  float deltaTime = 1.0f / frameRate;   // multiply to make it faster!

  /* interaction */
  int mouseC = (int) (mouseX / (float) width * C_SIZE);
  int mouseR = (int) (mouseY / (float) height * R_SIZE);
  
  water.applyForce(mouseC, mouseR, 500.0f, deltaTime);
  
  float addedVolume = 1000.0f * deltaTime;
  if (keyPressed) {
    if (key == '+') {
      water.addVolume(mouseR, mouseC, addedVolume);
    }
    if (key == '-') {
      water.addVolume(mouseR, mouseC, -addedVolume);
    }
  }


  /* step */
  water.step(deltaTime, 20);

  float[][] volumes = water.volumemap();

  noStroke();
  fill(255);

  for (int r = 0; r < R_SIZE; r++) {
    for (int c = 0; c < C_SIZE; c++) {

      pushMatrix();
      float x = map(r, 0, R_SIZE - 1, -100, 100);
      float y = map(c, 0, C_SIZE - 1, -100, 100);
      float z = volumes[r][c] * 10.0;

      translate(x, y, z);
      rect(0, 0, 2, 2);

      popMatrix();
    }
  }
}
