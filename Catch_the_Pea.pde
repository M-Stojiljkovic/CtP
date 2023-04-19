// Simple game in Processing3 with speed up overtime

// Define the size of the window
int width = 800;
int height = 600;

// Define the player variables
int playerSize = 50;
float playerX = width/2;
float playerY = height - playerSize/2;
float playerSpeed = 6;

// Define the obstacle variables
int obstacleSize = 50;
float obstacleX = 0;
float obstacleY = 0;
float obstacleSpeed = 4;

// Define the point variables
int pointSize = 20;
float pointX = 200;
float pointY = 0;
float pointSpeed = 3;

// Define the score variables
int score = 0;
int highScore = 0;

// Define the level variables
int level = 1;
float levelSpeedMultiplier = 1.1;

void setup() {
  size(800, 600);
  smooth();
  frameRate(60);
  textAlign(CENTER, CENTER);
  textSize(20);
}

void draw() {
  // Set the background color
  background(0);
  
  // Move the player
  if (keyPressed && key == 'a' && playerX > playerSize/2) {
    playerX -= playerSpeed;
  } else if (keyPressed && key == 'd' && playerX < width - playerSize/2) {
    playerX += playerSpeed;
  }
  
  // Draw the player
  fill(0, 0, 255);
  rect(playerX - playerSize/2, playerY - playerSize/2, playerSize, playerSize);
  
  // Move the obstacle
  obstacleY += obstacleSpeed * levelSpeedMultiplier;
  if (obstacleY > height + obstacleSize/2) {
    obstacleX = random(obstacleSize/2, width - obstacleSize/2);
    obstacleY = -obstacleSize/2;
  }
  
  // Draw the obstacle
  fill(255, 0, 0);
  rect(obstacleX - obstacleSize/2, obstacleY - obstacleSize/2, obstacleSize, obstacleSize);
  
  // Move the point
  pointY += pointSpeed * levelSpeedMultiplier;
  if (pointY > height + pointSize/2) {
    pointX = random(pointSize/2, width - pointSize/2);
    pointY = -pointSize/2;
  }
  
  // Draw the point
  fill(0, 255, 0);
  ellipse(pointX, pointY, pointSize, pointSize);
  
  // Check for collision with obstacle
  if (dist(playerX, playerY, obstacleX, obstacleY) < (playerSize + obstacleSize)/2) {
    if (score > highScore) {
      highScore = score;
    }
    score = 0;
    level = 1;
    obstacleX = random(obstacleSize/2, width - obstacleSize/2);
    obstacleY = -obstacleSize/2;
    pointX = random(pointSize/2, width - pointSize/2);
    pointY = -pointSize/2;
    levelSpeedMultiplier = 1.1;
  }
  
  // Check for collision with point
  if (dist(playerX, playerY, pointX, pointY) < (playerSize + pointSize)/2) {
    score++;
    pointX = random(pointSize/2, width - pointSize/2);
    pointY = -pointSize/2;
    levelSpeedMultiplier *= 1.05;
    level = int(sqrt(score))+1;
  }

  
  // Display the score and high score
  fill(255);
  text("Score: " + score + "  High Score: " + highScore, width/2, 50);
}
