class Spaceship extends GameObject {
  float speed = 5;
  boolean movingLeft, movingRight;
  
  Spaceship(float x, float y) {
    super(x, y);
  }
  
  void display() {
    // Provide an implementation for the display method
    // This can be a generic display for any spaceship
  }
  
  void move() {
    // Move the spaceship based on keyboard input
    if (movingLeft && x > 0) {
      x -= speed;
    }
    if (movingRight && x < width - 50) {
      x += speed;
    }
  }
  
  void moveLeft() {
    movingLeft = true;
  }
  
  void moveRight() {
    movingRight = true;
  }
  
  void stopMoving() {
    movingLeft = false;
    movingRight = false;
  }
}
