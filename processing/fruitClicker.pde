
import java.util.*;

//declare the variables
PImage img, img2; 
int img_x, img_y; //x and y location of the image
int speed_x, speed_y; //x and y speed of the image
String text = "Click the Mango"; //text to display on canvas
int[][] mangoes = new int[10][4];
int ticker = 0;
int tempTicker = 0;
int lastHit = 0;
int lastRound = 0;
int[] hitMangoes = new int[10];

void setup(){
  size(1000,600);
  img = loadImage("mango1.png"); //load the image
  img2 = loadImage("mangoexplosion.png"); //load the image
  img.resize(100, 100); //resize the image to 100 by 100
  img2.resize(100, 100); //resize the image to 100 by 100
  
  for (int i = 0; i<mangoes.length; i++){
    mangoes[i][0] = (int)(Math.random()*899+1); // initial x value
    mangoes[i][1] = (int)(Math.random()*499+1); // initial y value
    
    mangoes[i][2] = (int)(Math.random()*5+2); //set the x speed to random number
    mangoes[i][3] = (int)(Math.random()*5+2); //set the y speed to random number
  }
  
}

void draw(){
  background(255); //refill the background 
 
  for (int i = 0; i<mangoes.length; i++){
    if (!(hitMangoes[i]==i+1)){
      image(img, mangoes[i][0], mangoes[i][1]);
      
      if(mangoes[i][0]>= width - 100 || mangoes[i][0]<= 0){
        mangoes[i][2] = mangoes[i][2] * -1; //change the speed to the opposite
        //speed_x *= -1;
      }
      if(mangoes[i][1] >= height -100 || mangoes[i][1]<= 0){
        mangoes[i][3] = mangoes[i][3] * -1; //change the speed to the opposite
      }
      
      //update the location by adding the speed
      mangoes[i][0] = mangoes[i][0] + mangoes[i][2];
      //img_x += speed_x;
      mangoes[i][1] = mangoes[i][1] + mangoes[i][3];
    }
  }
  
  if (tempTicker == 10){
    text = "Would you like to play again? Press any key!";
  }
  else if (lastHit != 0 && second()-lastHit > 2){
    text = "It has been " + (second()-lastHit) + " seconds since you last hit a mango!";
  }
  
  //text setting: 
  textSize(20);
  fill(0);
  textAlign(CENTER, CENTER);
  text(text, width/2, 100);
}
//add mouse click 
void mousePressed(){
  for (int i = 0; i<mangoes.length; i++){
    if (!(hitMangoes[i]==i+1)){
      if(mouseX >= mangoes[i][0] && mouseX<= mangoes[i][0]+100 && mouseY >= mangoes[i][1] && mouseY <= mangoes[i][1]+100){
          ticker+=1;
          tempTicker+=1;
          hitMangoes[i]=i+1;
          if (tempTicker == 1){
            text = "You clicked the mango! Great Job! Your score is now " + tempTicker + " mango and " + ticker + " in total"; //change the text value to display on canvas;
          }
          else{
            text = "You clicked the mango! Great Job! Your score is now " + tempTicker + " mangoes and " + ticker + " in total"; //change the text value to display on canvas
          }
          lastHit = second();
          image(img2, mangoes[i][0], mangoes[i][1]);  
      } 
    }
  }
}

void keyPressed(){
  if (tempTicker == 10){
    tempTicker = 0;
    for (int i = 0; i<mangoes.length; i++){
      mangoes[i][0] = (int)(Math.random()*899+1); // initial x value
      mangoes[i][1] = (int)(Math.random()*499+1); // initial y value
      
      mangoes[i][2] = (int)(Math.random()*5+2+(ticker/10+1)); //set the x speed to random number
      mangoes[i][3] = (int)(Math.random()*5+2+(ticker/10+1)); //set the y speed to random number
    }
    tempTicker = 0;
    lastHit = 0;
    hitMangoes = new int[10];
    text = "Round " + (ticker/10+1) + ": Click the Mango";
  }
}
