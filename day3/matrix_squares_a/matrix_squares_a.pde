void setup() {
  size(600, 600);
  smooth();
}

void draw() {
  background(53);

  stroke(255, 69, 0);
  noFill();
  
  for (int i = 0; i < 50; i++) {   // zeile
    rect(0, 0, 50, 50); // rechteck
    translate(20, 0);  // pro schritt 20 nach rechts
  }
}

