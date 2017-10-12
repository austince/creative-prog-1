
void splitRect(float x, float y) {
  // intersection point
  PVector intPt = new PVector(width - x, height - y);
  pushMatrix();

  colorMode(HSB);
  rectMode(CORNER);
  fill(color(
    map((intPt.x + intPt.y) / 2, 0, (width + height) / 2, 0, 255), 
    120, 
    255, 
    100
    ));
  rect(0, 0, intPt.x, intPt.y);

  fill(color(
    map((intPt.x + intPt.y) / 2, 0, (width + height) / 2, 0, 120), 
    120, 
    255, 
    100
    ));

  rect(intPt.x, 0, width, intPt.y);

  fill(color(
    map((intPt.x + intPt.y) / 2, 0, (width + height) / 2, 120, 255), 
    120, 
    255, 
    100
    ));
  rect(0, intPt.y, intPt.x, height);
  popMatrix();
}