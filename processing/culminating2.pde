import ddf.minim.*;

AudioPlayer player;
Minim minim;

String text;
String musicStatus = "ON";
String currentStage = "start";
String theme = "desert";
int grid = 4;

color[] desertColors = [];

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
    fill(#cdbea1);
    rect(150, 400, width-300, 100);
    textSize(80);
    fill(0);
    text("MUSIC: " + musicStatus, (150+width-300)/2, 450);
    fill(#d6c9b1);
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
        }
      }
      if (mouseX >= 200 && mouseX <= 200 + 170) {
        if (mouseY >= 190 && mouseY <= 190 + 170) {
          theme = "forest";
        }
      }
      if (mouseX >= (width/2 - 110) + 240 && mouseX <= (width/2 - 110) + 240 + 170) {
        if (mouseY >= 190 && mouseY < 190 + 170) {
          theme = "space";
        }
      }
    } else if (theme == "forest") {
      if (mouseX >= width/2 - 110 && mouseX <= (width/2 - 110) + 220) {
        if (mouseY >= 170 && mouseY <= 170 + 220) {
          theme = "forest";
        }
      }
      if (mouseX >= 200 && mouseX <= 200 + 170) {
        if (mouseY >= 190 && mouseY <= 190 + 170) {
          theme = "space";
        }
      }
      if (mouseX >= (width/2 - 110) + 240 && mouseX <= (width/2 - 110) + 240 + 170) {
        if (mouseY >= 190 && mouseY <= 190 + 170) {
          theme = "desert";
        }
      }
    } else if (theme == "space") {
      if (mouseX >= width/2 - 110 && mouseX <= (width/2 - 110) + 220) {
        if (mouseY >= 170 && mouseY <= 170 + 220) {
          theme = "space";
        }
      }
      if (mouseX >= 200 && mouseX <= 200 + 170) {
        if (mouseY >= 190 && mouseY <= 190 + 170) {
          theme = "desert";
        }
      }
      if (mouseX >= (width/2 - 110) + 240 && mouseX <= (width/2 - 110) + 240 + 170) {
        if (mouseY >= 190 && mouseY <= 190 + 170) {
          theme = "forest";
        }
      }
    }
    // Check for adjust grid size button click
    if (mouseX >= 150 && mouseX <= 150+width-300) {
      if (mouseY >= 520 && mouseY <= 620) {
        setupGridAdjust();
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
}

void setupGridAdjust(){
  background(#e6dfd0);
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
  fill(#ded4c0);
  rect(200, 200, 600, 600, 50);
  
  fill(#c5b391);
  for (int rows = 0; rows < grid; rows++){
     for (int columns = 0; columns < grid; columns++){
       rect(225+rows*(525/grid+4), 225+columns*(525/grid+4), (530/grid-4), (530/grid-4), 10);
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
  background(#e6dfd0);
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
    fill(#c5b391);
    rect(width/2-110, 170, 220, 220);
    textSize(60);
    fill(0);
    text("Desert", (width)/2, 270);

    fill(#ded4c0);
    rect(200, 190, 170, 170);
    textSize(40);
    fill(0);
    text("Forest", 285, 270);

    fill(#ded4c0);
    rect((width/2-110)+240, 190, 170, 170);
    textSize(40);
    fill(0);
    text("Space", (width/2-110)+240+85, 270);
  } else if (theme == "forest") {
    fill(#c5b391);
    rect(width/2-110, 170, 220, 220);
    textSize(60);
    fill(0);
    text("Forest", (width)/2, 270);

    fill(#ded4c0);
    rect(200, 190, 170, 170);
    textSize(40);
    fill(0);
    text("Space", 285, 270);

    fill(#ded4c0);
    rect((width/2-110)+240, 190, 170, 170);
    textSize(40);
    fill(0);
    text("Desert", (width/2-110)+240+85, 270);
  } else if (theme == "space") {
    fill(#c5b391);
    rect(width/2-110, 170, 220, 220);
    textSize(60);
    fill(0);
    text("Space", (width)/2, 270);

    fill(#ded4c0);
    rect(200, 190, 170, 170);
    textSize(40);
    fill(0);
    text("Desert", 285, 270);

    fill(#ded4c0);
    rect((width/2-110)+240, 190, 170, 170);
    textSize(40);
    fill(0);
    text("Forest", (width/2-110)+240+85, 270);
  }
  
  // Rendering the Change Map Dimensions button
  fill(#cdbea1);
  rect(150, 520, width-300, 100);
  textSize(60);
  fill(0);
  text("Adjust Grid Size", (width)/2, 570);

  // Rendering the Start Game button
  fill(#cdbea1);
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

  background(#e6dfd0);

  textSize(150);
  fill(0);
  textAlign(CENTER, CENTER);
  text("2048:", width/2, 100);
  textSize(160);
  text("POWER", width/2, 250);
  currentStage = "start";

  // Rendering the Toggle Map Settings button
  fill(#cdbea1);
  rect(150, 520, width-300, 100);
  textSize(60);
  fill(0);
  text("Toggle Map Settings", (width)/2, 570);

  // Rendering the Start Game button
  fill(#cdbea1);
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

// Work on themes, make sure the start game buttons work for the start menu and the map menu