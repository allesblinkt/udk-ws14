int dots = 20;

void setup() {
  size(600, 600);
}

void draw() {
  background(0);

  stroke(255);
  noFill();

  beginShape();
  vertex(100, 100);
  vertex(200, 400);
  vertex(mouseX, mouseY);
  vertex(500, 400);
  endShape(CLOSE);
 
}
