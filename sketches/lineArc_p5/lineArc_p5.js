var cHeight;
var heightStep = 10;

function setup() {
  createCanvas(400, 400);
  background(100);
   noStroke();
  //noFill();
  colorMode(HSB);
  fill(120, 220, 255, 0.29);
  cHeight = 0;
  frameRate(10);
}

function draw() {
  background(0);
    noFill();
stroke(255, 102, 255);
  arcLine(-50, cHeight, width + 50, 100, 50, 500, 3000);  
  cHeight += heightStep;
  if (cHeight > height) {
    cHeight = 0;
  }
  console.log(cHeight);
}

function arcLine(x, y, maxX, stepX, offsetX, minHeight, maxHeight) {
    let prevX = x;
  x += random(0, stepX);
  for (; x < maxX; x += random(0, stepX)) {
    let offX = random(-offsetX, offsetX);

    curve(
      prevX, y + random(minHeight, maxHeight),
      prevX, y,
      x + offsetX, y,
      x, y + random(minHeight, maxHeight)
    );

    prevX = x;
  }
}