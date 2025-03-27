int scale = 10;

void setup(){
  size(880, 480);
  background(#ADD8E6);
 
  //Generates whether the pawn and rook will be white or black respectively
  int whiteOrBlack = (int)(Math.random()*2);
  int whiteOrBlack2 = (int)(Math.random()*2);

  translate(0, -18*scale); //Makes the nameplate fit on the screen
  drawPawn(whiteOrBlack);
  drawRook(whiteOrBlack2);
  drawFlag();
  drawX();
  drawPlus();
  drawMinus();
  drawMonitor();
  drawCar(25, 66*scale, 13.4*scale);
}

void draw(){
  translate(0, -18*scale);
  drawName();
}

void mouseClicked(){
  //Generates whether the pawn and rook will be white or black respectively
  int whiteOrBlack = (int)(Math.random()*2);
  int whiteOrBlack2 = (int)(Math.random()*2);
 
  drawPawn(whiteOrBlack);
  translate(0,0);
  drawName(); //Draws name instantly to prevent pawn fazing through
  drawRook(whiteOrBlack2);
}

void drawCar(int scale, float x, float y){
  noFill();
  fill(#FFFFFF);
 
  int width = scale*10;
  int height = scale*10;
 
  translate(x, -y);
  float wheelDiameter = width*0.13;
  float carWidth = width*0.49;
  rect(width*0.25,height*0.29+height*1.2,carWidth+width*0.08,carWidth-width*0.36, 40,40,0,0);
  fill(#000000);
  rect(width*0.26,height*0.30+height*1.2,carWidth+width*0.06,carWidth-width*0.37, 40,40,0,0);
  noFill();
  fill(#FFFFFF);
  rect(width*0.12,height*0.42+height*1.2,carWidth+width*0.24,carWidth-width*0.30, 40,40,40,40);
  fill(#EFE7DB);
  rect(width*0.12,height*0.45+height*1.2,height*0.09,width*0.05, 0,40,40,0);
  fill(#FF0000);
  rect(width*0.12+carWidth+width*0.18,height*0.45+height*1.2,width*0.06,height*0.05, 40,0,0,40);
  fill(#8c0000);
  rect(width*0.12+carWidth+width*0.18,height*0.485+height*1.2,width*0.06,height*0.01, 40,0,0,40);
  fill(#FFA500);
  rect(width*0.12,height*0.49+height*1.2,height*0.05,width*0.02, 0,40,40,0);
  fill(#3c4142);
  rect(width*0.1,height*0.56+height*1.2,carWidth+width*0.28,width*0.05, 40,40,40,40);
  fill(#FFFFFF);
  arc(width*0.3,height*0.6+height*1.2,wheelDiameter+height*0.02,wheelDiameter+height*0.02,PI-PI/16,PI+PI+PI/16);
  arc(width*0.25+carWidth,height*0.6+height*1.2,wheelDiameter+height*0.02,wheelDiameter+height*0.02,PI-PI/16,PI+PI+PI/16);
  fill(#000000);
  ellipse(width*0.3,height*0.6+height*1.2,wheelDiameter,wheelDiameter);
  fill(#FFFFFF);
  ellipse(width*0.3,height*0.6+height*1.2,wheelDiameter/2,wheelDiameter/2);
  fill(#000700);
  ellipse(width*0.25+carWidth,height*0.6+height*1.2,wheelDiameter,wheelDiameter);
  fill(#FFFFFF);
  ellipse(width*0.25+carWidth,height*0.6+height*1.2,wheelDiameter/2,wheelDiameter/2);
  //Resetting translation for next drawing
  translate(-x, y);
}

void drawMonitor(){
  fill(#727272);
  //Base of the monitor
  rect(10*scale, 22*scale, 2*scale, 10*scale);
  //Monitor stalk
  rect(8*scale, 26*scale, 2*scale, 2*scale);
  //Main monitor
  rect(scale, 21*scale, 8*scale, 12*scale);
  fill(0,0,100);
  //Screen
  rect(2*scale, 22*scale, 6*scale, 10*scale);
  fill(255);
}

void drawMinus(){
  fill(#D4FAFA);
  rect(25*scale, 22*scale, 16*scale, 5*scale);
}

void drawPlus(){
  //Changed scale of plus to make it more visually appealing
  beginShape();
  fill(#9CBD88);
  vertex(25*scale, 40*scale);
  vertex(20*scale, 40*scale);
  vertex(20*scale, 32*scale);
  vertex(12*scale, 32*scale);
  vertex(12*scale, 27*scale);
  vertex(20*scale, 27*scale);
  vertex(20*scale, 19*scale);
  vertex(25*scale, 19*scale);
  vertex(25*scale, 27*scale);
  vertex(32*scale, 27*scale);
  vertex(32*scale, 32*scale);
  vertex(25*scale, 32*scale);
  endShape(CLOSE);
}

void drawX(){
  beginShape();
  fill(#A1291A);
  vertex(15*scale, 45*scale);
  vertex(20*scale, 50*scale);
  vertex(25*scale, 50*scale);
  vertex(20*scale, 45*scale);
  vertex(25*scale, 40*scale);
  vertex(20*scale, 40*scale);
  vertex(17.5*scale, 42.5*scale);
  vertex(15*scale, 40*scale);
  vertex(10*scale, 40*scale);
  endShape(CLOSE);
}

void drawRook(int whiteOrBlack){
  //Changed scale of rook to make the nameplate more visually appealing
 
  fill(whiteOrBlack*255);
 
  //Base of the rook
  beginShape();
  vertex(54*scale, 45*scale);
  vertex(54*scale, 42*scale);
  vertex(68*scale, 42*scale);
  vertex(68*scale, 45*scale);
  endShape(CLOSE);
 
  //Stalk of the Rook
  beginShape();
  vertex(54*scale, 42*scale);
  vertex(58*scale, 39*scale);
  vertex(58*scale, 25*scale);
  vertex(64*scale, 25*scale);
  vertex(64*scale, 39*scale);
  vertex(68*scale, 42*scale);
  endShape(CLOSE);
 
  //Head of the Rook
  beginShape();
  translate(-0.5*scale, -5*scale);
  vertex(58*scale, 30*scale);
  vertex(56*scale, 30*scale);
  vertex(56*scale, 25*scale);
  vertex(58*scale, 25*scale);
  vertex(58*scale, 29*scale);
  vertex(59*scale, 29*scale);
  vertex(59*scale, 25*scale);
  vertex(61*scale, 25*scale);
  vertex(61*scale, 29*scale);
  vertex(62*scale, 29*scale);
  vertex(62*scale, 25*scale);
  vertex(64*scale, 25*scale);
  vertex(64*scale, 29*scale);
  vertex(65*scale, 29*scale);
  vertex(65*scale, 25*scale);
  vertex(67*scale, 25*scale);
  vertex(67*scale, 30*scale);
 
  endShape(CLOSE);
  translate(0, 5*scale);
 
}

void drawPawn(int whiteOrBlack){
  fill(whiteOrBlack*255);
  //Base of the pawn
  beginShape();
  vertex(40*scale, 50*scale);
  vertex(52*scale, 50*scale);
  vertex(52*scale, 48*scale);
  vertex(40*scale, 48*scale);
  endShape(CLOSE);
 
  //Round base of pawn
  beginShape();
  vertex(40*scale, 48*scale);
  vertex(45*scale, 45*scale);
  vertex(52*scale, 45*scale);
  vertex(57*scale, 48*scale);
  endShape(CLOSE);
 
  //Base of the stalk of the pawn
  beginShape();
  vertex(45*scale, 45*scale);
  vertex(45*scale, 44*scale);
  vertex(52*scale, 44*scale);
  vertex(52*scale, 45*scale);
  endShape(CLOSE);
 
  //Stalk of the pawn
  beginShape();
  vertex(46*scale, 44*scale);
  vertex(46*scale, 32*scale);
  vertex(51*scale, 32*scale);
  vertex(51*scale, 44*scale);
  endShape(CLOSE);
 
  //Top sphere of the pawn
  circle(48.5*scale, 28*scale, 7*scale);
 
  //Base of the top sphere of the pawn
  beginShape();
  vertex(45*scale, 32*scale);
  vertex(45*scale, 31*scale);
  vertex(52*scale, 31*scale);
  vertex(52*scale, 32*scale);
  endShape(CLOSE);
 
}

void drawFlag(){
 
  int x = 68;
  int y = 45;
  int sizeX = 19;
  int sizeY = 4;
 
  //Three rectangles correlating to the different sections of the flag
  fill(#138808);
  rect(x*scale, (y-sizeY)*scale, sizeX*scale, sizeY*scale);
  fill(#FFFFFF);
  rect(x*scale, (y-sizeY*2)*scale, sizeX*scale, sizeY*scale);
  fill(#FF671F);
  rect(x*scale, (y-sizeY*3)*scale, sizeX*scale, sizeY*scale);
 
  //Three circles for the wheel in the middle of the flag
  fill(#06038D);
  circle(x*scale+sizeX*scale/2, (y-sizeY*1.5)*scale, sizeY*scale);
  fill(#FFFFFF);
  circle(x*scale+sizeX*scale/2, (y-sizeY*1.5)*scale, sizeY*0.8*scale);
  fill(#06038D);
  circle(x*scale+sizeX*scale/2, (y-sizeY*1.5)*scale, sizeY*0.5*scale);
}

void drawName(){
  //Letters are written backwards in order to prevent overlap
 
  //Colors change based on cursor position
 
  //Draws the second R of Sarveshwar (the last letter)
  beginShape();
  fill(mouseX, mouseY, (mouseX+mouseY)%255);
  vertex(77*scale, 45*scale);
  vertex(87*scale, 45*scale);
  vertex(87*scale, 54*scale);
  vertex(77*scale, 54*scale);
  endShape(CLOSE);
  beginShape();
  vertex(78*scale, 54*scale);
  vertex(87*scale, 65*scale);
  vertex(77*scale, 65*scale);
  endShape(CLOSE);
 
  //Draws the second A of Sarveshwar
  beginShape();
  fill(mouseY, (mouseX+mouseY)%255, mouseX);
  vertex(74*scale, 65*scale);
  vertex(77*scale, 45*scale);
  vertex(80*scale, 65*scale);
  endShape(CLOSE);
 
  //Draws the W of Sarveshwar
  beginShape();
  fill((mouseX+mouseY)%255, mouseX, mouseY);
  vertex(64*scale, 45*scale);
  vertex(67*scale, 65*scale);
  vertex(70*scale, 45*scale);
  endShape(CLOSE);
  beginShape();
  vertex(70*scale, 45*scale);
  vertex(73*scale, 65*scale);
  vertex(76*scale, 45*scale);
  endShape(CLOSE);
 
  //Draws the H of Sarveshwar
  beginShape();
  fill(mouseX, mouseY, (mouseX+mouseY)%255);
  vertex(54*scale, 45*scale);
  vertex(57*scale, 45*scale);
  vertex(57*scale, 54*scale);
  vertex(60*scale, 54*scale);
  vertex(60*scale, 45*scale);
  vertex(64*scale, 45*scale);
  vertex(64*scale, 65*scale);
  vertex(60*scale, 65*scale);
  vertex(60*scale, 57*scale);
  vertex(57*scale, 57*scale);
  vertex(57*scale, 65*scale);
  vertex(54*scale, 65*scale);
  endShape(CLOSE);
 
  //Draws the second S of Sarveshwar
  beginShape();
  fill(mouseY, (mouseX+mouseY)%255, mouseX);
  vertex(48*scale, 50*scale);
  vertex(54*scale, 45*scale);
  vertex(64*scale, 45*scale);
  vertex(59*scale, 50*scale);
  vertex(54*scale, 50*scale);
  vertex(50*scale, 54*scale);
  vertex(59*scale, 54*scale);
  vertex(48*scale, 65*scale);
  vertex(48*scale, 62*scale);
  vertex(54*scale, 57*scale);
  vertex(48*scale, 57*scale);
  endShape(CLOSE);
 
  //Draws the E of Sarveshwar
  beginShape();
  fill((mouseX+mouseY)%255, mouseX, mouseY);
  vertex(40*scale, 50*scale);
  vertex(40*scale, 65*scale);
  vertex(48*scale, 65*scale);
  vertex(48*scale, 62*scale);
  vertex(43*scale, 62*scale);
  vertex(43*scale, 60*scale);
  vertex(48*scale, 60*scale);
  vertex(48*scale, 57*scale);
  vertex(43*scale, 57*scale);
  vertex(43*scale, 54*scale);
  vertex(48*scale, 54*scale);
  vertex(48*scale, 50*scale);
  vertex(43*scale, 50*scale);
  endShape(CLOSE);
 
  //Draws the V of Sarveshwar
  beginShape();
  fill(mouseX, mouseY, (mouseX+mouseY)%255);
  vertex(36*scale, 65*scale);
  vertex(36*scale, 62*scale);
  vertex(40*scale, 50*scale);
  vertex(44*scale, 50*scale);
  endShape(CLOSE);
 
  //Draws the R of Sarveshwar
  beginShape();
  fill(mouseY, (mouseX+mouseY)%255, mouseX);
  vertex(27*scale, 52*scale);
  vertex(34*scale, 50*scale);
  vertex(36*scale, 55*scale);
  vertex(36*scale, 57*scale);
  vertex(27*scale, 57*scale);
  endShape(CLOSE);
  beginShape();
  vertex(27*scale, 57*scale);
  vertex(36*scale, 65*scale);
  vertex(36*scale, 62*scale);
  vertex(30*scale, 57*scale);
  endShape(CLOSE);
  //Creating the hole in R
  beginShape();
  fill(#ADD8E6);
  translate(4*scale, -4*scale);
  vertex(29*scale, 56*scale);
  vertex(29*scale, 60*scale);
  vertex(25*scale, 60*scale);
  vertex(25*scale, 56*scale);
  endShape(CLOSE);

  //Draws the A of Sarveshwar
  beginShape();
  fill((mouseX+mouseY)%255, mouseX, mouseY);
  translate(-4*scale, 4*scale);
  vertex(20*scale, 60*scale);
  vertex(26*scale, 60*scale);
  vertex(26*scale, 65*scale);
  vertex(30*scale, 65*scale);
  vertex(30*scale, 56*scale);
  vertex(27*scale, 52*scale);
  vertex(22*scale, 52*scale);
  vertex(18*scale, 59*scale);
  endShape(CLOSE);
  //Creating the hole in A
  beginShape();
  fill(#ADD8E6);
  translate(-3*scale, -3*scale);
  vertex(29*scale, 56*scale);
  vertex(32*scale, 60*scale);
  vertex(25*scale, 60*scale);
  vertex(27*scale, 56*scale);
  endShape(CLOSE);
 
  //Draws the S of Sarveshwar
  beginShape();
  fill(mouseX, mouseY, (mouseX+mouseY)%255);
  translate(3*scale, 3*scale);
  vertex(20*scale, 50*scale);
  vertex(15*scale, 45*scale);
  vertex(10*scale, 45*scale);
  vertex(5*scale, 50*scale);
  vertex(15*scale, 60*scale);
  vertex(5*scale, 60*scale);
  vertex(5*scale, 55*scale);
  vertex(1*scale, 60*scale);
  vertex(5*scale, 65*scale);
  vertex(15*scale, 65*scale);
  vertex(20*scale, 60*scale);
  vertex(10*scale, 50*scale);
  endShape(CLOSE);
 
}
