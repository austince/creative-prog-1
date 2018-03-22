/**
 * Load and Display an OBJ Shape. 
 * 
 * The loadShape() command is used to read simple SVG (Scalable Vector Graphics)
 * files and OBJ (Object) files into a Processing sketch. This example loads an
 * OBJ file of a rocket and displays it to the screen. 
 */


PShape rocket;

float ry;
int dir = 1;

public void setup() {
  size(640, 360, P3D);

  rocket = loadShape("sailboat.obj");
  rocket.setStroke(true);
  rocket.setStroke(color(0));
  rocket.setStrokeWeight(1.1);
  rocket.setStrokeWeight(.5);
  //rocket.setFill(color(0));
  rocket.setFill(color(0, 0, 0, 0));
  rocket.scale(5);

  setupVirtualCamera();
}


public void setupVirtualCamera() {
  float cameraY = height/2.0;
  float fov = PI/2;
  float cameraZ = cameraY / tan(fov / 2.0);
  float aspect = float(width)/float(height);
  if (mousePressed) {
    aspect = aspect / 2.0;
  }
  perspective(fov, aspect, cameraZ/10.0, cameraZ*10.0);
}

public void draw() {
  background(255);
  if (!mousePressed) {

    lights();
  }
  fill(0);
  textSize(20);
  //text("" + dir, 40, height - 40);

  translate(width/2, height/2, -200);
  rotateZ(ry);
  rotateY(ry);
  //rotateZ(ry);
  rotateX(PI / 2);
  //rotateX(-PI);
  //rotateZ(PI);
  //rotateZ(degrees(15));
  //rotateX(-PI / 2  + degrees(45));
  //rotateX(degrees(15));

  //rotateY(ry);
  shape(rocket);


  if (degrees(ry) > 45) {
    dir *= -1;
  } else if (degrees(ry) < -45) {
    dir *= -1;
  }
  ry += dir * 0.02;
}

void keyPressed() {
  save("boat.png");
}