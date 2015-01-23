import peasy.*;

PeasyCam cam;

int pointsAmount = 200; //Anzahl von Punkten
PVector[] pointsA = new PVector[pointsAmount];  // Kammer für alle Punkte wird bereitgestellt
PVector[] pointsB = new PVector[pointsAmount];  // Alle punkte

int index = 0;  // Momentaner Stand

PVector center;  // Mittelpunkt auf der x-Achse

float rad = 1000;  //größe des ausschwungs //breite der Laufbahn
float rad2 = 2000;
float angle = 0;  // aktueller Rotationswinkel
float angleStart = 0; // Startwinkel

void setup() {
  size(600, 600, P3D);
  
  cam = new PeasyCam(this, 400);
  //cam.setMinimumDistance(50);
  //cam.setMaximumDistance(1500);
  //cam.setYawRotationMode ();  //x/y-Rotation

  center = new PVector(0, 0, 0);

  angle = angleStart;

  // Berechnet mir erst mal alle Punkte die ich brauche
  for (int i = 0; i < pointsAmount; i++) { 
    pointsA[i] = new PVector(0, 0, 0); //
    pointsB[i] = new PVector(0, 0, 0); //
  }
}

void draw() {
  background(0);
   
  // Verändern der Kurve
  angle += 0.02;
  rad += 0.01;  // abstand vergrößer verkleiner-bar // höhe //0.1
  rad2 -= 0.01;

  // Berechnung der aktuellen Position
  float x1 = center.x + cos(angle) * rad;
  float y1 = center.y + sin(angle-rad) * rad;
  float z1 = center.z + sin(angle) * rad;

  float x2 = center.x - cos(angle) * rad2;
  float y2 = center.y - sin(angle-rad2) * rad2;
  float z2 = center.z - sin(angle) * rad2;

  PVector vec1 = new PVector(x1, y1, z1); 
  PVector vec2 = new PVector(x2, y2, z2);

  pointsA[index] = vec1;  // index-zahlen in array "points" entspricht vec1
  pointsB[index] = vec2; 

  lights();

  fill(255);
  noStroke();

  /* Draw bottom shape */
  beginShape(QUADS); //zeichne von A zu B zu C 

  for (int i = 0; i < pointsAmount - 1; i++) { //und mach das immer wieder
    int indexThis = (i + index + 1) % pointsAmount;
    int indexNext = (i + index + 1 + 1) % pointsAmount;

    PVector vecA = pointsA[indexThis];  
    PVector vecB = pointsA[indexNext];  
    PVector vecC = pointsB[indexNext];  
    PVector vecD = pointsB[indexThis];  

    fill(0, 0, 255);
    vertex(vecA.x, vecA.y, vecA.z); 
        
    fill(255, 0, 0);
    vertex(vecB.x, vecB.y, vecB.z);
    vertex(vecC.x, vecC.y, vecC.z);
    
    fill(0, 0, 255);
    vertex(vecD.x, vecD.y, vecD.z);
  }

  endShape(); //schließe diese Formen

  index = index + 1;  // immer +1 dot ist der vector der gezeichnet wird

  if (index >= pointsAmount) { //wenn der index auf pointsAmount angekommen/ größer ist
    index = 0; //setzt die Startposition wieder auf 0..und fange von vorne an
  }
}
