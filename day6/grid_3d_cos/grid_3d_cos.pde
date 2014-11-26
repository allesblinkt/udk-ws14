import peasy.*;
PeasyCam cam;

int gridCols = 50;  // Spalten
int gridRows = 50;  // Zeilen


void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 400);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1500);
}

void draw() {
  background(50);
  lights();
  noStroke();
  fill(255);
  
  randomSeed(23);

  for (int r = 0; r < gridRows; r++) {   // Zeilen
    for (int c = 0; c < gridCols; c++) {   // Elemente der Zeile
      pushMatrix();
    
      float x = map(r, 0, gridRows - 1, -200, 200);   // x Position
      float y = map(c, 0, gridCols - 1, -200, 200);   // y Position
      float z = (cos(r / float(gridRows) * TWO_PI) + cos(c / float(gridCols) * TWO_PI * 1.5)) * 50.0;

      translate(x, y, z);
      box(2);
      
      popMatrix();
    }
  }
}

