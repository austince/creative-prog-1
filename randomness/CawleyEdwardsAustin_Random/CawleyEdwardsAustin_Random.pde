import processing.pdf.*;

String filebase = "CawleyEdwardsAustin_Random";

final int CURVE_STEP = 100;
final int OFFSET_X = 50;
final int MAX_HEIGHT = 3000;
final int MIN_HEIGHT = 500;

int sign(float x) {
  if (x < 0) {
    return -1;
  } 
  return 1;
}


void setup() {
  size(1152, 720);
  beginRecord(PDF, filebase + ".pdf");
  background(0);

  noStroke();

  // Let's get blendy!
  blendMode(BLEND); // default
  //blendMode(ADD); // bright, highlight overlaps
  //blendMode(SUBTRACT); // blackness, same with DARKEST, MULTIPLY
  //blendMode(SCREEN); // muted and almost sunken
  //blendMode(REPLACE); // no alphas, crazy almost pixelated mesh
  //blendMode(LIGHTEST); // also muted, but overlapping areas stand out more
  //blendMode(DIFFERENCE); // almost opposite of subtract, very dark, so much color
  //blendMode(EXCLUSION); // like docs say, similar to DIF but less intense
  //blendMode(MULTIPLY); // like docs say, similar to DIF but less intense
  int maxX = width + OFFSET_X;
  int minX = -OFFSET_X;
  colorMode(HSB);
  // quarter down
  fill(120, 220, 255, 75);
  arcLine(minX, height / 4, maxX, CURVE_STEP, OFFSET_X, MIN_HEIGHT, MAX_HEIGHT);

  // half way down
  fill(240, 220, 255, 100);
  arcLine(0, height / 2, maxX, CURVE_STEP, OFFSET_X, MIN_HEIGHT, MAX_HEIGHT);

  // 3 / 4 down
  fill(60, 220, 255, 110);
  arcLine(0, height * 3 / 4, maxX, CURVE_STEP, OFFSET_X, MIN_HEIGHT, MAX_HEIGHT);

  // bottom
  fill(30, 220, 255, 100);
  arcLine(minX, height, maxX, CURVE_STEP, OFFSET_X, MIN_HEIGHT, MAX_HEIGHT);

  // Arc Web Overlay
  noFill();
  colorMode(RGB);
  int cMin = 200;
  int cMax = 255;
  int cAlph = 50;
  float strokeMin = 1;
  float strokeMax = 2;
  int rnRng = 150; // random height range
  for (int i = 0; i < 20; i++) {
    //strokeWeight(random(strokeMin, strokeMax));
    float r = random(1);
    if (r < 0.01) {
      strokeWeight(3);
    } else if (r < 0.11) {
      strokeWeight(2);
    } else {
      strokeWeight(1);
    }
    
    stroke(color(random(cMin, cMax), random(cMin, cMax), random(cMin, cMax), cAlph));
    int startX = (int) random(-50, 50);
    // quarter down
    arcLine(startX, (int) ((height / 4) + random(-rnRng, rnRng)), width, CURVE_STEP, OFFSET_X * 2, MIN_HEIGHT, MAX_HEIGHT * 3 / 4);

    // halfway down
    arcLine(startX, (int) ((height / 2) + random(-rnRng, rnRng)), width, CURVE_STEP, OFFSET_X * 2, MIN_HEIGHT, MAX_HEIGHT * 3 / 4);

    // 3/4 down
    arcLine(startX, (int) ((height * 3 / 4) + random(-rnRng, rnRng)), width, CURVE_STEP * 2, OFFSET_X * 2, MIN_HEIGHT, MAX_HEIGHT / 2);

    // Bottom
    arcLine(startX, (int) ((height) + random(-rnRng, rnRng)), width, CURVE_STEP, OFFSET_X * 2, MIN_HEIGHT, MAX_HEIGHT * 3 / 4);
  }

  endRecord();
  save(filebase + ".png");
}


void arcLine(int x, int y, int maxX, int stepX, int offsetX, int minHeight, int maxHeight) {
  int c = g.fillColor;
  println(c);

  int prevX = x;
  x += random(0, stepX);
  for (; x < maxX; x += random(0, stepX)) {
    int offX = (int) random(-offsetX, offsetX);
    //println(x);
    curve(
      prevX, y + random(minHeight, maxHeight), 
      prevX, y, 
      x + offsetX, y, 
      x, y + random(minHeight, maxHeight)
      );

    prevX = x;
  }
}