/**
 * Reflection 
 * by Simon Greenwold. 
 * 
 * Vary the specular reflection component of a material
 * with the horizontal position of the mouse. 
 */

void setup() {
  size(640, 360, P3D);
  noStroke();
  fill(0.4);
}

void draw() {
  background(0);
  translate(width / 2, height / 2);
  
  lightSpecular(255, 255, 255);
  directionalLight(255, 0, 0,    1, 0, -1);
  
  float s = mouseX / float(width);
  
  fill(200);
  specular(255, 255, 255);
  shininess(10.0);

  sphere(120);
}
