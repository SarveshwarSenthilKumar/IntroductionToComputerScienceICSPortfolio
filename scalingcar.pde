int width = 1000;
int height = 1000;

float wheelDiameter = width*0.13;
float carWidth = width*0.49;
PImage img;

void setup() {
  size(1000, 1000);
  //add road.jpg to the same folder and adjust accordingly
  img = loadImage("road.jpg");
  background(255);
}

void draw() {
  noFill();
  image(img,0,0,1000,1000);
  fill(#FFFFFF);
  rect(width*0.25,height*0.29+height*0.1,carWidth+width*0.08,carWidth-width*0.36, 40,40,0,0);
  fill(#000000);
  rect(width*0.26,height*0.30+height*0.1,carWidth+width*0.06,carWidth-width*0.37, 40,40,0,0);
  noFill();
  fill(#FFFFFF);
  rect(width*0.12,height*0.42+height*0.1,carWidth+width*0.24,carWidth-width*0.30, 40,40,40,40);
  fill(#EFE7DB);
  rect(width*0.12,height*0.45+height*0.1,height*0.09,width*0.05, 0,40,40,0);
  fill(#FF0000);
  rect(width*0.12+carWidth+width*0.18,height*0.45+height*0.1,width*0.06,height*0.05, 40,0,0,40);
  fill(#8b0000);
  rect(width*0.12+carWidth+width*0.18,height*0.485+height*0.1,width*0.06,height*0.01, 40,0,0,40);
  fill(#FFA500);
  rect(width*0.12,height*0.49+height*0.1,height*0.05,width*0.02, 0,40,40,0);
  fill(#3c4142);
  rect(width*0.1,height*0.56+height*0.1,carWidth+width*0.28,width*0.05, 40,40,40,40);
  fill(#FFFFFF);
  arc(width*0.3,height*0.6+height*0.1,wheelDiameter+height*0.02,wheelDiameter+height*0.02,PI-PI/16,PI+PI+PI/16);
  arc(width*0.25+carWidth,height*0.6+height*0.1,wheelDiameter+height*0.02,wheelDiameter+height*0.02,PI-PI/16,PI+PI+PI/16);
  fill(#000000);
  ellipse(width*0.3,height*0.6+height*0.1,wheelDiameter,wheelDiameter);
  fill(#FFFFFF);
  ellipse(width*0.3,height*0.6+height*0.1,wheelDiameter/2,wheelDiameter/2);
  fill(#000000);
  ellipse(width*0.25+carWidth,height*0.6+height*0.1,wheelDiameter,wheelDiameter);
  fill(#FFFFFF);
  ellipse(width*0.25+carWidth,height*0.6+height*0.1,wheelDiameter/2,wheelDiameter/2);
 

}