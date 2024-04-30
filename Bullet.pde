class Bullet extends GameObject implements Shootable {
  float speed = 7;
  boolean active = false;
  
  Bullet() {
    super(0, 0);
  }
  
  void display() {
    if (active) {
      // Display the bullet
      fill(255);
      ellipse(x, y, 5, 10);
    }
  }
  
  void move() {
    if (active) {
      // Move the bullet
      y -= speed;
      
      // Deactivate if it goes off the screen
      if (y < 0) {
        reset();
      }
    }
  }
  
  void shoot(float x, float y) {
    // Shoot the bullet from the player's spaceship
    this.x = x;
    this.y = y;
    active = true;
  }
  
  void reset() {
    // Deactivate the bullet
    active = false;
  }
  
boolean hits(AlienSpaceship alien) {
  // Check for collision with an alien spaceship using bounding boxes
  return active &&
         x < alien.x + 60 &&
         x + 5 > alien.x &&
         y < alien.y + 40 &&
         y + 10 > alien.y;
}

  boolean hitsBoss(BossAlien boss) {
    // Calculate the position of the boss alien's hitbox based on its location
    float bossX = width / 2;
    float bossY = 50 + 20;
    
    // Check if the bullet's position overlaps with the boss alien's hitbox
    return active &&
           x > bossX - boss.hitboxWidth/2 &&
           x < bossX + boss.hitboxWidth/2 &&
           y > bossY - boss.hitboxHeight/2 &&
           y < bossY + boss.hitboxHeight/2;
  }
}
