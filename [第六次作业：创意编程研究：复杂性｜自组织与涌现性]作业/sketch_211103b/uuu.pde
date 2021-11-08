class ParticleSystem{
  ArrayList<Particle> particles;           
  PVector origin;                                 
  float aliveTime;
  ParticleSystem(PVector location_){
    origin = location_.get();
    particles = new ArrayList<Particle>();
    aliveTime = 255;
  }
  void update(){
    origin = new PVector(mouseX, mouseY);
  }
  void addParticle(){                            
    float Rate = random(1);
    if(Rate < 0.5)
      particles.add(new Particle(origin));
    else
      particles.add(new Confetti(origin));
  }
  void run(){
    Iterator<Particle> it = particles.iterator();
    while(it.hasNext()){
      Particle p = it.next();
      p.run();
      if(p.isDead()){
        it.remove();
      }
    }
    aliveTime -= 1;
  }
  boolean isDead(){
    if(aliveTime <= 0){
      return true;
    }else{
      return false;
    }
  }
  void applyForce(PVector force){           
    for(Particle p: particles){
      p.applyForce(force);
    } 
  }
  void applyRepeller(Repeller re){         
    for(Particle p: particles){
      PVector force = re.repel(p);
      p.applyForce(force);
    }
  }
}
