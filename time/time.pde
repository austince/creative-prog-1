/*
Author: Austin Cawley-Edwards
 
 Sources:
 http://bencrowder.net/blog/2013/sine-circle-test-animation/
 
 
 Videos from:
 https://www.youtube.com/watch?v=bf0vy8xd1LA
 */

final float timeInterval = 1000;
float radStep;
float rotateStep = radians(25);
float prevMillis;
float startRad = 100;
float curRotation;

final int numFetusImgs = 38;
PImage fetusImgs[] = new PImage[numFetusImgs];
int curFetus = 0;
int fetusInc = 1;
float prevFetusMillis; 
float fetusInterval = 100;

// Previous rings, a workaround to stop image from overwriting AND keep multiple rings on screen
import java.util.ArrayDeque;
import java.util.Iterator;

final int maxRings = 10;
// color + rot + rad + freq + amp
ArrayDeque<Float[]> prevRings = new ArrayDeque(maxRings);

int curFrame = 0;

void setup() {
  size(1080, 960);
  println("Loading!");

  prevMillis = millis();     // start our timer (used later in the sketch)
  prevFetusMillis = millis();

  radStep = height * .05;
  curRotation = 0;

  // Load all the fetus images
  for (int i = 1; i <= numFetusImgs; i++) {
    fetusImgs[i-1] = loadImage("fetus/" + i + ".png");
  }
}

/**
 */
void draw() {
  clear();
    // BLACK
  background(0);

  // Draw the fetus
  imageMode(CENTER);
    //tint(255, 25);
  image(fetusImgs[curFetus], width / 2, height / 2);
  //noTint();
  
  for (Iterator itr = prevRings.iterator(); itr.hasNext(); ) {
    // in format [ rot, color, rad, freq, amp ]
    Float[] ringProps = (Float[]) itr.next();
    pushMatrix();
    translate(width / 2, height / 2);
    rotate(ringProps[0]);
    //stroke(ringProps[1]);
    stroke(color(255));

    wavyCircle(0, 0, ringProps[2], ringProps[3], ringProps[4]);
    popMatrix();
  }

  float curMillis = millis();

  // Fetus updater
  // Have a full cycle complete in 15 seconds
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

  if (curMillis > prevMillis + timeInterval) {
    println("One seconds have passed...");    
    // Increment every ring in the queue
    for (int i = 0; i < prevRings.size(); i++) {
      // in format [ rot, color, rad, freq, amp ]
      Float[] ringProps = (Float[]) prevRings.remove(); // remove the first
      // Increment it
      ringProps[2] += radStep;
      ringProps[0] += random(-rotateStep, rotateStep);
      // Add it to the tail
      prevRings.add(ringProps);
    }    

    curRotation += random(-rotateStep, rotateStep);
    Float[] nextRingProps = {
      curRotation, 
      (float) color(255), 
      startRad, 
      10f, 
      15f
    };

    // Add a new ring to the queue
    if (prevRings.size() == maxRings) {
      // Pop the first, 'oldest', off
      prevRings.removeFirst();
    }
    prevRings.add(nextRingProps);

    // Time stuff
    prevMillis = curMillis;
  }
  
  curFrame++;
}