int NUM_ALIENS = 5; // Number of alien spaceships
PlayerSpaceship player; // Updated to PlayerSpaceship
AlienSpaceship[] aliens;
boolean shooting = false; // Flag to indicate if the player is shooting
Bullet[] bullets; // Array to store bullets
PImage img, spaceship, alienImg, backgroundImg;
int gameState = 0; // 0 for start screen, 1 for gameplay
int currentRound = 1; // Current round
int roundDuration = 5000; // Duration of each round in milliseconds (10 seconds)
long roundStartTime; // Start time of the current round
int aliensDestroyed = 0; // Number of aliens destroyed by the player
boolean displayRules = false; // Flag to track whether rules are currently displayed
//int aliensRemaining; // Number of aliens remaining
int aliensEscaped = 0; // Number of aliens that have escaped
boolean gameEnded = false;



void setup() {
  size(800, 600);
  
  img = loadImage("1320395.png");
  img.resize(width, height);
  alienImg = loadImage("alienship.png");
  
  // Create player spaceship
  player = new PlayerSpaceship(width / 2, height - 50);
  
  // Initialize array for alien spaceships
  initializeAliens();
  
  bullets = new Bullet[10];
  for (int i = 0; i < bullets.length; i++) {
    bullets[i] = new Bullet();
  }
}

void initializeAliens() {
  if (!gameEnded && currentRound <= 4) {
    if (currentRound < 4) {
      int numAliens = NUM_ALIENS * currentRound;
      aliens = new AlienSpaceship[numAliens];
      for (int i = 0; i < numAliens; i++) {
        aliens[i] = new AlienSpaceship(random(width), random(height/2));
      }
    } else {
      // For round 4, add the boss alien
      aliens = new AlienSpaceship[1]; // Only one alien (the boss)
      aliens[0] = new BossAlien(width / 2, height / 2); // Instantiate the boss alien
    }
  }
}




void draw() {
  if (gameState == 0) {
    // Start screen
    displayStartScreen();  
    if (!displayRules) {
      displayStartScreen();
    } else {
      displayRulesScreen();
    }
  } else if (gameState == 1 && !gameEnded) {
    // Gameplay
    image(img, 0, 0); // Display the image at coordinates (0, 0)
    
    // Display and move player spaceship
    player.display();
    player.move();
    
    if (currentRound < 4) {
      // Display and move regular alien spaceships
      for (AlienSpaceship alien : aliens) {
        alien.display();
        alien.move();
      }
    } else if (currentRound == 4) {
      // Boss battle
      if (aliens.length > 0 && aliens[0] instanceof BossAlien) {
        BossAlien boss = (BossAlien) aliens[0];
        boss.display();
        boss.displayHealthBar();
         
        
        // Check for collisions with boss
        for (Bullet bullet : bullets) {
          if (bullet.hitsBoss(boss)) {
            bullet.reset();
            boss.takeDamage(10); // Assuming each bullet deals 10 damage to the boss
            break;
          }
        }
      }
    }
    
    // Display and move bullets
    for (Bullet bullet : bullets) {
      bullet.display();
      bullet.move();
      
      // Check for collisions with regular aliens
      if (currentRound < 4) {
        for (AlienSpaceship alien : aliens) {
          if (bullet.hits(alien)) {
            bullet.reset();
            alien.reset();
            aliensDestroyed++;
            break;
          }
        }
      }
    }
    
    // Check if round is over
    if (millis() - roundStartTime >= roundDuration) {
      // Start next round or end game if all rounds are completed
      if (currentRound < 4) {
        startNextRound();
      } else {
        endGame();
      }
    }
    displayRoundAndTimer();
  }
}

void keyPressed() {
  if (gameState == 0) {
    if (key == 'q' || key == 'Q') { // Change from 'Q' to 'T'
      // Start the game when T is pressed
      gameState = 1;
      roundStartTime = millis(); // Start round timer
    } else if (gameState == 0 && (key == 'r' || key == 'R')) {
      // Toggle Display rules when R is pressed
      displayRules = !displayRules;
    }
  } else{
    // Handle other key presses based on game state
    handleKeyPress();
  }
}


void keyReleased() {
  if (key == 'a' || key == 'A' || key == 'd' || key == 'D') {
    player.stopMoving();
  }
}

void mousePressed() {
  // Check for right mouse click
  if (mouseButton == LEFT) {
    // Shoot bullets with right mouse click
    for (Bullet bullet : bullets) {
      if (!bullet.active) {
        bullet.shoot(player.x + 25, player.y);
        break;
      }
    }
  }
  
}

void displayRoundAndTimer() {
  // Calculate remaining time
  int remainingTime = roundDuration - (int)(millis() - roundStartTime);
  // Ensure remaining time does not go below 0
  if (remainingTime < 0) {
    remainingTime = 0;
  }
  // Convert remaining time to seconds
  int seconds = remainingTime / 1000;
  
  // Display round number and timer
  textAlign(LEFT);
  textSize(20);
  fill(255);
  text("Round: " + currentRound, 20, 20); // Display current round number
  text("Time: " + seconds + " seconds", 20, 40); // Display remaining time
}

void startNextRound() {
  // Increment current round
  currentRound++;
  // Reset round start time
  roundStartTime = millis();
  // Initialize aliens for the next round
  initializeAliens();
}

void endGame() {
  // Display end game screen with the score
  backgroundImg.filter(GRAY);
  background(backgroundImg);
  textAlign(CENTER, CENTER);
  textSize(32);
  fill(255);
  gameEnded = true;
  text("Game Over!", width/2, height/2 - 50);
  text("Aliens Destroyed: " + aliensDestroyed, width/2, height/2);
  text("Aliens Escaped: " + aliensEscaped, width/2, height/2 + 50);
}



void displayRulesScreen() {
  // Display start screen elements
  // Load the background image
  backgroundImg.resize(width, height);
  // Apply filter to the background image
  backgroundImg.filter(GRAY);
  // Display the filtered background image
  image(backgroundImg, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(25);
  fill(255);
  text("Rules of the Game", width/2, height/2 - 100);
  // Add more rules text as needed
  textSize(16);
  text("1. Destroy as many alien spaceships as possible.", width/2, height/2 - 50);
  text("2. Press A or D to move the ship.", width/2, height/2);
  text("3. click your mouse to shoot bullets.", width/2, height/2 + 50);
  text("4. Complete each round within the time limit.", width/2, height/2 + 100);
  text("5. Defeat the boss.", width/2, height/2 + 150);
  // Add more rules as needed
  textSize(30);
  text("Press R to return to the menu", width/2, height/2 + 200);
}


void displayStartScreen() {
  // Display start screen elements
  // Load the background image
  backgroundImg = loadImage("aRTU1s.png");
  backgroundImg.resize(width, height);
  // Apply filter to the background image
  backgroundImg.filter(GRAY);
  
  // Display the filtered background image
  image(backgroundImg, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(32);
  fill(255);
  text("Press Q to start", width/2, height/2);
   text("Press R for rules", width/2, height/2 + 50);
}

void handleKeyPress() {
  // Handle key presses during gameplay
  // For example, movement controls, shooting, etc.
  if (key == 'a' || key == 'A') {
    player.moveLeft();
  } else if (key == 'd' || key == 'D') {
    player.moveRight();
  }
}



interface Shootable {
  void shoot(float x, float y);
  void reset();
  boolean hits(AlienSpaceship alien);
}
