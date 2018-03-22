// Do you know what you're interacting with?
import java.util.StringJoiner;
import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;
import java.io.IOException;
import java.io.Writer;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.OutputStreamWriter;
import java.io.FileOutputStream;



String homeDir;
String desktopDir;
String filePath;
PrintWriter hackWriter;
String msg = "this is what i'm doing. \n right? \n\n\n\n this is a lot more work than my past life\n";

void startHackin() {
  String username = System.getProperty("user.name");
  homeDir = System.getProperty("user.home");
  StringJoiner joiner = new StringJoiner(File.separator); //Separator
  desktopDir = joiner.add(homeDir).add("Desktop").toString();
  filePath = joiner.add("interactions-with-" + username + ".txt").toString();
}

void hack(String msg2) {
  BufferedWriter writer = null;

  try {
    writer = new BufferedWriter(new FileWriter(filePath, true));
    writer.append(msg);
    writer.newLine();
    writer.append(msg2);
    writer.newLine();
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
    }
  }
}