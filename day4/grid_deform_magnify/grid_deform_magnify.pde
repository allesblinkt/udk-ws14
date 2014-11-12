int gridCols = 50;  // Spalten
int gridRows = 50;  // Zeilen

float margin = 40;  // Rand
float influence = 100;   // Einflussbereich der Maus (Radius)

void setup() {
  size(600, 600);
  smooth();
}

void draw() {
  background(50);

  noStroke();
  fill(255);


  for (int r = 0; r < gridRows; r++) {   // Zeilen
    for (int c = 0; c < gridCols; c++) {   // Elemente der Zeile
      float x = map(c, 0, gridCols - 1, margin, width - margin);   // x Position
      float y = map(r, 0, gridRows - 1, margin, height - margin);   // y Position

      float distance = dist(mouseX, mouseY, x, y);    // Abstand Maus Punkt

      if (distance < influence) {   // Wenn im Bereich der Maus, dann Verschiebung
        float strength = map(distance, 0, influence, 1.0, 0.0);    // stärke der Verschiebung
        
         float deltaX = x - mouseX;   // Unterschied Maus - Punkt = Richtung
         float deltaY = y - mouseY;
         
         x = x + deltaX * strength * 1.0;  // Um die Stärke der Verschiebung in Richtung verschieben...
         y = y + deltaY * strength * 1.0;  // Unbedingt ander Faktoren versuchen. z.B. -2.0 statt 1.0 
      }

      ellipse(x, y, 5, 5);
    }
  }

  noFill();
  stroke(60);  
  ellipse(mouseX, mouseY, influence * 2.0, influence * 2.0);

  noStroke();
  fill(255, 69, 0);
  ellipse(mouseX, mouseY, 5, 5);
}

