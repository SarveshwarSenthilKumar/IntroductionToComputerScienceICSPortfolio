
import ddf.minim.*;

AudioPlayer player;
Minim minim;

PImage lightning;
PImage undo;
PImage hammer;
PImage lock;
PImage bomb;

String text;
String musicStatus = "ON";
String currentStage = "start";
String theme = "desert";
int grid = 4;

String warning = "Welcome to the Game! Make your first move!";

int currentScore = 0;
int currentMoves = 0;

boolean foursOnly = false;
int fours = 0;

boolean doubleMode = false;
int doubles = 0;

String currentMusic = "basiclofi";

int[][] currentGrid;
int[][] lastGrid;

color[] desertColors = {#e6dfd0, #ded4c0, #d6c9b1, #cdbea1, #c5b391, #bda981, #b49e72};
color[] spaceColors = {#cccccc, #c0c0c0, #b3b3b3, #a6a6a6, #999999, #8d8d8d, #808080};
color[] forestColors = {#99c199, #80b280, #66a266, #4d934d, #338333, #197419, #006400};

color[] colors = desertColors;

void setup() {
  // Creating the basic canvas
  size(1000, 1000);
  
  // Holding lightning powerup image
  lightning = loadImage("lightningbolt.png");
  lightning.resize(80,80);
  
  undo = loadImage("undoicon.png");
  undo.resize(70,70);
  
  hammer = loadImage("hammer.png");
  hammer.resize(70,70);
  
  lock = loadImage("lock.png");
  lock.resize(50,50);
  
  bomb = loadImage("bomb.png");
  bomb.resize(50,50);

  // Setting up the music player
  minim = new Minim(this);
  player = minim.loadFile("music.mp3");
  player.loop();

  // Creating the basic title page
  setupTitlePage();
}

void draw() {
  if (currentStage == "start") {
    // Rendering the music settings dynamically
    fill(colors[3]);
    rect(150, 400, width-300, 100);
    textSize(80);
    fill(0);
    text("MUSIC: " + musicStatus, (150+width-300)/2, 450);
    fill(colors[2]);
    rect(150+width-400, 400, 100, 100);
    fill(0);
    if (musicStatus == "ON") {
      fill(0);
      textSize(200);
      text("-", 800, 435);
    } else if (musicStatus == "OFF") {
      fill(0);
      textSize(170);
      text("+", 800, 445);
    }
  } 
  else if (currentStage == "selectingmaps") {
    setupMapsPage();
  }
  else if (currentStage == "adjustinggrid") {
    setupGridAdjust();
  }
  else if (currentStage == "playinggame") {
    playGame();
  }
}

void keyPressed() {
  // Checks for mute and unmute key presses and plays music accordingly
  if (key == 'm' || key == 'M') {
    toggleMusic();
  }
  if (key == 't' || key == 'T'){
      if (currentMusic == "basiclofi"){
        toggleMusic();
        musicStatus = "ON";
        currentMusic = "baby";
        minim = new Minim(this);
        player = minim.loadFile("baby.mp3");
        player.loop();
      }
      else if (currentMusic == "baby"){
        toggleMusic();
        musicStatus = "ON";
        currentMusic = "espresso";
        minim = new Minim(this);
        player = minim.loadFile("espresso.mp3");
        player.loop();
      }
      else if (currentMusic == "espresso"){
        toggleMusic();
        musicStatus = "ON";
        currentMusic = "party";
        minim = new Minim(this);
        player = minim.loadFile("party.mp3");
        player.loop();
      }
      else if (currentMusic == "party"){
        toggleMusic();
        musicStatus = "ON";
        currentMusic = "wmyb";
        minim = new Minim(this);
        player = minim.loadFile("wmyb.mp3");
        player.loop();
      }
      else if (currentMusic == "wmyb"){
        toggleMusic();
        musicStatus = "ON";
        currentMusic = "shakeitoff";
        minim = new Minim(this);
        player = minim.loadFile("shakeitoff.mp3");
        player.loop();
      }
      else if (currentMusic == "shakeitoff"){
        toggleMusic();
        musicStatus = "ON";
        currentMusic = "wonderwall";
        minim = new Minim(this);
        player = minim.loadFile("wonderwall.mp3");
        player.loop();
      }
      else if (currentMusic == "wonderwall"){
        toggleMusic();
        musicStatus = "ON";
        currentMusic = "carelesswhisper";
        minim = new Minim(this);
        player = minim.loadFile("carelesswhisper.mp3");
        player.loop();
      }
      else if (currentMusic == "carelesswhisper"){
        toggleMusic();
        musicStatus = "ON";
        currentMusic = "apt";
        minim = new Minim(this);
        player = minim.loadFile("apt.mp3");
        player.loop();
      }
      else if (currentMusic == "apt"){
        toggleMusic();
        musicStatus = "ON";
        currentMusic = "fein";
        minim = new Minim(this);
        player = minim.loadFile("fein.mp3");
        player.loop();
      }
      else if (currentMusic == "fein"){
        toggleMusic();
        musicStatus = "ON";
        currentMusic = "basiclofi";
        minim = new Minim(this);
        player = minim.loadFile("music.mp3");
        player.loop();
      }
  }
  
  else if (currentStage == "adjustinggrid"){
    if (keyCode == UP){
       if (grid < 10){
         grid+=1;
       }
    }
    else if (keyCode == DOWN){
       if (grid > 4){
          grid-=1;
       }
    }
  }
  
  else if (currentStage == "playinggame"){
    if (keyCode == UP){
      warning = "";
      int[][] tempGrid = shiftGrid(currentGrid, "up");
      int changes = 0;
      boolean trigger = true;
      
      for (int row=0; row<grid; row++){
        for (int column=0; column<grid; column++){
          if (tempGrid[row][column]!=currentGrid[row][column]){
            changes+=1;
          }
          if (currentGrid[row][column]==0 || tempGrid[row][column]==0){
            trigger = false;
          }
        }
      }
      
      if (trigger && checkPossibleCollisions(currentGrid) == 0){
           currentStage = "finishedgame";
           setupFinishedGamePage();
      }
      
      if (changes!=0 || !trigger){
        lastGrid = currentGrid;
        currentGrid = shiftGrid(currentGrid, "up");
        
        int changes2 = 0;
        do {
          changes2 = 0;
          tempGrid = shiftGrid(currentGrid, "up");
          for (int row=0; row<grid; row++){
            for (int column=0; column<grid; column++){
              if (tempGrid[row][column]!=currentGrid[row][column]){
                changes2+=1;
              }
            }
          }
          currentGrid = tempGrid;
        } while (changes2 != 0);
        
        if (changes > 0){
          currentMoves += 1;
        }
        
        int[][] freeSpots = new int[grid*grid][2];
        int totalFree = 0;
        for (int rows = 0; rows < grid; rows++){
             for (int columns = 0; columns < grid; columns++){
               if (currentGrid[rows][columns] == 0){
                 freeSpots[totalFree][0] = rows;
                 freeSpots[totalFree][1] = columns;
                 totalFree += 1;
               }
               if (changes>0){
                 if (currentGrid[rows][columns]%2!=0){
                   if (currentGrid[rows][columns] == 17){
                     currentGrid[rows][columns] = 0;
                   }
                   else{
                     currentGrid[rows][columns]+=2;
                   }
                 }
               }
             }
         }
         
         int randomAddition = (int)(Math.random()*totalFree);
         int randomNum = (int)(Math.random()*101);
         
         if (totalFree != 0 && changes != 0){
             if (doubles == 10){
               doubleMode = false;
               doubles = 0;
             }
             if (doubleMode){
               doubles+=1;
             }
             
             if (fours == 10){
               foursOnly = false;
               fours = 0;
             }
             if (foursOnly){
               currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               fours+=1;
             }
             else if (totalFree >= 4){
               if (randomNum >= 85 && randomNum <= 92){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               }
               else if (randomNum >= 93 && randomNum <= 97){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 1;
               }
               else if (randomNum >= 98){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
                 while (currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] != 0){
                   randomAddition = (int)(Math.random()*totalFree);
                 }
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
               }
               else{
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
               }
             }
             else{
               if (randomNum >= 85 && randomNum <= 92){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               }
               else if (randomNum >= 93 && randomNum <= 97){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 1;
               }
               else{
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
               }
             }
           }
         }
        }
    else if (keyCode == DOWN){
      warning = "";
      int[][] tempGrid = shiftGrid(currentGrid, "down");
      int changes = 0;
      boolean trigger = true;
      
      for (int row=0; row<grid; row++){
        for (int column=0; column<grid; column++){
          if (tempGrid[row][column]!=currentGrid[row][column]){
            changes+=1;
          }
          if (currentGrid[row][column]==0 || tempGrid[row][column]==0){
            trigger = false;
          }
        }
      }
      
      if (trigger && checkPossibleCollisions(currentGrid) == 0){
           currentStage = "finishedgame";
           setupFinishedGamePage();
      }
         
      if (changes!=0 || !trigger){
        lastGrid = currentGrid;
        currentGrid = shiftGrid(currentGrid, "down");
        
        int changes2 = 0;
        do {
          changes2 = 0;
          tempGrid = shiftGrid(currentGrid, "down");
          for (int row=0; row<grid; row++){
            for (int column=0; column<grid; column++){
              if (tempGrid[row][column]!=currentGrid[row][column]){
                changes2+=1;
              }
            }
          }
          currentGrid = tempGrid;
        } while (changes2 != 0);
        
        if (changes > 0){
          currentMoves += 1;
        }
        
        int[][] freeSpots = new int[grid*grid][2];
        int totalFree = 0;
        for (int rows = 0; rows < grid; rows++){
             for (int columns = 0; columns < grid; columns++){
               if (currentGrid[rows][columns] == 0){
                 freeSpots[totalFree][0] = rows;
                 freeSpots[totalFree][1] = columns;
                 totalFree += 1;
               }
               if (changes>0){
                 if (currentGrid[rows][columns]%2!=0){
                   if (currentGrid[rows][columns] == 17){
                     currentGrid[rows][columns] = 0;
                   }
                   else{
                     currentGrid[rows][columns]+=2;
                   }
                 }
               }
             }
         }
         
         int randomAddition = (int)(Math.random()*totalFree);
         int randomNum = (int)(Math.random()*101);
         
         if (totalFree != 0 && changes != 0){
             if (doubles == 10){
               doubleMode = false;
               doubles = 0;
             }
             if (doubleMode){
               doubles+=1;
             }
             
             if (fours == 10){
               foursOnly = false;
               fours = 0;
             }
             if (foursOnly){
               currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               fours+=1;
             }
             else if (totalFree >= 4){
               if (randomNum >= 85 && randomNum <= 92){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               }
               else if (randomNum >= 93 && randomNum <= 97){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 1;
               }
               else if (randomNum >= 98){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
                 while (currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] != 0){
                   randomAddition = (int)(Math.random()*totalFree);
                 }
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
               }
               else{
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
               }
             }
             else{
               if (randomNum >= 85 && randomNum <= 92){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               }
               else if (randomNum >= 93 && randomNum <= 97){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 1;
               }
               else{
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
               }
             }
         }
      }
       
    }
    else if (keyCode == LEFT){
      warning = "";
      int[][] tempGrid = shiftGrid(currentGrid, "left");
      int changes = 0;
      boolean trigger = true;
      
      for (int row=0; row<grid; row++){
        for (int column=0; column<grid; column++){
          if (tempGrid[row][column]!=currentGrid[row][column]){
            changes+=1;
          }
          if (currentGrid[row][column]==0 || tempGrid[row][column]==0){
            trigger = false;
          }
        }
      }
      
      if (trigger && checkPossibleCollisions(currentGrid) == 0){
           currentStage = "finishedgame";
           setupFinishedGamePage();
      }
      
      if (changes!=0 || !trigger){
        lastGrid = currentGrid;
        currentGrid = shiftGrid(currentGrid, "left");
        
        int changes2 = 0;
        do {
          changes2 = 0;
          tempGrid = shiftGrid(currentGrid, "left");
          for (int row=0; row<grid; row++){
            for (int column=0; column<grid; column++){
              if (tempGrid[row][column]!=currentGrid[row][column]){
                changes2+=1;
              }
            }
          }
          currentGrid = tempGrid;
        } while (changes2 != 0);
        
        if (changes > 0){
          currentMoves += 1;
        }
        
        int[][] freeSpots = new int[grid*grid][2];
        int totalFree = 0;
        for (int rows = 0; rows < grid; rows++){
             for (int columns = 0; columns < grid; columns++){
               if (currentGrid[rows][columns] == 0){
                 freeSpots[totalFree][0] = rows;
                 freeSpots[totalFree][1] = columns;
                 totalFree += 1;
               }
               if (changes>0){
                 if (currentGrid[rows][columns]%2!=0){
                   if (currentGrid[rows][columns] == 17){
                     currentGrid[rows][columns] = 0;
                   }
                   else{
                     currentGrid[rows][columns]+=2;
                   }
                 }
               }
             }
         }
         
         int randomAddition = (int)(Math.random()*totalFree);
         int randomNum = (int)(Math.random()*101);
         
         if (totalFree != 0 && changes != 0){
             if (doubles == 10){
               doubleMode = false;
               doubles = 0;
             }
             if (doubleMode){
               doubles+=1;
             }
             
             if (fours == 10){
               foursOnly = false;
               fours = 0;
             }
             if (foursOnly){
               currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               fours+=1;
             }
             else if (totalFree >= 4){
               if (randomNum >= 85 && randomNum <= 92){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               }
               else if (randomNum >= 93 && randomNum <= 97){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 1;
               }
               else if (randomNum >= 98){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
                 while (currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] != 0){
                   randomAddition = (int)(Math.random()*totalFree);
                 }
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
               }
               else{
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
               }
             }
             else{
               if (randomNum >= 85 && randomNum <= 92){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               }
               else if (randomNum >= 93 && randomNum <= 97){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 1;
               }
               else{
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
               }
             }
           }
         }
      }
    else if (keyCode == RIGHT){
      warning = "";
      int[][] tempGrid = shiftGrid(currentGrid, "right");
      int changes = 0;
      boolean trigger = true;
      
      for (int row=0; row<grid; row++){
        for (int column=0; column<grid; column++){
          if (tempGrid[row][column]!=currentGrid[row][column]){
            changes+=1;
          }
          if (currentGrid[row][column]==0 || tempGrid[row][column]==0){
            trigger = false;
          }
        }
      }
      
      if (trigger && checkPossibleCollisions(currentGrid) == 0){
           currentStage = "finishedgame";
           setupFinishedGamePage();
      }
      
      if (changes!=0 || !trigger){
        lastGrid = currentGrid;
        currentGrid = shiftGrid(currentGrid, "right");
        
        int changes2 = 0;
        do {
          changes2 = 0;
          tempGrid = shiftGrid(currentGrid, "right");
          for (int row=0; row<grid; row++){
            for (int column=0; column<grid; column++){
              if (tempGrid[row][column]!=currentGrid[row][column]){
                changes2+=1;
              }
            }
          }
          currentGrid = tempGrid;
        } while (changes2 != 0);
        
        if (changes > 0){
          currentMoves += 1;
        }
        
        int[][] freeSpots = new int[grid*grid][2];
        int totalFree = 0;
        for (int rows = 0; rows < grid; rows++){
             for (int columns = 0; columns < grid; columns++){
               if (currentGrid[rows][columns] == 0){
                 freeSpots[totalFree][0] = rows;
                 freeSpots[totalFree][1] = columns;
                 totalFree += 1;
               }
               if (changes>0){
                 if (currentGrid[rows][columns]%2!=0){
                   if (currentGrid[rows][columns] == 17){
                     currentGrid[rows][columns] = 0;
                   }
                   else{
                     currentGrid[rows][columns]+=2;
                   }
                 }
               }
             }
         }
         
         int randomAddition = (int)(Math.random()*totalFree);
         int randomNum = (int)(Math.random()*101);
         
         if (totalFree != 0 && changes != 0){
             if (doubles == 10){
               doubleMode = false;
               doubles = 0;
             }
             if (doubleMode){
               doubles+=1;
             }
             
             if (fours == 10){
               foursOnly = false;
               fours = 0;
             }
             if (foursOnly){
               currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               fours+=1;
             }
             else if (totalFree >= 4){
               if (randomNum >= 85 && randomNum <= 92){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               }
               else if (randomNum >= 93 && randomNum <= 97){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 1;
               }
               else if (randomNum >= 98){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
                 while (currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] != 0){
                   randomAddition = (int)(Math.random()*totalFree);
                 }
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
               }
               else{
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
               }
             }
             else{
               if (randomNum >= 85 && randomNum <= 92){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               }
               else if (randomNum >= 93 && randomNum <= 97){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 1;
               }
               else{
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
               }
             }
           }
         }
      }
  }
  else if (currentStage == "finishedgame"){
    if (key == ' '){
      setupTitlePage();
    }
  }
  
  if (key == '1'){
    toggleMusic();
    musicStatus = "ON";
    currentMusic = "basiclofi";
    minim = new Minim(this);
    player = minim.loadFile("music.mp3");
    player.loop();
  }
  else if (key == '2'){
    toggleMusic();
    musicStatus = "ON";
    currentMusic = "baby";
    minim = new Minim(this);
    player = minim.loadFile("baby.mp3");
    player.loop();
  }
  else if (key == '3'){
    toggleMusic();
    musicStatus = "ON";
    currentMusic = "espresso";
    minim = new Minim(this);
    player = minim.loadFile("espresso.mp3");
    player.loop();
  }
  else if (key == '4'){
    toggleMusic();
    musicStatus = "ON";
    currentMusic = "party";
    minim = new Minim(this);
    player = minim.loadFile("party.mp3");
    player.loop();
  }
  else if (key == '5'){
    toggleMusic();
    musicStatus = "ON";
    currentMusic = "wmyb";
    minim = new Minim(this);
    player = minim.loadFile("wmyb.mp3");
    player.loop();
  }
  else if (key == '6'){
    toggleMusic();
    musicStatus = "ON";
    currentMusic = "shakeitoff";
    minim = new Minim(this);
    player = minim.loadFile("shakeitoff.mp3");
    player.loop();
  }
  else if (key == '7'){
    toggleMusic();
    musicStatus = "ON";
    currentMusic = "wonderwall";
    minim = new Minim(this);
    player = minim.loadFile("wonderwall.mp3");
    player.loop();
  }
  else if (key == '8'){
    toggleMusic();
    musicStatus = "ON";
    currentMusic = "carelesswhisper";
    minim = new Minim(this);
    player = minim.loadFile("carelesswhisper.mp3");
    player.loop();
  }
  else if (key == '9'){
    toggleMusic();
    musicStatus = "ON";
    currentMusic = "apt";
    minim = new Minim(this);
    player = minim.loadFile("apt.mp3");
    player.loop();
  }
  else if (key == '0'){
    toggleMusic();
    musicStatus = "ON";
    currentMusic = "fein";
    minim = new Minim(this);
    player = minim.loadFile("fein.mp3");
    player.loop();
  }
}

