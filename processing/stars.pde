
int scale = 10;
int widthOfStar = scale*10;
int heightOfStar = scale*9;

void setup() {
  size(1200, 1000);
}

void drawStar(float x, float y) {
  beginShape();
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
}

void draw() {
  background(255);
  fill(200, 100, 100);
  drawStar(0.5, 0);
  drawStar(1, 1);
  drawStar(1, 0.25);
  drawStar(0.25, 2.0);
  drawStar(7, -1);
}
