
void spinningSplitRect() {
  // intersection point
  PVector intPt = new PVector(width - mouseX, height - mouseY);
  pushMatrix();
  translate(intPt.x, intPt.y);
  
  if (mousePressed) {
    rotate(radians(map(millis(), 0, 999, 0, 359)));
  } else {
    rotate(radians(map(second(), 0, 59, 0, 359)));
  }
  
  colorMode(HSB);
  
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