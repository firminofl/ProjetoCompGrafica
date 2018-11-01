PVector v = new PVector();
PImage pic = createImage(500,500,RGB);

float g = 9.8;
float step = 0.01;
float diameter = 20;

float vx0 = 50;
float vy0 = 2;

float x0 = 0;
float y0 = 0;

float t = 0;

void setup(){
  size(500,720);
  pic.set(250,250,color(255,0,0)); //8bits
}

//loop
void draw(){
  //background(50);
  image(pic,0,0);
  float x = x0 + vx0 * t;
  float y = y0 + vy0 * t * 0.5 * g * t * t;
  System.out.print("\nValores de y:" + y);
  ellipse(x, y, diameter, diameter);
  delay(20);

  t += step;
}
