abstract class GameObject {
  float x, y;
  
  GameObject(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  abstract void display();
  abstract void move();
}
