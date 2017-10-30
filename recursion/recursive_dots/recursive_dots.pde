// Start with a single point and randomly draw another two

final int maxDepth = 10;
final int dotRadius = 20;
int maxVariance;

void setup() {
  size(800, 800);
  background(255);
  noStroke();
  int startX = (int) (width * random(1));
  int startY = (int) (width * random(1));

  maxVariance = width / 4;
  dot(startX, startY, 0);

  save("Cawley-EdwardsAustin_RECURSION.png");
}

void dot(int x, int y, int step) {
  if (step > maxDepth) {
    return;
  }

  fill(lerpColor(color(#b71c1c), color(#ffebee), (float) step / (float) maxDepth));
  ellipse(x, y, dotRadius, dotRadius);
  dot((int) (x + maxVariance * random(-1, 1)), (int) (y + maxVariance * random(-1, 1)), step + 1);
  dot((int) (x + maxVariance *  random(-1, 1)), (int) (y + maxVariance *  random(-1, 1)), step + 1);
}