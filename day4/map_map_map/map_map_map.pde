void setup() {
  size(600, 600);
}


void draw() {
  background(52);

  fill(255);
  noStroke();

  float x = map(mouseX, 0, width, 400, 200);
  ellipse(x, width * 0.5, 50, 50);

  float brightness = map(mouseY, 0, height, 255, 0);
  fill(brightness);  
  rect(0, 400, width, 200);
}

