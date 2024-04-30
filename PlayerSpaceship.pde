class PlayerSpaceship extends Spaceship {
  PImage spaceship; // Image for the player's spaceship
  int spaceshipWidth, spaceshipHeight; // Width and height of the spaceship image
  float scaleFactor = 0.25; // Scale factor for resizing the spaceship image

  PlayerSpaceship(float x, float y) {
    super(x, y);
    spaceship = loadImage("spaceship.png"); // Load the image for the player's spaceship
    spaceship.resize(width, height);
      
    spaceshipWidth = int(spaceship.width * scaleFactor); // Calculate the new width of the spaceship image
    spaceshipHeight = int(spaceship.height * scaleFactor); // Calculate the new height of the spaceship image
  }

  void display() {
    // Draw the resized spaceship image with its center at the player's position
    image(spaceship, x - spaceshipWidth / 2, y - spaceshipHeight / 2, spaceshipWidth, spaceshipHeight);
  }
}
