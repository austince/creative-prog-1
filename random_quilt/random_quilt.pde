import java.util.Collections;  //<>// //<>// //<>// //<>//
import java.util.Arrays;
import java.util.List;

Quilt quilt;
Quilter[] quilters;
final int NUM_SQ_P_SIDE = 25;
//final int NUM_QUILTERS = NUM_SQ_P_SIDE * 4;
final int NUM_QUILTERS = NUM_SQ_P_SIDE;
final int FRAME_RATE = 30;
final double QUILTER_TURN_RATIO = .25;
int stepNum = 0;

void setup() {
  size(600, 600);
  frameRate(FRAME_RATE);
  quilt = new Quilt(0, 0, width, height, NUM_SQ_P_SIDE);
  quilt.drawBackground(color(255));
  //quilt.drawQuiltGrid();

  quilters = new Quilter[NUM_QUILTERS];

  // Intitialize the quilters
  for (int i = 1; i < NUM_QUILTERS + 1; i++) {
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
    //Quilter q = new Quilter(i);
    TriangleQuilter q = new TriangleQuilter(i);
    q.setGrabMode(GrabMode.NEXT_CLOSEST);
    //q.setGrabMode(GrabMode.NEXT_IN_LINE);
    q.setLineWeight(1);

    // Divide into 4 groups
    // ideally will have quilters aligned along the sides
    if (i > NUM_QUILTERS * .75) {
      q.setPos(0, 0);
    } else if (i > NUM_QUILTERS / 2) {
      q.setPos(NUM_SQ_P_SIDE, 0);
    } else if (i > NUM_QUILTERS / 4) {
      q.setPos(0, NUM_SQ_P_SIDE);
    } else {
      q.setPos(NUM_SQ_P_SIDE, NUM_SQ_P_SIDE);
    }

    quilters[i-1] = q;
  }
}


/**
 Initial plan was to have each in a separate thread
 Ran into problems with drawing synchronization
 Could have created a draw Semaphore -- ?
 Semaphore drawPriv = new Semaphore(1, true);
 
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

  // Only allow the top half of the list to take a turn to simulate speed of quilters?
  for (int i = 0; i <= NUM_QUILTERS * QUILTER_TURN_RATIO; i++) {
    int quilterId = orderList.get(i);
    Quilter quilter = quilters[quilterId];

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

  // Check if any in the bottom half of the list are still working
  for (int i = NUM_QUILTERS / 2; i < NUM_QUILTERS; i++) {
    int quilterId = orderList.get(i);
    Quilter quilter = quilters[quilterId];

    if (!quilter.isDoneWithSquare) {
      anyQuilterStillWorking = true;
      break;
    }
  }

  if (quilt.allSquaresTaken() && !anyQuilterStillWorking) {
    debug("All done, stopping", "!");

    save("Cawley-EdwardsAustin_QUILT.jpg");
    noLoop(); // finish the process
  } else {
    stepNum++;
    save("steps/" + "QUILT-" + stepNum + ".jpg");
  }
}