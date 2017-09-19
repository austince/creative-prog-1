class Quilt {
  int topX, topY, bottomX, bottomY;
  int qWidth, qHeight;
  int sWidth;
  private int numSquaresPerSide;
  private boolean[][] squaresTaken;

  Quilt(int x, int y, int w, int h, int numSquaresPerSide) {
    topX = x;
    topY = y;
    qWidth = w;
    qHeight = h;
    bottomX = x + w;
    bottomY = y + h;
    sWidth = w / numSquaresPerSide;
    this.numSquaresPerSide = numSquaresPerSide;
    squaresTaken = new boolean[numSquaresPerSide][numSquaresPerSide]; // defaults to false
  }

  void drawQuiltGrid() {
    for (int i = topX; i < qWidth; i += sWidth) {
      line(i, topY, i, bottomY);
    }

    for (int j = topY; j < qHeight; j += sWidth) {
      line(topX, j, bottomX, j);
    }
  }
  
  void drawBackground(color quiltColor) {
    fill(quiltColor);
    rect(topX, topY, bottomX, bottomY);
  }
  
  Square getNextSquare() {
    // Just get the next square in line for now
    // If at the end
    Square nextSquare = null;

    for (int i = 0; i < numSquaresPerSide; i++) {
      for (int j = 0; j < numSquaresPerSide; j++) {
        if (!squaresTaken[i][j]) {
          // give this square back if it's not already taken
          squaresTaken[i][j] = true;
          nextSquare = new Square(i * sWidth, j * sWidth, sWidth);
          break;
        }
      }

      if (nextSquare != null) {
        // get out of both loops if found a square
        break;
      }
    }

    return nextSquare;
  }
}

class Square {
  int topX, topY;
  int sWidth;

  Square(int x, int y, int squareWidth) {
    topX = x;
    topY = y;
    sWidth = squareWidth;
  }

  int getWidth() {
    return sWidth;
  }
}