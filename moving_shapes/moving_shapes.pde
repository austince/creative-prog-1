PositionedText txt;
PFont font;
String[] overheard = {
  "confused?", 
  "what makes you happy?", 
  "i've noticed you eat alone.", 
  "how much do you love lemons", 
  "are squirrels hungry", 
  "are you trying to leave", 
  "what do you think about \n when you think about squirrels", 
  "have you heard how shitty \n the nfl is lately?", 
  "what bothers you", 
  "do you know what i'm doing?", 
  "maybe i think you do", 
  "maybe you think you do", 
  "maybe you think i do", 
  "maybe i think i do", 
};
int currentPhrase = 0;

boolean clearBg = true;
boolean drawBgRects = true;


void setup() {
  //size(1600, 800);
  size(1280, 1024);
  //size(1920, 1080);
  font = loadFont("Colfax-Thin-48.vlw");
  textFont(font, 32);
  noCursor();
   noStroke();
  background(color(255));
  startHackin();
  
  println(
  "USAGE:", 
  "c - toggle background clearing \n",
  "z - toggle background rectangle drawing \n",
  "s - save an image \n",
  "q - quiiiiit!"
  );
}

void draw() {
  if (clearBg) {
    clear();
    background(color(255));
  }

  if (drawBgRects) {
    splitRect(mouseX * 2, mouseY * 2);
    splitRect(mouseX, mouseY);
  }

 
  spinningRects(mouseX, mouseY, 50, 50);

  for (int i = 150; i < 200; i += 10) {
    for (int j = 150; j < 200; j += 10) {
      squarePathCircles(mouseX - i, mouseY - j, i, 10);
      squarePathCircles(mouseX + i, mouseY - j, i, 10);
      squarePathCircles(mouseX + i, mouseY + j, i, 10);
    }
  }

  squarePathCircles(mouseX, height - mouseY, 50, 20);
  squarePathCircles(width - mouseX, mouseY, 50, 20);

  spinningCircles(width - mouseX, height - mouseY, 150, 100);
  //  spinningCircles(width + mouseX, height + mouseY, 150, 100);

  if (txt != null) {
    fill(color(0));
    textMode(MODEL);
    textSize(txt.size);
    text(txt.value, txt.pt.x - txt.size, txt.pt.y - txt.size);
    txt.update();
    if (txt.size >= txt.stopSize) {
      txt = null;
    }
  }
}

void mouseClicked() {
  makeText();
  hack(txt.value);
}

void keyPressed() {

  if (key == 'c') {
    clearBg = !clearBg;
  } else if (key == 'z') { 
    drawBgRects = !drawBgRects;
  } else if (key == 's') {
    println("Saved to 'saves/shapes" + frameCount + ".png'");
    save("saves/shapes" + frameCount + ".png");
  } else if (key == 'q') {
    exit();
  } else {
    makeText();
  }
}

void makeText() {
  // Start text descention
  txt = new PositionedText(overheard[currentPhrase], mouseX, mouseY);
  currentPhrase = (currentPhrase + 1) % overheard.length;
}

class PositionedText {
  int fallRate = 2;
  int growRate = 1;
  int size = 1;
  int stopSize = 105;
  String value; 
  PVector pt;


  PositionedText(String t, float x, float y) {
    this.value = t; 
    this.pt = new PVector(x, y);
  }

  void update() {
    this.pt.y += fallRate; 
    this.size += growRate;
  }
}