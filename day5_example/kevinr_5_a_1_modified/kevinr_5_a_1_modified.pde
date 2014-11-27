int gridCols = 50;  // Spalten
int gridRows = 50;  // Zeilen

float margin = 10;  // Rand
float influence = 400;   // Einflussbereich der Maus (Radius)


void setup() {
  size(600, 600);
  smooth();
}

void draw() {
  background(50);
  float time = millis() / 1000.0;

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

        x = x + deltaX * strength * sineWave(time, 2.0) * -2.0;  // Um die Stärke der Verschiebung in Richtung verschieben...
        y = y + deltaY * strength * sineWave(time, 0.3) * -3.0;  // Unbedingt ander Faktoren versuchen. z.B. -2.0 statt 1.0 

        //fill(255, 0, 0);
      }

      ellipse(x, y, 5, 5);
      fill(255);
    }
  }

  noFill();
  stroke(60);  
  ellipse(mouseX, mouseY, influence * 2.0, influence * 2.0);

  noStroke();
  fill(255, 69, 0);
  ellipse(mouseX, mouseY, 15, 15);
}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      influence = influence + 10;
    }

    if (keyCode == DOWN) {
      influence = influence - 10;
      influence = max(influence, 0);
    }
  }
}

