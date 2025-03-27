/*
void setup(){
  size(500,500);
}

void draw(){
  fill(#000000);
  circle(width/2,height/2,100);
  if (dist(mouseX, mouseY, width/2, height/2)<50){
    fill(#0000ff);
    circle(width/2,height/2,100);
  }
}
*/

int smallerCircleR = 10;
int largerCircleR = 50;

void setup(){
  size(600,600);
}

void draw(){
  background(255);
  fill(#0000ff);
  circle(mouseX, mouseY, smallerCircleR*2);
  fill(#ff0000);
  circle(width/2, height/2, largerCircleR*2);
  float distance = dist(mouseX, mouseY, width/2, height/2);
  if (distance<smallerCircleR+largerCircleR){
    fill(#0000ff);
    circle(width/2, height/2, largerCircleR*2);
  }
}