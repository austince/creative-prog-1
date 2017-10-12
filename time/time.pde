/*
Author: Austin Cawley-Edwards
 
 Sources:
 http://bencrowder.net/blog/2013/sine-circle-test-animation/
 
 
 Fetus video from from:
 https://www.youtube.com/watch?v=bf0vy8xd1LA
 */
final boolean saveFrames = false;
final int maxFrames = 30 * 10; // for 30fps animation, maxFrames = 30 * desired length in seconds

final float ringInterval = 5000; // time between new rings
int startRad = 175; // starting radius for new rings
float rotateStep = 25; // degrees
int curRotation = 0; // degrees
float darkenPcnt = 0.15; // how much to darken the ring at each step
float radStep; // dependent on size
float prevRingMillis; // ring timer

final int numFetusImgs = 38;
final float fetusInterval = 100;
PImage fetusImgs[] = new PImage[numFetusImgs];
int curFetus = 0;
int fetusInc = 1; // the incrementor for counting up and down the fetus images
float prevFetusMillis; // fetus timer

// Previous rings, a workaround to stop image from overwriting AND keep multiple rings on screen
// Imports should go up top but this is experimental, ooph.
import java.util.Queue;
import java.util.ArrayDeque;
import java.util.Iterator;

final int maxRings = 11;
// color + rot + rad + freq + amp
ArrayDeque<Integer[]> prevRings = new ArrayDeque(maxRings);

void setup() {
  //size(1080, 960);
    size(1920, 1080);
  println("Loading!");

  // Setup modes
  colorMode(HSB, 255);
  imageMode(CENTER);

  prevRingMillis = millis();     // start our timers
  prevFetusMillis = millis();

  // Setup the incrementers
  radStep = height * .05;

  // Load all the fetus images
  for (int i = 1; i <= numFetusImgs; i++) {
    fetusImgs[i-1] = loadImage("fetus/" + i + ".png");
  }
}

/**
 */
void draw() {
  clear();
  drawContent();
  update();

  if (saveFrames) {
    println("Saving frame", frameCount, "of", maxFrames);
    save("frames/" + frameCount + ".png");

    if (frameCount >= maxFrames) {
      println("Done saving frames!");
      exit();
    }
  }
}

/**
Darken a color by percent
@param percent - number between 0 and 1 
*/
color darken(color c, float percent) {
  colorMode(HSB);
  float h = hue(c);
  float b = brightness(c) * (1 - percent);
  float s = saturation(c);
  float a = alpha(c);
  return color(h, s, b, a);
}

/**
 Draws all the fun stuff
 */
void drawContent() {
  // BLACK
  background(0);

  // Draw the fetus
  // tint the fetus images based on the second of the minute
  float h = map(second(), 0, 59, 0, 255);
  color tintColor = color(h, 255, 255, 255);
  tint(tintColor);
  image(fetusImgs[curFetus], width / 2, height / 2);
  noTint();

  // Draw a wavy circle for each previous ring stored
  for (Iterator itr = prevRings.iterator(); itr.hasNext(); ) {
    // in format [ rot, color, rad, freq, amp ]
    Integer[] ringProps = (Integer[]) itr.next();
    pushMatrix();
    float randOff = random(-0.75, 0.75);
    // just slightly not in the center
    translate((width / 2.1) + randOff, (height / 2.1) + randOff);
    rotate(radians(ringProps[0]));
    stroke(ringProps[1]);
    strokeWeight(3);
    // Draw that wavy tree circle
    // maps amp to average of width and height
    wavyCircle(0, 0, ringProps[2], ringProps[3], map(ringProps[2], 0, (width + height) / 2, 7, 25));
    popMatrix();
  }
}

/**
 Update all the content based on TIME
 */
void update() {
  float curMillis = millis();

  // Fetus updater
  // Full cycle completes in numImages / fetusInterval millis
  if (curMillis > prevFetusMillis + fetusInterval) {
    // Fetus stuff
    curFetus += fetusInc;
    if (curFetus == fetusImgs.length || curFetus == -1) {
      fetusInc *= -1; // switch the direction of growth
      curFetus += fetusInc;
    }
    // time stuff
    prevFetusMillis = curMillis;
  }

  if (curMillis > prevRingMillis + ringInterval) {
    // Increment every ring in the queue
    for (int i = 0; i < prevRings.size(); i++) {
      // in format [ rot, color, rad, freq, amp ]
      Integer[] ringProps = (Integer[]) prevRings.remove(); // remove the first
      // Increment all the things
      // Make the color just a little darker
      ringProps[1] = darken(ringProps[1], darkenPcnt);
      // up the radius 
      ringProps[2] += (int) radStep;
      // rotate over a random interval
      ringProps[0] += (int) random(-rotateStep, rotateStep);
      // Add it to the tail
      prevRings.add(ringProps);
    }    

    curRotation += random(-rotateStep, rotateStep);
    Integer[] nextRingProps = {
      curRotation, // degrees
      // map color to minutes as trees take longer to change than people. maybe.
      color( // hopefully some kind of brown
          map(minute(), 0, 59, 80, 164), // hue
          map(minute(), 0, 59, 70, 85), // saturation
          map(minute(), 0, 59, 30, 60), // brightness
          255
      ),
      // color(19, 47, 52); // chocolate brown
      startRad, // rad
      10, // amp, meaningless now that it's based on radius
      15 // freq
    };

    // Add a new ring to the queue
    if (prevRings.size() == maxRings) {
      // Pop the first, 'oldest', off
      prevRings.removeFirst();
    }
    prevRings.add(nextRingProps);

    // Time stuff
    prevRingMillis = curMillis;
  }
}