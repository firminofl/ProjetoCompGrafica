PVector v = new PVector();

//Imagem
PImage pic = createImage(500, 500, RGB);

float g = 9.8;
float step = 0.1;
float t = 0;
float diameter = 20;

float x0 = 0;
float y0 = 0;

float vx0 = 50;
float vy0 = 2;

float y = 0;

void setup() {
  size(800, 600);

  pic.set(250, 250, color(255, 0, 0));
}

// Loop
void draw() {
  image(pic, 0, 0);
  //background(51);

  float x = x0 + vx0 * t;
  float y = y0 + vy0 + 0.5 * g * t * t;

  ellipse(x, y, diameter, diameter);
  delay(20);

  t += step;
}
