import beads.*;
import java.util.Arrays; 
import netP5.*;
import oscP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
PImage flowerImage;
AudioContext ac;
ArrayList<Flower> flowers = new ArrayList<Flower>();

void setup() {
  size(800, 800, OPENGL);
  smooth();
  pixelDensity(2);

  oscP5 = new OscP5(this, 12001);

  flowerImage = loadImage("./imgs/flower.png");
  makeFlowerGrid();
  ac = AudioContext.getDefaultContext();
  
  
}

void draw() {
  background(0);

  // The second is using an enhanced loop:
  for (Flower flower : flowers) {
    flower.draw();
  }
}



/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/flower")) {
    int flowerIndex = theOscMessage.get(0).intValue();
    int airOn = theOscMessage.get(1).intValue();

    Flower targetFlower = flowers.get(flowerIndex);
    //targetFlower.airOn = boolean(airOn);
    targetFlower.setAir(boolean(airOn));
    //player.play(1, 0.1);
  }
}
