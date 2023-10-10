class BeeInformation {
  public String nameDutch = "Bijennaam";
  public String nameLatin = "LatijnseNaam";
  public String status = "";
  public PImage img;
  public float trendPercentage = 0.0;
  public float trendPercentageInitial = 0.0;
  public float trendPercentageAnimated = 0.0;

  public float outputPercentage = 0.0;

  //we will interpolate between these numbers
  public int data_2003 = 0;
  public int data_2018 = 0;

  public int flowerSpecialism = 0;
  //array with different images for flower specialism
  public PImage[] flowerSpecialismImgs = new PImage[3];

  public int nestingMethod = 0;
  public PImage[] nestingMethodImgs = new PImage[2];
  public PImage socialImage;
  public boolean social = false;


  public boolean parasitic;
  public PImage[] parasiticImgs = new PImage[2];

  public String area = "";
  public PImage areaImage;

  public PImage atlasImage = new PImage();

  public PImage percentageCircle = new PImage();

  public int atlas_areas = 0;

  private int titlePadding = 30;
  float titleBottomY = 75;
  //animation class for the percentage
  Ani trendPercentageAni;

  //list of coordinates for the columns
  float[] colXCoordinates = new float[3];
  //width of a single column
  float colXWidth;

  CurveGenerator percentageCurve;

  BeeInformation() {
    createColumns();
    loadImages();
    percentageCurve = new CurveGenerator();
  }

  void createColumns () {
    //divide the screen in 3 columns
    for (int i = 0; i < colXCoordinates.length; i ++) {

      //
      colXCoordinates[i] = ((width / colXCoordinates.length) * (i * 1.1)) + titlePadding;
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

    atlasImage = loadImage("./imgs/atlas.png");

    parasiticImgs[0] = loadImage("./imgs/parasite0.png");
    parasiticImgs[1] = loadImage("./imgs/parasite1.png");
  }

  void preSaveImages() {
    if (social) {
      socialImage = loadImage("./imgs/social1.png");
    } else {
      socialImage = loadImage("./imgs/social0.png");
    }

    try {
      areaImage = loadImage("./imgs/" + area + ".png");
    }
    catch(Exception e) {
      println("Could not load area image for " + area);
    }
  }

  void draw(TimerBar timerBar) {
    if (!timerBar.fadeOut) {

      //this is to speed the percentage up a little for the bee calculations
      //this makes the last seconds of the bee info static
      float percentageSpedUp = timerBar.percentage * 1;
      percentageSpedUp = constrain(percentageSpedUp, 0.0, 1.0);

      //divide the percentage by 0.5 to split it into two parts
      //check which half of the timer we are in (0 or 1)
      int percentageHalf = floor(percentageSpedUp/ 0.5);

      //calculate how far the current half is
      float percentagePerHalf = (percentageSpedUp * 2.0);
      if (percentageHalf > 0) {
        percentagePerHalf -= 1.0;
      }

      //calculate the eased percentage for this half
      float curvePercentage = percentageCurve.currentVal(percentagePerHalf);

      outputPercentage = 0.0;
      //calculate the real value for this half
      if (percentageHalf == 0) {
        //if this is the first half, interpolate the already curved percentage from 100 to the 2003 data
        outputPercentage  = lerp(0., data_2003, curvePercentage);
      } else {
        //if this is the second half, interpolate the already curved percentage from 2003 data to the 2018 data
        outputPercentage  = lerp(data_2003, data_2018, curvePercentage);
      }

      fill(255);
      ////send the osc messages
      sendPercentageMessagesToFlowers(outputPercentage);
      //println("BeeCurve " + trendPercentageAnimated);
    }

    float imgH = height * 0.45;
    float imgW = (imgH / img.height ) * img.width;

    //println("image shrinks with " + (imgH / img.height));
    //println("image shrinks with " + img.height + " " + img.width + " to " + imgH + " " + imgW);
    imageMode(CENTER);
    image(img, width / 2, (imgH * 0.5), imgW, imgH);


    fill(255);
    textFont(quicksand);
    textSize(48);
    textAlign(LEFT, TOP);
    text(nameDutch, titlePadding, imgH + (titlePadding));
    textSize(18);
    textAlign(RIGHT, TOP);
    text(nameLatin, width - titlePadding, imgH  + (titlePadding));

    textAlign(LEFT, BOTTOM);
    textSize(24);
    //Make all the columns
    text("Afname percentage: ", colXCoordinates[0], height * 0.55);

    textAlign(LEFT, BOTTOM);
    textFont(quicksand);
    textSize(24);
    text("Status:", colXCoordinates[0], height * 0.6);
    text(status, colXCoordinates[0], (height * 0.6) + 32);


    pushMatrix();
    //move everything after this up a bit for better alignment
    translate(0, -80);


    //bloem specialisme
    textFont(quicksand);
    textSize(24);
    text("Bloem specialisme:", colXCoordinates[1], height * 0.725);

    imageMode(CORNER);
    float flowerSpecImgH = height * 0.04;
    float flowerSpecImgW = (flowerSpecImgH / flowerSpecialismImgs[flowerSpecialism].height ) * flowerSpecialismImgs[flowerSpecialism].width;
    image(flowerSpecialismImgs[flowerSpecialism], colXCoordinates[1], height * 0.74, flowerSpecImgW, flowerSpecImgH);

    //nestel methode
    textFont(quicksand);
    textSize(24);
    text("Parasiet:", colXCoordinates[0], height * 0.85);


    imageMode(CORNER);
    float parasiticImgH = height * 0.075;
    float parasiticImgW = (parasiticImgH / parasiticImgs[int(parasitic)].height ) * parasiticImgs[int(parasitic)].width;
    image(parasiticImgs[int(parasitic)], colXCoordinates[0] + 40, height * 0.865, parasiticImgW, parasiticImgH);


    //nestel methode
    textFont(quicksand);
    textSize(24);
    text("Nestelmethode:", colXCoordinates[1], height * 0.85);


    imageMode(CORNER);
    float nestingMethodImgH = height * 0.1;
    float nestingMethodImgW = (nestingMethodImgH / nestingMethodImgs[nestingMethod].height ) * nestingMethodImgs[nestingMethod].width;
    image(nestingMethodImgs[nestingMethod], colXCoordinates[1] - 30, height * 0.865, nestingMethodImgW, nestingMethodImgH);

    //draw social icon
    textFont(quicksand);
    textSize(24);
    text("Sociaal:", colXCoordinates[0], height * 0.725);

    imageMode(CORNER);
    float socialImageH = height * 0.05;
    float socialImageW = (socialImageH / socialImage.height ) * socialImage.width;
    image(socialImage, colXCoordinates[0], height * 0.745, socialImageW, socialImageH);



    textAlign(LEFT, BOTTOM);
    text("Gebied:", colXCoordinates[2], height * 0.725);

    imageMode(CORNER);
    float areaImgH = height * 0.1;
    float areaImgW = (areaImgH / areaImage.height ) * areaImage.width;
    image(areaImage, colXCoordinates[2], height * 0.73, areaImgW, areaImgH);


    //write atlas gebieden
    textFont(quicksand);
    textSize(24);
    textAlign(LEFT, BOTTOM);
    text("Atlasgebieden:", colXCoordinates[2], height * 0.85);
    //draw atlas image
    imageMode(CORNER);

    float atlasImageH = height * 0.075;
    float atlasImageW = (atlasImageH / atlasImage.height ) * atlasImage.width;
    image(atlasImage, colXCoordinates[2], height * 0.865, atlasImageW, atlasImageH);
    textSize(48);
    textAlign(CENTER, CENTER);
    textFont(quicksandBold);
    text(atlas_areas, colXCoordinates[2] + (atlasImageW / 2), height *0.865 + (atlasImageH * 0.4));




    popMatrix();


    //draw percentage circle
    imageMode(CENTER);
    float percentageCircleImgH = height * 0.15;
    //float percentageCircleImgW = percentageCircleImgH;
    image(percentageCircle, width /2, height * 0.575  , percentageCircleImgH, percentageCircleImgH);

    //Write the percentage
    textSize(75);
    textAlign(CENTER, CENTER);
    //text(round(outputPercentage), (colXCoordinates[1] - colXCoordinates[0]) / 2, height * 0.7);
    String percentString = str(round(outputPercentage));
    text(percentString, width / 2, height * 0.575);


    //this creates the fade out effect, always leave this at the bottom
    if (timerBar.fadeOut) {
      fill(0, 0, 0, timerBar.percentage * 255. * 1.5);
      rectMode(CORNERS);
      rect(0, 0, width, height);
    }
  }

  void resetAnimation() {
    pickRandomFlowersForBee(trendPercentageInitial);
  }


  void trendPercentageUpdated() {

    //sendPercentageMessagesToFlowers(trendPercentageAnimated);
  }
}
