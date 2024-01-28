
PVector mouse;
ArrayList<Coral> movers = new ArrayList<Coral>();
ArrayList<Coral> dead = new ArrayList<Coral>();

int maxCorals = 1000; 
int iterations = 1000;
boolean limit = false;

void setup() {
  size(800, 800);
  dead.add(new Coral(width*2/3, height*2/3)); 

  for (int i = 0; i < maxCorals; i++) {
    movers.add(new Coral());
    mouse=new PVector(0, 0);
  }
}


void draw() {
  background(0);
  mouse.set(mouseX, mouseY);
  for (Coral m : movers) {
    m.show();
  }
  for (Coral s : dead) {
    s.show();
  
    if (s.pos.x >= height || s.pos.y <= 0 || s.pos.x >= width || s.pos.x <= 0) {
      limit = true;
    }
  }

  for (int n = 0; n < iterations; n++) {
    for (int i = movers.size() - 1; i > 0; i--) {
      Coral m = movers.get(i);
      m.walk();

      for (Coral s : dead) {
        if (s.checkStuck(m)) {
          m.stuck = true;
          dead.add(m);
          movers.remove(i);
          break;
        }
      }
    }
  }

  while (movers.size() < maxCorals && limit == false) {
    movers.add(new Coral());
  }
}


class Coral {
  PVector pos;
  PVector vel;
  boolean stuck;
  float radius;


  Coral() {
    pos = randomCoral(); 
    stuck = false; 
    radius = random(4, 8); 
  }


  Coral(int x, int y) {
    pos = new PVector(x, y);
    stuck = true;
    radius = random(4, 8);
  }


  PVector randomCoral() {
    float i = random(4);  
    PVector p = new PVector();
    float x = mouseX;
    float y = mouseY;
    if (i <= 1) { 
      p = new PVector(x, 0);
    } else if (i <= 2) {  
      p = new PVector(x, height);
    } else if (i <= 3) {
      p = new PVector(0, y);
    } else if (i <= 4) {
      p = new PVector(width, y);
    }
    return p;
  }

  void walk() {
    vel = PVector.random2D(); 
    pos.add(vel);
    pos.x = constrain(pos.x, 0, mouseX);
    pos.y = constrain(pos.y, 0, mouseY);
  }

  void show() {
    noStroke();
    if (stuck) {
      fill(#4DE3F0);
    } else {
      fill(#FFFFFF);
    }
    ellipse(pos.x, pos.y, random(4, 8) * 2, random(4, 8) * 2);
  }

  boolean checkStuck(Coral dr) {
    float d = dist(pos.x, pos.y, dr.pos.x, dr.pos.y);
    if (d < sqrt(radius * dr.radius * 2 * 2)) {
      if (random(1) < 0.1) {
        return true;
      }
    }
    return false;
  }
}
