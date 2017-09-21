enum GrabMode {
  NEXT_IN_LINE, 
    NEXT_CLOSEST
}

/**
 
 */
class Quilter {
  boolean isDoneWithSquare = true;

  Square cSquare;
  int id = -1;
  int currentStep = 0;
  GrabMode grabMode = GrabMode.NEXT_IN_LINE;
  int x = 0, y = 0; // position on quilt

  public Quilter(int id) {
    this.id = id;
  }
  
  public Quilter(int id, GrabMode mode) {
     this(id);
     this.grabMode = mode;
  }

  public int getNumberOfSteps() {
    return 3;
  }

  public void setGrabMode(GrabMode mode) {
    this.grabMode = mode;
  }

  public void setPos(int x, int y) {
    this.x = x;
    this.y = y;
  }

  /**
   Default is to grab in order
   */
  public Square grabNextSquare(Quilt quilt) {
    if (this.grabMode == GrabMode.NEXT_IN_LINE) {
      for (int i = 0; i < quilt.numSquaresPerSide; i++) { //<>//
        for (int j = 0; j < quilt.numSquaresPerSide; j++) {
          if (!quilt.squaresTaken[i][j]) {
            // give this square back if it's not already taken
            return quilt.takeSquare(i, j);
          }
        }
      }
    } else if (this.grabMode == GrabMode.NEXT_CLOSEST) {
      return this.grabNextClosest(quilt); //<>//
    }

    return null;
  }

  private Square grabNextClosest(Quilt quilt) {
    // Grab the closest Square to x,y position on quilt
    ArrayList<Integer[]> availPositions = new ArrayList();

    for (int i = 0; i < quilt.numSquaresPerSide; i++) {
      for (int j = 0; j < quilt.numSquaresPerSide; j++) {
        if (!quilt.squaresTaken[i][j]) {
          // add to avail list if it's not already taken
          Integer pos[] = { i, j };
          availPositions.add(pos);
        }
      }
    }

    // Now find the closest of available
    if (availPositions.isEmpty()) {
      return null;
    }

    // Find the square position the closest to x, y
    Integer[] minDistPos = availPositions.get(0);
    double minDist = Math.hypot(x - minDistPos[0], y - minDistPos[1]);

    for (int i = 1; i < availPositions.size(); i++) {
      Integer[] nextPos = availPositions.get(i);
      double dist = Math.hypot(x - nextPos[0], y - nextPos[1]);
      if (dist < minDist) {
        minDist = dist;
        minDistPos = nextPos;
      }
    }

    return quilt.takeSquare(minDistPos[0], minDistPos[1]);
  }

  public void setNextSquare(Square square) {
    cSquare = square;
    currentStep = 0;
    isDoneWithSquare = false;
  }

  void drawNext() {
    currentStep += 1;
    pushMatrix();
    translate(cSquare.topX, cSquare.topY);

    drawStep(currentStep);

    popMatrix();

    if (currentStep == getNumberOfSteps()) {
      isDoneWithSquare = true;
    }
  }

  /**
   Default steps 
   */
  void drawStep(int step) {
    int w = cSquare.getWidth();
    if (step == 1) {
      fill(255);
      ellipse(w / 2, w / 2, 10, 10);
    } else if (step == 2) {
      fill(100, 150, 100);
      rect(0, 0, w / 2, w);
    }
  }
}