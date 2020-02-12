class LSystem {
  //these are the instance variables
  float startX, startY;
  float segmentLength;
  float angleUnit;
  float scaleFactor;
  
  String commandString; //string that has the commands that move the point and draw lines
  String[][] ruleSet; // this is a 2D string array that has the rules
  
  //constructor
  LSystem(float theStartX, float theStartY, float theSegmentLength, float theAngleUnit, float theScaleFactor, String theCommandString, String[][] theRuleSet) {
    startX = theStartX; 
    startY = theStartY;
    segmentLength  = theSegmentLength;
    angleUnit = theAngleUnit;
    scaleFactor = theScaleFactor;
    commandString = theCommandString;
    ruleSet = theRuleSet;
  }
  
  // This method is essentially a GraphicProgram factory
  // It creates each generation of a fractal and then returns the graphic program of the desired generation
  GraphicProgram graphicGeneration(int numGenerations){
    //the value of segment length is assigned to a local variable where it will be manipulated
    float newLength = segmentLength;
    
    //for each generation, the entire command string is checked for the key in ruleSet
    for(int i = 0; i < numGenerations; ++i){
      for(int index = 0; index < commandString.length(); ++index){
         for(int k = 0; k < ruleSet.length; ++k){ 
           // if ruleSet is shorter than commandString, that means ruleSet cannot contain the commandString
           // therefore the rest of ruleSet does not need to be checked
           if (index + ruleSet[0][0].length() <= commandString.length()) {
             String lengthRule = commandString.substring(index, index + ruleSet[0][0].length());
             String startOfCommandString = commandString.substring(0, index);
             String endOfCommandString = commandString.substring(index + ruleSet[0][0].length());
             // if a section of the commandString matches the rules of transformation,
             // then the transformation is added at the exact index, right after the characters that have already been parsed
             // the rest of the string is added on after the transformation
             if (lengthRule.equals(ruleSet[k][0])){
               commandString = startOfCommandString + ruleSet[k][1] + endOfCommandString;
               index += ruleSet[k][1].length();
             }
           }
         }
       }   
     //with each new generation, the segmentLength gets smaller, so it has to be multipled by the scaleFactor at the end of every generation
     newLength *= scaleFactor;
    }
  return new GraphicProgram(startX, startY, newLength, angleUnit, commandString);
  }
}
  
