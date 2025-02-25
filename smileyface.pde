void setup() {
  size(1000, 1000);
}

void draw() {
  noFill();
  fill(#C68863);
  ellipse(380,300,540,600);
  noFill();
  for (int i=200;i<220;i++){
    arc(250, i, 210, 70, PI, PI+PI);
  }
  fill(255,255,255);
  ellipse(250,250,200,100);
  fill(0,0,0);
  ellipse(250,250,90,100);
  fill(255,255,255);
  ellipse(265,240,40,40);
  for (int i=200;i<220;i++){
    noFill();
    arc(250, i, 210, 70, PI, PI+PI);
  }
  int increment = 270;
  fill(255,255,255);
  ellipse(250+increment,250,200,100);
  fill(0,0,0);
  ellipse(250+increment,250,90,100);
  fill(255,255,255);
  ellipse(265+increment,240,40,40);
  for (int i=200;i<220;i++){
    noFill();
    arc(250+increment, i, 210, 70, PI, PI+PI);
  }
  
  for (int i=400;i<420;i++){
    noFill();
    arc(250+increment/2, i, 300, 120, PI+PI, PI*3);
  }
}
