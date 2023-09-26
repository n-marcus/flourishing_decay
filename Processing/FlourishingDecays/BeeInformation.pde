class BeeInformation {
  public String nameDutch = "Bijennaam";
  public String nameLatin = "LatijnseNaam";
  public String status = "";
  public PImage img;
  public float trendPercentage = 0.0;
  public float trendPercentageInitial = 0.0;
  public float trendPercentageAnimated = 0.0;
  Ani trendPercentageAni;


  BeeInformation() {
  }

  void draw(TimerBar timerBar) {
    float imgH = height * 0.4;
    float imgW = (imgH / img.height ) * img.width;

    //println("image shrinks with " + (imgH / img.height));
    //println("image shrinks with " + img.height + " " + img.width + " to " + imgH + " " + imgW);
    imageMode(CENTER);
    image(img, width / 2, imgH * 0.5, imgW, imgH);

    fill(255);

    textSize(48);
    text(nameDutch, width * 0.05, height * 0.45);
    textSize(32);
    text(nameLatin, width * 0.1, height * 0.45 + 40);

    textSize(24);
    text("Status: " + status, width * 0.05, height * 0.45 + 110);

    //why is the percentage sign invisible here?
    text("Trend Percentage: " + int(trendPercentageAnimated) + "%%%%  ", width * 0.05, height * 0.64);



    //this creates the fade out effect, always leave this at the bottom
    if (timerBar.fadeOut) {
      fill(0, 0, 0, timerBar.percentage * 255. * 1.5);
      rectMode(CORNERS);
      rect(0, 0, width, height);
    }
  }


  void reshow() {
    trendPercentage = random(100);
    ; //reset the value for the new animation
    //restart the animation
    trendPercentageAni = new Ani(this, 4, 0, "trendPercentageAnimated", trendPercentage, Ani.EXPO_IN, "onUpdate:trendPercentageUpdated");
    trendPercentageAni.start();
    //pick the flowers that will be active for this bee
    pickRandomFlowersForBee(trendPercentageInitial);
  }


  void trendPercentageUpdated() {

    sendPercentageMessagesToFlowers(trendPercentageAnimated);
  }

  void initAnimation() {
    trendPercentageInitial = trendPercentage; //save the initial value somewhere before we start animating it
    //take 4 seconds, 0 seconds delay to move variable trendpercentageAnimated to the value of trendPercentage
    trendPercentageAni = new Ani(this, 4, 0, "trendPercentageAnimated", trendPercentage, Ani.EXPO_IN, "onUpdate:trendPercentageUpdated");
  }
}
