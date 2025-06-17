
/*
 * Title: 2048-Power
 * Author: Sarveshwar Senthil Kumar
 * Date: June 17th, 2025
 * Description of the program: This is a template
 */

import ddf.minim.*;

// Initializing classes for Audio
AudioPlayer player;
Minim minim;

// Initializing classes for images
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

// Display text for the first move
String warning = "Welcome to the Game! Make your first move!";

int currentScore = 0;
int currentMoves = 0;

// Powerup Toggle Variables
boolean foursOnly = false;
int fours = 0;

boolean doubleMode = false;
int doubles = 0;

String currentMusic = "basiclofi";

int[][] currentGrid;
int[][] lastGrid;

// Initializing arrays for special themes
color[] desertColors = {#e6dfd0, #ded4c0, #d6c9b1, #cdbea1, #c5b391, #bda981, #b49e72};
color[] spaceColors = {#cccccc, #c0c0c0, #b3b3b3, #a6a6a6, #999999, #8d8d8d, #808080};
color[] forestColors = {#99c199, #80b280, #66a266, #4d934d, #338333, #197419, #006400};

color[] colors = desertColors;

void setup() {
  // Creating the basic canvas
  size(1000, 1000);
  
  // Image to hold Lightning Powerup image
  lightning = loadImage("lightningbolt.png");
  lightning.resize(80,80);
  
  // Image to hold Undo Powerup Image
  undo = loadImage("undoicon.png");
  undo.resize(70,70);
  
  // Image to hold Hammer Powerup Image
  hammer = loadImage("hammer.png");
  hammer.resize(70,70);
  
  // Image to hold Lock Powerup Image
  lock = loadImage("lock.png");
  lock.resize(50,50);
  
  // Image to hold Bomb Powerup Image
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
    
    // Conditional to Toggle Music + or - depending on ON or OFF
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
  
  // Checks for toggle track key press
  if (key == 't' || key == 'T'){
    
      // Conditional to update track based on current track
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
    // Checking for arrow clicks to increase or decrease size of grid
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
    // Checking for moves in-game using arrow keys
    if (keyCode == UP){
      warning = "";
      int[][] tempGrid = shiftGrid(currentGrid, "up");
      int changes = 0;
      boolean trigger = true;
      
      // Loop to check for the number of changes in upcoming turn
      for (int row=0; row<grid; row++){
        for (int column=0; column<grid; column++){
          // Checks if the corresponding square is the same in the upcoming turn and the current turn
          if (tempGrid[row][column]!=currentGrid[row][column]){
            changes+=1;
          }
          
          // Check to make sure there is an empty square present
          if (currentGrid[row][column]==0 || tempGrid[row][column]==0){
            trigger = false;
          }
        }
      }
      
      // Conditional to check if there are no possible collisions and no free spots left rendering the game over
      if (trigger && checkPossibleCollisions(currentGrid) == 0){
           currentStage = "finishedgame";
           setupFinishedGamePage();
      }
      
      // Conditional to make sure that there are changes and there are empty spaces
      if (changes!=0 || !trigger){
        lastGrid = currentGrid;
        currentGrid = shiftGrid(currentGrid, "up");
        
        // Loop to make sure that all the tiles are shifted as far as they can
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
        
        // Adding 1 to the number of moves
        if (changes > 0){
          currentMoves += 1;
        }
        
        // Array to store the coordinates of the free spots
        int[][] freeSpots = new int[grid*grid][2];
        int totalFree = 0;
        
        // Loop to iterate through every square and check the value
        for (int rows = 0; rows < grid; rows++){
             for (int columns = 0; columns < grid; columns++){
               // If the value is 0 in the square, the coordinate will be added to freeSpots array and increase the totalFree ticker
               if (currentGrid[rows][columns] == 0){
                 freeSpots[totalFree][0] = rows;
                 freeSpots[totalFree][1] = columns;
                 totalFree += 1;
               }
               if (changes>0){
                 // Conditional to account for lock tiles, add a move to their timer
                 if (currentGrid[rows][columns]%2!=0){
                   // If 8 moves has passed, the lock tile will be set to a empty tile
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
         
         // Generate a random index in the freeSpots array to generate a square
         int randomAddition = (int)(Math.random()*totalFree);
         // Generate a number for probabilities from 0 to 100
         int randomNum = (int)(Math.random()*101);
         
         /*
         Probabilities Table:
         2: 0-84 85%
         4: 85-92 8%
         Lock: 93-97 5%
         Bomb: 98-100 2%
         */
         
         if (totalFree != 0 && changes != 0){
             // Check if doubles is activated, if 10 moves have passed deactivate double powerup
             if (doubles == 10){
               doubleMode = false;
               doubles = 0;
             }
             // If double powerup is activated, add a move to the counter
             if (doubleMode){
               doubles+=1;
             }
             
             // Check if fours only powerup is activated, if 10 moves have passed deactivate fours powerup
             if (fours == 10){
               foursOnly = false;
               fours = 0;
             }
             // If fours only powerup is activated, add a move to the counter and generate a 4
             if (foursOnly){
               currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               fours+=1;
             }
             // If there are more than 4 squares free in the grid, allow probability for bomb tile
             else if (totalFree >= 4){
               // If random number is between 85 and 92: generate a 4 in a random free square
               if (randomNum >= 85 && randomNum <= 92){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               }
               // If random number is between 93 and 97: generate a lock tile in a random free square
               else if (randomNum >= 93 && randomNum <= 97){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 1;
               }
               // If random number is between 98 and 100: generate two bomb tiles in two random free squares
               else if (randomNum >= 98){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
                 // Loop to keep iterating until two bomb tiles are placed in individual open tiles
                 do {
                   randomAddition = (int)(Math.random()*totalFree);
                 } while (currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] != 0);
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
               }
               // If random number is between 85 and 92: generate a 2 in a random free square
               else{
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
               }
             }
             // If there are less than 4 squares, the probabilities for bomb tile switch to a 2 tile
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
      
      // Loop to check for the number of changes in upcoming turn
      for (int row=0; row<grid; row++){
        for (int column=0; column<grid; column++){
          // Checks if the corresponding square is the same in the upcoming turn and the current turn
          if (tempGrid[row][column]!=currentGrid[row][column]){
            changes+=1;
          }
          
          // Check to make sure there is an empty square present
          if (currentGrid[row][column]==0 || tempGrid[row][column]==0){
            trigger = false;
          }
        }
      }
      
      // Conditional to check if there are no possible collisions and no free spots left rendering the game over
      if (trigger && checkPossibleCollisions(currentGrid) == 0){
           currentStage = "finishedgame";
           setupFinishedGamePage();
      }
      
      // Conditional to make sure that there are changes and there are empty spaces
      if (changes!=0 || !trigger){
        lastGrid = currentGrid;
        currentGrid = shiftGrid(currentGrid, "down");
        
        // Loop to make sure that all the tiles are shifted as far as they can
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
        
        // Adding 1 to the number of moves
        if (changes > 0){
          currentMoves += 1;
        }
        
        // Array to store the coordinates of the free spots
        int[][] freeSpots = new int[grid*grid][2];
        int totalFree = 0;
        
        // Loop to iterate through every square and check the value
        for (int rows = 0; rows < grid; rows++){
             for (int columns = 0; columns < grid; columns++){
               // If the value is 0 in the square, the coordinate will be added to freeSpots array and increase the totalFree ticker
               if (currentGrid[rows][columns] == 0){
                 freeSpots[totalFree][0] = rows;
                 freeSpots[totalFree][1] = columns;
                 totalFree += 1;
               }
               if (changes>0){
                 // Conditional to account for lock tiles, add a move to their timer
                 if (currentGrid[rows][columns]%2!=0){
                   // If 8 moves has passed, the lock tile will be set to a empty tile
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
         
         // Generate a random index in the freeSpots array to generate a square
         int randomAddition = (int)(Math.random()*totalFree);
         // Generate a number for probabilities from 0 to 100
         int randomNum = (int)(Math.random()*101);
         
         /*
         Probabilities Table:
         2: 0-84 85%
         4: 85-92 8%
         Lock: 93-97 5%
         Bomb: 98-100 2%
         */
         
         if (totalFree != 0 && changes != 0){
             // Check if doubles is activated, if 10 moves have passed deactivate double powerup
             if (doubles == 10){
               doubleMode = false;
             }
             // If double powerup is activated, add a move to the counter
             if (doubleMode){
               doubles+=1;
             }
             
             // Check if fours only powerup is activated, if 10 moves have passed deactivate fours powerup
             if (fours == 10){
               foursOnly = false;
               fours = 0;
             }
             // If fours only powerup is activated, add a move to the counter and generate a 4
             if (foursOnly){
               currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               fours+=1;
             }
             // If there are more than 4 squares free in the grid, allow probability for bomb tile
             else if (totalFree >= 4){
               // If random number is between 85 and 92: generate a 4 in a random free square
               if (randomNum >= 85 && randomNum <= 92){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               }
               // If random number is between 93 and 97: generate a lock tile in a random free square
               else if (randomNum >= 93 && randomNum <= 97){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 1;
               }
               // If random number is between 98 and 100: generate two bomb tiles in two random free squares
               else if (randomNum >= 98){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
                 // Loop to keep iterating until two bomb tiles are placed in individual open tiles
                 do {
                   randomAddition = (int)(Math.random()*totalFree);
                 } while (currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] != 0);
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
               }
               // If random number is between 85 and 92: generate a 2 in a random free square
               else{
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
               }
             }
             // If there are less than 4 squares, the probabilities for bomb tile switch to a 2 tile
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
      
      // Loop to check for the number of changes in upcoming turn
      for (int row=0; row<grid; row++){
        for (int column=0; column<grid; column++){
          // Checks if the corresponding square is the same in the upcoming turn and the current turn
          if (tempGrid[row][column]!=currentGrid[row][column]){
            changes+=1;
          }
          
          // Check to make sure there is an empty square present
          if (currentGrid[row][column]==0 || tempGrid[row][column]==0){
            trigger = false;
          }
        }
      }
      
      // Conditional to check if there are no possible collisions and no free spots left rendering the game over
      if (trigger && checkPossibleCollisions(currentGrid) == 0){
           currentStage = "finishedgame";
           setupFinishedGamePage();
      }
      
      // Conditional to make sure that there are changes and there are empty spaces
      if (changes!=0 || !trigger){
        lastGrid = currentGrid;
        currentGrid = shiftGrid(currentGrid, "left");
        
        // Loop to make sure that all the tiles are shifted as far as they can
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
        
        // Adding 1 to the number of moves
        if (changes > 0){
          currentMoves += 1;
        }
        
        // Array to store the coordinates of the free spots
        int[][] freeSpots = new int[grid*grid][2];
        int totalFree = 0;
        
        // Loop to iterate through every square and check the value
        for (int rows = 0; rows < grid; rows++){
             for (int columns = 0; columns < grid; columns++){
               // If the value is 0 in the square, the coordinate will be added to freeSpots array and increase the totalFree ticker
               if (currentGrid[rows][columns] == 0){
                 freeSpots[totalFree][0] = rows;
                 freeSpots[totalFree][1] = columns;
                 totalFree += 1;
               }
               if (changes>0){
                 // Conditional to account for lock tiles, add a move to their timer
                 if (currentGrid[rows][columns]%2!=0){
                   // If 8 moves has passed, the lock tile will be set to a empty tile
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
         
         // Generate a random index in the freeSpots array to generate a square
         int randomAddition = (int)(Math.random()*totalFree);
         // Generate a number for probabilities from 0 to 100
         int randomNum = (int)(Math.random()*101);
         
         /*
         Probabilities Table:
         2: 0-84 85%
         4: 85-92 8%
         Lock: 93-97 5%
         Bomb: 98-100 2%
         */
         
         if (totalFree != 0 && changes != 0){
             // Check if doubles is activated, if 10 moves have passed deactivate double powerup
             if (doubles == 10){
               doubleMode = false;
             }
             // If double powerup is activated, add a move to the counter
             if (doubleMode){
               doubles+=1;
             }
             
             // Check if fours only powerup is activated, if 10 moves have passed deactivate fours powerup
             if (fours == 10){
               foursOnly = false;
               fours = 0;
             }
             // If fours only powerup is activated, add a move to the counter and generate a 4
             if (foursOnly){
               currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               fours+=1;
             }
             // If there are more than 4 squares free in the grid, allow probability for bomb tile
             else if (totalFree >= 4){
               // If random number is between 85 and 92: generate a 4 in a random free square
               if (randomNum >= 85 && randomNum <= 92){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               }
               // If random number is between 93 and 97: generate a lock tile in a random free square
               else if (randomNum >= 93 && randomNum <= 97){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 1;
               }
               // If random number is between 98 and 100: generate two bomb tiles in two random free squares
               else if (randomNum >= 98){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
                 // Loop to keep iterating until two bomb tiles are placed in individual open tiles
                 do {
                   randomAddition = (int)(Math.random()*totalFree);
                 } while (currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] != 0);
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
               }
               // If random number is between 85 and 92: generate a 2 in a random free square
               else{
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
               }
             }
             // If there are less than 4 squares, the probabilities for bomb tile switch to a 2 tile
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
      
      // Loop to check for the number of changes in upcoming turn
      for (int row=0; row<grid; row++){
        for (int column=0; column<grid; column++){
          // Checks if the corresponding square is the same in the upcoming turn and the current turn
          if (tempGrid[row][column]!=currentGrid[row][column]){
            changes+=1;
          }
          
          // Check to make sure there is an empty square present
          if (currentGrid[row][column]==0 || tempGrid[row][column]==0){
            trigger = false;
          }
        }
      }
      
      // Conditional to check if there are no possible collisions and no free spots left rendering the game over
      if (trigger && checkPossibleCollisions(currentGrid) == 0){
           currentStage = "finishedgame";
           setupFinishedGamePage();
      }
      
      // Conditional to make sure that there are changes and there are empty spaces
      if (changes!=0 || !trigger){
        lastGrid = currentGrid;
        currentGrid = shiftGrid(currentGrid, "right");
        
        // Loop to make sure that all the tiles are shifted as far as they can
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
        
        // Adding 1 to the number of moves
        if (changes > 0){
          currentMoves += 1;
        }
        
        // Array to store the coordinates of the free spots
        int[][] freeSpots = new int[grid*grid][2];
        int totalFree = 0;
        
        // Loop to iterate through every square and check the value
        for (int rows = 0; rows < grid; rows++){
             for (int columns = 0; columns < grid; columns++){
               // If the value is 0 in the square, the coordinate will be added to freeSpots array and increase the totalFree ticker
               if (currentGrid[rows][columns] == 0){
                 freeSpots[totalFree][0] = rows;
                 freeSpots[totalFree][1] = columns;
                 totalFree += 1;
               }
               if (changes>0){
                 // Conditional to account for lock tiles, add a move to their timer
                 if (currentGrid[rows][columns]%2!=0){
                   // If 8 moves has passed, the lock tile will be set to a empty tile
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
         
         // Generate a random index in the freeSpots array to generate a square
         int randomAddition = (int)(Math.random()*totalFree);
         // Generate a number for probabilities from 0 to 100
         int randomNum = (int)(Math.random()*101);
         
         /*
         Probabilities Table:
         2: 0-84 85%
         4: 85-92 8%
         Lock: 93-97 5%
         Bomb: 98-100 2%
         */
         
         if (totalFree != 0 && changes != 0){
             // Check if doubles is activated, if 10 moves have passed deactivate double powerup
             if (doubles == 10){
               doubleMode = false;
             }
             // If double powerup is activated, add a move to the counter
             if (doubleMode){
               doubles+=1;
             }
             
             // Check if fours only powerup is activated, if 10 moves have passed deactivate fours powerup
             if (fours == 10){
               foursOnly = false;
               fours = 0;
             }
             // If fours only powerup is activated, add a move to the counter and generate a 4
             if (foursOnly){
               currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               fours+=1;
             }
             // If there are more than 4 squares free in the grid, allow probability for bomb tile
             else if (totalFree >= 4){
               // If random number is between 85 and 92: generate a 4 in a random free square
               if (randomNum >= 85 && randomNum <= 92){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
               }
               // If random number is between 93 and 97: generate a lock tile in a random free square
               else if (randomNum >= 93 && randomNum <= 97){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 1;
               }
               // If random number is between 98 and 100: generate two bomb tiles in two random free squares
               else if (randomNum >= 98){
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
                 // Loop to keep iterating until two bomb tiles are placed in individual open tiles
                 do {
                   randomAddition = (int)(Math.random()*totalFree);
                 } while (currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] != 0);
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 6;
               }
               // If random number is between 85 and 92: generate a 2 in a random free square
               else{
                 currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
               }
             }
             // If there are less than 4 squares, the probabilities for bomb tile switch to a 2 tile
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
    // Toggle the title page if the user presses space after game is over
    if (key == ' '){
      setupTitlePage();
    }
  }
  
  // Toggle different music tracks depending on the number which the user presses
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

        // Reset the score count, the number of moves, and the grid
        currentScore = 0;
        currentMoves = 0;
        currentGrid = new int[grid][grid];
        for (int rows = 0; rows < grid; rows++){
           for (int columns = 0; columns < grid; columns++){
             currentGrid[rows][columns] = 0;
           }
        }
        
        // Set a random square to 2 to start the game
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

    // Check for change theme clicks depending on current theme
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
          
          // Reset the score count, the number of moves, and the grid
          currentScore = 0;
          currentMoves = 0;
          currentGrid = new int[grid][grid];
          for (int rows = 0; rows < grid; rows++){
             for (int columns = 0; columns < grid; columns++){
               currentGrid[rows][columns] = 0;
             }
          }
          
          // Set a random square to 2 to start the game
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
    // Check for back button in view previous scores page
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
  
    // Check for arrow button clicks to adjust grid size
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
    // Check for button to go back in the actual game screen
    if (mouseX >= 10 && mouseX <= 70) {
      if (mouseY >= 10 && mouseY <= 70) {
        setupTitlePage();
      }
    }
    
    // Check if first powerup to combine all tiles is pressed
    if (mouseX >= 225 && mouseX <= 325){
      if (mouseY >= 800 && mouseY <= 900){
        combineAllPowerup();
      }
    }
    
    // Check if second powerup to spawn only fours is pressed
    if (mouseX >= 335 && mouseX <= 435){
      if (mouseY >= 800 && mouseY <= 900){
       // Check if the user has enough score to toggle this powerup which costs 100 points per grid size
       if (currentScore>=100*grid){
          currentScore -= 100*grid;
          foursOnly = true;
        }
        else{
          warning = "You need " + (100*grid-currentScore) + " more score!";
        }
      }
    }
    
    // Check if third powerup to undo the last move is pressed
    if (mouseX >= 445 && mouseX <= 545){
      if (mouseY >= 800 && mouseY <= 900){
        // Check if the user has enough score to toggle this powerup which costs 50 points per grid size
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
    
    // Check if the fourth powerup to break a random tile is pressed - this powerup costs only 25 points per grid size
    if (mouseX >= 555 && mouseX <= 655){
      if (mouseY >= 800 && mouseY <= 900){
        randomTileBreak();
      }
    }
    
    // Check if the fifth powerup to double the next 10 collisions is pressed
    if (mouseX >= 665 && mouseX <= 765){
      if (mouseY >= 800 && mouseY <= 900){
        // Check if the user has enough score to toggle this powerup which costs 200 points per grid size
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
    // Check if the user clicks the back button
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
        
        // Reset the score count, the number of moves, and the grid
        currentScore = 0;
        currentMoves = 0;
        currentGrid = new int[grid][grid];
        for (int rows = 0; rows < grid; rows++){
           for (int columns = 0; columns < grid; columns++){
             currentGrid[rows][columns] = 0;
           }
        }
        
        // Set a random square to 2 to start
        currentGrid[(int)(Math.random()*grid-1)][(int)(Math.random()*grid-1)] = 2;
        playGame();
      }
    }
  }
}

// Method for the powerup to break a random tile
void randomTileBreak(){
  
  //Checking for the number of filled squares and adding the coordinates to the filledGrid array
  int filledSquare = 0;
  int[][] filledGrid = new int[grid*grid][2];
  
  
  // Iterating through each square in the array and updating the counter and array respectively
  for (int rows = 0; rows < grid; rows++){
    for (int columns = 0; columns < grid; columns++){
       if (currentGrid[rows][columns] != 0 && currentGrid[rows][columns] != 2){
         filledGrid[filledSquare][0] = rows;
         filledGrid[filledSquare][1] = columns;
         filledSquare++;
       }
    }
  }
  
  // If there are any filled squares that are not 2s
  if (filledSquare > 0){
    // Make sure that the user can afford this powerup, else display a warning for such
    if (currentScore>=25*grid){
      // Deduct the cost of the powerup
      currentScore -= 25*grid;
      
      // Choose a random square from the filled grid and set that square equal to 0 meaning a free square
      int randomIndex = (int)(Math.random()*(filledSquare));
      int[] randomSquare = filledGrid[randomIndex];
      
      currentGrid[randomSquare[0]][randomSquare[1]] = 0;
    }
    else{
      warning = "You need " + 25*grid + " more score!";
    }
  }
  // If there are no filled squares that are not 2s, displays a warning
  else {
    warning = "You need more than 1 filled non-two tile!";
  }
}

// Method for the powerup to essentially combine all tiles into one tile
void combineAllPowerup(){
  
  int filledSquare = 0;
  
  // Iterate through each square and check for filled squares
  for (int rows = 0; rows < grid; rows++){
    for (int columns = 0; columns < grid; columns++){
       if (currentGrid[rows][columns] != 0 && currentGrid[rows][columns] != 2){
         filledSquare++;
       }
    }
  }
  
  // If there are more than one filled tile which is not a two, continue with the powerup logic, else display a warning
  if (filledSquare > 0){
    // The new square is calculated as the closest power of two to the currentScore divided by 2
    int newSquare = closestTwoPower(currentScore/2);
    
    // Divide the current score by 4 as a punishment
    currentScore /= 4;
    
    // Set the entire grid equal to empty squares
    currentGrid = new int[grid][grid];
    for (int rows = 0; rows < grid; rows++){
       for (int columns = 0; columns < grid; columns++){
         currentGrid[rows][columns] = 0;
       }
    }
            
    // Choose a random square to house to new square
    currentGrid[(int)(Math.random()*grid)][(int)(Math.random()*grid)] = newSquare;
  }
  else {
    warning = "You need more than 1 filled non-two tile!";
  }
}

// Method used in the combineAllPowerup to find the closest power of two
int closestTwoPower(int num){
  int counter = 1;
  
  // Future addition to the function to return a list of powers below the number
  //ArrayList<int> powersOfTwo = new ArrayList<>();
  
  // While the number is higher than the counter, the number gets multiplied by 2
  while (num > counter){
    counter*=2;
    // Future addition with the list
    //powersOfTwo.add(counter);
  }
  
  // If the previous power of two is closer to the number, the counter is divided by 2
  if (abs(num-counter)>=abs(num-counter/2)){
    counter/=2;
  }
  
  return counter;
}

// Function to toggle the View Previous Scores Page
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
    // Declaring a new instance of the BufferedReader class to read the lines of scores.txt
    String path = sketchPath("scores.txt");
    BufferedReader sentenceReader = new BufferedReader(new java.io.FileReader(path));
    String currentLine = sentenceReader.readLine();
    
    // Initualizing an integer variable to hold the number of scores, as well as an strings ArrayList to hold the scores and other information
    int numberOfScores = 0;
    textSize(40);
    ArrayList<String> scores = new ArrayList<>();
    
    // Iterates through the file until the last line and adds the scores to the ArrayList and the counter respectively
    while (currentLine != null) {
        scores.add(currentLine);
        numberOfScores++;
        currentLine = sentenceReader.readLine();
    }
    
    numberOfScores-=1;
    
    // Loop to display the scores line by line with a buffer of 40 pixels
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

// Method to render the View Instructions Page
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
  
  // Exploding Blocks Description
  text("Exploding blocks do not disappear unless broken in which case, they will destroy the blocks around them", 100, 640);
}

// Method to display the End Screen after the user loses the current game
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

       // Draw a square which is the total width divided by the grid size and total height divided by the grid size
       fill(colors[((powerOfTwo(currentGrid[rows][columns])%colors.length))]);
       rect(225+rows*(525/grid+4), 320+columns*(525/grid+4), (530/grid-4), (530/grid-4), 10);
       
       // If the square is a 6, it is a bomb square, in which case the bomb image will be rendered
       if (currentGrid[rows][columns] == 6){
         bomb.resize((int)((500/grid)),(int)((500/grid)));
         image(bomb, (225+rows*(525/grid+4)), (320+columns*(525/grid+4)));
       }
       // Render the text number of the square if the square is not a 0
       else if (currentGrid[rows][columns]%2 == 0){
         fill(0);
         textSize(160/grid);
         text(currentGrid[rows][columns], (225+rows*(525/grid+4)+(530/grid-4)/2), (320+columns*(525/grid+4)+(530/grid-4)/2));
       }
       // If the square is not divisible by 2, it is a lock square, in which case the lock image will be rendered
       else {
         lock.resize((int)((500/grid)),(int)((500/grid)));
         image(lock, (225+rows*(525/grid+4)), (320+columns*(525/grid+4)));
       }
     }
  }
  try {
    // Write the score to the scores.txt file for future reference where the current score, the number of moves, and the grid size are mentioned.
    String path = sketchPath("scores.txt");
    PrintWriter sentenceWriter = new PrintWriter(new java.io.FileWriter(path, true));
    sentenceWriter.println("Score: " + currentScore + " in " + currentMoves + " moves of grid size " + grid + "x" + grid);
    sentenceWriter.close(); 
  } catch (IOException e) {
    e.printStackTrace();
  }
  
  // Display instructions for the user to move on to the next stage
  text("Press SPACE to Continue", width/2, height-100);
    
}

// Method to check the number of possible collisions in a grid
int checkPossibleCollisions(int[][] currentGrid){
  // Initialize variable for possible collisionss
  int possibleCollisions = 0;
  int[][] newGrid = currentGrid;
  
  // Check for left swipe collisions
  for (int row=1; row<grid; row++){
    for (int column=0; column<grid; column++){
      if (newGrid[row][column]==newGrid[row-1][column] && newGrid[row][column]!=0){
        possibleCollisions++;
      }
    }
  }
  // Check for right swipe collisions
  for (int row=grid-1; row>0; row--){
    for (int column=0; column<grid; column++){
      if (newGrid[row][column]==newGrid[row-1][column] && newGrid[row][column]!=0){
        possibleCollisions++;
      }
    }
  }
  // Check for up swipe collisions
  for (int row=0; row<grid; row++){
    for (int column=1; column<grid; column++){
      if (newGrid[row][column]==newGrid[row][column-1] && newGrid[row][column]!=0){
        possibleCollisions++;
      }
    }
  }
  // Check for down swipe collisions
  for (int row=0; row<grid; row++){
    for (int column=grid-1; column>0; column--){
      if (newGrid[row][column]==newGrid[row][column-1] && newGrid[row][column]!=0){
        possibleCollisions++;
      }
    }
  }
  
  return possibleCollisions;
}

// Method to combine squares before the grid is shifted
int[][] checkCollisions(int[][] currentGrid, String direction){
  int[][] newGrid = currentGrid;
  
  switch (direction) {
    case "left":
      // Iterates through every square in the grid
      for (int row=1; row<grid; row++){
        for (int column=0; column<grid; column++){
          // Checks if the left square is the same as the current square
          if (newGrid[row][column]==newGrid[row-1][column] && newGrid[row][column]!=0){
            // If the double powerup is on, the value of the new square is doubled
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
      // Iterates through every square in the grid
      for (int row=grid-1; row>0; row--){
        for (int column=0; column<grid; column++){
          // Checks if the left square is the same as the current square
          if (newGrid[row][column]==newGrid[row-1][column] && newGrid[row][column]!=0){
            // If the double powerup is on, the value of the new square is doubled
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
      // Iterates through every square in the grid
      for (int row=0; row<grid; row++){
        for (int column=1; column<grid; column++){
          // Checks if the square above is the same as the current square
          if (newGrid[row][column]==newGrid[row][column-1] && newGrid[row][column]!=0){
            // If the double powerup is on, the value of the new square is doubled
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
      // Iterates through every square in the grid
      for (int row=0; row<grid; row++){
        for (int column=grid-1; column>0; column--){
          // Checks if the square above is the same as the current square
          if (newGrid[row][column]==newGrid[row][column-1] && newGrid[row][column]!=0){
            // If the double powerup is on, the value of the new square is doubled
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
  // Iterate through every tile
  for (int row=0; row<grid; row++){
    for (int column=0; column<grid; column++){
      if (newGrid[row][column] != 0){
        // Check if the square is a 12, which is a combination of 2 sixes which is a bomb tile
        if (newGrid[row][column] % 12 == 0){
          // Sets the bomb tile to blank
          newGrid[row][column] = 0;
          
          // Checks for row above
          if (row>0){
            // Sets the square directly above to blank
            newGrid[row-1][column] = 0;
            
            // Checks for column to the left
            if (column>0){
              // Sets the square in the top left to blank
              newGrid[row-1][column-1] = 0;
            }
            
            // Checks for column to the right
            if (column<grid-1){
              // Sets the square in the top right to blank
              newGrid[row-1][column+1] = 0;
            }
          }
          
          // Checks for the row below
          if (row<grid-1){
            // Sets the square directly below to blank
            newGrid[row+1][column] = 0;
            
            // Checks for column to the left
            if (column>0){
              // Sets the square at the bottom left to blank
              newGrid[row+1][column-1] = 0;
            }
            
            // Checks for column to the right
            if (column<grid-1){
              // Sets the square at the bottom right to blank
              newGrid[row+1][column+1] = 0;
            }
          }
          
          // Checks for the column to the left
          if (column>0){
            // Sets the square directly to the left to blank
            newGrid[row][column-1] = 0;
          }
          
          // Checks for the column to the right
          if (column<grid-1){
            // Sets the square directly to the right to blank
            newGrid[row][column+1] = 0;
          } 
        }
      }
    }
  } 
  
  return newGrid;
}

// Method to shift the grid in a direction
int[][] shiftGrid(int[][] currentGrid, String direction) {
  
  int[][] newGrid = new int[grid][grid];
  // Combine all close tiles with direction
  currentGrid = checkCollisions(currentGrid, direction);
  
  switch (direction) {
    case "up":
      for (int i=0; i<grid; i++){
        // Initializes an empty array to store the coordinates of the filled tiles 
        int[] filled = new int[grid];
        int filledCount = 0;
        
        // Loop to iterate through each square in the current culumn and add filled squares to the array
        for (int number : currentGrid[i]){
          if (number != 0){
            filled[filledCount] = number;
            filledCount++;
          }
        }
        
        // Due to the direction of up, the empty spaces fill up from the bottom
        for (int x=grid-filledCount; x>0; x--){
          filled[filledCount+x-1] = 0;
        }
        newGrid[i] = filled;
      }
      break;
      
     case "down":
      for (int i = 0; i < grid; i++) {
        // Initializes an empty array to store the coordinates of the filled tiles
        int[] filled = new int[grid];
        int filledCount = 0;
    
        // Loop to iterate through each square in the current column and add filled squares to the array
        for (int x = grid - 1; x >= 0; x--) {
          if (currentGrid[i][x] != 0) {
            filled[filledCount] = currentGrid[i][x];
            filledCount++;
          }
        }
    
        // Due to the direction of down, the filled squares fill up at the bottom
        for (int x = 0; x < filledCount; x++) {
          newGrid[i][grid - 1 - x] = filled[x];
        }

        // Due to the direction of down, the empty spaces fill up from the top
        for (int x = 0; x < grid - filledCount; x++) {
          newGrid[i][x] = 0;
        }
      }
      break;
      
    case "left":
      for (int i = 0; i < grid; i++) {
        // Initializes an empty array to store the coordinates of the filled tiles
        int[] filled = new int[grid];
        int filledCount = 0;
 
        // Loop to iterate through each square in the current row and add filled squares to the array
        for (int x = 0; x < grid; x++) {
          if (currentGrid[x][i] != 0) {
            filled[filledCount] = currentGrid[x][i];
            filledCount++;
          }
        }
  
        
        int y = grid - 1;
        // Iterate through each row and set the right most squares to the number of blank squares
        for (int x = grid-filledCount - 1; x >= 0; x--) {
          newGrid[y][i] = 0;
          y--;
        }
        
        // Iterate through each row and set the left most squares to the filled squares
        while (y >= 0) {
          newGrid[y][i] = filled[y];
          y--;
        }
      }
      break;
      
    case "right":
      for (int i = 0; i < grid; i++) {
        // Initializes an empty array to store the coordinates of the filled tiles
        int[] filled = new int[grid];
        int filledCount = 0;
 
        // Loop to iterate through each square in the current row and add filled squares to the array
        for (int x = 0; x < grid; x++) {
          if (currentGrid[x][i] != 0) {
            filled[filledCount] = currentGrid[x][i];
            filledCount++;
          }
        }
  
        int y = grid - 1;
        // Iterate through each row and set the left most squares to the number of blank squares
        for (int x = filledCount - 1; x >= 0; x--) {
          newGrid[y][i] = filled[x];
          y--;
        }
  
        // Iterate through each row and set the right most squares to the filled squares
        while (y >= 0) {
          newGrid[y][i] = 0;
          y--;
        }
      }
      break;
  }
  
  return checkCollisions(newGrid, direction);
}

// Method to find how many times two has to be multipled to reach a number
int powerOfTwo(int n) {
  // Initialize the variable to keep track of how many times the number has been divided
  int power = 0;
  
  // While the number is greater than 2 to the power of 0, the number keeps getting divided by 2
  while (n > 1) {
      n /= 2;
      power++;
  }
  return power;
}

// Method for the actual game screen
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
         
         // If the current square is a bomb, render bomb image
         if (currentGrid[rows][columns] == 6){
           bomb.resize((int)((500/grid)),(int)((500/grid)));
           image(bomb, (225+rows*(525/grid+4)), (225+columns*(525/grid+4)));
         }
         // Display the number as text if it is a number block
         else if (currentGrid[rows][columns]%2 == 0){
           fill(0);
           textSize(160/grid);
           text(currentGrid[rows][columns], (225+rows*(525/grid+4)+(530/grid-4)/2), (225+columns*(525/grid+4)+(530/grid-4)/2));
         }
         // If the current square is a lock, render lock image
         else {
           lock.resize((int)((500/grid)),(int)((500/grid)));
           image(lock, (225+rows*(525/grid+4)), (225+columns*(525/grid+4)));
         }
       }
     }
  }
  
  // Display Powerup Squares
  // Display combine all powerup
  fill(colors[1]);
  rect(225, 800, 100, 100, 10);
  image(lightning, 233, 810);
  
  // Display only spawn 4s powerup
  fill(colors[1]);
  rect(335, 800, 100, 100, 10);
  fill(0);
  textSize(40);
  text("444", 385, 850);
  
  // Display undo last move powerup
  fill(colors[1]);
  rect(445, 800, 100, 100, 10);
  fill(0);
  textSize(40);
  image(undo, 460, 815);
  
  // Display destroy random block powerup
  fill(colors[1]);
  rect(555, 800, 100, 100, 10);
  fill(0);
  textSize(40);
  image(hammer, 570, 815);
  
  // Display 2x combine powerup
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
  
  // Display any warnings left behind
  text(warning, width/2, 950);
}

// Method to setup adjust grid size page
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
  
  // Render grid using dynamic height and width using calculations
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

// Method to setup the select maps page
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

  // Display the maps slider for size based on the current theme selected
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
  
  // Rendering the View Instructions button
  fill(colors[3]);
  rect(150, 780, width-300, 100);
  textSize(60);
  fill(0);
  text("View Instructions", (width)/2, 830);
  
  // Rendering the View Previous Scores button
  fill(colors[3]);
  rect(150, 890, width-300, 100);
  textSize(60);
  fill(0);
  text("View Previous Scores", (width)/2, 940);
}

// Method to toggle music on and off
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

// Method to setup the title page for the user
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