import java.awt.Point;
import java.awt.Robot;
import java.awt.MouseInfo;

Robot robot;  // robot to move the mouse
float mouseDeltaX = 0.0;  // mouse change in X
float mouseDeltaY = 0.0;  // mouse change in Y

float rotationY = 0.0;
float rotationX = 0.0;


void setup() {
  size(600, 600, P3D);
  noCursor();    // hide the actual cursor

  initializeRobot();
}


void draw() {
  doTheMouseStuff();

  background(200);

  fill(0);
  text("delta x:" + mouseDeltaX, 10, 20);
  text("delta y:" + mouseDeltaY, 10, 40);

  noFill();
  stroke(0);
  translate(width * 0.5, height * 0.5);

  rotationX = rotationX - mouseDeltaY * 0.001;
  rotationY = rotationY + mouseDeltaX * 0.001;

  rotate(rotationX);
  rotateY(rotationY);

  sphere(100);
}


/** Makes the robot which can move the mouse */
void initializeRobot() {
  try { 
    robot = new Robot();
  }
  catch(Throwable e) {
    die("Could not make robot");
  }
}


/** Move the mouse to the center and measure */
void doTheMouseStuff() {
  /* Where is the sketch and its center? */
  Point canvasLoc = this.getLocationOnScreen();  
  Point centerLoc = new Point(canvasLoc.x + width / 2, canvasLoc.y + height / 2);
  
  /* Where is the mouse */
  Point mouseLoc = MouseInfo.getPointerInfo().getLocation();
  
  /* Measure how far the mouse is from the center */
  mouseDeltaX = mouseLoc.x - centerLoc.x;
  mouseDeltaY = mouseLoc.y - centerLoc.y;

  /* Move the mouse pointer to the center of the sketch */
  robot.mouseMove(centerLoc.x, centerLoc.y); 
}
