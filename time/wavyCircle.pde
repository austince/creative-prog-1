/**
 Based on:
 http://bencrowder.net/blog/2013/sine-circle-test-animation/
 */
final float twopi = PI * 2;

void wavyCircle(float x, float y, float radius, float freq, float amp) {
  float angle = 0;
  float angleStep = 0.005;
  float dx, dy;

  // draw a full circle with a lot of little circles
  //while (angle <= twopi) {
  //  dx = x + (radius + sin(angle * freq) * amp) * cos(angle);
  //  dy = y + (radius + sin(angle * freq) * amp) * sin(angle);

  //  angle += angleStep;

  //  float weight = g.strokeWeight;

  //  ellipse(dx, dy, weight, weight);
  //}
  noFill();
  beginShape();
  while (angle <= TWO_PI) {
    dx = x + (radius + sin(angle * freq) * amp) * cos(angle);
    dy = y + (radius + sin(angle * freq) * amp) * sin(angle);
    vertex(dx, dy);
    angle += angleStep;
  }
  endShape(CLOSE);
}