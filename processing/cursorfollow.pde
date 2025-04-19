int rect_width;
int rect_height;

void setup(){
  size(1000, 1000);
  
  int circleDiameter = 50;
  float circleSpeed = 2.5;
  color circleColor = #FF5733;
  
  println(circleDiameter);
  println(circleSpeed);
  println(circleColor);

}

int ellipseX = 50;
int ellipseY = 50;
float ellipseSize = 25;
color ellipseColor = #90CAF9;

void draw(){
  background(255);
  float circleX = mouseX;
  float circleY = mouseY;
  fill(ellipseColor);
  ellipse(circleX,circleY,ellipseX,ellipseY);

}