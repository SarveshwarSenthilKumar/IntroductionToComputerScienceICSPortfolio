
String text;
int chosenImage = 0;
PImage character, bg, object, heart;
String currentStage = "start";
int characterX, characterY;
int[][] objects = new int[100][5];
PImage[] images = new PImage[20];
int characterLives = 4;
int score = 0;
String currentMode = "keys";

void setup(){
  size(1400,800);
  
  heart = loadImage("heart.png");
  heart.resize(50,50);
    
  characterX = width/2;
  characterY = height-150;
  character = loadImage("jetpackguy.png");
  
  object = loadImage("meteor.png");
  object.resize(100, 100);
  for(int i=0; i<6; i++){
    images[i]=object;
  }
  
  object = loadImage("bricks.png");
  object.resize(100, 100);
  for(int i=6; i<13; i++){
    images[i]=object;
  }
  
  object = loadImage("rocks.png");
  object.resize(100, 100);
  images[2]=object;
  for(int i=13; i<19; i++){
    images[i]=object;
  }
  
  object = loadImage("mango1.png");
  object.resize(100, 100);
  images[19]=object;
  
  displayStartMenu();
}

void draw(){
  if (currentMode == "mouse"){
    characterX = mouseX;
  }
  if (currentStage == "game"){
    bg = loadImage("background2.jpg");
    bg.resize(1400,800);
    image(bg, 0, 0);
    image(character, characterX, characterY);
    
    textSize(50);
    fill(255);
    textAlign(CENTER, CENTER);
    text(score, width/2, 100);
    
    drawLives();
    
    boolean allFloor = true;
    for (int i=0; i<objects.length; i++){
      if (objects[i][2] != 0){
        image(images[objects[i][3]], objects[i][0], objects[i][1]);
        objects[i][1] += objects[i][2];
        if (objects[i][1] < height-100){
          allFloor = false;
        }
        boolean hit = checkCollision(objects[i][0], objects[i][1], 100, 100, characterX, characterY, 100);
        
        if (hit){
          characterLives+=objects[i][4];
          objects[i][2] = 0;
        }
        else if (objects[i][1]>=height-100){
          score+=objects[i][2]*3*objects[i][4]*-1;
          objects[i][2] = 0;
        }
      }
      
      if (characterLives<=0){
        currentStage = "gameover";
      }

    }
    
    if(allFloor){
      createObject();
    } 
  }
}

void mouseClicked(){
  if (currentStage == "start"){
    if (mouseX>=width/2-200&&mouseX<=width/2+400){
      if (mouseY>=height/2+250&&mouseY<=height/2+350){
        currentStage = "game";
        createObject();
      }
      else{
        currentMode = "mouse";
      }
    }
    else{
      currentMode = "mouse";
    }
  }
}

void keyPressed(){
  if (currentStage == "game"){
      if (key == 'a' || key == 'A'){
        if (characterX > 0){
          characterX -= 12;
        }
      }
      else if (key == 'd' || key == 'D'){
        if (characterX < width-150){
          characterX += 12;
        }
      }
  }
  
  else if (currentStage == "start"){
    currentMode = "keys";
  }
}

boolean checkCollision(int x, int y, int height1, int width1, int characterX, int characterY, int charWidth){
  
  if (characterX+charWidth >= x-15 && characterX+charWidth <= x+width1+15){
    if (characterY <= height1+y){
      return true;
    }
  }
  return false;
} 

void drawLives(){
  for (int i=0; i<characterLives; i++){
    image(heart, 20+i*60, 50);
  }
}

void createObject(){
  for (int i=0; i<objects.length; i++){
    objects[i][0] = (int)(Math.random()*width)+100;
    objects[i][1] = 0-i*120;
    objects[i][2] = (int)(Math.random()*21)+7;
    objects[i][3] = (int)(Math.random()*20);

    if (objects[i][3]!=19){
      objects[i][4] = -1;
    }
    else {
      objects[i][4] = 1;
    }
  }
}

void displayStartMenu(){
  
  bg = loadImage("background.jpg");
  bg.resize(1400,800);
  image(bg, 0, 0);
  text = "The Sky is Falling! - Sarveshwar";
  textSize(50);
  fill(255);
  textAlign(CENTER, CENTER);
  text(text, width/2, 100);
  
  text = "Use A<- and D-> to Move Left and Right or Click Anywhere to Toggle Mouse Mode";
  textSize(30);
  fill(0);
  textAlign(CENTER, CENTER);
  text(text, width/2, 160);
  
  character.resize(400, 400);
  image(character, width/2-200, height/2-200);
  character.resize(100,100);
  
  fill(255, 165, 0);
  rect(width/2-200, height/2+250, 400, 100);
  
  text = "Continue";
  textSize(40);
  fill(0);
  textAlign(CENTER, CENTER);
  text(text, width/2, height/2+300);
  
}
