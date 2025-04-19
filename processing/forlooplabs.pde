/*Draw Lines across Screen
void setup(){
  size(400,400);
}

void draw(){
  background(255);
  for (int i  = 0; i<=width; i+=20){
    line(i, 0, i, height);
    line(0, i, width, i);
  }
}
*/

/*Rain Drop
void setup(){
  size(800, 800);
}

void draw(){
  background(0);
  for (int i = 0; i <= width; i+=20){
    float dropHeight = (float)(Math.random()*height+1);
    fill(255);
    rect(i, dropHeight, 5, 15);
  }
}
*/

float currentHeight = 400;
float maxSpeed = 4.905;
float maxHeight= 400;
float tempMax = 400;
boolean hitGround;

void setup(){
  size(800, 800);
}

void draw(){
  background(255);
  fill(255,000,000);
  currentHeight+=maxSpeed;
  println(abs(maxHeight-height));
  if (abs(maxHeight-height) <= 400){
    if (currentHeight>=height-50){
      maxSpeed *= -0.9;
      hitGround = true;
      maxHeight=tempMax;
      print(maxHeight);
    }
    else if (currentHeight<=maxHeight-50){
      maxSpeed*=-0.9;
      tempMax=maxHeight*1.5;
    }
    circle(width/2, currentHeight, 100);
  }
  else{
    circle(width/2, 750, 100); 
  }
  
}