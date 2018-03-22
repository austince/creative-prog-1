// Perlin Motion cirlce -> to be a sphere one day
import processing.pdf.*;

float yIncrement =    0.05;    // how much to change b/w individual waves (0-1)
float timeIncrement = 0.01;    // speed of change over time (0-1)
float timeOffset =    0;       // incremented each frame to shift the noise
float maxOffset = 30;

void setup() {
  //size(800, 800);
  size(1152, 720);
  beginRecord(PDF, "sketch-2.pdf");

  noiseDetail(1, 0.1);
  // first adjusts overall variety
  // Lower --> less
  // second adjusts local variety
  // 0 -> 1

  //wavyCircle(width / 2, height / 2, 200, 10, 10);
  frameRate(30);
}

void draw() {
  background(180);
  fill(color(50));

  // update time position in the Perlin
  // noise each frame 
  float whAvg = (width + height) / 2;
  noiseyCircle(width / 2, height / 2, whAvg / 4, timeOffset, 30);
  noiseyCircle(width / 4, height / 4, whAvg / 8, timeOffset, maxOffset);
  noiseyCircle(width * 3 / 4, height * 3 / 4, whAvg / 10, timeOffset / 2, 30);


  maxOffset = map(millis(), 0, 999, 30, 32);

  timeOffset += timeIncrement;
}

void keyPressed() {
  if (key == 's') {
    save("random-sketch-2-" + frameCount + ".png");
  } else if (key == 'q') {
    endRecord();
    exit();
  }
}