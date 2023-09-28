class BeeInformation {
  public String nameDutch = "Bijennaam";
  public String nameLatin = "LatijnseNaam";
  public String status = "";
  public PImage img;
  public float trendPercentage = 0.0;
  public float trendPercentageInitial = 0.0;
  public float trendPercentageAnimated = 0.0;

  public int flowerSpecialism = 0;
  //array with different images for flower specialism
  public PImage[] flowerSpecialismImgs = new PImage[3];

  public int nestingMethod = 0;
  public PImage[] nestingMethodImgs = new PImage[2];

  public PImage percentageCircle = new PImage();

  private int titlePadding = 20;
  float titleBottomY = 75;
  //animation class for the percentage
  Ani trendPercentageAni;

  //list of coordinates for the columns
  float[] colXCoordinates = new float[3];
  //width of a single column
  float colXWidth;

  BeeInformation() {
    createColumns();
    loadImages();
  }

  void createColumns () {
    //divide the screen in 3 columns
    for (int i = 0; i < colXCoordinates.length; i ++) {
      colXCoordinates[i] = (((width - titlePadding) / colXCoordinates.length) * i) + titlePadding;
    }

    //save the width of a singular column
    colXWidth = colXCoordinates[1] - colXCoordinates[0];
  }

  void loadImages() {
    //load all the flower specialism images
    for (int i = 0; i < flowerSpecialismImgs.length; i ++) {
      flowerSpecialismImgs[i] = loadImage("./imgs/flowerSpecialism" + i  +".png");
    }

    //load all the flower specialism images
    for (int i = 0; i < nestingMethodImgs.length; i ++) {
      nestingMethodImgs[i] = loadImage("./imgs/nestingMethod" + i  +".png");
    }


    //percentage circle
    percentageCircle = loadImage("./imgs/percentageCircle.png");
  }

  void draw(TimerBar timerBar) {
    float imgH = height * 0.45;
    float imgW = (imgH / img.height ) * img.width;

    //println("image shrinks with " + (imgH / img.height));
    //println("image shrinks with " + img.height + " " + img.width + " to " + imgH + " " + imgW);
    imageMode(CENTER);
    image(img, width / 2, (imgH * 0.5) + titleBottomY, imgW, imgH);

    fill(255);
    textFont(quicksand);
    textSize(48);
    textAlign(LEFT, BOTTOM);
    text(nameDutch, titlePadding, titleBottomY);
    textSize(18);
    textAlign(RIGHT, BOTTOM);
    text(nameLatin, width - titlePadding, titleBottomY);

    textAlign(CENTER, BOTTOM);
    textSize(24);
    //Make all the columns
    text("Percentage: ", colXCoordinates[0] + (colXWidth / 2), height * 0.55);

    textAlign(LEFT, BOTTOM);
    textFont(quicksand);
    textSize(24);
    text(status, colXCoordinates[1], height * 0.55);


    //bloem specialisme
    textFont(quicksand);
    textSize(24);
    text("Bloem specialisme:", colXCoordinates[1], height * 0.6);

    imageMode(CORNER);
    float flowerSpecImgH = height * 0.05;
    float flowerSpecImgW = (flowerSpecImgH / flowerSpecialismImgs[flowerSpecialism].height ) * flowerSpecialismImgs[flowerSpecialism].width;
    image(flowerSpecialismImgs[flowerSpecialism], colXCoordinates[1], height * 0.625, flowerSpecImgW, flowerSpecImgH);

    //nestel methode
    textFont(quicksand);
    textSize(24);
    text("Nestelmethode:", colXCoordinates[1], height * 0.725);


    imageMode(CORNER);
    float nestingMethodImgH = height * 0.125;
    float nestingMethodImgW = (nestingMethodImgH / nestingMethodImgs[nestingMethod].height ) * nestingMethodImgs[nestingMethod].width;
    image(nestingMethodImgs[nestingMethod], colXCoordinates[1], height * 0.75, nestingMethodImgW, nestingMethodImgH);

    textAlign(CENTER, BOTTOM);
    text("Gebied:", colXCoordinates[2] + (colXWidth / 2), height * 0.55);

    textFont(quicksand);
    textSize(24);
    text("Atlasgebieden:", colXCoordinates[2], height * 0.725);

    imageMode(CENTER);
    float percentageCircleImgH = height * 0.15;
    float percentageCircleImgW = percentageCircleImgH;
    image(percentageCircle, (colXCoordinates[1] - colXCoordinates[0]) / 2, height * 0.7,percentageCircleImgH,percentageCircleImgH);

    //Write the percentage
    textSize(48);
    textAlign(CENTER, CENTER);
    text(int(trendPercentageAnimated), (colXCoordinates[1] - colXCoordinates[0]) / 2, height * 0.7);



    //write the years:
    textAlign(CENTER, CENTER);
    textFont(quicksand);
    textSize(18);
    text("2003", width / 2, height - 30);
    text("2018", width - 25, height - 30);

    //draw the year lines
    fill(255);
    //rectMode(COR);
    rect(width / 2, height - 30, 5, 10);

    //this creates the fade out effect, always leave this at the bottom
    if (timerBar.fadeOut) {
      fill(0, 0, 0, timerBar.percentage * 255. * 1.5);
      rectMode(CORNERS);
      rect(0, 0, width, height);
    }
  }


  void reshow() {
    trendPercentage = 100; //reset the value for the new animation
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