void mouseClicked() {
  if (currentStage == "start") {
    //Check for Start Menu Buttons
    if (mouseX >= 150 && mouseX <= 150+width-300) {
      //Check for Music Toggle
      if (mouseY >= 400 && mouseY <= 500) {
        toggleMusic();
      }

      // Check for Toggle Map Settings Button
      else if (mouseY >= 520 && mouseY <= 620) {
        setupMapsPage();
      }
      
      // Check for Start Game Button
      else if (mouseY >= 670 && mouseY <= 770) {
        currentStage = "playinggame";

        currentScore = 0;
        currentMoves = 0;
        currentGrid = new int[grid][grid];
        for (int rows = 0; rows < grid; rows++){
           for (int columns = 0; columns < grid; columns++){
             currentGrid[rows][columns] = 0;
           }
        }
        
        currentGrid[(int)(Math.random()*grid-1)][(int)(Math.random()*grid-1)] = 2;
        playGame();
      }
    }
  } 
  else if (currentStage == "selectingmaps") {
    // Check for Back Button
    if (mouseX >= 10 && mouseX <= 70) {
      if (mouseY >= 10 && mouseY <= 70) {
        setupTitlePage();
      }
    }

    if (theme == "desert") {
      if (mouseX > width/2 - 110 && mouseX < (width/2 - 110) + 220) {
        if (mouseY > 170 && mouseY < 170 + 220) {
          theme = "desert";
          colors = desertColors;
        }
      }
      if (mouseX >= 200 && mouseX <= 200 + 170) {
        if (mouseY >= 190 && mouseY <= 190 + 170) {
          theme = "forest";
          colors = forestColors;
        }
      }
      if (mouseX >= (width/2 - 110) + 240 && mouseX <= (width/2 - 110) + 240 + 170) {
        if (mouseY >= 190 && mouseY < 190 + 170) {
          theme = "space";
          colors = spaceColors;
        }
      }
    } else if (theme == "forest") {
      if (mouseX >= width/2 - 110 && mouseX <= (width/2 - 110) + 220) {
        if (mouseY >= 170 && mouseY <= 170 + 220) {
          theme = "forest";
          colors = forestColors;
        }
      }
      if (mouseX >= 200 && mouseX <= 200 + 170) {
        if (mouseY >= 190 && mouseY <= 190 + 170) {
          theme = "space";
          colors = spaceColors;
        }
      }
      if (mouseX >= (width/2 - 110) + 240 && mouseX <= (width/2 - 110) + 240 + 170) {
        if (mouseY >= 190 && mouseY <= 190 + 170) {
          theme = "desert";
          colors = desertColors;
        }
      }
    } else if (theme == "space") {
      if (mouseX >= width/2 - 110 && mouseX <= (width/2 - 110) + 220) {
        if (mouseY >= 170 && mouseY <= 170 + 220) {
          theme = "space";
          colors = spaceColors;
        }
      }
      if (mouseX >= 200 && mouseX <= 200 + 170) {
        if (mouseY >= 190 && mouseY <= 190 + 170) {
          theme = "desert";
          colors = desertColors;
        }
      }
      if (mouseX >= (width/2 - 110) + 240 && mouseX <= (width/2 - 110) + 240 + 170) {
        if (mouseY >= 190 && mouseY <= 190 + 170) {
          theme = "forest";
          colors = forestColors;
        }
      }
    }
    
    // Check for adjust grid size button click
    if (mouseX >= 150 && mouseX <= 150+width-300) {
      if (mouseY >= 520 && mouseY <= 620) {
        setupGridAdjust();
      }
      // Check for Start Game Button
      else if (mouseY >= 670 && mouseY <= 770) {
          currentStage = "playinggame";
          currentScore = 0;
          currentMoves = 0;
          currentGrid = new int[grid][grid];
          for (int rows = 0; rows < grid; rows++){
             for (int columns = 0; columns < grid; columns++){
               currentGrid[rows][columns] = 0;
             }
          }
          
          currentGrid[(int)(Math.random()*grid)][(int)(Math.random()*grid)] = 2;
          playGame();
        }
       
       // Check for View Instructions Button
       else if  (mouseY >= 780 && mouseY <= 880){
         currentStage = "viewinstructions";
         viewInstructions(); 
       }
       
       // Check for View Previous Scores Button
       else if  (mouseY >= 890 && mouseY <= 990){
         currentStage = "viewingprevious";
         viewPrevious(); 
       }
      }
  }
  else if (currentStage == "viewingprevious"){
    if (mouseX >= 10 && mouseX <= 70) {
      if (mouseY >= 10 && mouseY <= 70) {
        setupMapsPage();
      }
    }
  }
  else if (currentStage == "adjustinggrid"){
    // Check for button to go back to the theme menu
    if (mouseX >= 10 && mouseX <= 70) {
      if (mouseY >= 10 && mouseY <= 70) {
        setupMapsPage();
      }
    }
    rect(width/2+10, 850, 100, 100);
    rect(width/2-110, 850, 100, 100);
  
    if (mouseY >= 850 && mouseY <= 950){
      if (mouseX >= width/2+10 && mouseX <= width/2+110){
        if (grid > 4){
          grid-=1;
        }
      }
      else if (mouseX >= width/2-110 && mouseX <= width/2-10){
        if (grid < 10){
          grid+=1;
        }
      }
    }
  }
  else if (currentStage == "playinggame"){
    if (mouseX >= 10 && mouseX <= 70) {
      if (mouseY >= 10 && mouseY <= 70) {
        setupTitlePage();
      }
    }
    
    if (mouseX >= 225 && mouseX <= 325){
      if (mouseY >= 800 && mouseY <= 900){
        combineAllPowerup();
      }
    }
    
    if (mouseX >= 335 && mouseX <= 435){
      if (mouseY >= 800 && mouseY <= 900){
       if (currentScore>=100*grid){
          currentScore -= 100*grid;
          foursOnly = true;
        }
        else{
          warning = "You need " + (100*grid-currentScore) + " more score!";
        }
      }
    }
    
    if (mouseX >= 445 && mouseX <= 545){
      if (mouseY >= 800 && mouseY <= 900){
        if (currentScore>=50*grid){
          currentScore -= 50*grid;
          currentGrid = lastGrid;
          warning = "The last move has been undone";
        }
        else{
          warning = "You need " + (50*grid-currentScore) + " more score!";
        }
      }
    }
    
    if (mouseX >= 555 && mouseX <= 655){
      if (mouseY >= 800 && mouseY <= 900){
        randomTileBreak();
      }
    }
    
    if (mouseX >= 665 && mouseX <= 765){
      if (mouseY >= 800 && mouseY <= 900){
        if (currentScore>=200*grid){
          currentScore -= 200*grid;
          doubleMode = true;
        }
        else{
          warning = "You need " + (200*grid-currentScore) + " more score!";
        }
      }
    }
  }
  else if (currentStage == "viewinstructions"){
    if (mouseX >= 10 && mouseX <= 70) {
      if (mouseY >= 10 && mouseY <= 70) {
        setupTitlePage();
        setupMapsPage();
      }
    }
    
     //Check for Start Menu Buttons
    if (mouseX >= 150 && mouseX <= 150+width-300) {
      
      // Check for Start Game Button
      if (mouseY >= 670 && mouseY <= 770) {
        setupTitlePage();
        currentStage = "playinggame";

        currentScore = 0;
        currentMoves = 0;
        currentGrid = new int[grid][grid];
        for (int rows = 0; rows < grid; rows++){
           for (int columns = 0; columns < grid; columns++){
             currentGrid[rows][columns] = 0;
           }
        }
        
        currentGrid[(int)(Math.random()*grid-1)][(int)(Math.random()*grid-1)] = 2;
        playGame();
      }
    }
  }
}

