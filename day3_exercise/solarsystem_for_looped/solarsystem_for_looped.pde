


void setup() {
  size(600, 600);
  smooth();
}


void draw() {
  
  float earthX = 0.0;
  float earthY = 0.0;
  
  background(53);
  noStroke();

  float time = millis() / 1000.0;

  pushMatrix();    // MAUS Anfang
  translate(mouseX, mouseY);

  fill(0);
  ellipse(0, 0, 50, 50);   // here comes the sun


  for (int i = 0; i < 4; i++) {
    pushMatrix();   // ERDE Anfang

    float speedFactor = 1.0 + i * 0.4;

    //rotate( radians(time * 360.0 / 5.0) + radians(i * 20) );   // Kosmische Raupe
    rotate( radians(time * 360.0 / 5.0  * speedFactor ));   // Drehung Erde alle 5 Sekungen
    translate(70 + i * 30, 0);
    
    earthX = screenX(0, 0);
    earthY =screenY(0, 0);
    
    

    fill(0, 0, 255);
    ellipse(0, 0, 10 + i * 10, 10 + i * 10);  // here comes the earth

    rotate(radians(time * 360.0 * 1.0));   // Drehung alle halbe Sekunde
    translate(20, 0);

    fill(128);
    ellipse(0, 0, 5, 5);   // look at the moon

    popMatrix();   // ERDE Ende
  }








  /* Erde */
  pushMatrix();   // MARS Anfang

  rotate(radians(time * 360.0 * 0.5));
  translate(100, 0);

  fill(255, 69, 0);
  ellipse(0, 0, 10, 10);    // mars!

  popMatrix();   // MARS Ende


  popMatrix();   // MAUS Ende

  fill(255);
  text("[insert cool name]", 20, 50);
  text(nf(time, 0, 2), 20, 70);
  
  stroke(255);
  
  line(mouseX, mouseY,  earthX, earthY);
}

