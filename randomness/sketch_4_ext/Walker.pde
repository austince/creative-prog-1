class Walker {
  private int framesWalked = 0;
  
  int curvePoints = 5;  // either 4 or 5
  
  float speed = 30;    // max movement each frame
  float xMin = 0;
  float xMax = width;
  float yMin = 0;
  float yMax = height;
  
  int curFrame;
  float prevX, prevY;
  float x, y;
  float[][] nextPts = new float[curvePoints][2];
  
  Walker(float x, float y) {
    curFrame = 0;
    this.x = prevX = x;
    this.y = prevY = y;
  }
  
  Walker(float x, float y, int startFrame) {
    this(x, y);
    curFrame = startFrame;
  }
  
  Walker(float x, float y, int startFrame, int speed) {
    this(x, y, startFrame);
    this.speed = speed;
  }
  
  void setBoundaries(float xMin, float xMax, float yMin, float yMax) {
    this.xMin = xMin;
    this.xMax = xMax;
    this.yMin = yMin;
    this.yMax = yMax;
  }
  
  void update() {
    // First and last point are not drawn
    // with 4: between 2nd and 3rd
    // with 5: between 2nd, 3rd, 4th
    // => 2nd point must always be prevX, prevY
    // => last - 1 point must always be what prevX, prevY is set to
    
    //float xDir = sign(random(-speed, speed));
    //float yDir = sign(random(-speed, speed));
    for (int i = 1; i <= curvePoints; i++) {
      x = x + random(-speed, speed);
      y = y + random(-speed, speed);
      // Attempts to make it a little more 'curvy'
      //x += xDir * random(0, speed / maxVerts);
      //y += yDir  * random(0, speed / maxVerts);

      if (i == 2) {
        nextPts[i-1][0] = prevX;
        nextPts[i-1][1] = prevY;
      } else {
        nextPts[i-1][0] = x;
        nextPts[i-1][1] = y;
      }

      if (i == curvePoints - 1) {
        // set prevX and prevY
        prevX = x;
        prevY = y;
      }
    }
    
    framesWalked++;
    curFrame++;
    // escape is futile
    x = constrain(x, xMin, xMax);
    y = constrain(y, yMin, yMax);

    prevX = constrain(prevX, xMin, xMax);
    prevY = constrain(prevY, yMin, yMax);
  }


/**
No value changes!
*/
  void draw() {
    noFill();

    // Calculate how much has changed
    float changeX = abs(prevX - x);
    float changeY = abs(prevY - y);
    // max avg change would be `speed`
    float avgChange = (changeX + changeY) / 2;
    //strokeWeight(map(avgChange, 0, speed, 2, 8));
    strokeWeight(map(avgChange, 0, speed, 10, 2));

    colorMode(HSB);
    stroke(color(map(curFrame % 1000, 0, 999, 0, 255), 120, 255, 75));

    beginShape();

    // First and last point are not drawn
    // with 4: between 2nd and 3rd
    // with 5: between 2nd, 3rd, 4th
    // => 2nd point must always be prevX, prevY
    // => last - 1 point must always be what prevX, prevY is set to
    
    for (int i = 1; i <= curvePoints; i++) {
      float[] pt = nextPts[i-1];
      curveVertex(pt[0], pt[1]);
    }

    endShape();
  }
}