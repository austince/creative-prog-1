// design 2086
// page 261
class TriangleQuilter extends Quilter {
  private color lineColor = color(0);
  private int lineWeight = 2;
  
  TriangleQuilter(int id) {
    super(id);
  }

  TriangleQuilter(int id, int xPos, int yPos) {
    super(id, GrabMode.NEXT_CLOSEST);
    x = xPos;
    y = yPos;
  }

  public void setLineColor(color c) {
    this.lineColor = c;
  }

  public void setLineWeight(int weight) {
    this.lineWeight = weight;
  }



  @Override
    public int getNumberOfSteps() {
    return 3;
  }

  @Override
    void drawStep(int step) {
    strokeWeight(lineWeight);
    stroke(lineColor);
    int l = cSquare.getWidth();

    if (step == 1) {
      // long outlines 
      line(
        l / 4, 0, 
        l / 4, l
        );

      line(
        l * .75, 0, 
        l * .75, l
        );

      line(
        0, l / 4, 
        l, l / 4
        );

      line(
        0, l * .75, 
        l, l * .75
        );
    } else if (step == 2) {
      // inner square lines
      line(
        l / 4, l / 2, 
        l * .75, l / 2
        );

      line(
        l / 2, l / 4, 
        l / 2, l * .75
        );
    } else if (step == 3) {
      // corner triangles
      line(
        l / 4, l, 
        l / 2, l * .75
        );

      line(
        0, l * .75, 
        l / 4, l / 2
        );

      line(
        l / 2, l / 4, 
        l * .75, 0
        );

      line(
        l * .75, l / 2, 
        l, l / 4
        );
    }
  }
}