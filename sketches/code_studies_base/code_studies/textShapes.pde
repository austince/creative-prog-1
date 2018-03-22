import java.util.Collections;

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