PImage road;
PImage carR;
PImage carL;

PImage car_1;
PImage car_2;

float car_x;
float car_y;
float car_x2;
float car_y2;
float car_speed = 32;
float car_speed2 = 30;

boolean flip = false;
boolean second_flip = false;

void setup(){
  size(900, 600);
  road = loadImage("road.jpg");
  carR = loadImage("carR.png");
  carL = loadImage("carL.png");
  
  car_1 = carR;
  car_2 = carL;
  
  car_x = 5;
  car_y = 470;
  car_x2 = 595;
  car_y2 = 410;

}

void draw(){
  image(road, 0, 0, width, height);
  
  if (flip)
    car_x = car_x - car_speed;
  else
    car_x = car_x + car_speed;
    
  if (second_flip)
    car_x2 = car_x2 + car_speed2;
  else
    car_x2 = car_x2 - car_speed2;
  
  if (car_y <= car_y2){
    image(car_1, car_x, car_y, 150, 100);
    image(car_2, car_x2, car_y2, 150, 100);
  }
  else{
    image(car_2, car_x2, car_y2, 150, 100);
    image(car_1, car_x, car_y, 150, 100);
  }
  
  if (car_x >= 900){
    flip = true;
    car_1 = carL;
    car_y = 410;
  }
  else if (car_x <= -150){
    flip = false;
    car_1 = carR;
    car_y = 470;
  }
  
  if (car_x2 >= 900){
    second_flip = false;
    car_2 = carL;
    car_y2 = 410;
  }
  else if (car_x2 <= -150){
    second_flip = true;
    car_2 = carR;
    car_y2 = 470;
  }
  
  if (abs((car_x-160) - car_x2) <= 20 && car_y == car_y2){
    if (car_speed < car_speed2)
      car_speed2 = car_speed;
    else
      car_speed = car_speed2;
  }
  else if (abs((car_x2-160) - car_x) <= 20 && car_y == car_y2){
    if (car_speed < car_speed2)
      car_speed2 = car_speed;
    else
      car_speed = car_speed2;
  }

}
