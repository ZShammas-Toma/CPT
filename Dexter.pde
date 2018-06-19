PVector playerLoc; 
PVector playerSpeed;
PVector villainLoc;
PVector villainSpeed;
PVector obstacle;
boolean walk[] = {false, false, false};
boolean click[] = {false, false, false, false, false, false, false, false, false, false};
PImage menuBackground;
PImage clueOne;
PImage clueTwo;
PImage clueThree; 
PImage clueFour;
PFont explainingText;

void setup() {
size(1300, 700);
  villainLoc = new PVector (16000, 400);
  villainSpeed = new PVector (0, 0);
  playerSpeed = new PVector (0, 0);
  playerLoc = new PVector (180, 400);
  obstacle = new PVector (1000, 430);
  menuBackground = loadImage("mainMenu.jpg");
  clueOne = loadImage("knifeClue.png");
  clueTwo = loadImage("gloveClue.png");
  clueThree = loadImage("blueprintClue.jpg");
  clueFour = loadImage("bloodClue.png");
  explainingText = createFont("VCR_OSD_MONO_1.001.ttf", 1);
  textFont(explainingText);
}

void draw() {
  //Calling the movement method
  playerMovement();
  
  gravity();
  
  //MOVING DISPLAY
  translate(-playerLoc.x + 180, 0);
  
  //DRAWING SCENERY
  background(#010115);
  fill(#91a3b0);
  ellipse(playerLoc.x + 470, 500, 300, 300);
  fill(#228B22);
  rect(0, 520, width + playerLoc.x, 520);
  
  instructionBox();  

  //Drawing Obstacles
  stroke(0);
  fill(225);
  rect(1000, 430, 90, 90);
  
  playerCollision();
  
  if (playerLoc.x > 6330 && playerLoc.x < 8000) {
    playerLoc.x = 15000;
  }
  
  if (playerLoc.x >= 15000) {
    fill(#8B4513);
    rect(14820, 0, width + playerLoc.x, 700);
    //Drawing the Main Villain: Brian Morgan
    noStroke();
    fill(222,168,121,200); 
    //Head
    triangle(villainLoc.x + 30, villainLoc.y, villainLoc.x + 50, villainLoc.y - 50, villainLoc.x + 5, villainLoc.y - 50);
    //Body
    fill(#9C0000); 
    rect(villainLoc.x + 2, villainLoc.y - 20, 57, 80);
    //Legs
    rect(villainLoc.x + 12.5, villainLoc.y + 60, 15, 60);
    rect(villainLoc.x + 32, villainLoc.y + 60, 15, 60);
    //Suit
    fill(225);
    triangle(villainLoc.x + 30, villainLoc.y + 10, villainLoc.x + 10, villainLoc.y - 20, villainLoc.x + 20, villainLoc.y - 20);
    triangle(villainLoc.x + 30, villainLoc.y + 10, villainLoc.x + 38, villainLoc.y - 20, villainLoc.x + 48, villainLoc.y - 20);
    //Eyes and Mouth
    noStroke();
    fill(0);
    ellipse(villainLoc.x + 19, villainLoc.y - 40, 10, 10);
    stroke(0);
    strokeWeight(3);
    line(villainLoc.x + 17, villainLoc.y - 28, villainLoc.x + 26, villainLoc.y - 28);
    fill(#9C0000); //Hat
    rect(villainLoc.x + 3.5, villainLoc.y - 53, 50, 10);
    rect(villainLoc.x + 13, villainLoc.y - 63, 30, 20);
   }
  //Drawing The Main Character: Dexter Morgan
  noStroke();
  fill(222,168,121,200); 
  //Head
  triangle(playerLoc.x + 30, playerLoc.y, playerLoc.x + 50, playerLoc.y - 50, playerLoc.x + 5, playerLoc.y - 50);
  //Body
  fill(0); 
  rect(playerLoc.x + 2, playerLoc.y - 20, 57, 80);
  //Legs
  rect(playerLoc.x + 12.5, playerLoc.y + 60, 15, 60);
  rect(playerLoc.x + 32, playerLoc.y + 60, 15, 60);
  //Suit
  fill(225);
  triangle(playerLoc.x + 30, playerLoc.y + 10, playerLoc.x + 10, playerLoc.y - 20, playerLoc.x + 20, playerLoc.y - 20);
  triangle(playerLoc.x + 30, playerLoc.y + 10, playerLoc.x + 38, playerLoc.y - 20, playerLoc.x + 48, playerLoc.y - 20);
  //Stab Wound
  fill(#C80707);
  rect(playerLoc.x + 49, playerLoc.y + 30, 10, 5);
  //If statements for the character facing left and right (make easier to read)
  if (walk[0] || walk[2] && walk[1] == false && walk[0] == false || walk[2] && walk[1] == false && walk[2] == false || walk[0] && walk[2] && walk[1] == false || walk[1] == false && playerLoc.y == 400) {
    fill(0);
    ellipse(playerLoc.x + 37, playerLoc.y - 40, 10, 10);
    stroke(0);
    strokeWeight(3);
    line(playerLoc.x + 39, playerLoc.y - 28, playerLoc.x + 29, playerLoc.y - 28);
  }
  if (walk[1] || walk[1] && walk[2] && walk[0] == false) {
    noStroke();
    fill(0);
    ellipse(playerLoc.x + 19, playerLoc.y - 40, 10, 10);
    stroke(0);
    strokeWeight(3);
    line(playerLoc.x + 17, playerLoc.y - 28, playerLoc.x + 26, playerLoc.y - 28);
  }
  fill(0); //Hat
  rect(playerLoc.x + 3.5, playerLoc.y - 53, 50, 10);
  rect(playerLoc.x + 13, playerLoc.y - 63, 30, 20);
  
  //Drawing Brian Morgan's Shack
  noStroke();
  fill(#8B4513);
  rect(6338, 144, 600, 376);
  
  speechBubbles();
  
  openingTitle();
  
  mainMenu();
}

void gravity() {
  playerLoc.y += playerSpeed.y;
  playerSpeed.y += 0.3;
  if (playerLoc.y <= 300) {
    playerSpeed.y += 2;
  }
  if (playerLoc.y >= 400) {
    playerSpeed.y = 0;
  }
  if (playerLoc.y >= 400) {
    playerLoc.y = 400;
  }
  if (playerLoc.y <= 45) {
    playerSpeed.y = -playerSpeed.y;
  }
}

void speechBubbles() {
  if (playerLoc.x < 300) {
  noStroke();
  fill(225);
  rect(playerLoc.x + 65, playerLoc.y - 60, 80, 30);
  fill(0);
  textSize(11);
  text("Where am I?", playerLoc.x + 68, playerLoc.y - 40);
  }
}

void openingTitle() {
  if (click[4] == false) {
  stroke(225);
  fill(0);
  rect(0, 0, 1300, 700);
  textSize(17);
  fill(225);
  text("Dexter is a private investigator, he always gets the job done no matter what. But today, was different to say the least...", 17, 50);
  text("He woke up in the middle of nowhere with a stab wound next to his ribcage, and doesn't remember anything from the past 24 hours.", 17, 90);
  text("Pick up clues and dodge obstacles to help Dexter solve this case ... or else it might be his last.", 17, 130);
  fill(102);
  rect(1150, 650, 100, 30);
  fill(225);
  text("START", 1175, 672);
  }
}

void instructionBox() {
  //INSTRUCTION BOX
  stroke(225);
  fill(0);
  rect(playerLoc.x - 180, 580, 300, 100);
  fill(225);
  textSize(15);
  text("Use the arrow keys", playerLoc.x - 175, 600);
  text("to jump and move left and right.", playerLoc.x - 175, 620);
  //Changing he text box to explain clues when clicked on by the mouse + Drawing Clues
  //The First Clue
  if (click[5] == false) {
    image(clueOne, 1000, 500);
  } 
  if (click[5] == true && click[3] == true) {
    fill(0);
    rect(playerLoc.x - 180, 580, 300, 100);
    fill(225);
    text("You found a clue", playerLoc.x - 175, 600);
    text("Based on the blood spatter", playerLoc.x - 175, 620);
    text("pattern, this knife seems to be", playerLoc.x - 175, 640);
    text("the one that stabbed me.", playerLoc.x - 175, 660);
  }
  //The Second Clue
  if (click[6] == false) {
    image(clueTwo, 3000, 600);
  }
  if (click[6] == true && click[3] == true) {
    fill(0);
    rect(playerLoc.x - 180, 580, 300, 100);
    fill(225);
    text("You found a clue", playerLoc.x - 175, 600);
    text("A pair of gloves, looks like our", playerLoc.x - 175, 620);
    text("killer didn't wanna get his hands", playerLoc.x - 175, 640);
    text("dirty, interesting ...", playerLoc.x - 175, 660);
  }
  //The Third Clue
  if (click[7] == false) {
    image(clueThree, 5000, 550);
  }
  if (click[7] == true && click[3] == true) {
    fill(0);
    rect(playerLoc.x - 180, 580, 300, 100);
    fill(225);
    text("You found a clue", playerLoc.x - 175, 600);
    text("Oh my goodness, it's a blueprint", playerLoc.x - 175, 620);
    text("that he used to plan my death,", playerLoc.x - 175, 640);
    text("so this wasn't random he wanted", playerLoc.x - 175, 660);
    text("to kill me specifically, but why?", playerLoc.x - 175, 680);
  }
  if (click[8] == false) {
    image(clueFour, 6000, 500);
  }
  if (click[8] == true && click[3] == true) {
    fill(0);
    rect(playerLoc.x - 180, 580, 300, 100);
    fill(225);
    text("You found a clue", playerLoc.x - 175, 600);
    text("Blood, but it can't be mine", playerLoc.x - 175, 620);
    text("I need to use my DNA indicator", playerLoc.x - 175, 640);
    text("that I always keep with me", playerLoc.x - 175, 660);
    fill(102);
    if (click[9] == false) {
      rect(playerLoc.x + 150, 590, 130, 40); 
      fill(0);
      text("USE INDICATOR", playerLoc.x + 160, 615);
    }
    if (click[9] == true) {
      fill(0);
      rect(playerLoc.x - 180, 580, 300, 100);
      fill(225);
      text("That's impossible!", playerLoc.x - 175, 600);
      text("It has my DNA, but it's not my", playerLoc.x - 175, 620);
      text("blood. What the he--", playerLoc.x - 175, 640);
    }
  }
}

void playerCollision() {
  //Touching obstacles + Game over screen
  //d, d1, and d2 are all distances between obstacle and character
  float d = dist(obstacle.x + 45, obstacle.y + 45, playerLoc.x + 39, playerLoc.y + 20);  
  float d1 = dist(obstacle.x + 45, obstacle.y + 45, playerLoc.x + 20, playerLoc.y + 90);
  float d2 = dist(obstacle.x + 45, obstacle.y + 45, playerLoc.x + 20, playerLoc.y + 90); 
  //When collision happens the start over or quit game screen pops up
  if (click[0] == false && d <= 82 || d1 <= 70 || d2 <= 70) {
    fill(225);
    rect(obstacle.x + 350, obstacle.y - 200, 200, 100);
    textSize(28);
    fill(102);
    text("Start Over", obstacle.x + 380, obstacle.y - 140);
    fill(225);
    rect(obstacle.x + 350, obstacle.y - 50, 200, 100);
    textSize(28);
    fill(102);
    text("Quit Game", obstacle.x + 380, obstacle.y + 10);
  }
  //setting character to start of game
  if (click[0] == true && (d <= 82 || d1 <= 70 || d2 <= 70)) {
    playerLoc.x = 180;
    playerLoc.y = 400;
  } 
  //Quitting the game and returning to main menu
  if (click[1] == true && (d <= 82 || d1 <= 70 || d2 <= 70)) {
    click[3] = false;
  } 
}

void mainMenu() {
  //MAIN MENU
  noStroke();
  if (click[3] == false) {
    image(menuBackground, 0, 0);
    fill(#840000);
    rect(330, 515, 300, 150);
    textSize(40);
    fill(225);
    text("PLAY GAME", 370, 600);
    fill(#840000);
    rect(650, 515, 300, 150);
    textSize(40);
    fill(225);
    text("EXIT GAME", 690, 600);
      if (click[2] == true) {
        exit();
      }
  }
}

void keyPressed() {
  //movement for player
  if (keyCode == RIGHT) {
    walk[0] = true;
  }
  if (keyCode == LEFT) {
    walk[1] = true;
  }
  if (keyCode == UP) {
    walk[2] = true;
  }
}

void keyReleased() {
  //movement for player
  if (keyCode == RIGHT) {
    walk[0] = false;
  }
  if (keyCode == LEFT) {
    walk[1] = false;
  }
  if (keyCode == UP) {
    walk[2] = false;
  }
}

void playerMovement() {
  //variables set again here
  float d = dist(obstacle.x + 45, obstacle.y + 45, playerLoc.x + 39, playerLoc.y + 20);  
  float d1 = dist(obstacle.x + 45, obstacle.y + 45, playerLoc.x + 20, playerLoc.y + 90);
  float d2 = dist(obstacle.x + 45, obstacle.y + 45, playerLoc.x + 20, playerLoc.y + 90);
  
  // (d>= 82...) is when the distance between obstacle and player is greater than certain number, player can move
  //used to inhibit player movement when collision happens and when the main menu + opening title is on the screen
  if (walk[0] && (d >= 80 || d1 >= 70 || d2 >= 70)) {
    playerLoc.x = playerLoc.x + 8;
  }
  if (walk[1] && (d >= 82 || d1 >= 70 || d2 >= 70)) {
    playerLoc.x = playerLoc.x - 8;
  }
  if (walk[2] && (d >= 82 || d1 >= 70 || d2 >= 70)) {
    playerLoc.y = playerLoc.y - 25;
  }
  if (playerLoc.x > 1500) {
    villainLoc.x = villainLoc.x + 5;
  }
}

void mousePressed() {
  float d = dist(obstacle.x + 45, obstacle.y + 45, playerLoc.x + 39, playerLoc.y + 20);  
  float d1 = dist(obstacle.x + 45, obstacle.y + 45, playerLoc.x + 20, playerLoc.y + 90);
  float d2 = dist(obstacle.x + 45, obstacle.y + 45, playerLoc.x + 20, playerLoc.y + 90);
  
  println(mouseX, mouseY);
  println(playerLoc.x, playerLoc.y);
  //click[0] represents the Start Over buttom after collision
  if (mouseX > 1000 - obstacle.x + 350 && mouseX < 1200 - obstacle.x + 550 && mouseY > 230 && mouseY < 330 && d <= 82 || d1 <= 70 || d2 <= 70) {
    click[0] = true;
  }
  //click[1] represents the Quit Game button after collision
  if (mouseX > 1000 - obstacle.x + 350 && mouseX < 1200 - obstacle.x + 550 && mouseY > 380 && mouseY < 480 && (d <= 82 || d1 <= 70 || d2 <= 70)) {
    click[1] = true;
  }
  //click[2] represents the EXIT button on the main menu
  if (mouseX > 650 && mouseX < 930 && mouseY >515 && mouseY < 665) {
    click[2] = true;
  }
  //click[3] represents the PLAY GAME button on the main menu
  if (mouseX > 330 && mouseX < 630 && mouseY > 515 && mouseY < 665) {
    click[3] = true;
  }
  //click[4] represents the "START" button on the opening title screen
  if (mouseX > 1150 && mouseX < 1250 && mouseY > 650 && mouseY < 690) {
    click[4] = true;
  }
  //click[5] represents the first clue
  if (mouseX > 1004 - playerLoc.x + 180 && mouseX < 1199 - playerLoc.x + 180 && mouseY > 569 && mouseY < 631) {
    click[5] = true;
  }
  //click[6] represents the second clue
  if (mouseX > 3000 - playerLoc.x + 180 && mouseX < 3130 - playerLoc.x + 180 && mouseY > 604 && mouseY < 699) {
    click[6] = true;
  }
  //click[7] represents the third clue
  if (mouseX > 5000 - playerLoc.x + 180 && mouseX < 5207 - playerLoc.x + 180 && mouseY > 550 && mouseY < 691) {
    click[7] = true;
  }
  //click[8] represents the fourth clue
  if (mouseX > 6000 - playerLoc.x + 180 && mouseX < 6400 - playerLoc.x + 180 && mouseY > 500 && mouseY < 700) {
    click[8] = true;
  }
  //click[9] represents the USE INDICATOR button
  if (mouseX > 330 && mouseX < 463  && mouseY > 590 && mouseY < 630) {
    click[9] = true;
  }
}

void mouseReleased() {
  click[0] = false;
  click[1] = false;
}
