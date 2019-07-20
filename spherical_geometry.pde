import peasy.*;

PeasyCam cam;
PVector[][] globe;
int total = 200;

// START SUPERSHAPE VARIABLES
float m = 1;
float m2 = 1;
float n1 = 2;
float n12 = 2;
float n2 = 2;
float n22 = 2;
float n3 = 2;
float n32 = 2;
float a = 1;
float b = 1;
// END SUPERSHAPE VARIABLES

// START INPUT VARIABLES
boolean shiftPressed = false;
char mUp = 'q';
char mDown = 'a';
char n1Up = 'w';
char n1Down = 's';
char n2Up = 'e';
char n2Down = 'd';
char n3Up = 'r';
char n3Down = 'f';
char aUp = 't';
char aDown = 'g';
char bUp = 'y';
char bDown = 'h';
// END INPUT VARIABLES

void keyPressed()
{
  if (key == keyCode) if (keyCode == TAB) shiftPressed = !shiftPressed;
  
  if (shiftPressed != true && key == mUp) m += 0.1;
  if (shiftPressed != true && key == mDown) m -= 0.1;
  if (shiftPressed == true && key == mUp) m2 += 0.1;
  if (shiftPressed == true && key == mUp) m2 -= 0.1;
  if (shiftPressed != true && key == n1Up) n1 += 0.1;
  if (shiftPressed != true && key == n1Down) n1 -= 0.1;
  if (shiftPressed == true && key == n1Up) n12 += 0.1;
  if (shiftPressed == true && key == n1Down) n12 -= 0.1;
  if (shiftPressed != true && key == n2Up) n2 += 0.1;
  if (shiftPressed != true && key == n2Down) n2 -= 0.1;
  if (shiftPressed == true && key == n2Up) n22 += 0.1;
  if (shiftPressed == true && key == n2Down) n22 -= 0.1;
  if (shiftPressed != true && key == n3Up) n3 += 0.1;
  if (shiftPressed != true && key == n3Down) n3 -= 0.1;
  if (shiftPressed == true && key == n3Up) n32 += 0.1;
  if (shiftPressed == true && key == n3Down) n32 -= 0.1;
  if (shiftPressed != true && key == aUp) a += 0.1;
  if (shiftPressed != true && key == aDown) a -= 0.1;
  if (key == bUp) b += 0.1;
  if (key == bDown) b -= 0.1;
  
}


void setup()
{
  size(1000, 1000, P3D);
  
  cam = new PeasyCam(this, 500);
  
  globe = new PVector[total + 1][total + 1];
}

float supershape(float theta, float _m, float _n1, float _n2, float _n3)
{
  float t1 = abs((1 / a) * cos(_m * theta / 4));
  t1 = pow(t1, _n2);
  
  float t2 = abs((1 / b) * sin(_m * theta / 4));
  t2 = pow(t2, _n3);
  
  float t3 = t1 + t2;
  float r = pow(t3, -1 / _n1);
  
  return r;
}

void draw()
{
  background(0);

  noStroke();
  lights();
  

  
  float radius = 50;
  
  for(int i = 0; i < total + 1; i++)
  {
    float lat = map(i, 0, total, -HALF_PI, HALF_PI);
    float r2 = supershape(lat, m, n1, n2, n3);
    for(int j = 0; j < total + 1; j++)
    {
      float lon = map(j, 0, total, -PI, PI);
      
      float r1 = supershape(lon, m2, n12, n22, n32);
      
      float x = radius * r1 * cos(lon) * r2 * cos(lat);
      float y = radius * r1 * sin(lon) * r2 * cos(lat);
      float z = radius * r2 * sin(lat);
      
      globe[i][j] = new PVector(x, y, z);
    }
  }
  
  for(int i = 0; i < total; i++)
  {
    if (i <= total / 2)
    {
      if (i % 2 == 0) fill(128, 0, 255);
      else fill(255, 0, 128);
    } 
    else
    {
      if (i % 2 == 1) fill(128, 0, 255);
      else fill(255, 0, 128);
    }
    
    noStroke();
    beginShape(TRIANGLE_STRIP);
    for(int j = 0; j < total + 1; j++)
    {
      PVector v1 = globe[i][j];
      PVector v2 = globe[i + 1][j];
      vertex(v1.x, v1.y, v1.z);
      vertex(v2.x, v2.y, v2.z);
    }
    endShape();
    
    stroke(0, 255, 255);
    fill(0, 255, 255);
    textSize(20);
    cam.beginHUD();
    text("m: " + m, 100, 50);
    text("n1: " + n1, 200, 50);
    text("n2: " + n2, 300, 50);
    text("n3: " + n3, 400, 50);
    text("m2: " + m2, 100, 100);
    text("n12: " + n12, 200, 100);
    text("n22: " + n22, 300, 100);
    text("n32: " + n32, 400, 100);
    text("a: " + a, 100, 150);
    text("b: " + b, 200, 150);
    if (shiftPressed) text("mode 2", 100, 200);
    cam.endHUD();
  }
}
