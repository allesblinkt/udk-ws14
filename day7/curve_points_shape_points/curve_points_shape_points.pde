int dots = 20;


void setup() {
  size(600, 600);
}

void draw() {
  background(0);

  noFill();

  stroke(255);  
  beginShape();

  for (int i = 0; i < dots; i++) {
    float x = map(i, 0, dots-1, 0, width);
    float y = sin(i / float(dots) * TWO_PI) * 200 + height * 0.5;

    vertex(x, y);
  }

  endShape();
}
