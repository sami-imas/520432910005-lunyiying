public class Wall{
  private PVector pos;
  private PVector dimensions;
  public Wall(float x, float y){
    pos = new PVector(x, y);
  }
  public void show(){
    noStroke();
    fill(#FFEE6C);
    rect(pos.x, pos.y, dimensions.x, dimensions.y);
  }
  public void setDimensions(float x, float y){
    dimensions = new PVector(x, y);
  }
  public float getX(){
    return pos.x;
  }
  public float getY(){
    return pos.y;
  }
  public float dimX(){
    return dimensions.x;
  }
  public float dimY(){
    return dimensions.y;
  }
}
