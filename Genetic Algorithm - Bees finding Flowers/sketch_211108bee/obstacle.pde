public class Obstacles{

  private ArrayList<Wall> obst;
  private Wall temp;
  public Obstacles(){
    obst = new ArrayList();
  }
  public void create(float x, float y){
    temp = new Wall(x, y);
  }
  public void insert(float x, float y){
    temp.setDimensions(x - temp.getX(), y - temp.getY());
    obst.add(temp);
  }
  public boolean collision(PVector cell){
    for(Wall w : obst){
        float left, right, up, down;
        if (w.dimX() > 0){
          right = w.getX() + w.dimX();
          left  = w.getX();
        } else {
          right  = w.getX();
          left = w.getX() + w.dimX();
        }
        if (w.dimY() > 0){
          up = w.getY() + w.dimY();
          down  = w.getY();
        } else {
          up  = w.getY();
          down = w.getY() + w.dimY();
        }
        
        if((left < cell.x && cell.x < right) && (down < cell.y && cell.y < up)){
          return true;
        }
      }
      return false;
  }

  public void show(){
    if(editing){
      noStroke();
      fill(#FFEE6C, 100);
      float dimX = mouseX - temp.getX();
      float dimY = mouseY - temp.getY();
      rect(temp.pos.x, temp.pos.y, dimX, dimY);
    }
    for(Wall w : obst){
      w.show();
    }
  }
  public void pop(){
    if(!obst.isEmpty()){
      obst.remove(obst.size() - 1);
    }
  }
}
