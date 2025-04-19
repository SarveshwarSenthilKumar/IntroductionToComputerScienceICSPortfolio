int width = 500;
int height = 500;

float wheelDiameter = width*0.13;
float carWidth = width*0.49;
PImage road, tree, cloud;
int randomX = (int)(Math.random()*501)+250;

void setup() {
  size(1000, 1000);
  road = loadImage("road2.png");
  tree = loadImage("tree.png");
  cloud = loadImage("cloud.png");
}

void drawCloud(int x, int y, int size){
  image(cloud,x, y,size,size);
}

void drawRoad(){
  image(road,0,500,1000,600);
}

void drawTree(int x){
  image(tree, x, 300, 250, 330);
}

void draw() {
  drawRoad();
  drawTree(randomX);
  drawCloud(200, 0, 200);
  
  noFill();
  fill(#FFFFFF);
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
 

}