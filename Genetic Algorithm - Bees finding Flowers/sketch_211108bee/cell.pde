public class Cell{
    
    private float genes[] = new float[maxSteps];
    private PVector pos,
                    facing, 
                    repRange = new PVector(0, 0);
    private int moves; 
    private float fit; 
    private boolean crash, 
                    finish, 
                    death, 
                    champ = false, 
                    crashWall = false;

    public Cell(){
      pos = new PVector(inicio.x, inicio.y);
      fit = 0;
      moves = 0;
      facing = new PVector(0, 2);
      crash = false;
      finish = false;
      death = false;
      startUp();
    }
    
    public Cell(Cell p1, Cell p2){
      pos = new PVector(inicio.x, inicio.y);
      fit = 0;
      moves = 0;
      facing = new PVector(0, 1);
      crash = false;
      finish = false;
      death = false;
      child(p1, p2);
    }
    
    public void startUp(){
      genes[0] = random(-PI, PI);
      for(int i = 1; i < genes.length; i++){
        genes[i] = random(-HALF_PI/4, HALF_PI/4);
      }
    }
    
    public void champ(){
      pos = new PVector(inicio.x, inicio.y);
      fit = 0;
      moves = 0;
      facing = new PVector(0, 1);
      crash = false;
      finish = false;
      death = false;
      champ = true;
    }

    public void disp(){
      noStroke();
      if(champ){
        fill(255, 100, 100);
      } else{
        fill(255);
      }
      ellipse(pos.x, pos.y, 15, 15);
    }
    public void move(){
      if(!crash && !finish && !death){
        pos.add(facing.rotate(genes[moves]).setMag(1));
        moves++; 
      }
    }

    public void collision(){
      if((pos.x > width || pos.x < 0) || (pos.y > height || pos.y < 0)){
        crash = true;
      } else if (obs.collision(pos)) {
        crash = true;
        crashWall = true;
      }
    }
    public void finish(){
      if(dist(pos.x, pos.y, goal.x, goal.y) <= goalRadius){
        finish = true;
      }
    }

    public void death(){
      if((moves >= maxSteps || crash || finish) && !death){
        death = true;
        fitCalc();
        repRange.x = ant;
        repRange.y = ant + fit;
        ant = ant + fit;
      }
    }

    public void fitCalc(){
      float dist = dist(pos.x, pos.y, goal.x, goal.y);
      if(finish){
        fit = 50 + 100.0/(moves * moves);
        if(maxSteps > moves && nMSteps > moves){
          nMSteps = moves;
        }
      } else {
        fit = 1.0/(dist * dist);
        fit -= (int(crashWall)*0.1)/(dist*dist);
      }
      totalFit += fit;
    }
    public boolean selected(float selected){
      if(repRange.x <= selected && repRange.y > selected){
        return true;
      }
      return false;
    }
    public void child(Cell p1, Cell p2){
      for(int i = 0; i < genes.length; i++){
        if(floor(random(0, 2)) == 1){
          genes[i] = p1.genes[i];
        } else {
          genes[i] = p2.genes[i];
        }
        if(floor(random(0, 100)) == 0){
          genes[i] = random(-HALF_PI/4, HALF_PI/4);
        }
      }
    }
    public float getFit(){
      return fit;
    }
    public boolean isDeath(){
      return death;
    }
    public boolean isChamp(){
      return champ;
    }
    
    
}
