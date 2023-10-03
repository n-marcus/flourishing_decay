OscP5 oscP5;
NetAddress myRemoteLocation;

static final int numFlowers = 100;
int currentFadeOutFlower = 0;
int _currentFadeOutFlower = 0;
Ani currentFadeOutFlowerAni;

//create a list from 0 - numflowers
static final IntList flowerIndices = IntList.fromRange(numFlowers);

void setupOSC() {
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12001);

  currentFadeOutFlowerAni = new Ani(this, 1, 0, "currentFadeOutFlower", numFlowers, Ani.EXPO_IN, "onUpdate:sendFadeOutMessages");
}

void sendPercentageMessagesToFlowers(float percentage) {

  println("Sending fade on messages " + percentage);

  //calculate how many flowers can be on at this moment in time
  int maxFlowerIndex = ceil((percentage / 100.) * numFlowers);
  //println("max flower index: "

  for (int i = 0; i < numFlowers; i ++ ) {
    int currentIndex = flowerIndices.get(i);
    OscMessage myMessage = new OscMessage("/flower");

    myMessage.add(currentIndex); // which flower

    int airOn = (i > maxFlowerIndex) ? 1 : 0;
    myMessage.add(airOn); //turn it off

    /* send the message */
    oscP5.send(myMessage, myRemoteLocation);
  }
}

void sendFadeOutMessages() {
  //if the currently selected fadeout flower has changed, send the osc message to turn it off
  for (int i = 0; i < currentFadeOutFlower; i ++ ) {
    OscMessage myMessage = new OscMessage("/flower");

    myMessage.add(i); // which flower
    myMessage.add(1); //turn it on

    /* send the message */
    oscP5.send(myMessage, myRemoteLocation);
  }
}

void clearAllAir() {
  //reset the current fadeout flower
  currentFadeOutFlower = 0;
  println("Starting clear all air");
  //start the fade out flower animation
  if (!currentFadeOutFlowerAni.isPlaying()) {
    println("Starting fadeoutflowerani");
    currentFadeOutFlowerAni.start();
  }
}

void pickRandomFlowersForBee(float perc) {
  println("Picking random flowers for bee with percentage " + perc);
  //shuffle the list of 0 to the number of flowers
  flowerIndices.shuffle();
}
