import java.util.*;
ArrayList<ParticleSystem> systems;
PVector gravity;
Repeller repeller;
void mousePressed(){
  systems.add(new ParticleSystem(new PVector(mouseX, mouseY)));
  //gravity = new PVector(0, 0.1);
}
void setup(){
  size(1200, 500);
  systems = new ArrayList<ParticleSystem>();
  repeller = new Repeller(width/2-20, height/2);
}
void draw(){
 background(0);
 Iterator<ParticleSystem> it = systems.iterator();
 while(it.hasNext()){
   ParticleSystem p = it.next();
   gravity = new PVector(random(-0.1, 0.1), random(-0.1, 0.2));
   p.applyRepeller(repeller);
   p.applyForce(gravity);
   p.run();
   p.addParticle();
   if(p.isDead()){
     it.remove();
   }
 }
 repeller.display();
}
