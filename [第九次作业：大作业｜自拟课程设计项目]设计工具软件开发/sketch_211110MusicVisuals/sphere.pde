class Sphere {
  float[] x,y;
  float[] angle1;
  float[] angle2;
  float transPos;
  float transPos2;
 

  Sphere(float transPos, float transPos2) {
    angle1 = new float[fft.specSize()];
    angle2 = new float[fft.specSize()];
    x = new float[fft.specSize()];
    y = new float[fft.specSize()];
    this.transPos=transPos;
    this.transPos2=transPos2;
  } 

  void render() {
    noStroke();

    // 1
    pushMatrix();
    translate(width/2, height/2, 0);
    for (int i = 0; i < fft.specSize(); i++) {
      angle1[i] = angle1[i]+fft.getFreq(i)/2000;
      rotateX(sin(angle1[i]/5)/30);
      rotateY(cos(angle1[i]/5)/30);
      fill(#fdd97b); 
      pushMatrix();
        translate((x[i]+transPos), (x[i]+transPos2));
        box(fft.getFreq(i)/20+fft.getFreq(i)/50);
      popMatrix();
    }
    popMatrix();

    // 5
    pushMatrix();
    translate(width/2, height/2, 0);
    for (int i = 0; i < fft.specSize(); i++) {
      angle2[i] = angle2[i]+fft.getFreq(i)/1800;
      rotateX(-sin(angle1[i]/5)/60);
      rotateY(cos(angle1[i]/5)/60);
      fill(#bdcffd); 
      pushMatrix();
      translate((x[i]+transPos), (x[i]+transPos2));
      box(fft.getFreq(i)/20+fft.getFreq(i)/30);
      popMatrix();
    }
    popMatrix();
  }
}
