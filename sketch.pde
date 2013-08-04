int totalBalls = 16;
Ball[] balls = new Ball[totalBalls];
float targetX, targetY;
int width, height;
  
void setup() {
    width = 500;
    height = 550;
    size(width, height);
    noStroke();
    smooth();
    background(0);
    targetX = width / 2;
    targetY = height / 2;
    fill(color(255, 0, 0));
    for (int i = 0; i < totalBalls; i++) {
        Ball ball = new Ball();
        ball.x = random(width);
        ball.y = random(height);
        ball.vx = random(10) - 5;
        ball.vy = random(10) - 5;
        ball.radius = width * .05;
        balls[i] = ball;
    }
};
  
void draw() {
    background(0);
    fill(color(255, 0, 0));
    for (int i = 0; i < totalBalls; i++) {
        balls[i].x += balls[i].vx;
        balls[i].y += balls[i].vy;
        checkWallCollision(balls[i]);
        balls[i].render();
    }
    for (int i = 0; i < totalBalls; i++) {
        for (int j = i + 1; j < totalBalls; j++) {
            float dx = balls[j].x - balls[i].x;
            float dy = balls[j].y - balls[i].y;
            float dist = sqrt(dx * dx + dy * dy);
            if (dist < (balls[j].radius + balls[i].radius)) {
                // balls have contact so push back...
                float normalX = dx / dist;
                float normalY = dy / dist;
                float midpointX = (balls[i].x + balls[j].x) / 2;
                float midpointY = (balls[i].y + balls[j].y) / 2;
                balls[i].x = midpointX - normalX * balls[i].radius;
                balls[i].y = midpointY - normalY * balls[i].radius;
                balls[j].x = midpointX + normalX * balls[j].radius;
                balls[j].y = midpointY + normalY * balls[j].radius;
                float dVector = (balls[i].vx - balls[j].vx) * normalX;
                dVector += (balls[i].vy - balls[j].vy) * normalY;
                float dvx = dVector * normalX;
                float dvy = dVector * normalY;
                balls[i].vx -= dvx;
                balls[i].vy -= dvy;
                balls[j].vx += dvx;
                balls[j].vy += dvy;
            }
        }
    }
};
  
void checkWallCollision(Ball ball) {
    if (ball.x < ball.radius) {
        ball.x = ball.radius;
        ball.vx *= -1;
    }     if (ball.x > width - (ball.radius)) {
        ball.x = width - (ball.radius);
        ball.vx *= -1;
    }     if (ball.y < ball.radius) {
        ball.y = ball.radius;
        ball.vy *= -1;
    }     if (ball.y > height - (ball.radius)) {
        ball.y = height - (ball.radius);
        ball.vy *= -1;
    }
}
  
class Ball {
  float x = 0;
  float y = 0;
  float vx = 0;
  float vy = 0;
  float gravityX = 0;
  float gravityY = 0;
  float radius = 5.0;
  
  void render() {
      ellipse(this.x, this.y, this.radius * 2, this.radius * 2);
  }
}