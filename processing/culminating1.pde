import ddf.minim.*;

AudioPlayer player;
Minim minim;

String text;
String musicStatus = "ON";
String currentStage = "start";

void setup(){
  // Creating the basic canvas
  size(1000, 1000);
  background(#e6dfd0);
  
  // Setting up the music player
  minim = new Minim(this);
  player = minim.loadFile("music.mp3");
  player.loop();
  
  // Creating the basic title page
  setupTitlePage();
}

void draw(){
  if (currentStage == "start"){
    // Rendering the music settings dynamically
    fill(#cdbea1);
    rect(150, 400, width-300, 100);
    textSize(80);
    fill(0);
    text("MUSIC: " + musicStatus , (150+width-300)/2, 450);
    fill(#d6c9b1);
    rect(150+width-400, 400, 100, 100);
    fill(0);
    if (musicStatus == "ON"){
      fill(0);
      textSize(200);
      text("-" , 800, 435);
    }
    else if (musicStatus == "OFF"){
      fill(0);
      textSize(170);
      text("+" , 800, 445);
    }
  }
}

void keyPressed(){
  if (currentStage == "start"){
    // Checks for mute and unmute key presses and plays music accordingly
    if (key == 'm' || key == 'M'){
      if (musicStatus == "ON"){
        musicStatus = "OFF";
        player.close();
        minim.stop();
      }
      else if (musicStatus == "OFF"){
        musicStatus = "ON";
        minim = new Minim(this);
        player = minim.loadFile("music.mp3");
        player.loop();
      }
    }
  }
}

void setupTitlePage(){
  // Set up basic title page
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
  text("Toggle Map Settings" , (width)/2, 570);
  
  // Rendering the Start Game button
  fill(#cdbea1);
  rect(150, 670, width-300, 100);
  textSize(60);
  fill(0);
  text("START GAME" , (width)/2, 720);

  // Printed instructions for menu selection
  textSize(50);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Press M to mute/unmute", width/2, 850);
  textSize(50);
  text("Use mouse to select menu", width/2, 900);

}
