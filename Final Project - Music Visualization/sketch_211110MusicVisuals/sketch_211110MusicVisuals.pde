import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer track;
AudioMetaData meta;
BeatDetect beat;
FFT fft;

float speed;
boolean hasChosenTrack = false;

Star[] stars;
Sphere[] spheres;
PImage playImg, pauseImg;
Button pauseButton;

JSONObject config;

void settings() {
  int fullscreen =0;
  size(1000, 720, P3D);
  if (fullscreen == 1) {
    fullScreen(P3D);
  }
}

void setup() {
  surface.setTitle("MusicVisuals");
  surface.setResizable(true);
  textFont(createFont("Serif", 40));
  minim = new Minim(this);

  playImg = loadImage("play1.png");
  pauseImg = loadImage("pause.png");
  int starsAmount = constrain(800, 0, 2000);
  int spheresAmount = constrain(5, 3, 5);
  stars = new Star[starsAmount];
  spheres = new Sphere[spheresAmount];

  pauseButton = new Button(pauseImg, new PVector(80, height-150));


  for (int i=0; i<stars.length; i++) {
    stars[i] = new Star();
  }

  noLoop();
  selectInput("Select a music file:", "finishSetup");
}

void finishSetup(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    //keep playing if already has music
    if (hasChosenTrack)
    {
      track.play();
      loop();
    }
  } else {
    if (hasChosenTrack) {
      track.close();
    }
    track = minim.loadFile(selection.getAbsolutePath());
    meta = track.getMetaData();
    fft = new FFT(track.bufferSize(), track.sampleRate());
    beat = new BeatDetect(track.bufferSize(), track.sampleRate());
    beat.setSensitivity(5);

    //instantiate the circles, which currently require fft loaded
    int[] spherecoord1 = {150, 150, -150, -150, 150};
    int[] spherecoord2 = {150, -150, 150, -150, -150};
    for (int i = 0; i < 5; ++i) {
      spheres[i] = new Sphere(spherecoord1[i], spherecoord2[i]);
    }
    hasChosenTrack = true;
    track.play();
    loop();
  }
}

int ys = 25;
int yi = 20;

void draw() {
  // avoid nullPointerException while the user has not chosen a track yet
  if (hasChosenTrack) {
    background(#061153);
    fft.forward(track.mix);
    beat.detect(track.mix);
    noStroke();

    int y = ys;
    text("  ", 10, y+=yi);
    text(meta.title(), 30, y+=yi);
    text("  ", 10, y+=yi);
    text("  ", 10, y+=yi);
    text(meta.author(), 30, y+=yi);



    // gray progress line
    strokeWeight(15);
    stroke( 100, 100, 100);
    line( width / 2 - 350, height - 60, width / 2 + 350, height - 60 );

    // white elapsed progress line
    strokeWeight(15);
    stroke( 255, 255, 255);
    float position = map( track.position(), 0, track.length(), 0, 900 );
    line( width / 2 - 350, height - 60, width / 2 - 350 + position, height - 60 );
    circle(width / 2 - 350 + position, height -60, 3);

    // elapsed time

    text(
      miliToMin(track.position()) + ":"
      + miliToSeg(track.position()),
      width / 2 - 460,
      height - 45);

    // total time

    text(
      miliToMin(track.length()) + ":"
      + miliToSeg(track.length()),
      width / 2 + 375,
      height - 45);

    // main spheres
    for (int i = 0; i < spheres.length; i++) {
      spheres[i].render();
    }

    // background stars
    for (int i=0; i<stars.length; i++) {
      stars[i].render();
    }

    // update buttons
    pauseButton.update();


    // beat detection to speedup stars
    int lowBand = 5;
    int highBand = 15;
    // at least this many bands must have an onset
    // for isRange to return true
    int numberOfOnsetsThreshold = 4;
    if (beat.isRange(lowBand, highBand, numberOfOnsetsThreshold)) {
      speed = 50;
    } else {
      speed = 20;
    }


    //meter test


    colorMode(HSB, 360, 100, 100);
    translate(width/2, height/2, 0);
    int r = 0;
    float r2;
    for (int i = 0; i < 360; ++i) {
      int j = round(map(i, 0, 360, 50, fft.specSize()/3));
      r2 = min(100 + fft.getBand(j)*4, 250);
      float xbar = r * cos(radians(i));
      float xbar2 = r2 * cos(radians(i));
      float ybar = r * sin(radians(i));
      float ybar2 = r2 * sin(radians(i));

      strokeWeight(30);
      stroke(#ff8055, 140);
      line(ybar, -xbar, ybar2, -xbar2);
    }
    colorMode(RGB, 255);
  }
}

String miliToMin(int mili) {
  return nf(mili/1000 / 60, 2);
}

String miliToSeg(int mili) {
  return nf(mili/1000 % 60, 2);
}


void mousePressed() {

  //pause/resume button
  if (pauseButton.containsMouseIn() && track.isPlaying()) {
    pauseButton.setImg(playImg);
    track.pause();
  } else {
    pauseButton.setImg(pauseImg);
    track.play();
  }

  //goes back and choose other music


  // terrible way to check if mouseclick on progressBar
}



void stop() {
  track.close();
  minim.stop();
  super.stop();
}
