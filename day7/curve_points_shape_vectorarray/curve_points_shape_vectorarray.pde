int dots = 20;

PVector[] points = new PVector[dots];

void setup() {
  size(600, 600);
}

void draw() {
  background(0);

  stroke(255);

  for (int i = 0; i < dots; i++) {
    float x = map(i, 0, dots-1, 0, width);
    float y = sin(i / float(dots) * TWO_PI) * 200 + height * 0.5;

    PVector vec = new PVector(x, y);
    points[i] = vec;
    
    ellipse(vec.x, vec.y, 20, 20);
  }

   stroke(255, 69, 0);
   for (int i = 0; i < dots; i++) {
     PVector vec = points[i];

     rect(vec.x, vec.y, 10, 10);
    }
}
