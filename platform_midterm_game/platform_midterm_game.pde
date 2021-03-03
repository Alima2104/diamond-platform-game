import processing.sound.*;
SoundFile file, file2;

int startTime; 
int counter; 
int maxTime; 
boolean done; 

int score = 0;

PImage startscreen;
PImage gamescreen;
PImage winscreen;
PImage gameoverscreen;
PImage airplane;

PImage spritesheet2;
PImage[] sprites2;

PImage spritesheet;
PImage[] sprites;
int x;
int y;
int direction = 1; // 0 up
int step = 0;
int speed = 3;

int x2;
int step2 = 0;
int speed2 = 3;
int direction2 = 1;

PImage diamond;

String gameState;
Timer countDownTimer;
int timeLeft;

PFont mono;

Platform [] platforms;
Character1 c;
Character2 c2;
Diamond [] diamonds;
Enemy [] enemies;
Portal p;

boolean left, right, up, down, space;
boolean left1, right1, up1, down1, space1;

void setup() {

  size(800, 600);

  startscreen = loadImage("bg11.jpg");
  gamescreen = loadImage("bg22.jpg");
  gameoverscreen = loadImage("sky_background.jpg");
  winscreen = loadImage("bg44.jpg");
  airplane = loadImage("airplane1.png");

  gameState = "START";

  countDownTimer = new Timer (1000);
  timeLeft = 60;

  counter = 0; 
  startTime= millis(); 
  maxTime=60; 
  done=false;

  mono = createFont("Franklin Goth Ext Condensed.ttf", 32);
  textFont(mono);

  left=false;
  right=false;
  up = false;
  down = false;
  space=false;

  left1=false;
  right1=false;
  up1 = false;
  down1 = false;
  space1=false;

  file = new SoundFile(this, "bensound-inspire.mp3");
  //file2 = new SoundFile(this, "bensound-creativeminds.mp3");

  c = new Character1(50, 40, 50, 515);
  c2 = new Character2(50, 40, 50, 570);

  spritesheet = loadImage("char1.png");
  sprites = new PImage[6];
  int w = spritesheet.width/6;
  int h = spritesheet.height;

  spritesheet2 = loadImage("char2.png");
  sprites2 = new PImage[6]; 
  int w2 = spritesheet2.width/6;
  int h2 = spritesheet2.height;

  for (int x2=0; x2 < 6; x2++) {
    sprites2[x2] = spritesheet2.get(x*w2, y*h2, w2, h2);
  }

  for (int x=0; x < 6; x++) {
    sprites[x] = spritesheet.get(x*w, y*h, w, h);
  }

  diamonds = new Diamond[3];
  diamond = loadImage("diamond1.png");
  diamonds[0] = new Diamond(725, 525, 50, 50);
  diamonds[1] = new Diamond(30, 150, 50, 50);
  diamonds[2] = new Diamond(320, 70, 50, 50);

  imageMode(CORNER);

  p = new Portal(25, 50, 90, 60);

  platforms = new Platform[18];
  platforms[0] = new Platform (0, 575, 800, 25);
  platforms[1] = new Platform (0, 450, 650, 25);
  platforms[2] = new Platform (600, 325, 200, 25);
  platforms[3] = new Platform (200, 325, 200, 25);
  platforms[4] = new Platform (0, 200, 200, 25);
  platforms[5] = new Platform (300, 200, 300, 25);
  platforms[6] = new Platform (0, 0, 25, height);
  platforms[7] = new Platform (width-25, 0, 25, height);
  platforms[8] = new Platform (0, 0, width, 25);
  platforms[9] = new Platform (560, 0, 80, 25);
  platforms[10] = new Platform (725, 500, 50, 25);
  platforms[11] = new Platform (25, 380, 80, 25);
  platforms[12] = new Platform (25, 100, 100, 25);
  platforms[13] = new Platform (25, 515, 60, 25);
  platforms[14] = new Platform (725, 240, 60, 25);
  platforms[15] = new Platform (250, 120, 150, 25);
  platforms[16] = new Platform (450, 120, 100, 25);
  platforms[17] = new Platform (460, 325, 80, 25);


  enemies = new Enemy[4];
  enemies[0] = new Enemy(460, 324, 80, 25);
  enemies[1] = new Enemy(450, 119, 100, 25);
  enemies[2] = new Enemy(350, height-26, 80, 25);
  enemies[3] = new Enemy(190, 449, 80, 25);
}

void draw() {
  background(255);

  if (gameState == "START") {
    startGame();
    //file2.play();
  } else if (gameState == "PLAY") {
    playGame();
  } else if (gameState == "WIN1") {
    winGame1();
  } else if (gameState == "WIN2") {
    winGame2();
  } else if (gameState == "LOSE") {
    loseGame();
  }
}

