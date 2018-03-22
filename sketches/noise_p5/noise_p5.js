let detail =    0.6;      // amount of detail in the noise (0-1)
let increment = 0.002;    // how quickly to move through noise (0-1) 

function setup() {
  createCanvas(800, 800);
  noiseDetail(8, detail);
  makeNoise();
}

function draw() {
}

function colorPixel(x, y, c) {
  var d = pixelDensity();
  for (var i = 0; i < d; i++) {
    for (var j = 0; j < d; j++) {
      // loop over
      idx = 4 * ((y * d + j) * width * d + (x * d + i));
      pixels[idx] = red(c);
      pixels[idx+1] = green(c);
      pixels[idx+2] = blue(c);
      pixels[idx+3] = alpha(c);
    }
  }
}

function makeNoise(step = 1) {
  loadPixels();
  let d = pixelDensity();
  let widthD = width * d;
  let heightD = height * d;
  for (let x = 0; x < widthD; x += step) {
    for (let y = 0; y < heightD; y += step) {

      // noise() returns a value 0-1, so multiply
      // by 255 to get a number we can use for color
      let gray = noise(x*increment, y*increment) * 255;

      // set the current pixel to the value from noise()
      colorPixel(x, y, color(gray));
    }
  }
  updatePixels();
}
