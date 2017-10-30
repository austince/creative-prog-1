import processing.pdf.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Collections;
import java.util.concurrent.CopyOnWriteArrayList;

//List<Walker> walkers = Collections.synchronizedList(new ArrayList<Walker>());
List<Walker> walkers = new CopyOnWriteArrayList<Walker>();

Walker walker;
int splitTime = 10;
final int maxWalkers = 10;
final int maxSpeed = 10;
final int minSpeed = 5;
final int maxColorChange = 10;


void setup() {
  //size(800, 800);
  size(1152, 720);
  beginRecord(PDF, "random-sketch-4-ext.pdf");
  background(255);

  // start in center of screen
  Walker w = new Walker(width / 2, height /2, 30);
  w.setBoundaries(0, width, 0, height);
  walkers.add(w);
  frameRate(30);

  // Call this before drawing
  registerMethod("pre", this);
}

void pre() {
  println("Updating");
  for (Walker walker : walkers) {
    walker.update();
    if (walkers.size() < maxWalkers && frameCount % splitTime == 0) {
      // split it
      Walker w = new Walker(walker.x, walker.y);
      float range = avg(walker.xMin, walker.xMax);
      w.setBoundaries(walker.xMin + range, walker.xMax - range, 0, height);
      walkers.add(w);
    }
  }
}

// No update logic!
void draw() {
  println("Drawing");
  for (Walker walker : walkers) {
    walker.draw();
  }
}


void keyPressed() {
  if (key == 's') {
    save("random-sketch-4.png");
  } else if ( key == 'q') {
    endRecord();
    exit();
  }
}