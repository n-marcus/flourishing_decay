/////////////////////////////////////
//HIER KAN JE DINGEN AANPASSEN PEPE//
/////////////////////////////////////

//Dit is het pad naar de foto die ziet na het uitfaden van de bij
String fadeOutMessageImgPath = "./imgs/fadeOutMessage.png";
//Dit is hoeveel seconden de delen duren (witte balk en grijze balk, de rest past zich daarop aan)
//mag ook een kommagetal zijn bijvoorbeeld 5.2
float tijdPerBij = 40;
float tijdPerFadeOut = 20;

//////////////////////////////////
//HIERONDER NIETS AANPASSEN PEPE//
//////////////////////////////////

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

static final int numFlowers = 100;


PImage fadeOutMessageImg = new PImage();

void setup() {
  pixelDensity(1);
  //size(1080, 1920, OPENGL);
  //1 is eigen scherm, 2 is externe display
  noCursor();

  //noSmooth();

  Ani.init(this);

  loadJSON();

  fullScreen(2);

  timerBar = new TimerBar();

  quicksand = createFont("Quicksand_Book.otf", 48);
  quicksand12 = createFont("Quicksand_Book.otf", 12);
  quicksandBold = createFont("Quicksand_Bold.otf", 75);
  textFont(quicksand);

  setupOSC();

  setupOSCFlowers();

  sendOscReset(4000, 1);
  
  fadeOutMessageImg = loadImage(fadeOutMessageImgPath);
}


void draw() {
  background(0);

  bees[beeIndex].draw(timerBar);

  timerBar.draw();


  fill(255);
  noStroke();
  textSize(14);
  textAlign(LEFT, TOP);
  //text(int(frameRate), 10, 10);
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
  /* send the message */
  oscP5.send(myMessage, abletonOSC);
}
