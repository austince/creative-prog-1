// an array of colors to randomly choose from
color[] colors;

float x, y, px, py;    // values for drawing lines


void walkerSetup(float initX, float initY) {
  x = px = initX;
  y = py = initY;
  
  colorMode(HSB);
  colors = new color[4];
  colors[0] = color(255, 150, 50);
  colors[1] = color(150, 255, 50);
  colors[2] = color(0, 150, 255);
  colors[3] = color(150, 50, 255);
}

void walker() {
  // select a random color for each line
  // note that we have to "cast" the random value to an
  // integer, since random() returns a float but array
  // indices are integers
  int whichColor = int(random(0, colors.length));
  stroke(colors[whichColor]);

  // draw a line from the current to the
  // previous position
  line(x, y, px, py);

  // save current position as the previous
  px = x;
  py = y;

  // pick a random direction for the next line
  // random(1) returns a random value b/w 0-1
  // if less than 0.5 (50% chance), draw in the
  // x direction, otherwise draw in the y direction
  if (random(1) < 0.5) {
    if (random(1) < 0.5) {    // do the same thing to determine left or right!
      x -= 8;
    } else {
      x += 8;
    }
  } else {
    if (random(1) < 0.5) {
      y -= 8;
    } else {
      y += 8;
    }
  }
  
  if ( y > height) {
    y = height;
  } else if (y < 0) {
    y = 0;
  }
  
   if ( x > width) {
    x = width;
  } else if (x < 0) {
    x = 0;
  }
}