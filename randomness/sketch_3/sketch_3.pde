import processing.pdf.*; //<>//
import java.util.StringJoiner; //<>//

/**
 https://stackoverflow.com/questions/12616124/get-number-of-files-in-a-directory-and-its-subdirectories
 */
int countFilesRec(String dirPath) {
  File dir = new File(dirPath);
  File[] files = dir.listFiles();
  int count = 0;
  if (files != null) {
    for (File file : files) {
      count++;
      if (file.isDirectory()) {
        count += countFilesRec(file.getAbsolutePath());
      }
    }
  }

  return count;
}


String concatPath(String base, String ext) {
  StringJoiner joiner = new StringJoiner(File.separator); //Separator
  return joiner.add(base).add(ext).toString();
}

long sum(float ...args) {
  long s = 0;
  for (float a : args) {
    s += a;
  }
  return s;
}

float[] squareEach(int[] args) {
  float[] sqed = new float[args.length];
  for (int i = 0; i < args.length; i++) {
    sqed[i] = sq(args[i]);
  }
  return sqed;
}

void setup() {
  //size(800, 800);
  size(1152, 720);
  beginRecord(PDF, "sketch-3.pdf");
  println("Seeding the random generator!");
  String curDir = System.getProperty("user.dir");
  String homeDir = System.getProperty("user.home");
  String downloadsDir = concatPath(homeDir, "Downloads");
  String desktopDir = concatPath(homeDir, "Desktop");

  randomSeed(countFilesRec(downloadsDir));
  walkerSetup(width * .75, height *.75);
  colorMode(RGB);
  background(250);
  fill(color(200, 0, 50, 200));
  text("Are you hoarding in " + homeDir + "? ?", width / 4, height * .75);
  text("Are you hoarding in " + curDir + "? " + countFilesRec(curDir), width / 4, height * .8);
  text("Are you hoarding in " + desktopDir + "? " + countFilesRec(desktopDir), width / 5, height * .9);
  text("Are you hoarding in " + downloadsDir + "? " + countFilesRec(downloadsDir), width / 5, height * .7);

  String ip = getIP();
  long ipSeed = sum(squareEach(ipParts(ip)));
  println(ipSeed);
  randomSeed(ipSeed);
  textSize(20);
  text("Seeded with your " + countFilesRec(downloadsDir) + " damn files.", width / 2, height / 4);
  text("Jk: seeded at your " + ip + " damn location.", width / 4, height / 2);

  endRecord();
}

void draw() {
  walker();
}

void keyPressed() {
  if (key == 's') {
    save("random-sketch-3-" + frameCount + ".png");
  } else if (key == 'q') {
   endRecord();
   exit();
  }
}