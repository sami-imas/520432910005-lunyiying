float a;
float b;
float c;

void setup() {
  size(600, 600);
  background(30);
  frameRate(9);
}

void mdla() {
  a=(int)random(0, 2);
  b=(int)random(0, 200);
  c=(int)random(370, 500);
  fill(random(0));
  rect(0, 0, 200, 230);
  if (a==0) {
    fill(random(70, 200));
    rect(0, 0, random(0, 230), random(0, 200));
  } else if (a==1) {
    fill(random(70, 200));
    rect(b, 0, 200-b, random(0, 200));
  }
  fill(255);
  noStroke();
  rect(300, 50, 300, 40);
  rect(0, 230, 800, 40);
  rect(0, 450, 300, 40);
  rect(300, 0, 40, 800);
  rect(200, 0, 40, 450);
  rect(500, 0, 40, 230);
  rect(c, 230, 40, 370);
  fill(random(75, 125));
  rect(random(0, 100), 230, 40, 40);
  fill(random(100, 200));
  rect(200, 230, 40, 40);
  fill(random(125, 200));
  rect(300, 230, 40, 40);
  fill(random(70, 125));
  rect(random(350, 450), 50, 40, 40);
  fill(random(70, 200));
  rect(500, 50, 40, 40);
  fill(random(100, 255));
  rect(random(0, 120), 450, 40, 40);
  fill(random(70, 255));
  rect(300, random(-40, 10), 40, 40);
  fill(random(70, 200));
  rect(300, 50, 40, 40);
  fill(random(125, 255));
  rect(300, random(270, 400), 40, 40);
  fill(random(70, 125));
  rect(300, 450, 40, 40);
  fill(random(100, 255));
  rect(c, random(250, 600), 40, 40);
  fill(random(125, 255));
  rect(500, random(100, 150), 40, 40);
  fill(random(125, 200));
  rect(c, 230, 40, 40);
  fill(random(70, 125));
  rect(200, random(0, 150), 40, 40);
  fill(random(70, 255));
  rect(200, random(300, 400), 40, 40);
  fill(random(70, 200));
  rect(200, 450, 40, 40);
  fill(random(0));
  rect(340, 270, 260, 330);
  fill(255);
  noStroke();
  rect(c, 230, 40, 370);
  fill(random(100, 255));
  rect(340, random(270, 600), c-340, random(20, 250));
  fill(random(100, 255));
  rect(340, random(270, 600), c-340, random(20, 250));
  fill(random(125, 200));
  rect(c, 230, 40, 40);
  rect(c, random(250, 600), 40, 40);
  fill(random(125, 255));
}

void draw() {
  if (mousePressed) {
    mdla();
  }
}
