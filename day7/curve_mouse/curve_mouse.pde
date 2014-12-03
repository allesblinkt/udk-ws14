int dots = 200;
 
float[] xs = new float[dots];
float[] ys = new float[dots];

int index = 0;

void setup() {
  size(600, 600);
}

void draw() {
  background(0);

  noFill();

  stroke(255);  

  beginShape();
  for (int i = 0; i < dots; i++) {
    vertex(xs[i], ys[i]);
  }
  endShape();
  
  
  if (index >= dots) {
    index = 0;
  }
  
  xs[index] = mouseX;
  ys[index] = mouseY;
  
  index++;
  
}
