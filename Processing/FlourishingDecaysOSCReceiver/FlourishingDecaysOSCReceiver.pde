import beads.*;
import java.util.Arrays;
import netP5.*;
import oscP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
PImage flowerImage;
AudioContext ac;
ArrayList<Flower> flowers = new ArrayList<Flower>();

boolean mouseMode = false;

void setup() {
  size(800, 800, OPENGL);
  smooth();
  pixelDensity(2);

  oscP5 = new OscP5(this, 12001);

  flowerImage = loadImage("./imgs/flower.png");
  makeFlowerGrid();
  ac = AudioContext.getDefaultContext();

  myRemoteLocation = new NetAddress("169.254.145.242", 4200);
}

void draw() {
  background(0);

  // The second is using an enhanced loop:
  for (Flower flower : flowers) {
    flower.draw();
    
    if (flower.sendingMessage) { 
       fill(0,255,0);
       circle(10,10,10);
    }
  }

  fill(255);

  int numFlowersOn = 0;
  for (Flower flower : flowers) {
    //if the air for this flower is on, increase the num flowers on variable
    if (flower.airOn) {
      numFlowersOn ++;
    }
  }
  text("Percentage on: " + (numFlowersOn) + "%", width / 2, 50);
  text("Reverse: " + (100 - numFlowersOn) + "%", width / 2, 100);
  text("Mousemode on: " + (mouseMode), width / 2, 150);

  if (mouseMode) {
    checkMouse();
  }
}

void mousePressed() {
  checkClicked();
}

void mouseReleased() {
}

void checkClicked() {
  for (Flower flower : flowers) {
    flower.checkClicked();
  }
}

void checkReleased() {
  for (Flower flower : flowers) {
    if (flower.airOn) {
      flower.setAir(false);
    }
  }
}





void checkMouse() {
  for (Flower flower : flowers) {
    flower.checkMouse();
  }
}

void keyPressed() {

  if (key == 'a') {
    for (Flower flower : flowers) {
      flower.setAir(!flower.airOn);
      delay(2);
      flower.draw();
    }
  }

  if (keyCode == 32) {
    mouseMode = !mouseMode;

    //if we turn mouse mode off, turn all flowers off
    if (mouseMode == false) {
      for (Flower flower : flowers) {
        flower.setAir(false);
      }
    }
  }
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/flower")) {
    //println("got flower message");

    int flowerIndex = theOscMessage.get(0).intValue();
    int airOn = theOscMessage.get(1).intValue();

    println("/flower " + flowerIndex + " " + airOn);

    Flower targetFlower = flowers.get(flowerIndex);
    //targetFlower.airOn = boolean(airOn);
    targetFlower.setAir(boolean(airOn));
    //player.play(1, 0.1);
  }
}
