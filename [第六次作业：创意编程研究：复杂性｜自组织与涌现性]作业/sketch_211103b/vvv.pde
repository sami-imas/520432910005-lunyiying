class Confetti extends Particle{
  float R = random(255);
  float G = random(255);
  float B = random(255);
  Confetti(PVector l){
    super(l);
  }
  void display(){
    stroke(255, 255, 255, lifespan);
    fill(255,255,255,lifespan);
    //ellipse(location.x, location.y, 8, 8);
    
    rect(location.x, location.y, 4, 4);
  }
}
