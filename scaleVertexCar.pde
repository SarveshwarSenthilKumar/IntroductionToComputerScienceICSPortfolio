int scale = 50;

void setup(){
  size(1000,1000);
}

void draw (){
  background(255);
  fill(200, 100, 100);
  beginShape();
  vertex(6*scale, 12*scale);
  vertex(8*scale, 12*scale);
  vertex(8*scale, 10*scale);
  vertex(12*scale, 10*scale);
  vertex(12*scale, 12*scale);
  vertex(14*scale, 12*scale);
  vertex(14*scale, 15*scale);
  vertex(6*scale, 15*scale);
  endShape(CLOSE);
  
  int wheelDiameter = 2*scale;
  
  fill(#000000);
  ellipse(8*scale,15*scale,wheelDiameter,wheelDiameter);
  fill(#FFFFFF);
  ellipse(8*scale,15*scale,wheelDiameter/2,wheelDiameter/2);
  fill(#000000);
  ellipse(12*scale,15*scale,wheelDiameter,wheelDiameter);
  fill(#FFFFFF);
  ellipse(12*scale,15*scale,wheelDiameter/2,wheelDiameter/2);
  fill(#0000FF);
  rect(8.5*scale, 10.5*scale, 3*scale, 1.5*scale);
}