final PVector inicio = new PVector(250, 750),
  goal = new PVector(250, 100);
final int population = 50,
  goalRadius = 50;
ArrayList<Cell> generation = new ArrayList(),
  children = new ArrayList();
float totalFit = 0,
  ant = 0;
int genCount = 0,
  maxSteps = 4000,
  nMSteps = maxSteps;
boolean nextGen = true,
  showAll = true,
  start =false,
  editing = false;
Obstacles obs = new Obstacles();

public void setup() {
  background(#FFD6E3);
  size(500,800);
  for (int i = 0; i < population; i++) {
    generation.add(new Cell());
  }
  frameRate(400);
}

public void draw() {
  background(#FFD6E3);
  noStroke();
  fill(#AAA7FF);
  ellipse(goal.x, goal.y, goalRadius*2, goalRadius*2);
  obs.show();
  evolution();
}

public void selection() {
  Cell champ = new Cell();
  float bestFit = 0;
  for (Cell c : generation) {
    if (c.getFit() > bestFit) {
      champ = c;
      bestFit = c.getFit();
    }
  }
  children.add(champ);
  children.get(0).champ();
  for (int i = 1; i < population; i++) {
    Cell parent1 = search(floor(random(0, totalFit)));
    Cell parent2;
    do {
      float s = random(0, totalFit);
      parent2 = search(s);
    } while (parent1 == parent2);
    children.add(new Cell(parent1, parent2));
  }
  generation.clear();
  for (Cell c : children) {
    generation.add(c);
  }
  children.clear();
  genCount++;
  nextGen = false;
  totalFit = 0;
  ant = 0;
  maxSteps = nMSteps;
}

public void evolution() {
  if (start) {
    nextGen = true;
    for (int i = 0; i < population; i++) {
      Cell cell = generation.get(i);
      cell.collision();
      if (showAll || cell.isChamp()) {
        cell.disp();
      }
      cell.move();
      cell.finish();
      cell.death();
      if (nextGen && !cell.isDeath()) {
        nextGen = false;
      }
    }
    if (nextGen) {
      selection();
    }
  }
}
public Cell search(float rep) {
  boolean ready = false;
  int place = 0;
  while (!ready) {
    if (generation.get(place).selected(rep)) {
      ready = true;
    } else {
      place++;
    };
  }
  return generation.get(place);
}
public void keyPressed() {
  if (keyCode == 32) {
    showAll = !showAll;
  } else if (keyCode == 8 && genCount == 0) {
    obs.pop();
  } else if (key == ENTER && !editing) {
    start = !start;
    genCount = genCount==0?1:genCount;
  }
}
public void mousePressed() {
  if (genCount == 0) {
    obs.create(mouseX, mouseY);
    editing = true;
  }
}
public void mouseReleased() {
  if (genCount == 0) {
    obs.insert(mouseX, mouseY);
    editing = false;
  }
}
