class Particle{
  PVector location;              
  PVector velocity;             
  PVector acceleration;          
  float mass;                    
  float lifespan;                


  Particle(){
    location = new PVector(random(width), random(height));
    velocity = new PVector(random(-2,2), random(-1, 0));
    acceleration = new PVector(1, 1);
    mass = 1;
    lifespan = 255;
  }
  Particle(PVector l){
    location = l.get();
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-2, 2),random(-1, 0));
    mass = 1;
    lifespan = 255;
  }
  void applyForce(PVector force){
    acceleration.add(PVector.div(force, mass));
  }
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    lifespan -= 1.0;
  }
  void display(){
    stroke(255,255,255,lifespan);
    fill(255,255,255,lifespan);
    ellipse(location.x, location.y, 30, 30);
  }
  boolean isDead(){
    if(lifespan < 0.0){
      return true;
    }else{
      return false;
    }
  }
  void run(){
    update();
    display();
  }
}