void startGame() {
  imageMode(CORNER);
  image(startscreen, 0, 0);
  textAlign(CENTER);
  textSize(50);
  fill(255, 0, 0);
  text("Click anywhere to play!", width/2, height/2+200);
  textSize(30);
  fill(100, 0, 0);
  text("Welcome to the game!\n " +
    "Instructions: \n In order to escape you should reach airplane.\n Avoid red lines!\n Use the keyboard to move Player 1 and Player 2 \n through the maze and collect the crystals on your way to the exit. \n " +
    " The A,W,D keys move Player 2 and the arrow keys move Player 1 ", width/2, height/2-200);

  if (mousePressed) {
    gameState = "PLAY";
    countDownTimer.start();
    //file2.stop();
    file.play();
  }
}

void playGame() {
  imageMode(CORNER);
  image(gamescreen, 0, 0, width, height);

  c.update();
  c2.update();
  for (int i = 0; i < platforms.length; ++i) {
    c.collisionSide = rectangleCollisions(c, platforms[i]);
    c2.collisionSide = rectangleCollisions(c2, platforms[i]);


    c.checkPlatforms();
    c2.checkPlatforms();
  }
  c2.display(); 
  c.display();
  imageMode(CORNER);
  p.display();

  for (int i = 0; i < platforms.length; ++i) {
    platforms[i].display();
  }

  for (int i = 0; i < diamonds.length; ++i) {
    diamonds[i].display();
  }

  for (int i = 0; i < enemies.length; ++i) {
    enemies[i].display();
  }

  if (countDownTimer.complete()==true) {
    if (timeLeft>1) {
      timeLeft -= 1;
      countDownTimer.start();
    } else {
      gameState = "LOSE";
    }
  }

  textAlign(LEFT);
  textSize(20);
  fill(255);
  text("Time Left: " + timeLeft, 650, 50);
  textAlign(CENTER);



  if (rectangleCollisionPvE(c, p)) {
    winGame1();
    file.stop();
  }

  if (rectangleCollisionPvE(c2, p)) {
    winGame2();
    file.stop();
  }
  for (int q = 0; q < enemies.length; ++q) {

    if (enemyCollision(c, enemies[q])) {
      // c.SetC1(460, 85);
      file.stop();
      loseGame();
    }
  }
  for (int m = 0; m < enemies.length; ++m) {

    //file.stop();
    if (enemyCollision(c2, enemies[m])) {
      loseGame(); 
      file.stop();
    }
  }

  for (int i = 0; i < diamonds.length; ++i) {
    if (DiamondCollision(c, diamonds[i])) {
      diamonds[i].setDiamond(700+i*30, 0, 20, 20);
      score++;
    }
  }

  for (int k = 0; k < diamonds.length; ++k) {
    if (DiamondCollision(c2, diamonds[k])) {
      diamonds[k].setDiamond(700+k*30, 0, 20, 20);
      score++;
    }
  }
}

void winGame1() {
  imageMode(CORNER);
  image(winscreen, 0, 0);
  fill(96, 67, 191);
  textSize(40);
  text("CONGRATS! PLAYER ONE WON!\nIf  you want to play again \n click anywhere!", width/2, height/2-100);
  if (mousePressed) {
    resetGame();
    file.play();
  }
}

void winGame2() {
  imageMode(CORNER);
  image(winscreen, 0, 0);
  fill(96, 67, 191);
  textSize(40);
  text("CONGRATS! PLAYER TWO WON!\nIf  you want to play again \n click anywhere!", width/2, height/2-100);
  if (mousePressed) {
    resetGame();
    file.play();
  }
}
void loseGame() {
  imageMode(CORNER);
  image(gameoverscreen, 0, 0, width, height);
  fill(72, 80, 194);
  textSize(40);
  text("GAME OVER!\nIf  you want to play again \n click anywhere!", width/2, height/2-100);
  if (mousePressed) {
    resetGame();
    file.play();
  }
}
void resetGame() {
  c.SetC1(50, 515);
  c2.SetC2(50, 570);
  gameState = "PLAY";
  timeLeft = 60;
}


//AIRPLANE WITH C1
boolean rectangleCollisionPvE(Character1 r1, Portal r2) {

  float dx = (r1.x+r1.w/2) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/2) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.halfWidth + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    ////collision has happened on the x axis
    ////now check on the y axis
    if (abs(dy) < combinedHalfHeights) {
      ////collision detected
      return true;
    }
  }
  return false;
}

//AIRPLANE WITH C2
boolean rectangleCollisionPvE(Character2 r1, Portal r2) {
  ////r1 is the player
  ////r2 is the enemy

  float dx = (r1.x+r1.w/2) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/2) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.halfWidth + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    ////collision has happened on the x axis
    ////now check on the y axis
    if (abs(dy) < combinedHalfHeights) {
      ////collision detected
      return true;
    }
  }
  return false;
}


