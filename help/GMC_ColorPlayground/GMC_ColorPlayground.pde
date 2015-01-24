/**
 * A little playground for color experiments...
 *
 */
import processing.video.*;
import java.awt.image.*;


Capture cam;

PFont font;

/* Those values determine where the region of interest (white box) is */
float regionX = 320;
float regionY = 240;
float regionW = 75;
float regionH = 75;


void setup() {
  size(1280, 480);

  font = loadFont("Futura-Medium-16.vlw");

  /* Start capture from default camera */
  cam = new Capture(this, 640, 480);
  cam.start();
}

void draw() {
  background(60);

  /* Get new camera image if there is one */
  if (cam.available() == true) {
    cam.read();
  }

  /* Draw camera image */
  image(cam, 0, 0);

  /* Draw region on top */
  rectMode(CENTER);
  noFill();
  stroke(255);
  rect(regionX, regionY, regionW, regionH);

  /* Get the region sub image and draw it */
  fill(255);
  textFont(font);
  text("Region", 700, 50);

  PImage regionImg = cam.get(int(regionX - regionW * 0.5), int(regionY - regionH * 0.5), int(regionW), int(regionH));
  image(regionImg, 700, 70);


  /* Average all colors of the region image and draw a little rectangle with that color */
  color averageColor = averageAllPixels(regionImg);

  fill(255);
  textFont(font);
  text("Average Color", 700, 320);

  rectMode(CORNER);
  fill(averageColor);
  noStroke();
  rect(700, 340, 100, 100);


  /* Draw bars for the RGB values */  
  fill(255);
  textFont(font);
  text("RGB Values", 900, 50);
  
  drawColorBar("R", red(averageColor), 900, 70);
  drawColorBar("G", green(averageColor), 900, 110);
  drawColorBar("B", blue(averageColor), 900, 150);


  /* Draw bars for the HSB values */  
  fill(255);
  textFont(font);
  text("HSB Values", 900, 250);

  drawColorBar("H", hue(averageColor), 900, 270);
  drawColorBar("S", saturation(averageColor), 900, 310);
  drawColorBar("B", brightness(averageColor), 900, 350);
}


/**
 * Draws a little bar to display a value... 
 * The value is expected to go from 0 to 255 (as for colors)
 */
void drawColorBar(String theName, float theValue, float theX, float theY) {
  float w = 200;
  float h = 200;

  rectMode(CORNER);
  fill(80);
  rect(theX, theY, w, 20);

  float valueW = map(theValue, 0, 255, 0, w);

  fill(255);
  rect(theX, theY, valueW, 20);
  
  fill(128);
  noStroke();
  textFont(font);
  text(theName, theX + 3, theY + 16);
  text(int(theValue) + " ", theX + 30, theY + 16);
}


/** 
 * Averages the colors of all pixels in an image and returns the average color.
 * This function is rather slow, so don't put too large images in 
 */
color averageAllPixels(PImage theImage) {
  theImage.loadPixels();

  float r = 0;
  float g = 0;
  float b = 0;

  for (int i = 0; i < theImage.pixels.length; i ++) {
    color pixelColor = theImage.pixels[i];
    
    r = r + red(pixelColor);
    g = g + green(pixelColor);
    b = b + blue(pixelColor);
  }

  r = r / theImage.pixels.length;
  g = g / theImage.pixels.length;
  b = b / theImage.pixels.length;

  return color(r, g, b);
}

