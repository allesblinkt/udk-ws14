int gridCols = 30;  // Spalten
int gridRows = 30;  // Zeilen

float margin = 100;  // Rand
float influence = 50;   // Einflussbereich der Maus (Radius)

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
        float s = map(distance, 0, influence, 30, 5);      
        float transparency = map(distance, 0, influence,  0, 255);
        
        fill(255, transparency);
        ellipse(x, y, s, s);
      } else {
        fill(255);
        ellipse(x, y, 5, 5);
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

