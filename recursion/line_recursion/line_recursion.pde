/* //<>// //<>// //<>//
Author: Austin Cawley-Edwards
 */

// Some standard colors
color red = color(0, 0, 255);
color green = color(0, 255, 0);
color blue = color(255, 0, 0);
color white = color(255);
color black = color(0);

// Google colors cause I thought I might use them
color ggGreen = #3cba54;
color ggRed = #db3236;
color ggYellow = #f4c20d;
color ggBlue = #4885ed;

// Some starting colors
color startColor = white;
color bgColor = color(255, 255, 255, 120);
int alpha = (int) (.5 * 255);

float maxRotation = 25;

// Will increase "spread" the higher the max and smaller the distance
float minColorInc = 15;
float maxColorInc = 65;

// The parameters to describe the lines attrs
int lineSpaceBredth = 75;
int lineSpaceHeight = 50;
int lineLen = 50;

// The initial rotation of the system
float startRot = radians(10); 

// All colors that will stop a recursion
color[] stopColors = {
  blue, 
  red, 
  green, 
  black, 
};
// How close a color channel has to been
float stopColorThresh = 25;

void setup() {
  size(800, 800);
  background(bgColor);
  strokeWeight(2);
  for (color eC : stopColors) {
    println("End color: ", hex(eC));
  }

  // Add some alpha in there
  color startWithAlpha = color(red(startColor), blue(startColor), green(startColor), 255 * alpha);

  rotate(startRot);
  // Draw the seed line
  expandingLine(width / 2, height / 2, startWithAlpha);
  println("done");
  save("Cawley-Edwards_Austin_RECURSION.png");
}

/* Color comparitors */

boolean equal(color c1, color c2) {
  return compare(c1, c2, 0);
}

boolean compare(color c1, color c2, float threshold) {
  return abs(red(c1) - red(c2)) <= threshold 
    && abs(green(c1) - green(c2)) <= threshold
    && abs(blue(c1) - blue(c2)) <= threshold;
}

boolean compareRedBlue(color c1, color c2, float threshold) {
  return abs(red(c1) - red(c2)) <= threshold
    && abs(blue(c1) - blue(c2)) <= threshold;
}

boolean compareRedGreen(color c1, color c2, float threshold) {
  return abs(red(c1) - red(c2)) <= threshold 
    && abs(green(c1) - green(c2)) <= threshold;
}

boolean compareBlueGreen(color c1, color c2, float threshold) {
  return abs(green(c1) - green(c2)) <= threshold
    && abs(blue(c1) - blue(c2)) <= threshold;
}

boolean compareAnyTwo(color c1, color c2, float threshold) {
  return compareBlueGreen(c1, c2, threshold) 
  || compareRedGreen(c1, c2, threshold)
  || compareRedBlue(c1, c2, threshold);
}

/* Functions to modify color values */

color incrementBlue(color c) {
  color inc = color(0, 0, random(minColorInc, maxColorInc));
  return (blendColor(c, inc, SUBTRACT) & 0xffffff) | (alpha << 24);
}

color incrementRed(color c) {
  color inc = color(random(minColorInc, maxColorInc), 0, 0);
  return (blendColor(c, inc, SUBTRACT) & 0xffffff) | (alpha << 24);
}

color incrementGreen(color c) {
  color inc = color(0, random(minColorInc, maxColorInc), 0);
  return (blendColor(c, inc, SUBTRACT) & 0xffffff) | (alpha << 24);
}

color incrementColor(color c) {
  return incrementRed(incrementGreen(incrementBlue(c))); // lol what makes a tech kid laugh
}

/**
 plz help
 */
color incrementColorNah(color c) {
  // Get the r, b, g values using bitshift and decrement each randomly
  color incColor = color(0);

  for (int shift = 16; shift >= 0; shift -= 8) {
    int cCopy = c;
    int cVal = (cCopy >> shift) & 0xff;
    int dec = (int) random(0, maxColorInc);
    incColor = incColor | ((dec << shift) & 0xff);
    incColor = blendColor(c, incColor, SUBTRACT);
  }

  return incColor;
}

/*
Main recursive function
Uses color as a base case exit value
*/
void expandingLine(float x, float y, color c) {
  for (color eC : stopColors) {
    if (compareAnyTwo(c, eC, stopColorThresh)) {
      println("Done with: ", hex(c));
      return;
    }
  }

  float halfH = lineSpaceHeight / 2;
  float halfL = lineLen / 2;
  float halfW = lineSpaceBredth / 2;


  // draw the main line
  stroke(c);
  float rot;
  rot = radians(random(-maxRotation, maxRotation));
  translate(x, y);
  rotate(rot);
  line(
    0, -halfL, 
    0, halfL
    );
  rotate(-rot);

  color nextColor;
  // Draw four surrounding lines
  nextColor = incrementColor(c);
  println("c", hex(c));
  println("alpha", alpha(c));
  pushMatrix();
  expandingLine(
    -halfW, 
    -lineSpaceHeight, 
    nextColor
    );
  popMatrix();

  // red top left
  nextColor = incrementGreen(incrementBlue(c));
  println("red stays");
  println("c", hex(c));
  println("next", hex(nextColor));
  pushMatrix();
  expandingLine(
    halfW, 
    -lineSpaceHeight, 
    nextColor
    );
  popMatrix();

  //// blue bottom right
  nextColor = incrementGreen(incrementRed(c));
  pushMatrix();
  expandingLine(
    halfW, 
    lineSpaceHeight, 
    nextColor
    );
  popMatrix();

  //// Green bottom left
  nextColor = incrementRed(incrementBlue(c));
  pushMatrix();
  expandingLine(
    -halfW, 
    lineSpaceHeight, 
    nextColor
    );
  popMatrix();
}