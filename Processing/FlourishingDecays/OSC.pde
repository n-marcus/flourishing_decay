OscP5 oscP5;
NetAddress myRemoteLocation;
NetAddress abletonOSC;


int currentFadeOutFlower = 0;
int _currentFadeOutFlower = 0;
Ani currentFadeOutFlowerAni;

//create a list from 0 - numflowers
static final IntList flowerIndices = IntList.fromRange(numFlowers);

void setupOSC() {
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12001);
  abletonOSC = new NetAddress("169.254.145.242", 4200);

  currentFadeOutFlowerAni = new Ani(this, 1, 0, "currentFadeOutFlower", numFlowers, Ani.EXPO_IN);
}

void sendPercentageMessagesToFlowers(float percentage) {

  println("Sending fade on messages " + percentage);

  //calculate how many flowers can be on at this moment in time
  int maxFlowerIndex = floor((percentage / 100.) * numFlowers);
  //println("max flower index: "

  for (int i = 0; i < numFlowers; i ++ ) {
    //loop over all flowers, if this one should be on, tell the virtual flower to turn on 
    //(it will filter duplicate messages for us as to not spam the osc connection)
    int airOn = (i > maxFlowerIndex) ? 1 : 0;
    flowers[i].sendOscMessage(airOn);
  }
}

void sendFadeOutMessages() {
  //if the currently selected fadeout flower has changed, send the osc message to turn it off

  println("Counting till " + currentFadeOutFlower + " and turning it on");
  for (int i = 0; i < currentFadeOutFlower; i ++ ) {
    //flowers[i].sendOscMessage(1);

    //somehow doing this through the flower objects doesnt always work
    //so we force it again with this
    OscMessage myMessage = new OscMessage("/flower");

    myMessage.add(i); // which flower
    myMessage.add(1); //turn it on

    //delay(3);

    /* send the message */
    oscP5.send(myMessage, myRemoteLocation);
    oscP5.send(myMessage, abletonOSC);
  }
}

//void clearAllAir() {
//  ////reset the current fadeout flower
//  //currentFadeOutFlower += 3;

//  //if (currentFadeOutFlower > flowers.length) {
//  // currentFadeOutFlower = flowers.length - 1;
//  //}

//  //sendFadeOutMessages();


//}

void sendOscReset(int time, int onOrOff) {
  println("Sending reset message!");

  OscMessage myMessage = new OscMessage("/reset");
  myMessage.add(time); //turn it on
  myMessage.add(onOrOff); //turn it on

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
  oscP5.send(myMessage, abletonOSC);
  
  //set all the local OSC flowers to be reset as well
  for (OSCFlower flower : flowers ) {
    flower.airOn = onOrOff;
  }
}

void pickRandomFlowersForBee(float perc) {
  //println("Picking random flowers for bee with percentage " + perc);
  //shuffle the list of 0 to the number of flowers
  flowerIndices.shuffle();
}
