GraphicProgram[] graphicList;
LSystem[] systemList;

void settings(){
    size(600, 600);
}

void setup(){
    background(230);
    noLoop(); // this removes a horizontal line drawn from (0,0) to segmentLength on the x-axis

    //  This was the code I used to test the smiley face
    //  graphicProgram[] tempList = {
    //    new graphicProgram(width/8, 7*height/8, width/8, HALF_PI, "FFFFFF-FFFFFF-FFFFFF-FFFFFF-f-ff++F-FFFF-FffF-F-F-F++fffF+F+F+F-f+FF"),
    //  };
    //  graphicList = tempList;
    
    // the 2D arrays that form the various rule sets are defined
    String[][] ruleSet1 = {{"F", "F-F++F-F"}};
    String[][] ruleSet2 = {{"F-F", "F-FF++FFF++FF-F"}};
    String[][] ruleSet3 = {{"FF", "FF+FF--FFF--FF+F"}};
    
    // the Koch fractal and my two original fractals are created here
    LSystem[] tempList = {
      new LSystem(width/8, 9*height/10, 3*width/4, PI/3.0, 1/3., "F", ruleSet1),
      new LSystem(width/6, 1*height/6, width/5, PI/4.0, 3/4., "F-F", ruleSet2),
      new LSystem(5*width/6, 2*height/5, width/5, 4*PI/3.0, 2/3., "FF", ruleSet3)
    };
     
    systemList = tempList;
 
    // All of the fractals are created up to the desired generation and written to a file
    graphicList = new GraphicProgram[systemList.length];
    for(int i = 0; i < systemList.length; ++i){
      graphicList[i] = systemList[i].graphicGeneration(5);
      String myStr = graphicList[i].gnuplotForm();
      graphicList[i].createFile(myStr, "fractals_" + i + ".dat");
    }
}

void draw(){
  // These are my method calls to draw my smile and write it to a file
  // In the future, I would only put the draw function here and the rest would go in setup
  // However, I left this code just so you could see that I did indeed do the smile
  //  for(int i = 0; i < graphicList.length; ++i){
  //    graphicList[i].draw();
  //    String myStr = graphicList[i].gnuplotForm();
  //    graphicList[i].createFile(myStr, "graphPoints.dat");
  //  }
  
   for(int j = 0; j < graphicList.length; ++j){
     graphicList[j].draw();
   }
}
