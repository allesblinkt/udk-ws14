void setup() {
  size(600, 600);
  smooth();
}


void draw() {
  background(53);
  noStroke();
  
  float time = millis() / 1000.0;

  pushMatrix();    // MAUS Anfang
  translate(mouseX, mouseY);

  fill(0);
  ellipse(0, 0, 50, 50);   // here comes the sun
  
  pushMatrix();   // ERDE Anfang

  rotate( radians(time * 360.0 / 5.0) );   // Drehung Erde alle 5 Sekungen
  translate(70, 0);

  fill(255, 69, 0);
  ellipse(0, 0, 10, 10);  // here comes the earth
  
  rotate(radians(time * 360.0 * 1.0));   // Drehung alle halbe Sekunde
  translate(20, 0);
  
  fill(128);
  ellipse(0, 0, 5, 5);   // look at the moon

  popMatrix();   // ERDE Ende


  /* Erde */
  pushMatrix();   // MARS Anfang

  rotate(radians(time * 360.0 * 0.5));
  translate(100, 0);

  fill(255, 255, 0);
  ellipse(0, 0, 10, 10);    // mars!
  
  popMatrix();   // MARS Ende


  popMatrix();   // MAUS Ende

  fill(255);
  text("[insert cool name]", 20, 50);
  text(nf(time, 0,2) , 20, 70);
}
