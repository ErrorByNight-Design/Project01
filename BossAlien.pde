class BossAlien extends AlienSpaceship {
  int health; // Health of the boss alien
  int hitboxWidth = 120; // Adjust hitbox width based on boss alien image dimensions
  int hitboxHeight = 100; // Adjust hitbox height based on boss alien image dimensions

  BossAlien(int x, int y) {
    super(x, y);
    health = 100; // Initial health of the boss alien
  }
  
  void takeDamage(int damage) {
    health -= damage; // Reduce boss health by the amount of damage taken
    if (health <= 0) {
      aliensDestroyed++;
      endGame(); // End the game if boss's health reaches 0
    }
  }
  
  void displayHealthBar() {
    // Display the boss health bar
    float barWidth = 200;
    float barHeight = 20;
    float healthRatio = (float) health / 100;
    fill(255, 0, 0); // Red color for health bar
    rectMode(CORNER);
    rect(width/2 - barWidth/2, 50, barWidth, barHeight); // Outline of health bar
    fill(0, 255, 0); // Green color for filled portion indicating health
    rect(width/2 - barWidth/2, 50, barWidth * healthRatio, barHeight); // Actual health remaining
  }
  
  void display() {
    // Display the boss alien with its image
    float bossWidth = 120; // Adjust based on the boss alien image dimensions
    float bossHeight = 100; // Adjust based on the boss alien image dimensions
    
    image(alienImg, width / 2 - bossWidth / 2, 50 + 20, bossWidth, bossHeight);

  }
  
  void shootAtPlayer() {
    // Logic to make the boss shoot at the player
    
  }
 /*boolean hits(Bullet bullet) {
    // Calculate the position of the boss alien's hitbox based on its new location
    float bossX = width / 2;
    float bossY = 50 + 20;
    
    // Check if the bullet's position overlaps with the boss alien's hitbox
    return bullet.x > bossX - hitboxWidth/2 && bullet.x < bossX + hitboxWidth/2 &&
           bullet.y > bossY - hitboxHeight/2 && bullet.y < bossY + hitboxHeight/2;
}*/


}
