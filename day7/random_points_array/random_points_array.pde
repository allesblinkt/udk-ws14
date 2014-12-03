int dots = 200;

void setup() {
  size(600, 600);
}

void draw() {
  background(0);

  noFill();

  stroke(255, 0, 0);
  randomSeed(20);
  
  float[] xs = new float[dots];
  float[] ys = new float[dots];

  for (int i = 0; i < 10; i++) {
    float x = random(0, width);
    float y = random(0, height);

    xs[i] = x;
    ys[i] = y;
    
    ellipse(x, y, 10, 10);
  }

  stroke(255);  

  beginShape();
  for (int i = 0; i < dots; i++) {
    vertex(xs[i], ys[i]);
  }
  endShape();
}
