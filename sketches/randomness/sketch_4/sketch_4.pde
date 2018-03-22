import processing.pdf.*;

float speed = 30;    // max movement each frame
float x, y;         // position values for the circle
float prevX, prevY;

void setup() {
  //size(800, 800);
  size(1152, 720);
  beginRecord(PDF, "random-sketch-4.pdf");

  background(255);

  // start in center of screen
  x = prevX = width/2;
  y = prevY = height/2;
  frameRate(30);
}

int sign(float x) {
   if (x < 0) {
     return -1;
   }
   return 1;
}


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
  stroke(color(map(frameCount % 1000, 0, 999, 0, 255), 120, 255, 75));

  beginShape();

  // First and last point are not drawn
  // with 4: between 2nd and 3rd
  // with 5: between 2nd, 3rd, 4th
  // => 2nd point must always be prevX, prevY
  // => last - 1 point must always be what prevX, prevY is set to
  int maxVerts = 5; // either 4 or 5
   //float xDir = sign(random(-speed, speed));
   //float yDir = sign(random(-speed, speed));
  for (int i = 1; i <= maxVerts; i++) {
    x = x + random(-speed, speed);
    y = y + random(-speed, speed);
    // Attempts to make it a little more 'curvy'
    //x += xDir * random(0, speed / maxVerts);
    //y += yDir  * random(0, speed / maxVerts);

    if (i == 2) {
      curveVertex(prevX, prevY);
    } else {
      curveVertex(x, y);
    }

    if (i == maxVerts - 1) {
      // set prevX and prevY
      prevX = x;
      prevY = y;
    }
    
    
  }

  endShape();

  // escape is futile
  x = constrain(x, 0, width);
  y = constrain(y, 0, height);

  prevX = constrain(prevX, 0, width);
  prevY = constrain(prevY, 0, height);
}


void keyPressed() {
 if (key == 's') {
   endRecord();
   save("random-sketch-4.png"); 
   exit();
 }
}