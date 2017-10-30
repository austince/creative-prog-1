class Quilt {
  int topX, topY, bottomX, bottomY;
  int qWidth, qHeight;
  int sWidth;
  int numSquaresPerSide;
  private boolean[][] squaresTaken;
  Square[][] squares;

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
    squares = new Square[numSquaresPerSide][numSquaresPerSide]; // defaults to null
    for (int i = 0; i < numSquaresPerSide; i++) {
      for (int j = 0; j < numSquaresPerSide; j++) {
        squares[i][j] = new Square(i * sWidth, j * sWidth, sWidth);
      }
    }
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

  Square takeSquare(int x, int y) {
    quilt.squaresTaken[x][y] = true;
    return quilt.squares[x][y];
  }

  boolean allSquaresTaken() {
    for (int i = 0; i < numSquaresPerSide; i++) {
      for (int j = 0; j < numSquaresPerSide; j++) {
        if (!squaresTaken[i][j]) {
          return false;
        }
      }
    }

    return true;
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