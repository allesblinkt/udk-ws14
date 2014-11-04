void setup() {
  size(600, 600);
  smooth();
}

void draw() {
  background(255);

  stroke(255, 69, 0);
  noFill();

  rectMode(CENTER);

  for (int i = 0; i < 25; i++) {   // zeilen
    translate(0, 40);  // pro zeile 40 nach unten

    pushMatrix();   // matrix vor elementen der Zeile speichern
    
    for (int j = 0; j < 25; j++) {  // schritte in der zeile
      float angleStep = map(mouseX, 0, width, 0, 90);    // X position der Maus variiert den Winkel zwischen 0 und 90 grad
      float angle = j * radians(angleStep);

      pushMatrix();   // matrix vor Rotation speichern
      rotate(angle); 

      rect(0, 0, 50, 50); // rechteck
      popMatrix();   // matrix vor Rotation wiederherstellen

      translate(40, 0);  // pro schritt in zeile 40 nach rechts
    }
    
    popMatrix();    // matrix vor elementen der Zeile wiederherstellen
  }
}

