import java.io.*;
import java.util.Scanner;

import javax.swing.JOptionPane;
// PrintWriter output;

class GraphicProgram {
  float startX, startY;
  float segmentLength;
  float angleUnit;
  
  String commandString; // string that has the commands that move the point and draw lines
  
  // constructor
  GraphicProgram(float theStartX, float theStartY, float theSegmentLength, float theAngleUnit, String theCommandString) {
    startX = theStartX; 
    startY = theStartY;
    segmentLength  = theSegmentLength;
    angleUnit = theAngleUnit;
    commandString = theCommandString;
  }
  
  // this creates a file that gnuplot can read
  String gnuplotForm() {
     // push and pop are used since translate is used in this method
     pushMatrix();
     
     translate(startX, startY);
     
     // this is an empty string that will have chars added to it
     // this string will be written to a txt file
     String outStr = "";
     
     PMatrix2D pm2D = new PMatrix2D();
     
     // these create the comments at the beginning of the file
     outStr += "#  Width = " + width;
     outStr += "\n#  Height = " + height;
     outStr += "\n# startX = " + startX;
     outStr += "\n# startY = " + startY;
     outStr += "\n# segmentLength = " + segmentLength;
     outStr += "\n# angleUnit = " + angleUnit;
     outStr += "\n# commandString = " + commandString;
     outStr += "\n";
     
     for(int i = 0; i < commandString.length(); ++i){
        // I originally used if and else if statements to determine this
        // but the professor pointed out that switch is more efficient
        // This set of cases determines the next command dictated by commandString
        // The command is then executed and each new set of coodinates is added to outStr
        switch (commandString.charAt(i)){
          case 'F':
            //outStr += startX + " " + startY;
            
            //access each point on the matrix and add it to the string
            getMatrix(pm2D);
            outStr += pm2D.m02 + "  \t" + pm2D.m12 + "\n" ;
            
            //move to the end of the line and add that point to the string
            translate(segmentLength, 0);
            getMatrix(pm2D);
            outStr += pm2D.m02 + "  \t" + pm2D.m12 + "\n" ;
            break;
          case 'f': 
            translate(segmentLength, 0);
            break;
          case '+': 
            rotate(angleUnit);
            break;
          default: 
            rotate(-angleUnit);
            break;
        }
     }
     popMatrix();
     return outStr;
  }
  
  // this method creates a new file and writes outStr to it
  void createFile(String myStr, String outputFile) {
    // the outfile is made
    PrintWriter outFile = null;

    try {
      outFile = new PrintWriter(new FileWriter(outputFile));
    }
    catch (IOException e) {
      JOptionPane.showMessageDialog(null, "Error opening output file" + outputFile,
          "IO error", JOptionPane.ERROR_MESSAGE);
      System.exit(0);
    }

    //  I write my string into the file
    outFile.println(myStr);

    // The outfile is quit before the application is closed
    outFile.close();
  }
  
  // all of the commands in commandString are executed and the image is drawn
  public void draw() {
     stroke(#1A2A89);
     pushMatrix();
     
     // the origin is now at the point (startX, startY)
     translate(startX, startY);
     
    // this loop goes through each letter in the string of commands 
    for(int i = 0; i < commandString.length(); ++i){
      switch (commandString.charAt(i)){
          case 'F':
            // a line is drawn and then the program moves to the coordinate at the end of the line
            line(0, 0, segmentLength, 0);
            translate(segmentLength, 0);
            break;
          case 'f': 
            // move to a new coordinate
            translate(segmentLength, 0);
            break;
          case '+': 
            // rotates clockwise
            rotate(angleUnit);
            break;
          default: 
            // rotates counterclockwise
            rotate(-angleUnit);
            break;
      }
    }
  popMatrix();
  }
}
