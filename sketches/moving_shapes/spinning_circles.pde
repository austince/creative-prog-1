
void spinningCircles(float x, float y, float dist, float size) {
  PVector intPt = new PVector(width - x, height - y);
  colorMode(HSB);
  color c = color(
    map((intPt.x + intPt.y) / 2, 0, (width + height) / 2, 255, 0), 
    120, 
    255, 
    100
    );

  spinningCircles(x, y, dist, size, c, c);
}

void spinningCircles(float x, float y, float dist, float size, color c1, color c2) {
  pushMatrix();
  translate(x, y);
  rotate(radians(map(millis(), 0, 999, 0, 359)));
  fill(c1);
  ellipse(-dist, -dist, size, size);
  fill(c2);
  ellipse(dist, dist, size, size);
  popMatrix();
}