void randomTileBreak(){
  int filledSquare = 0;
  int[][] filledGrid = new int[grid*grid][2];
  
  for (int rows = 0; rows < grid; rows++){
    for (int columns = 0; columns < grid; columns++){
       if (currentGrid[rows][columns] != 0 && currentGrid[rows][columns] != 2){
         filledGrid[filledSquare][0] = rows;
         filledGrid[filledSquare][1] = columns;
         filledSquare++;
       }
    }
  }
  
  if (filledSquare > 0){
    if (currentScore>=25*grid){
      currentScore -= 25*grid;
      
      int randomIndex = (int)(Math.random()*(filledSquare));
      int[] randomSquare = filledGrid[randomIndex];
      
      currentGrid[randomSquare[0]][randomSquare[1]] = 0;
    }
    else{
      warning = "You need " + 25*grid + " more score!";
    }
  }
  else {
    warning = "You need more than 1 filled non-two tile!";
  }
}

void combineAllPowerup(){
  
  int filledSquare = 0;
  
  for (int rows = 0; rows < grid; rows++){
    for (int columns = 0; columns < grid; columns++){
       if (currentGrid[rows][columns] != 0 && currentGrid[rows][columns] != 2){
         filledSquare++;
       }
    }
  }
  
  if (filledSquare > 0){
    int newSquare = closestTwoPower(currentScore/2);
    currentScore /= 4;
    
    currentGrid = new int[grid][grid];
    for (int rows = 0; rows < grid; rows++){
       for (int columns = 0; columns < grid; columns++){
         currentGrid[rows][columns] = 0;
       }
    }
            
    currentGrid[(int)(Math.random()*grid)][(int)(Math.random()*grid)] = newSquare;
  }
  else {
    warning = "You need more than 1 filled non-two tile!";
  }
}

