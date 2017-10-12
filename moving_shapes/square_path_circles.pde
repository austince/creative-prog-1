/**
 Awesome paper on mapping circle space to squares
 https://arxiv.org/pdf/1509.06344.pdf
 */

int sign(float x) {
  if (x < 0) {
    return -1;
  } else if (x == 0) {
    return 0;
  } else /* x > 0*/ {
    return 1;
  }
}

PVector simpleMap(float u, float v) {
  PVector mapped = new PVector(0, 0);

  float uSq = u * u;
  float vSq = v * v;

  if (uSq >= vSq) {
    mapped.x =  sign(u) * sqrt(uSq + vSq);
    mapped.y = sign(u) * (v / u) * sqrt(uSq + vSq);
  } else {
    mapped.x = sign(v) * (u / v) * sqrt(uSq + vSq);
    mapped.y =  sign(v) * sqrt(uSq + vSq);
  }

  return mapped;
}

PVector fgMap(float u, float v) {
  PVector mapped = new PVector(0, 0);

  float uSq = u * u;
  float vSq = v * v;

  mapped.x = sign(u * v) / (v * sqrt(2)) * sqrt( uSq + vSq - sqrt((uSq + vSq) * (uSq + vSq - (4 * uSq * vSq))));
  mapped.y = sign(u * v) / (u * sqrt(2)) * sqrt( uSq + vSq - sqrt((uSq + vSq) * (uSq + vSq - (4 * uSq * vSq))));

  return mapped;
}

void squarePathCircles(float x, float y, float dist, float size) {
  PVector intPt = new PVector(width - x, height - y);

  colorMode(HSB);
  
  color c1 = color(
    map(intPt.x + intPt.y, 0, width + height, 0, 90), 
    120, 
    255, 
    100
    );

  color c2 = color(
    map(intPt.x + intPt.y, 0, width + height, 150, 255), 
    120, 
    255, 
    100
    );

  squarePathCircles(x, y, dist, size, c1, c2);
}

void squarePathCircles(float x, float y, float dist, float size, color c1, color c2) {
  float angle = radians(map(millis() % 1000, 0, 999, 0, 359));
  float u = cos(angle);
  float v = sin(angle);
  PVector pt = fgMap(u, v);

  pushMatrix();
  translate(x, y);

  fill(c1);
  ellipse(pt.x * dist, pt.y * dist, size, size);
  fill(c2);
  ellipse(-pt.x * dist, -pt.y * dist, size, size);
  popMatrix();
}