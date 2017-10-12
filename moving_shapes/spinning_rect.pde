
void spinningRects(float x, float y, float dist, float len) {
  // intersection point
  PVector intPt = new PVector(width - x, height - y);
  colorMode(HSB);
  color c2 = color(
    map((intPt.x + intPt.y) / 2, 0, (width + height) / 2, 0, 255), 
    120, 
    255, 
    100
    );

  spinningRects(x, y, dist, len, c2, c2);
}

void spinningRects(float x, float y, float dist, float len, color c1, color c2) {
  rectMode(CENTER);

  pushMatrix();
  translate(x, y);
  rotate(radians(map(millis(), 0, 999, 0, 359)));
  fill(c1);
  rect(-dist, -dist, len, len);
  fill(c2);
  rect(dist, dist, len, len);
  popMatrix();
}