/* While Loop for Stars
int scale = 10;
int widthOfStar = 10;
int heightOfStar = 10;

void setup(){
  size(1600, 1600);
  background(0);
  int stars=0;
  while (stars<12){
    stars++;
    drawStar((float)((Math.random()*20)+1), (float)((Math.random()*20)+1));
  }
}

void drawStar(float x, float y) {
  beginShape();
  fill(255,255,0);
  translate(x*widthOfStar, y*heightOfStar);
  vertex(6*scale, 1*scale);
  vertex(5*scale, 4*scale);
  vertex(2*scale, 4*scale);
  vertex(4*scale, 6*scale);
  vertex(3*scale, 9*scale);
  vertex(6*scale, 7*scale);
  vertex(9*scale, 9*scale);
  vertex(8*scale, 6*scale);
  vertex(10*scale, 4*scale);
  vertex(7*scale, 4*scale);
  endShape(CLOSE);
}*/

/* Rain Drop
void setup(){
  size(800, 800);
}

void draw(){
  background(0);
  int i = 0;
  while (i <= width){
    float dropHeight = (float)(Math.random()*height+1);
    fill(255);
    rect(i, dropHeight, 5, 15);
    i+=20;
  }
}*/