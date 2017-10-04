final float twopi = PI * 2;

void wavyCircle(float x, float y, float radius, float freq, float amp) {
  float angle = 0;
  float angleStep = 0.005;
  float dx, dy;

  // draw a full circle
  while (angle <= twopi) {
    dx = x + (radius + sin(angle * freq) * amp) * cos(angle);
    dy = y + (radius + sin(angle * freq) * amp) * sin(angle);

    angle += angleStep;

    ellipse(dx, dy, 2, 2);
  }
}