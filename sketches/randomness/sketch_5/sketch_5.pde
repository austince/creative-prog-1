import processing.pdf.*;

String filebase = "Random5";

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
  colorMode(HSB);
  fill(30, 255, 255, 100);
  arcLine(0, height, width, CURVE_STEP, OFFSET_X, MIN_HEIGHT, MAX_HEIGHT);
  fill(240, 255, 255, 100);
  arcLine(0, height / 2, width, CURVE_STEP, OFFSET_X, MIN_HEIGHT, MAX_HEIGHT);
  fill(60, 255, 255, 100);
  arcLine(0, height * 3 / 4, width, CURVE_STEP, OFFSET_X, MIN_HEIGHT, MAX_HEIGHT);
  fill(120, 255, 255, 100);
  arcLine(0, height / 4, width, CURVE_STEP, OFFSET_X, MIN_HEIGHT, MAX_HEIGHT);


  noFill();
  colorMode(RGB);
  stroke(color(255, 255, 255, 50));
  for (int i = 0; i < 50; i++) {
    arcLine(0, (int) ((height * 3 / 4) + random(-50, 50)), width, CURVE_STEP * 2, OFFSET_X * 2, MIN_HEIGHT, MAX_HEIGHT / 2);
    arcLine(0, (int) ((height / 4) + random(-25, 25)), width, CURVE_STEP, OFFSET_X * 2, MIN_HEIGHT, MAX_HEIGHT * 3 / 4);
    arcLine(0, (int) ((height / 2) + random(-25, 25)), width, CURVE_STEP, OFFSET_X * 2, MIN_HEIGHT, MAX_HEIGHT * 3 / 4);
    arcLine(0, (int) ((height) + random(-25, 25)), width, CURVE_STEP, OFFSET_X * 2, MIN_HEIGHT, MAX_HEIGHT * 3 / 4);
  }

  endRecord();
  save(filebase + ".png");
}


void arcLine(int x, int y, int maxX, int stepX, int offsetX, int minHeight, int maxHeight) {
  int prevX = 0;
  for (; x < maxX; x += random(0, stepX)) {
    int offX = (int) random(-offsetX, offsetX);
    println(x);
    curve(
      prevX, y + random(minHeight, maxHeight), 
      prevX, y, 
      x + offsetX, y, 
      x, y + random(minHeight, maxHeight)
      );

    prevX = x;
  }
}