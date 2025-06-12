
import ddf.minim.*;

AudioPlayer player;
Minim minim;

String text;
String musicStatus = "ON";
String currentStage = "start";
String theme = "desert";
int grid = 4;

int currentScore = 0;
int currentMoves = 0;

int[][] currentGrid;

color[] desertColors = {#e6dfd0, #ded4c0, #d6c9b1, #cdbea1, #c5b391, #bda981, #b49e72};
color[] spaceColors = {#cccccc, #c0c0c0, #b3b3b3, #a6a6a6, #999999, #8d8d8d, #808080};
color[] forestColors = {#99c199, #80b280, #66a266, #4d934d, #338333, #197419, #006400};

color[] colors = desertColors;

void setup() {
  // Creating the basic canvas
  size(1000, 1000);

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
  if (currentStage == "start") {
    // Checks for mute and unmute key presses and plays music accordingly
    if (key == 'm' || key == 'M') {
      toggleMusic();
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
      currentGrid = shiftGrid(currentGrid, "up");
      currentMoves += 1;
      
      int[][] freeSpots = new int[grid*grid][2];
      int totalFree = 0;
      for (int rows = 0; rows < grid; rows++){
           for (int columns = 0; columns < grid; columns++){
             if (currentGrid[rows][columns] == 0){
               freeSpots[totalFree][0] = rows;
               freeSpots[totalFree][1] = columns;
               totalFree += 1;
             }
           }
       }
       
       if (totalFree == 0 && checkPossibleCollisions(currentGrid) == 0){
         currentStage = "finishedgame";
         setupFinishedGamePage();
       }
       
       int randomAddition = (int)(Math.random()*totalFree);
       int randomNum = (int)(Math.random()*10);
       
       if (randomNum == 9){
         currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
       }
       else{
         currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
       }
     
    }
    else if (keyCode == DOWN){
      currentGrid = shiftGrid(currentGrid, "down");
      currentMoves += 1;
      
      int[][] freeSpots = new int[grid*grid][2];
      int totalFree = 0;
      for (int rows = 0; rows < grid; rows++){
           for (int columns = 0; columns < grid; columns++){
             if (currentGrid[rows][columns] == 0){
               freeSpots[totalFree][0] = rows;
               freeSpots[totalFree][1] = columns;
               totalFree += 1;
             }
           }
       }
       
       if (totalFree == 0 && checkPossibleCollisions(currentGrid) == 0){
         currentStage = "finishedgame";
         setupFinishedGamePage();
       }
       
       int randomAddition = (int)(Math.random()*totalFree);
       int randomNum = (int)(Math.random()*10);
       
       if (randomNum == 9){
         currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
       }
       else{
         currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
       }
       
    }
    else if (keyCode == LEFT){
      currentGrid = shiftGrid(currentGrid, "left");
      currentMoves += 1;
      
      int[][] freeSpots = new int[grid*grid][2];
      int totalFree = 0;
      for (int rows = 0; rows < grid; rows++){
           for (int columns = 0; columns < grid; columns++){
             if (currentGrid[rows][columns] == 0){
               freeSpots[totalFree][0] = rows;
               freeSpots[totalFree][1] = columns;
               totalFree += 1;
             }
           }
       }
       
       if (totalFree == 0 && checkPossibleCollisions(currentGrid) == 0){
         currentStage = "finishedgame";
         setupFinishedGamePage();
       }
       
       int randomAddition = (int)(Math.random()*totalFree);
       int randomNum = (int)(Math.random()*10);
       
       if (randomNum == 9){
         currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
       }
       else{
         currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
       }
       
    }
    else if (keyCode == RIGHT){
      currentGrid = shiftGrid(currentGrid, "right");
      currentMoves += 1;
      
      int[][] freeSpots = new int[grid*grid][2];
      int totalFree = 0;
      for (int rows = 0; rows < grid; rows++){
           for (int columns = 0; columns < grid; columns++){
             if (currentGrid[rows][columns] == 0){
               freeSpots[totalFree][0] = rows;
               freeSpots[totalFree][1] = columns;
               totalFree += 1;
             }
           }
       }
       
       if (totalFree == 0 && checkPossibleCollisions(currentGrid) == 0){
         currentStage = "finishedgame";
         setupFinishedGamePage();
       }
       
       int randomAddition = (int)(Math.random()*totalFree);
       int randomNum = (int)(Math.random()*10);
       
       if (randomNum == 9){
         currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 4;
       }
       else{
         currentGrid[freeSpots[randomAddition][0]][freeSpots[randomAddition][1]] = 2;
       }
       
    }
  }
  
  else if (currentStage == "finishedgame"){
    if (key == ' '){
      setupTitlePage();
    }
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
  }
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
       fill(colors[4]);
       rect(225+rows*(525/grid+4), 320+columns*(525/grid+4), (530/grid-4), (530/grid-4), 10);
       
       if (currentGrid[rows][columns] != 0){
         fill(colors[((powerOfTwo(currentGrid[rows][columns])%colors.length))]);
         rect(225+rows*(525/grid+4), 320+columns*(525/grid+4), (530/grid-4), (530/grid-4), 10);
         
         fill(0);
         textSize(30);
         text(currentGrid[rows][columns], (225+rows*(525/grid+4)+(530/grid-4)/2), (320+columns*(525/grid+4)+(530/grid-4)/2));
       }
     }
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
            newGrid[row-1][column] = newGrid[row][column]+newGrid[row-1][column];
            newGrid[row][column] = 0;
            currentScore+=newGrid[row][column]+newGrid[row-1][column];
          }
        }
      }
      break;
     
    case "right":
      for (int row=grid-1; row>0; row--){
        for (int column=0; column<grid; column++){
          if (newGrid[row][column]==newGrid[row-1][column] && newGrid[row][column]!=0){
            newGrid[row][column] = newGrid[row][column]+newGrid[row-1][column];
            newGrid[row-1][column] = 0;
            currentScore+=newGrid[row][column]+newGrid[row-1][column];
          }
        }
      }
      break;
      
    case "up":
      for (int row=0; row<grid; row++){
        for (int column=1; column<grid; column++){
          if (newGrid[row][column]==newGrid[row][column-1] && newGrid[row][column]!=0){
            newGrid[row][column-1] = newGrid[row][column]+newGrid[row][column-1];
            newGrid[row][column] = 0;
            currentScore+=newGrid[row][column]+newGrid[row][column-1];
          }
        }
      }
      break;
      
    case "down":
      for (int row=0; row<grid; row++){
        for (int column=grid-1; column>0; column--){
          if (newGrid[row][column]==newGrid[row][column-1] && newGrid[row][column]!=0){
            newGrid[row][column] = newGrid[row][column]+newGrid[row][column-1];
            newGrid[row][column-1] = 0;
            currentScore+=newGrid[row][column]+newGrid[row][column-1];
          }
        }
      }
      break;
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
         
         fill(0);
         textSize(30);
         text(currentGrid[rows][columns], (225+rows*(525/grid+4)+(530/grid-4)/2), (225+columns*(525/grid+4)+(530/grid-4)/2));
       }
     }
  }
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
}

void toggleMusic() {
  // Method to toggle music depending on current status
  if (musicStatus == "ON") {
    musicStatus = "OFF";
    player.close();
    minim.stop();
  } else if (musicStatus == "OFF") {
    musicStatus = "ON";
    minim = new Minim(this);
    player = minim.loadFile("music.mp3");
    player.loop();
  }
}

void setupTitlePage() {
  // Set up basic title page

  background(colors[0]);

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
}