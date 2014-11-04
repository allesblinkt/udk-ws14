void setup() {
  size(600, 600);
  smooth();
}


void draw() {
  background(255);

  stroke(255, 69, 0);
  noFill();
  
  translate(0, 60);    // alles 60 nach unten...
  rectMode(CENTER);

  for (int i = 0; i < 50; i++) {   // zeile
    float angle = i * radians(20);
   
    pushMatrix();   // matrix vor Rotation speichern
    rotate(angle); 
  
    rect(0, 0, 50, 50); // rechteck
    popMatrix();   // matrix vor Rotation wiederherstellen
    
    translate(20, 0);  // pro schritt 20 nach rechts
  }
}

