/** 
  * Look inside the signalFunctions tab to see the functions that 
  * generate the signals...
  */

void setup() {
  size(600, 600);
}

void draw() {
  background(50);
  
  stroke(128);
  line(width * 0.5, 0, width * 0.5, height);
  
  noStroke();
  fill(255);
  
  translate(width * 0.5, 0);   // x Ursprung in die Mitte
  
  float time = millis() / 1000.0;

  /* 1st */
  float x1 = map(sineWave(time, 0.2), -1.0, 1.0, -300.0, 300.0);
  ellipse(x1, 100.0, 50.0, 50.0);
  
  /* 2nd */
  float x2 = map(sineWave(time, 1.0), -1.0, 1.0, -300.0, 300.0);
  float size2 = map(triangleWave(time, 2.0), -1.0, 1.0, 10.0, 50.0);
  ellipse(x2, 200.0, size2, size2);
  
  /* 3rd */
  float x3 = map(triangleWave(time, 0.5), -1.0, 1.0, -250.0, 250.0);
  float size3 = map(sineWave(time, 4.0), -1.0, 1.0, 10.0, 50.0);
  ellipse(x3, 300.0, size3, size3);
  
  /* 4th */
  float x4 = map(sawtoothWave(time, 0.5), -1.0, 1.0, -200.0, 200.0);
  float size4 = map(squareWave(time, 4.0), -1.0, 1.0, 10.0, 50.0);
  ellipse(x4, 400.0, size4, size4);
  
  /* 5th */
  float x5 = map(sineWave(time, 0.55) * sineWave(time, 0.6), -1.0, 1.0, -200.0, 200.0);
  float brightness5 = map(sineWave(time, 0.1), -1.0, 1.0, 100.0, 255.0);
  fill(brightness5);
  ellipse(x5, 500.0, 40.0, 40.0);
}

