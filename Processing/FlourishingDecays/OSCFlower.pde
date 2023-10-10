OSCFlower[] flowers;

class OSCFlower {
  int index;

  int airOn = 0;
    OSCFlower(int _index) {
    index = _index;
  }

  void sendOscMessage(int _airOn) {
    if (_airOn != airOn ) {
      //if the airon status changed
      airOn = _airOn;

      //send an osc message
      OscMessage myMessage = new OscMessage("/flower");

      myMessage.add(flowerIndices.get(index)); // which flower
      myMessage.add(airOn); //turn it on

      /* send the message */
      oscP5.send(myMessage, myRemoteLocation);
      oscP5.send(myMessage, abletonOSC);
    } else { 
     //println("duplice osc message, not sending"); 
    }
  }
}


void setupOSCFlowers() {

  //init a list of flowers
  flowers = new OSCFlower[numFlowers];

  //loop over all flowers and give them an index
  for (int i = 0; i < numFlowers; i ++) {
    flowers[i] = new OSCFlower(i);
  }
}
