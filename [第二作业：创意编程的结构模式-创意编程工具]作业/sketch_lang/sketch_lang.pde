
void setup() {
  size(800, 800);
  background(30);
}

void draw() {
background(30);
  float xx=random(-1000, 1000);
  float yy=random(-1000, 1000);
  fill(random(400), 200, 300, random(100, 120));
  bezier(xx, yy, xx, yy+180, xx-120, yy+150, xx, yy);

  fill(30, 30, 30, 20);
  arc(mouseX, mouseY, 200, 200, 0, radians(360));
  fill(#FFFFB4, 50);
  arc(mouseX, mouseY, 100, 100, 0, radians(270));
  noStroke();

  if (mousePressed) {
    fill(#FCFFF0);
    arc(mouseX, mouseY-20, 120, 120, radians(180), radians(360));
  }
}
