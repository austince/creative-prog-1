/**
 
 */
class Quilter {
  boolean isDoneWithSquare = true;
  boolean isDoneQuilting = false;

  Square cSquare;
  int id = -1;
  int currentStep = 0;

  public Quilter(int id) {
    this.id = id;
  }

  public int getNumberOfSteps() {
    return 3;
  }

  /**
   Default is to grab in order
   */
  public Square grabNextSquare(Quilt quilt) {
    for (int i = 0; i < quilt.numSquaresPerSide; i++) {
      for (int j = 0; j < quilt.numSquaresPerSide; j++) {
        if (!quilt.squaresTaken[i][j]) {
          // give this square back if it's not already taken
          return quilt.takeSquare(i, j);
        }
      }
    }

    return null;
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