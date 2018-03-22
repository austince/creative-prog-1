final float TWO_PI = PI * 2;

void noiseyCircle(float x, float y, float radius, float noiseVal, float max) {
  float angle = 0;
  float angleStep = 0.05;
  float nRad = radius * map(noise(noiseVal),0, 1, 0.75, 1.25);
  noStroke();
  beginShape();

  while (angle <= TWO_PI) {
    //float dx = x + (radius + random(-20, 20) * noise(yNoise)) * cos(angle);
    //float dy = y + (radius + random(-20, 20) * noise(yNoise)) * sin(angle);
    float n = noise(noiseVal);
    //float dx = x + (radius + random(-max, max) * n) * cos(angle);
    //float dy = y + (radius + random(-max, max) * n) * sin(angle);
    float mn = max * n / 2;
    float dx = x + (nRad + random(-mn, mn)) * cos(angle);
    float dy = y + (nRad + random(-mn, mn)) * sin(angle);
    //float dx = x + (radius ) * cos(angle);
    //float dy = y + (radius + random(-mn, mn)) * sin(angle);
     //float dx = x + (radius + random(-mn, mn)) * cos(angle);
    //float dy = y + (radius ) * sin(angle);
    
    vertex(dx, dy);

    angle += angleStep;
  }

  endShape(CLOSE);
}


void wavyCircle(float x, float y, float radius, float freq, float amp) {
  float angle = 0;
  float angleStep = 0.005;
  float dx, dy;

  beginShape();
  while (angle <= TWO_PI) {
    dx = x + (radius + sin(angle * freq) * amp) * cos(angle);
    dy = y + (radius + sin(angle * freq) * amp) * sin(angle);
    vertex(dx, dy);
    angle += angleStep;
  }
  endShape(CLOSE);
}