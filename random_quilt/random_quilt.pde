import java.util.Collections; //<>// //<>//
import java.util.Arrays;
import java.util.List;

Quilt quilt;
Quilter[] quilters;
final int NUM_QUILTERS = 1;
final int FRAME_RATE = 1000;
int stepNum = 0;

void setup() {
  size(800, 800);
  frameRate(FRAME_RATE);
  quilt = new Quilt(0, 0, width, height, 6);
  quilt.drawBackground(color(255));
  //quilt.drawQuiltGrid();

  quilters = new Quilter[NUM_QUILTERS];

  // Intitialize the quilters
  for (int i = 0; i < NUM_QUILTERS; i++) {
    // random quilter
    //int quilterType = (int) random(2); // between 0 and 1
    //switch (quilterType) {
    //case 0:
    //  println("Rego Quilter.");
    //  quilters[i] = new Quilter(i);
    //  break;
    //case 1:
    //  println("Tri Quilter.");
    //  quilters[i] = new TriangleQuilter(i);
    //  break;
    //}
    quilters[i] = new TriangleQuilter(i);
  }
}


/**
 Initial plan was to have each in a separate thread
 Ran into problems with drawing synchronization
 Could have created a draw Semaphore -- ?
 
 import java.util.concurrent.Semaphore;
 
 */
void draw() {
  boolean anyQuilterStillWorking = false;
  // All drawing is done in threads
  // if quilters are done, give them a new square

  // Pick random order to run the quilters in
  Integer[] order = new Integer[NUM_QUILTERS];
  for (int i = 0; i < NUM_QUILTERS; i++) order[i] = new Integer(i);
  List<Integer> orderList = Arrays.asList(order);
  Collections.shuffle(orderList);
  
  debug("Quilter order: ");
  debugArray(orderList);

  for (Integer i : orderList) {
    Quilter quilter = quilters[i];

    if (quilter.isDoneWithSquare) {
      Square nextSquare = quilter.grabNextSquare(quilt);

      if (nextSquare != null) {
        debug("Got another square for quilter ", quilter.id, "!");
        quilter.setNextSquare(nextSquare);
        anyQuilterStillWorking = true;
        debug("Now at step: ", quilter.currentStep, " of ", quilter.getNumberOfSteps());
      }
    } else {
      anyQuilterStillWorking = true;
      debug("Quilter ", quilter.id, " drawing step", quilter.currentStep, "of", quilter.getNumberOfSteps());
      quilter.drawNext();
    }
  }

  if (quilt.allSquaresTaken() && !anyQuilterStillWorking) {
    debug("All done, stopping", "!"); //<>//
     //<>//
    save("Cawley-EdwardsAustin_QUILT.jpg"); //<>//
    noLoop(); // finish the process
  } else {
    stepNum++;
    save("steps/" + "QUILT-" + stepNum + ".jpg");
  }
}