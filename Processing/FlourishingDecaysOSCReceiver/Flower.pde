class Flower {
  int x, y, i;
  float LEDPerc = 0.0;
  boolean airOn = false;
  int airOffDiameter = 10;
  int airOnDiameter = 40;
  int currentDiameter = airOffDiameter;

  color airOnColor = color(0, 0, 200);
  color airOffColor = color(100, 100, 100);
  color currentColor = airOffColor;
  PImage img;

  SamplePlayer player;


  Flower(int _x, int _y, int _i, PImage _img) {
    x = _x;
    y = _y;
    i = _i;
    img = _img;
    //player = new SamplePlayer(SampleManager.sample("C:/Users/N-Mar/Documets/Works/Flourishing Decays Studio SPES/Code/FlourishingDecaysOSCReceiver/data/airOff.wav"));
  }

  void draw() {
    ellipseMode(CENTER);

    currentColor = airOn ? airOnColor : airOffColor;
    //currentDiameter = airOn ? airOnDiameter : airOffDiameter;

    if (airOn && currentDiameter < airOnDiameter) {
      currentDiameter +=2;
    }
    if (!airOn && currentDiameter > airOffDiameter) {
      currentDiameter -=2;
    }

    fill(currentColor);
    imageMode(CENTER);
    image(img, x, y, currentDiameter, currentDiameter);

    fill(255);
    textAlign(CENTER);
    textSize(16);
    text(i, x, y + 30);
  }

  void setAir(boolean _airOn) {
    airOn = _airOn;
  }
}


void makeFlowerGrid() {
  int xPos, yPos = 0;
  int rows = 10;
  int cols = 10;
  int i = 0;
  for (int y = 0; y < rows; y ++) {
    for (int x = 0; x < cols; x ++) {
      xPos = int(x * (width / cols));
      xPos += (width / cols) / 2;

      yPos = int(y * (height / rows));
      yPos += (height / rows) / 2;


      // Objects can be added to an ArrayList with add()
      flowers.add(new Flower(xPos, yPos, i, flowerImage));
      i ++;
    }
  }
}
