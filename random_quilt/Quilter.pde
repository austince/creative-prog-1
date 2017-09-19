/**
 
 */
class Quilter {
  boolean isDoneWithSquare = true;
  Square cSquare;
  int id = -1;
  int currentStep = 0;

  public Quilter(int id) {
    this.id = id;
  }
  
  public int getNumberOfSteps() {
     return 3; 
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
    switch (step) {
    case 1:
      drawStepOne();
      break;
    case 2:
      drawStepTwo();
      break;
    }
  }

  private void drawStepOne() {
    int w = cSquare.getWidth();
    fill(255);
    ellipse(w / 2, w / 2, 10, 10);
  }

  private void drawStepTwo() {
    int w = cSquare.getWidth();
    fill(100, 150, 100);
    rect(0, 0, w / 2, w);
  }
}