// Start with a single point and randomly draw another two
// blends colors towards the same final goal
import processing.pdf.*;

final int maxDepth = 10;
final int dotRadius = 20;
int maxVariance;

void setup() {
  //size(800, 800);
  size(1152, 720);
  beginRecord(PDF, "sketch-1.pdf");


  background(255);
  noStroke();
  int startX = (int) (width * random(.25, .75));
  int startY = (int) (height * random(.25, .75));
  println((float) startX / width, ",", (float) startY / height);
  maxVariance = width / 4;
  dot(startX, startY, 0, (int) random(maxDepth / 4, maxDepth), color(178, 18, 18, 150), color(255, 235, 238, 150));
  dot(startX, startY, 0, (int) random(maxDepth / 2, maxDepth), color(20, 133, 204, 150), color(255, 235, 238, 150));
  dot(startX, startY, 0, maxDepth, color(255, 252, 25, 150), color(255, 235, 238, 150));

  save("random-sketches-1-dots.png");
  endRecord();
}

void dot(float x, float y, int step, int stopStep, color start, color end) {
  if (step > stopStep) {
    return;
  }

  //x = constrain(x, 0, width);
  //y = constrain(y, 0, height);

  fill(lerpColor(start, end, (float) step / (float) maxDepth));
  ellipse(x, y, dotRadius, dotRadius);

  for (int i = 0; i < 2; i++) {
    dot((x + maxVariance * random(-1, 1)), (y + maxVariance * random(-1, 1)), step + 1, stopStep, start, end);
  }
}