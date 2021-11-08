color col;
int i;
boolean []flag=new boolean[3];

void setup() {
  size(600, 800);
  background(#6282FF);
}

void draw() {

  fill(255, 255, 255);
  rect(50, 50, 50, 50);
  fill(#FFBCD9);
  rect(150, 50, 50, 50);
  fill(#FFFB81);
  rect(250, 50, 50, 50);

  if (mousePressed==true) {
    if (flag[0]) {

      stroke(col);
      strokeWeight(1);
      noFill();
      rect(mouseX, mouseY, 20, random(40, 800));
    } else if (flag[1]) {

      noStroke();
      fill(col, random(150, 300));
      circle(mouseX+random(-80, 30), mouseY+random(-5, 5), random(0, 50));
    } else if (flag[2]) {
      noStroke();
      fill(col);
      circle(mouseX, mouseY, 10);
    }
  }
}
void mousePressed() {
  if (mouseX>50&&mouseX<100&&mouseY>50&&mouseY<100) {
    col=255;
    for (i=0; i<3; i++) {
      flag[i]=false;
    }
    flag[0]=true;
  } else if (mouseX>150&&mouseX<200&&mouseY>50&&mouseY<100) {
    col=#FFBCD9;
    for (i=0; i<3; i++) {
      flag[i]=false;
    }
    flag[1]=true;
  } else if (mouseX>250&&mouseX<300&&mouseY>50&&mouseY<100) {
    col=#FFFB81;
    for (i=0; i<3; i++) {
      flag[i]=false;
    }
    flag[2]=true;
  }
}
