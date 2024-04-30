class AlienSpaceship extends Spaceship {
  float speed = 2;

  
  AlienSpaceship(float x, float y) {
    super(x, y);
   
  }
  
  void display() {
    // Provide a specific display for an alien spaceship
   
  image(alienImg, x, y, 60, 40); // Adjust the size as needed

  }
  
  void move() {
    // Move the alien spaceship
    y += speed;
    
    // Reset if it goes off the screen
    if (y > height) { 
      aliensEscaped++;
      reset();

    }
  }
  
  void reset() {
    // Reset the alien spaceship's position
    y = 0;
    x = random(width);
  }
}
