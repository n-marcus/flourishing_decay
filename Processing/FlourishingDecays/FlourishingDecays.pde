import netP5.*;
import oscP5.*;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

int beeIndex = 0;

//array of beeinformation objects
BeeInformation[] bees;
TimerBar timerBar;

PFont quicksand;
PFont quicksand12;
PFont quicksandBold;


void setup() {
  pixelDensity(1);
  size(1080, 1920, OPENGL);
  //fullScreen(OPENGL,2);
  noSmooth();

  Ani.init(this);

  loadJSON();

  timerBar = new TimerBar();

  quicksand = createFont("Quicksand_Book.otf", 48);
  quicksand12 = createFont("Quicksand_Book.otf", 12);
  quicksandBold = createFont("Quicksand_Bold.otf", 48);
  textFont(quicksand);

  setupOSC();
}


void draw() {
  background(0);


  bees[beeIndex].draw(timerBar);

  timerBar.draw();
 

  fill(255);
  noStroke();
  textSize(14);
  textAlign(LEFT, TOP);
  text(int(frameRate), 10, 10);
}

void keyPressed() {
  println(keyCode);
  beeIndex ++;
  beeIndex %= bees.length;
}

void nextBee() {
  beeIndex ++;
  beeIndex %= bees.length;
  //bees[beeIndex].reshow();

  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/bee");

  myMessage.add(beeIndex); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
}
