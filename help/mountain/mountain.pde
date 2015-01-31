import peasy.*;
import processing.serial.*;

PeasyCam cam;
Serial serial;

float dimension = 200;   // side lenght of the flat surface
float maxHeight = 300;   // how high when the sensor is at maximum

int noiseSeed = 0;

PImage textureImage;

int segmentsPerLine = 100;   // How many segments per line do we calculate?
int lines = 40;    // How many lines behind each other?

int rawValue = 0;

PVector grid[][];


void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);

  textureImage = loadImage("rock.png");   // Load texture
  
  /* Open Serial port, uncomment and change settings... */
  //println(Serial.list());
  //String portName = Serial.list()[7];  // you might need to use a different port...
  //println("Chosen port: " + portName);
  //serial = new Serial(this, portName, 115200);

  grid = new PVector[lines][segmentsPerLine];    // 2 dimensional array to store calculated points
}


void draw() {
  background(255);

  /* Receive Serial data from sensor. Uncomment to use again... */
  // if (serial.available() > 0) {
  //   byte[] bytes = serial.readBytesUntil('\n');  // read until new line

  //   if (bytes != null && bytes.length > 0) {  // if there's data, convert it
  //     String numberString = new String(bytes);

  //     rawValue = int(numberString.trim());  // get rid of whitespace characters and parse number
  //     rawValue = int(map(rawValue, 1024, 0, 0, 1024));
  //   }
  // }

  rawValue = int(map(mouseX, 0, width, 0, 1024));   // just simulating sensor input with the mouse
  float normalizedValue = map(rawValue, 0, 1024, 0.0, 1.0);  // Wert von 0 - 1



  stroke(255);
  noFill();
  noiseSeed(noiseSeed);


  /* Calculate the points (and draw lines as we had before) */
  for (int r = 0; r < lines; r++) {   
    beginShape();
    stroke(255, 255, 255, 40);

    float rowP = map(r, 0, lines - 1, 0.0, 1.0);  // 0.0 for left, 1.0 for right...
    float z = map(r, 0, lines - 1, -dimension, dimension);

    float depthEnvelope = cos(rowP * TWO_PI ) * -0.5 + 0.5;  // bell shaped falloff  (0.0 -> 1.0 -> 0.0)

    for (int c = 0; c < segmentsPerLine; c++) {
      float lineP = map(c, 0, segmentsPerLine - 1, 0.0, 1.0);  // 0.0 for left, 1.0 for right...
      float lineEnvelope = cos(lineP * TWO_PI ) * -0.5 + 0.5;  // bell shaped falloff  (0.0 -> 1.0 -> 0.0) 

      float noiseU = (lineP - 0.5) * 10.0 * normalizedValue + 100;  // "where" are we in the noise function
      float noiseV =  10 * (rowP -0.5) * normalizedValue + 100;
      
      float x = map(c, 0, segmentsPerLine - 1, -dimension, dimension);
      float y = noise(noiseU, noiseV) * normalizedValue * maxHeight;  

      y = depthEnvelope * lineEnvelope * y * -1;  // apply envelope to y

      vertex(x, y, z);

      grid[r][c] = new PVector(x, y, z);
    }

    endShape();
  }


  /* Loop through all grid points and draw little quads with texture */
  noStroke();
  fill(200);
  lights();

  textureMode(NORMAL);
  beginShape(QUADS);

  texture(textureImage);

  for (int r = 0; r < lines - 1; r++) {   // Zeilen
    for (int c = 0; c < segmentsPerLine - 1; c++) {   // Elemente der Zeile

      float u = map(r, 0.0, lines - 1, 0.0, 1.0);   // texture coordinate horizontal
      float uNext = map(r + 1, 0.0, lines - 1, 0.0, 1.0);   // next texture coordinate

      float v = map(c, 0.0, segmentsPerLine - 1, 0.0, 1.0);   // texture coordinate vertical
      float vNext = map(c + 1, 0.0, segmentsPerLine - 1, 0.0, 1.0);   // next texture coordinate vertical

      PVector vecA = grid[r][c];
      PVector vecB = grid[r+1][c];
      PVector vecC = grid[r+1][c+1];
      PVector vecD = grid[r][c+1];

      vertex(vecA.x, vecA.y, vecA.z,   u, v);
      vertex(vecB.x, vecB.y, vecB.z,   uNext, v);
      vertex(vecC.x, vecC.y, vecC.z,   uNext, vNext);
      vertex(vecD.x, vecD.y, vecD.z,   u, vNext);
    }
  }
  endShape();
}


void keyPressed() {
   noiseSeed = millis();   // use a different noise every time we press a key...
}