int closestTwoPower(int num){
  
  int counter = 1;
  
  //ArrayList<int> powersOfTwo = new ArrayList<>();
  
  while (num > counter){
    counter*=2;
    //powersOfTwo.add(counter);
  }
  
  if (abs(num-counter)>=abs(num-counter/2)){
    counter/=2;
  }
  
  return counter;
  
}

void viewPrevious(){
  background(colors[0]);
  
  // Draw button background (rectangle)
  fill(200);
  rect(10, 10, 60, 60, 10);  // rounded corners

  // Draw left-pointing arrow
  fill(0);
  beginShape();
  vertex(20, 40);
  vertex(60, 20);
  vertex(60, 60);
  endShape(CLOSE);
  
  try{
    BufferedReader sentenceReader = new BufferedReader(new java.io.FileReader("scores.txt"));
    String currentLine = sentenceReader.readLine();
    int numberOfScores = 0;
    textSize(40);
    ArrayList<String> scores = new ArrayList<>();
    while (currentLine != null) {
        scores.add(currentLine);
        numberOfScores++;
        currentLine = sentenceReader.readLine();
    }
    
    numberOfScores-=1;
    
    for (; numberOfScores>0; numberOfScores--){
      text(scores.get(numberOfScores), width/2, 100+(scores.size()-numberOfScores)*40);
      if (scores.size()-numberOfScores==20){
        break;
      }
    }
    sentenceReader.close();
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}


void viewInstructions(){
  background(colors[0]);

  // Draw button background (rectangle)
  fill(200);
  rect(10, 10, 60, 60, 10);  // rounded corners

  // Draw left-pointing arrow
  fill(0);
  beginShape();
  vertex(20, 40);
  vertex(60, 20);
  vertex(60, 60);
  endShape(CLOSE);

  // Display main instructions
  textSize(70);
  textAlign(CENTER, CENTER);
  text("Use ← ↑ ↓ → keys to move tiles", width/2, 150);

  textSize(40);
  text("Combine Like Tiles to Create a Larger Tile", width/2, 250);

  textSize(60);
  text("Goal: Achieve the highest score!", width/2, 310);
  text("Example: 2 + 2 → 4, 4 + 4 → 8", width/2, 370);

  // Rendering the Start Game button
  fill(colors[3]);
  rect(150, 670, width - 300, 100);
  textSize(60);
  fill(0);
  text("START GAME", (width) / 2, 720);

  // Power-Up Button Layout
  // Lightning Power-Up Button
  fill(colors[1]);
  rect(225, 800, 100, 100, 10);
  image(lightning, 233, 810);
  
  // 444 Power-Up Button
  fill(colors[1]);
  rect(335, 800, 100, 100, 10);
  fill(0);
  textSize(40);
  text("444", 385, 850);
  
  // Undo Power-Up Button
  fill(colors[1]);
  rect(445, 800, 100, 100, 10);
  fill(0);
  textSize(40);
  image(undo, 460, 815);
  
  // Hammer Power-Up Button
  fill(colors[1]);
  rect(555, 800, 100, 100, 10);
  fill(0);
  textSize(40);
  image(hammer, 570, 815);
  
  // 2x Power-Up Button
  fill(colors[1]);
  rect(665, 800, 100, 100, 10);
  fill(0);
  textSize(40);
  text("2x", 715, 850);

  // Power-Up Descriptions (Make sure they fit between height 420 and 670)
  textSize(20);  // Smaller font size
  fill(0);
  textAlign(LEFT, TOP);

  // Lightning Power-Up Description
  text("Lightning: Clears the board, leaves 1 tile (closest power of 2 to score/2), costs current score/4", 100, 450);

  // 444 Power-Up Description
  text("444: Spawns 10 '4' tiles in a row, costs 100 per grid size", 100, 480);

  // Undo Power-Up Description
  text("Undo: Reverts last move, costs 50 per grid size", 100, 510);

  // Hammer Power-Up Description
  text("Hammer: Breaks a random tile, costs 25 per grid size", 100, 540);

  // 2x Power-Up Description
  text("2x: Doubles collisions for 10 moves, costs 200 per grid size", 100, 570);
  
  // Lock Description
  text("Locked blocks cannot be broken and disappear after 8 moves", 100, 610);
  
  // Esploding Blocks Description
  text("Exploding blocks do not disappear unless broken in which case, they will destroy the blocks around them", 100, 640);
}

void setupFinishedGamePage(){
  background(colors[0]);
    
  fill(0);
  textSize(60);
  
  text("Game Over!", width/2, 50);
  // Displaying the number of moves
  text("Number of Moves: " + currentMoves, width/2, 110);
  
  // Displaying the score of the user
  text("Total Score: " + currentScore, width/2, 170);
  
  text("Final Grid", width/2, 270);
  
  // Displaying the Grid
  for (int rows = 0; rows < grid; rows++){
     for (int columns = 0; columns < grid; columns++){

       fill(colors[((powerOfTwo(currentGrid[rows][columns])%colors.length))]);
       rect(225+rows*(525/grid+4), 320+columns*(525/grid+4), (530/grid-4), (530/grid-4), 10);
       
       if (currentGrid[rows][columns] == 6){
         bomb.resize((int)((500/grid)),(int)((500/grid)));
         image(bomb, (225+rows*(525/grid+4)), (320+columns*(525/grid+4)));
       }
       else if (currentGrid[rows][columns]%2 == 0){
         fill(0);
         textSize(160/grid);
         text(currentGrid[rows][columns], (225+rows*(525/grid+4)+(530/grid-4)/2), (320+columns*(525/grid+4)+(530/grid-4)/2));
       }
       else {
         lock.resize((int)((500/grid)),(int)((500/grid)));
         image(lock, (225+rows*(525/grid+4)), (320+columns*(525/grid+4)));
       }
     }
  }
  try {
    PrintWriter sentenceWriter = new PrintWriter(new java.io.FileWriter("scores.txt", true));
    sentenceWriter.println("Score: " + currentScore + " in " + currentMoves + " moves of grid size " + grid + "x" + grid);
    sentenceWriter.close(); 
  } catch (IOException e) {
    e.printStackTrace();
  }
  
  text("Press SPACE to Continue", width/2, height-100);
    
}

int checkPossibleCollisions(int[][] currentGrid){
  int possibleCollisions = 0;
  int[][] newGrid = currentGrid;
  
  for (int row=1; row<grid; row++){
    for (int column=0; column<grid; column++){
      if (newGrid[row][column]==newGrid[row-1][column] && newGrid[row][column]!=0){
        possibleCollisions++;
      }
    }
  }
  for (int row=grid-1; row>0; row--){
    for (int column=0; column<grid; column++){
      if (newGrid[row][column]==newGrid[row-1][column] && newGrid[row][column]!=0){
        possibleCollisions++;
      }
    }
  }
  for (int row=0; row<grid; row++){
    for (int column=1; column<grid; column++){
      if (newGrid[row][column]==newGrid[row][column-1] && newGrid[row][column]!=0){
        possibleCollisions++;
      }
    }
  }
  for (int row=0; row<grid; row++){
    for (int column=grid-1; column>0; column--){
      if (newGrid[row][column]==newGrid[row][column-1] && newGrid[row][column]!=0){
        possibleCollisions++;
      }
    }
  }
  
  return possibleCollisions;
}

int[][] checkCollisions(int[][] currentGrid, String direction){
  int[][] newGrid = currentGrid;
  
  switch (direction) {
    case "left":
      for (int row=1; row<grid; row++){
        for (int column=0; column<grid; column++){
          if (newGrid[row][column]==newGrid[row-1][column] && newGrid[row][column]!=0){
            if (doubleMode){
              newGrid[row-1][column] = (newGrid[row][column]+newGrid[row-1][column])*2;
              newGrid[row][column] = 0;
              currentScore+=(newGrid[row][column]+newGrid[row-1][column]*2);
            }
            else{
              newGrid[row-1][column] = newGrid[row][column]+newGrid[row-1][column];
              newGrid[row][column] = 0;
              currentScore+=newGrid[row][column]+newGrid[row-1][column];
            }
          }
        }
      }
      break;
     
    case "right":
      for (int row=grid-1; row>0; row--){
        for (int column=0; column<grid; column++){
          if (newGrid[row][column]==newGrid[row-1][column] && newGrid[row][column]!=0){
            if (doubleMode){
              newGrid[row][column] = (newGrid[row][column]+newGrid[row-1][column])*2;
              newGrid[row-1][column] = 0;
              currentScore+=(newGrid[row][column]+newGrid[row-1][column]*2);
            }
            else{ 
              newGrid[row][column] = newGrid[row][column]+newGrid[row-1][column];
              newGrid[row-1][column] = 0;
              currentScore+=newGrid[row][column]+newGrid[row-1][column];
            }
          }
        }
      }
      break;
      
    case "up":
      for (int row=0; row<grid; row++){
        for (int column=1; column<grid; column++){
          if (newGrid[row][column]==newGrid[row][column-1] && newGrid[row][column]!=0){
            if (doubleMode){
              newGrid[row][column-1] = (newGrid[row][column]+newGrid[row][column-1])*2;
              newGrid[row][column] = 0;
              currentScore+=(newGrid[row][column]+newGrid[row][column-1]*2);
            }
            else{ 
              newGrid[row][column-1] = newGrid[row][column]+newGrid[row][column-1];
              newGrid[row][column] = 0;
              currentScore+=newGrid[row][column]+newGrid[row][column-1];
            }
          }
        }
      }
      break;
      
    case "down":
      for (int row=0; row<grid; row++){
        for (int column=grid-1; column>0; column--){
          if (newGrid[row][column]==newGrid[row][column-1] && newGrid[row][column]!=0){
            if (doubleMode){
              newGrid[row][column] = (newGrid[row][column]+newGrid[row][column-1])*2;
              newGrid[row][column-1] = 0;
              currentScore+=(newGrid[row][column]+newGrid[row][column-1]*2);
            }
            else{ 
              newGrid[row][column] = newGrid[row][column]+newGrid[row][column-1];
              newGrid[row][column-1] = 0;
              currentScore+=newGrid[row][column]+newGrid[row][column-1];
            }
          }
        }
      }
      break;
  }

  // Checking for Bomb Tile
  for (int row=0; row<grid; row++){
    for (int column=grid-1; column>0; column--){
      if (newGrid[row][column] != 0){
        if (newGrid[row][column] % 12 == 0){
          newGrid[row][column] = 0;
          if (row>0){
            newGrid[row-1][column] = 0;
            if (column>0){
              newGrid[row-1][column-1] = 0;
            }
            if (column<grid-1){
              newGrid[row-1][column+1] = 0;
            }
          }
          if (row<grid-1){
            newGrid[row+1][column] = 0;
            if (column>0){
              newGrid[row+1][column-1] = 0;
            }
            if (column<grid-1){
              newGrid[row+1][column+1] = 0;
            }
          }
          if (column>0){
            newGrid[row][column-1] = 0;
          }
          if (column<grid-1){
            newGrid[row][column+1] = 0;
          } 
        }
      }
    }
  } 
  
  return newGrid;
}

int[][] shiftGrid(int[][] currentGrid, String direction) {
  
  int[][] newGrid = new int[grid][grid];
  currentGrid = checkCollisions(currentGrid, direction);
  
  switch (direction) {
    case "up":
      for (int i=0; i<grid; i++){
        int[] filled = new int[grid];
        int filledCount = 0;
        
        for (int number : currentGrid[i]){
          if (number != 0){
            filled[filledCount] = number;
            filledCount++;
          }
        }
        
        for (int x=grid-filledCount; x>0; x--){
          filled[filledCount+x-1] = 0;
        }
        newGrid[i] = filled;
      }
      break;
      
     case "down":
      for (int i = 0; i < grid; i++) {
        int[] filled = new int[grid];
        int filledCount = 0;
    
        for (int x = grid - 1; x >= 0; x--) {
          if (currentGrid[i][x] != 0) {
            filled[filledCount] = currentGrid[i][x];
            filledCount++;
          }
        }
    
        for (int x = 0; x < filledCount; x++) {
          newGrid[i][grid - 1 - x] = filled[x];
        }

        for (int x = 0; x < grid - filledCount; x++) {
          newGrid[i][x] = 0;
        }
      }
      break;
      
    case "left":
      for (int i = 0; i < grid; i++) {
        int[] filled = new int[grid];
        int filledCount = 0;
 
        for (int x = 0; x < grid; x++) {
          if (currentGrid[x][i] != 0) {
            filled[filledCount] = currentGrid[x][i];
            filledCount++;
          }
        }
  
        int y = grid - 1;
        for (int x = grid-filledCount - 1; x >= 0; x--) {
          newGrid[y][i] = 0;
          y--;
        }
        while (y >= 0) {
          newGrid[y][i] = filled[y];
          y--;
        }
      }
      break;
      
    case "right":
      for (int i = 0; i < grid; i++) {
        int[] filled = new int[grid];
        int filledCount = 0;
 
        for (int x = 0; x < grid; x++) {
          if (currentGrid[x][i] != 0) {
            filled[filledCount] = currentGrid[x][i];
            filledCount++;
          }
        }
  
        int y = grid - 1;
        for (int x = filledCount - 1; x >= 0; x--) {
          newGrid[y][i] = filled[x];
          y--;
        }
  
        while (y >= 0) {
          newGrid[y][i] = 0;
          y--;
        }
      }
      break;
  }
  
  return checkCollisions(newGrid, direction);
}

int powerOfTwo(int n) {
  int power = 0;
  while (n > 1) {
      n /= 2;
      power++;
  }
  return power;
}

void playGame(){
  currentStage = "playinggame";
  
  background(colors[0]);
  
  // Draw button background (rectangle)
  fill(200);
  rect(10, 10, 60, 60, 10);  // rounded corners

  // Draw left-pointing arrow
  fill(0);
  beginShape();
  vertex(20, 40);
  vertex(60, 20);
  vertex(60, 60);
  endShape(CLOSE);
  
  textSize(30);
  // Displaying the Current Song
  if (currentMusic == "basiclofi"){
    text("Currently Playing: Lofi (Worst Choice)", width/2, 50);
  }
  else if (currentMusic == "baby"){
    text("Currently Playing: Baby - Justin Bieber, Ludacris", width/2, 50);
  }
  else if (currentMusic == "espresso"){
    text("Currently Playing: Espresso - Sabrina Carpenter", width/2, 50);
  }
  else if (currentMusic == "party"){
    text("Currently Playing: Party in the USA - Miley Cyrus", width/2, 50);
  }
  else if (currentMusic == "wmyb"){
    text("Currently Playing: What Makes You Beautiful - One Direction", width/2, 50);
  }
  else if (currentMusic == "shakeitoff"){
    text("Currently Playing: Shake It Off - Taylor Swift", width/2, 50);
  }
  else if (currentMusic == "wonderwall"){
    text("Currently Playing: Wonderwall - Oasis (Developer's Pick)", width/2, 50);
  }
  else if (currentMusic == "carelesswhisper"){
    text("Currently Playing: Careless Whisper - George Michael", width/2, 50);
  }
  else if (currentMusic == "apt"){
    text("Currently Playing: A.P.T. - Bruno Mars & Rose", width/2, 50);
  }
  else if (currentMusic == "fein"){
    text("Currently Playing: FEIN - Travis Scott", width/2, 50);
  }
  
  textSize(60);
  // Displaying the number of moves
  text("Number of Moves: " + currentMoves, width/2, 100);
  
  // Displaying the score of the user
  text("Total Score: " + currentScore, width/2, 160);
  
  // Displaying the Grid
  for (int rows = 0; rows < grid; rows++){
     for (int columns = 0; columns < grid; columns++){
       fill(colors[4]);
       rect(225+rows*(525/grid+4), 225+columns*(525/grid+4), (530/grid-4), (530/grid-4), 10);
       
       if (currentGrid[rows][columns] != 0){
         fill(colors[((powerOfTwo(currentGrid[rows][columns])%colors.length))]);
         rect(225+rows*(525/grid+4), 225+columns*(525/grid+4), (530/grid-4), (530/grid-4), 10);
         
         if (currentGrid[rows][columns] == 6){
           bomb.resize((int)((500/grid)),(int)((500/grid)));
           image(bomb, (225+rows*(525/grid+4)), (225+columns*(525/grid+4)));
         }
         else if (currentGrid[rows][columns]%2 == 0){
           fill(0);
           textSize(160/grid);
           text(currentGrid[rows][columns], (225+rows*(525/grid+4)+(530/grid-4)/2), (225+columns*(525/grid+4)+(530/grid-4)/2));
         }
         else {
           lock.resize((int)((500/grid)),(int)((500/grid)));
           image(lock, (225+rows*(525/grid+4)), (225+columns*(525/grid+4)));
         }
       }
     }
  }
  
  fill(colors[1]);
  rect(225, 800, 100, 100, 10);
  image(lightning, 233, 810);
  
  fill(colors[1]);
  rect(335, 800, 100, 100, 10);
  fill(0);
  textSize(40);
  text("444", 385, 850);
  
  fill(colors[1]);
  rect(445, 800, 100, 100, 10);
  fill(0);
  textSize(40);
  image(undo, 460, 815);
  
  fill(colors[1]);
  rect(555, 800, 100, 100, 10);
  fill(0);
  textSize(40);
  image(hammer, 570, 815);
  
  fill(colors[1]);
  rect(665, 800, 100, 100, 10);
  fill(0);
  textSize(40);
  text("2x", 715, 850);
  
  if (foursOnly){
    warning = "You have " + (10-fours) + " 4s left in a row!";
  }
  if (doubleMode){
    warning = "You have " + (10-doubles) + " more doubled moves left!";
  }
  text(warning, width/2, 950);
}

void setupGridAdjust(){
  background(colors[0]);
  currentStage = "adjustinggrid";
  // Draw button background (rectangle)
  fill(200);
  rect(10, 10, 60, 60, 10);  // rounded corners

  // Draw left-pointing arrow
  fill(0);
  beginShape();
  vertex(20, 40);
  vertex(60, 20);
  vertex(60, 60);
  endShape(CLOSE);
  
  text("Adjust Grid Size", (width)/2, 70);
  
  // Showing Main Grid 
  fill(colors[1]);
  rect(200, 200, 600, 600, 50);
  
  currentGrid = new int[grid][grid];
  
  fill(colors[4]);
  for (int rows = 0; rows < grid; rows++){
     for (int columns = 0; columns < grid; columns++){
       rect(225+rows*(525/grid+4), 225+columns*(525/grid+4), (530/grid-4), (530/grid-4), 10);
       currentGrid[rows][columns] = 0;
     }
  }
  
  rect(width/2+10, 850, 100, 100);
  rect(width/2-110, 850, 100, 100);
  
  // Draw the Up arrow inside the left rectangle
  fill(0); // Set color to black
  beginShape();
  vertex(width/2-110+50, 850+25);  
  vertex(width/2-110+10, 850+75); 
  vertex(width/2-110+90, 850+75);  
  endShape(CLOSE);
  
  // Draw the Down arrow inside the right rectangle
  beginShape();
  vertex(width/2+10+50, 850+75);  
  vertex(width/2+10+10, 850+25);  
  vertex(width/2+10+90, 850+25);  
  endShape(CLOSE);

}

void setupMapsPage() {
  background(colors[0]);
  currentStage = "selectingmaps";
  // Draw button background (rectangle)
  fill(200);
  rect(10, 10, 60, 60, 10);  // rounded corners

  // Draw left-pointing arrow
  fill(0);
  beginShape();
  vertex(20, 40);
  vertex(60, 20);
  vertex(60, 60);
  endShape(CLOSE);

  textSize(80);
  text("Select Your Map", (width)/2, 70);

  if (theme == "desert") {
    fill(colors[4]);
    rect(width/2-110, 170, 220, 220);
    textSize(60);
    fill(0);
    text("Desert", (width)/2, 270);

    fill(colors[1]);
    rect(200, 190, 170, 170);
    textSize(40);
    fill(0);
    text("Forest", 285, 270);

    fill(colors[1]);
    rect((width/2-110)+240, 190, 170, 170);
    textSize(40);
    fill(0);
    text("Space", (width/2-110)+240+85, 270);
  } else if (theme == "forest") {
    fill(colors[4]);
    rect(width/2-110, 170, 220, 220);
    textSize(60);
    fill(0);
    text("Forest", (width)/2, 270);

    fill(colors[1]);
    rect(200, 190, 170, 170);
    textSize(40);
    fill(0);
    text("Space", 285, 270);

    fill(colors[1]);
    rect((width/2-110)+240, 190, 170, 170);
    textSize(40);
    fill(0);
    text("Desert", (width/2-110)+240+85, 270);
  } else if (theme == "space") {
    fill(colors[4]);
    rect(width/2-110, 170, 220, 220);
    textSize(60);
    fill(0);
    text("Space", (width)/2, 270);

    fill(colors[1]);
    rect(200, 190, 170, 170);
    textSize(40);
    fill(0);
    text("Desert", 285, 270);

    fill(colors[1]);
    rect((width/2-110)+240, 190, 170, 170);
    textSize(40);
    fill(0);
    text("Forest", (width/2-110)+240+85, 270);
  }
  
  // Rendering the Change Map Dimensions button
  fill(colors[3]);
  rect(150, 520, width-300, 100);
  textSize(60);
  fill(0);
  text("Adjust Grid Size", (width)/2, 570);

  // Rendering the Start Game button
  fill(colors[3]);
  rect(150, 670, width-300, 100);
  textSize(60);
  fill(0);
  text("START GAME", (width)/2, 720);
  
  fill(colors[3]);
  rect(150, 780, width-300, 100);
  textSize(60);
  fill(0);
  text("View Instructions", (width)/2, 830);
  
  fill(colors[3]);
  rect(150, 890, width-300, 100);
  textSize(60);
  fill(0);
  text("View Previous Scores", (width)/2, 940);
}

void toggleMusic() {
  // Method to toggle music depending on current status
  if (musicStatus == "ON") {
    musicStatus = "OFF";
    player.close();
    minim.stop();
  } else if (musicStatus == "OFF") {
    if (currentMusic == "basiclofi"){
      musicStatus = "ON";
      minim = new Minim(this);
      player = minim.loadFile("music.mp3");
      player.loop();
    }
    else if (currentMusic == "baby"){
      musicStatus = "ON";
      currentMusic = "baby";
      minim = new Minim(this);
      player = minim.loadFile("baby.mp3");
      player.loop();
    }
    else if (currentMusic == "espresso"){
      musicStatus = "ON";
      currentMusic = "espresso";
      minim = new Minim(this);
      player = minim.loadFile("espresso.mp3");
      player.loop();
    }
    else if (currentMusic == "party"){
      musicStatus = "ON";
      currentMusic = "party";
      minim = new Minim(this);
      player = minim.loadFile("party");
      player.loop();
    }
    else if (currentMusic == "wmyb"){
      musicStatus = "ON";
      currentMusic = "wmyb";
      minim = new Minim(this);
      player = minim.loadFile("wmyb.mp3");
      player.loop();
    }
    else if (currentMusic == "shakeitoff"){
      musicStatus = "ON";
      currentMusic = "shakeitoff";
      minim = new Minim(this);
      player = minim.loadFile("shakeitoff.mp3");
      player.loop();
    }
    else if (currentMusic == "wonderwall"){
      musicStatus = "ON";
      currentMusic = "wonderwall";
      minim = new Minim(this);
      player = minim.loadFile("wonderwall.mp3");
      player.loop();
    }
    else if (currentMusic == "carelesswhisper"){
      musicStatus = "ON";
      currentMusic = "carelesswhisper";
      minim = new Minim(this);
      player = minim.loadFile("carelesswhisper.mp3");
      player.loop();
    }
    else if (currentMusic == "apt"){
      musicStatus = "ON";
      currentMusic = "apt";
      minim = new Minim(this);
      player = minim.loadFile("apt.mp3");
      player.loop();
    }
    else if (currentMusic == "fein"){
      musicStatus = "ON";
      currentMusic = "fein";
      minim = new Minim(this);
      player = minim.loadFile("fein.mp3");
      player.loop();
    }
  }
}

void setupTitlePage() {
  // Set up basic title page
  background(colors[0]);
  fill(colors[0]);
  rect(0, 0, 1000, 1000);

  textSize(150);  
  
  fill(0);
  textAlign(CENTER, CENTER);
  text("2048:", width/2, 100);
  textSize(160);
  text("POWER", width/2, 250);
  currentStage = "start";

  // Rendering the Toggle Map Settings button
  fill(colors[3]);
  rect(150, 520, width-300, 100);
  textSize(60);
  fill(0);
  text("Toggle Map Settings", (width)/2, 570);

  // Rendering the Start Game button
  fill(colors[3]);
  rect(150, 670, width-300, 100);
  textSize(60);
  fill(0);
  text("START GAME", (width)/2, 720);

  // Printed instructions for menu selection
  textSize(50);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Press M to mute/unmute", width/2, 850);
  textSize(50);
  text("Use mouse to select menu", width/2, 900);
  textSize(50);
  text("Press T or use numbers to toggle tracks", width/2, 950);
}