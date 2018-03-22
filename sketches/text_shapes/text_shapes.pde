import java.util.Collections;

PFont assyrian;
PFont mono;
PFont lobster;

void setup() {
  size(1200, 900);
  frameRate(30);
  assyrian  = createFont("Assyrian-48", 10);
  mono  = createFont("FreeMono-48", 10);
  lobster = createFont("LobsterTwo-48", 10);
}

void draw() {
  background(0);

  int wStep = 30;
  int hStep = 80;
  int maxVar = 14;
  int tLead = 10;
  for (int x = 0; x < width; x += wStep + random(0, maxVar)) {
    for (int y = 0; y < height; y += hStep + random(0, maxVar)) {
      fill(255 * random(.6, 1));
      float r = random(1);
      float fR = random(1);
      if (fR < .5) {
        textFont(mono);
        textLeading(tLead);
      } else if (fR < .7) {
        textFont(assyrian);
        textLeading(tLead);
      } else {
        textFont(lobster);
        textLeading(tLead);
      }

      if (r < .5) {
        text(textTriangle(6), x, y);
      } else if (r < .8) {
        text(textRhombus(6), x, y);
      } else {
        text(textSquare(6), x, y);
      }
    }
  }
}

String repeat(String s, int n) {
  return String.join("", Collections.nCopies(n, s));
}

String textTriangle(int lines) {
  String triStr = "";
  for (int line = 1; line <= lines; line++) {
    String lineStr = repeat(" ", lines - line);
    lineStr += '/';
    // Fill spaces between edges with - when the last line
    String filler = (line == lines) ? "-" : " ";
    lineStr += repeat(filler, (line - 1) * 2);
    lineStr += '\\';
    triStr += lineStr + "\n";
    //println(lineStr);
  }
  return triStr;
}


String textRhombus(int lines) {
  String rhoStr = "";
  String startBrace = "/";
  String endBrace = "\\";
  int halfLine = lines / 2;

  for (int line = 1; line <= lines; line++) {
    int adjLine = line;

    int fillLen = 1 + (2 * (line - 1));
    String filler = (line == lines || line == 1) ? "-" : " ";

    if (line > halfLine) {
      adjLine--;
      startBrace = "\\";
      endBrace = "/";
      fillLen = 1 + (2 * (lines - line));
    }

    String lineStr = repeat(" ", Math.abs(adjLine - halfLine));
    lineStr += startBrace;
    lineStr += repeat(filler, fillLen);
    lineStr += endBrace;

    rhoStr += lineStr + "\n";
    //println(lineStr);
  }
  return rhoStr;
}


String textSquare(int lines) {
  String sqStr = "";
  for (int line = 1; line <= lines; line++) {
    String lineStr = "|";
    // Fill spaces between edges with - when the last line
    String filler = (line == lines || line == 1) ? "-" : " ";
    lineStr += repeat(filler, lines);
    lineStr += '|';

    sqStr += lineStr + "\n";
    //println(lineStr);
  }
  return sqStr;
}