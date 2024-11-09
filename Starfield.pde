int numParticles = 50; 
Particle[] particles = new Particle[numParticles];  
boolean exploded = false;
float bombX, bombY;

void setup() {
  size(600, 600);
  bombX = width / 2;
  bombY = height / 2;
  
  for (int i = 0; i < numParticles; i++) {
    if (i == 0) {
      particles[i] = new OddballParticle(); 
    } else {
      particles[i] = new Particle(); 
    }
  }
}

void draw() {
  background(0);  

  if (!exploded) {
    drawBomb(bombX, bombY); 
     fill(255);  
    textSize(24);
    textAlign(CENTER, CENTER);
    text("Click the Bomb", width / 2, height / 2 + 60);
  } else {
  
    for (Particle p : particles) {
      p.move();
      p.show();
    }
  }
}

void drawBomb(float x, float y) {
  fill(50); 
  noStroke();
  ellipse(x, y, 50, 50);

  stroke(255, 100, 0); 
  strokeWeight(4);
  line(x, y - 25, x, y - 40);
  
  noStroke();
  fill(255, 100, 0);
  ellipse(x, y - 45, 8, 8);
}

void mousePressed() {
  if (!exploded && dist(mouseX, mouseY, bombX, bombY) < 25) {
   
    for (Particle p : particles) {
      p.reset(bombX, bombY);
    }
    exploded = true;  
  }
}

class Particle {
  float x, y;
  float xSpeed, ySpeed;
  color col;


  Particle() {
    reset(width / 2, height / 2);  
  }


  void move() {
    x += xSpeed;
    y += ySpeed;


    if (x > width) x = 0;
    if (x < 0) x = width;
    if (y > height) y = 0;
    if (y < 0) y = height;
  }

  // Show method
  void show() {
    fill(col);
    noStroke();
    ellipse(x, y, 10, 10);  
  }


  void reset(float startX, float startY) {
    x = startX;
    y = startY;
    xSpeed = random(-5, 5); 
    ySpeed = random(-5, 5); 
    col = color(random(100, 255), random(100, 255), random(100, 255)); 
  }
}


class OddballParticle extends Particle {

  OddballParticle() {
    super();
    col = color(255, 0, 0);  // Make OddballParticle red
  }

  
  void move() {
    x += xSpeed * random(0.5, 1.5);  // Slight random variation in movement
    y += ySpeed * random(0.5, 1.5);

    // Wrap around edges
    if (x > width) x = 0;
    if (x < 0) x = width;
    if (y > height) y = 0;
    if (y < 0) y = height;
  }

  // Override show to change appearance
  void show() {
    fill(col);
    stroke(255);
    ellipse(x, y, 15, 15);  // Larger size for Oddball
  }


  void reset(float startX, float startY) {
    super.reset(startX, startY);
    col = color(255, 0, 0);  // Set color to red for Oddball
    xSpeed *= random(1.5, 2.0);  // Give Oddball a bit more speed
    ySpeed *= random(1.5, 2.0);
  }
}