//DIAMONDS WITH C1
boolean DiamondCollision(Character1 r1, Diamond r2) {
  float dx = (r1.x+r1.w/4) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/4) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.halfWidth/2 + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight/2 + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    ////collision has happened on the x axis
    ////now check on the y axis
    if (abs(dy) < combinedHalfHeights) {
      ////collision detected
      return true;
    }
  }
  return false;
}

//DIAMONDS WITH C2
boolean DiamondCollision(Character2 r1, Diamond r2) {
  float dx = (r1.x+r1.w/4) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/4) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.halfWidth/2 + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight/2 + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    ////collision has happened on the x axis
    ////now check on the y axis
    if (abs(dy) < combinedHalfHeights) {
      ////collision detected
      return true;
    }
  }
  return false;
}


String rectangleCollisions(Character1 r1, Platform r2) {

  //if (r1.vy < 0) { return "none"; }

  float dx = (r1.x+r1.w/4) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/4) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.halfWidth/2 + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight/2+ r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    ////collision has happened on the x axis
    ////now check on the y axis
    if (abs(dy) < combinedHalfHeights) {
      ////collision detected
      //determine the overlap on each axis
      float overlapX = combinedHalfWidths - abs(dx);
      float overlapY = combinedHalfHeights - abs(dy);
      ////the collision is on the axis with the
      ////SMALLEST overlap
      if (overlapX >= overlapY) {
        if (dy > 0) {
          ////move the rectangle back to eliminate overlap
          ////before calling its display to prevent
          ////drawing object inside each other
          r1.y += overlapY;
          return "top";
        } else {
          r1.y -= overlapY;
          return "bottom";
        }
      } else {
        if (dx > 0) {
          r1.x += overlapX;
          return "left";
        } else {
          r1.x -= overlapX;
          return "right";
        }
      }
    } else {
      //collision failed on the y axis
      return "none";
    }
  } else {
    //collision failed on the x axis
    return "none";
  }
}

String rectangleCollisions(Character2 r3, Platform r4) {

  float dx = (r3.x+r3.w/4) - (r4.x+r4.w/2);
  float dy = (r3.y+r3.h/4) - (r4.y+r4.h/2);

  float combinedHalfWidths = r3.halfWidth/2 + r4.halfWidth;
  float combinedHalfHeights = r3.halfHeight/2 + r4.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    if (abs(dy) < combinedHalfHeights) {
      float overlapX = combinedHalfWidths - abs(dx);
      float overlapY = combinedHalfHeights - abs(dy);
      if (overlapX >= overlapY) {
        if (dy > 0) {
          r3.y += overlapY;
          return "top";
        } else {
          r3.y -= overlapY;
          return "bottom";
        }
      } else {
        if (dx > 0) {
          r3.x += overlapX;
          return "left";
        } else {
          r3.x -= overlapX;
          return "right";
        }
      }
    } else {
      //collision failed on the y axis
      return "none";
    }
  } else {
    //collision failed on the x axis
    return "none";
  }
}

boolean enemyCollision(Character1 r1, Enemy r2) {
  ////r1 is the player
  ////r2 is the enemy

  float dx = (r1.x+r1.w/4) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/4) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.halfWidth/2 + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight/2 + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    ////collision has happened on the x axis
    ////now check on the y axis
    if (abs(dy) < combinedHalfHeights) {
      ////collision detected
      return true;
    }
  }
  return false;
}

boolean enemyCollision(Character2 r1, Enemy r2) {
  ////r1 is the player
  ////r2 is the enemy

  float dx = (r1.x+r1.w/4) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/4) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.halfWidth/2 + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight/2 + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    ////collision has happened on the x axis
    ////now check on the y axis
    if (abs(dy) < combinedHalfHeights) {
      ////collision detected
      return true;
    }
  }
  return false;
}


void keyPressed() {
  switch (keyCode) {
  case LEFT:
    left=true;
    break;
  case RIGHT:
    right=true;
    break;
  case UP:
    up=true;
    break;
  case DOWN:
    down=true;
    break;
  case 32:
    space=true;
    break;

  case 65://left
    left1=true;
    break;
  case 68:
    right1=true;
    break;
  case 87:
    up1=true;
    break;
  case 83:
    down1=true;
    break;
  }
}

void keyReleased() {
  switch(keyCode) {
  case 37://left
    left=false;
    break;
  case 39:
    right=false;
    break;
  case 38:
    up=false;
    break;
  case 40:
    down=false;
    break;
  case 32:
    space=false;
    break;

  case 65://left
    left1=false;
    break;
  case 68:
    right1=false;
    break;
  case 87:
    up1=false;
    break;
  case 83:
    down1=false;
    break;
  }
}
