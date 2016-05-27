
PImage img1;
PImage img2;
int radius = 15;
float x = -radius;
float y = 60;
float speed = 1.5;
float pX;
float pY;
void setup() 
{
  size(500, 500);
  img1 = loadImage("ball.png");
  img2 = loadImage("mute.png");
  ellipseMode(RADIUS);
}
 
void draw() 
{
  image(img2, 150 ,150);
  
  x += speed;
  y += speed;
  pX = x;
  pY = y;
  image(img1, pX, pY);

}