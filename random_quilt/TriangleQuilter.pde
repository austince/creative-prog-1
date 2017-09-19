// design 2086
// page 261
class TriangleQuilter extends Quilter {
  int x = 0, y = 0; // position on quilt

  TriangleQuilter(int id) {
    super(id);
  }

  TriangleQuilter(int id, int xPos, int yPos) {
    super(id);
    x = xPos;
    y = yPos;
  }

  @Override
    public int getNumberOfSteps() {
    return 3;
  }

  @Override
    void drawStep(int step) {
    strokeWeight(2);
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

  @Override
    public Square grabNextSquare(Quilt quilt) {
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
}