/*

 */

color darkRed = #b71c1c;
color lightRed = #ffebee;
color red = #fc0004;
color blue = #0100fc;

float triangleMaxLen = 700;
float startLen = 15;
color bgColor = color(0);
color startColor = red;
color endColor = blue;
float maxRotation = 120;
float stepSize = 1.75;

void setup() {
  size(800, 800);
  background(bgColor);
  stroke(255);
  //expandingTriangle(width / 2, height / 2, startLen, triangleMaxLen, lerpColor(color(255), red, .25) , blue);

  // Background
  expandingTriangle(width * 3 / 8, height * 3 / 8, startLen * .01, triangleMaxLen * .15, lightRed, blue);
  expandingTriangle(width * 5 / 8, height * 5 / 8, startLen * .01, triangleMaxLen * .15, lightRed, darkRed);

  expandingTriangle(width / 4, height / 4, startLen * .15, triangleMaxLen * .15, red, blue);

  expandingTriangle(width / 2, height / 2, startLen * .2, triangleMaxLen * .2, red, blue);

  expandingTriangle(width * 3 / 4, height * 3 / 4, startLen * .15, triangleMaxLen * .13, red, blue);

  println("done");
  save("Cawley-EdwardsAustin_RECURSION.png");
}

/**
 Draws a triangle around center x, y
 */
void eqTriangle(float x, float y, float len) {
  float halfLen = len / 2;
  float h = sqrt(3) * halfLen; // height
  float halfH = h / 2;

  triangle(
    x, y - halfH, // apex
    x + halfLen, y + halfH, // right
    x - halfLen, y + halfH // left
    );
}

void expandingTriangle(float x, float y, float len, float mL, color c, color eC) {
  // Expand
  // draw one triangle at center, then three more extending off corners
  if (len > mL) {
    return;
  }

  println("expanding!");

  color mixedColor = lerpColor(c, eC, len / mL);
  fill(mixedColor);
  eqTriangle(x, y, len);

  float halfLen = len / 2;
  float h = sqrt(3) * halfLen; // height
  float halfH = h / 2;
  float nextLen = len * stepSize;


  float rotation;
  // right
  rotation = maxRotation - random(-maxRotation, maxRotation);
  pushMatrix();
  rotate(radians(rotation));
  expandingTriangle(
    x + len, 
    y + h, 
    nextLen, 
    mL, 
    c, 
    eC
    );
  popMatrix();

  // left
  rotation = random(-maxRotation, maxRotation);
  pushMatrix();
  rotate(radians(rotation));
  expandingTriangle(
    x - len, 
    y + h, 
    nextLen, 
    mL, 
    c, 
    eC
    );
  popMatrix();

  // top
  rotation = random(-maxRotation, maxRotation);
  pushMatrix();
  rotate(radians(rotation));
  expandingTriangle(
    x, 
    y - h, 
    nextLen, 
    mL, 
    c, 
    eC
    );
  popMatrix();
}