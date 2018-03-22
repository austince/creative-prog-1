import java.io.BufferedReader; //<>// //<>// //<>//
import java.io.InputStreamReader;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.util.Collections;
import java.util.ArrayList;
import java.util.List;

final String readFilename = "../output.txt";
final String instructionsFilename = "../instructions.py";
final String startText = "------start-----";
final String endText = "------end-----";
List<String> inputStrs = Collections.synchronizedList(new ArrayList<String>());

final int writeInterval = 50;
final color bgColor = color(0);
final float txtSize = 14;

void setup() {
  size(700, 900);
  background(bgColor);
  PFont assyrian = createFont("Assyrian-48", txtSize);
  PFont bitstream  = createFont("BitstreamVeraSans-BoldOblique-16", txtSize);
  PFont courier  = createFont("Courier10PitchBT-Bold-16", txtSize);
  textSize(txtSize);
  textFont(courier);
  textLeading(20);

  thread("writeToPy");
  thread("streamFromOutput");
}

String pyPrint(String txt) {
  return "print(\"\"\"" + txt.replace("\\", "\\\\") + "\"\"\")\n";
}

void writeToPy() {
  File instrucFile = new File(sketchPath(instructionsFilename));
  while (true) {
    String output;
    float r = random(1);
    if (r < .5) {
      output = textTriangle(3);
    } else if (r < .8) {
      output = textSquare(3);
    } else {
      output = textRhombus(4);
    }

    println("Python, do: \n" + output);
    BufferedWriter writer = null;
    try {
      writer = new BufferedWriter(new FileWriter(instrucFile, true));
      writer.append(pyPrint(startText));
      writer.append(pyPrint(output));
      writer.append(pyPrint(endText));
      writer.flush();
    } 
    catch (IOException ex) {
      println("bad hack");
    }
    finally {
      try {
        writer.close();
      } 
      catch (Exception ex) {
        println("bad hack");
        println(ex);
      }
    }

    try {
      Thread.sleep(writeInterval);
    } 
    catch (InterruptedException ex) {
      println("Interruped .. ");
    }
  }
}

void streamFromOutput() {
  File readFile = new File(sketchPath(readFilename));
  BufferedReader input = null;
  try {
    input = new BufferedReader(new InputStreamReader(new FileInputStream(readFile)));
    String inputStr = "";
    while (true) {
      String line = input.readLine();
      if (line == null) {
        continue;
      } else if (line.equals(startText)) {
        inputStr = "";
      } else if (line.equals(endText)) {
        // Do Something with the input
        //println("Recieved: " + inputStr);
        //println();
        inputStrs.add(inputStr);
      } else {
        // inputStr += line;
        if (random(1) < .01) {
          // breaks 
          inputStr += line;
        } else {
          inputStr += line + '\n';
        }
      }
    }
  } 
  catch (IOException ex) {
    println(ex);

    try {
      input.close();
    } 
    catch (IOException ex2) {
    }
  }
}


void draw() {
  if (inputStrs.size() > 0) {
    String nextStr = inputStrs.remove(0);
    drawInput(nextStr);
  }
}

void keyPressed() {
  if (key == 's') {
    save("code-studies-" + frameCount + ".png");
  }
}


float lineWidth = 25;
float lineHeight = 8;
float curX = 0;
float curY = 0;
void drawInput(String inputStr) {
  clearCell(curX, curY);
  fill(255 * random(.1, 1));
  text(inputStr, curX, curY);
  curY += lineHeight;

  if (curY > height) {
    curY = 0;
    curX += lineWidth;
  }

  if (curX > width) {
    curX = 0;
  }
}

void clearCell(float x, float y) {
  fill(bgColor);
  //rect(x, y, lineWidth, y);
  rect(x, y, lineWidth, lineHeight + (height * .01));
}