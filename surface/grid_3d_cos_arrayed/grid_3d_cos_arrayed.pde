import peasy.*;
PeasyCam cam;

int gridCols = 50;  // Spalten
int gridRows = 50;  // Zeilen

PVector[][] grid = new PVector[gridCols][gridRows];    // two-dimensional array to store all points

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

  randomSeed(23);

  /* Calculate and store points */
  for (int r = 0; r < gridRows; r++) {   // Zeilen
    for (int c = 0; c < gridCols; c++) {   // Elemente der Zeile

      float x = map(r, 0, gridRows - 1, -200, 200);   // x Position
      float y = map(c, 0, gridCols - 1, -200, 200);   // y Position
      float z = (cos(r / float(gridRows) * TWO_PI) + cos(c / float(gridCols) * TWO_PI * 1.5)) * 50.0;

      PVector vec = new PVector(x, y, z);

      grid[c][r] = vec;
    }
  }


  /* Draw surface with stored points */
  fill(255);

  beginShape(QUAD);

  for (int r = 0; r < gridRows - 1; r++) {   // Zeilen
    for (int c = 0; c < gridCols - 1; c++) {   // Elemente der Zeile
      PVector vecA = grid[c][r];
      PVector vecB = grid[c+1][r];
      PVector vecC = grid[c+1][r+1];
      PVector vecD = grid[c][r+1];

      vertex(vecA.x, vecA.y, vecA.z);
      vertex(vecB.x, vecB.y, vecB.z);
      vertex(vecC.x, vecC.y, vecC.z);
      vertex(vecD.x, vecD.y, vecD.z);
    }
  }

  endShape();
}
