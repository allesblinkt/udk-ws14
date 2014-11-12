int gridCols = 30;  // Spalten
int gridRows = 30;  // Zeilen

float margin = 100;  // Rand
float influence = 100;   // Einflussbereich der Maus (Radius)

void setup() {
  size(600, 600);
}

void draw() {
  background(50);

  noStroke();
  fill(255);

  for (int r = 0; r < gridRows; r++) {   // Zeilen
    for (int c = 0; c < gridCols; c++) {   // Elemente der Zeile
      float x = map(r, 0, gridRows - 1, margin, width - margin);   // x Position
      float y = map(c, 0, gridCols - 1, margin, height - margin);   // y Position

      float distance = dist(mouseX, mouseY, x, y);

      if (distance < influence) {
        float shiftX = mouseX - x;
        float shiftY = mouseY - y;
        
        float strength = map(distance, 0, influence,  1.0, 0.0);
        
        ellipse(x - shiftX * strength, y - shiftY * strength, 3, 3);
      } else {
        ellipse(x, y, 3, 3);
      }
    }
  }

  noFill();
  stroke(100);  
  ellipse(mouseX, mouseY, influence * 2.0, influence * 2.0);

  noStroke();
  fill(255, 69, 0);
  ellipse(mouseX, mouseY, 5, 5);
}

