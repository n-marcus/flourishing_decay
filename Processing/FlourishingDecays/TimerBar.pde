class TimerBar {
  //Creating a stopwatch to keep time

  int timerLengthFadeOut = 10000;
  int timerLengthDefault = 30000;
  //int timerLengthFadeOut = 10000;
  //int timerLengthDefault = 12000;
  int timerLength = timerLengthDefault;
  int startMillis;
  int endMillis;
  float percentage = 0.0;

  color defaultColor = color(255, 255, 255);
  
  //
  color fadeOutColor = color(100);
  color currentColor = defaultColor;

  boolean resetSend = false;

  boolean fadeOut = false;

  TimerBar() {
    startMillis = millis();
    //endMillis =startMillis + timerLength;
  }

  void restart() {
    startMillis = millis();
    percentage = 0.0;

    for (BeeInformation bee : bees) {
      //reset all bee animations
      bee.resetAnimation();
    }
  }

  void draw() {
    int now = millis();

    percentage = float(now - startMillis) / float(timerLength);

    fill(currentColor);
    noStroke();
    rectMode(CORNER);
    rect(0, height, percentage * width, -20);
    fill(255);
    //write the years:
    textAlign(CENTER, CENTER);
    textFont(quicksand);
    textSize(30);
    text("1988", 40, height -45);
    text("2003", width / 2,  height - 45);
    text("2018", width - 40, height - 45);

    //draw the year lines
    fill(255);
    rect(15, height - 30, 2, 30);
    rect(width / 2 , height - 30, 2, 30);
    rect(width - 15, height - 30, 2, 30);

    if (percentage > 0.5 && fadeOut) {
      if (!resetSend) {
        //clearAllAir();
        sendOscReset((timerLengthFadeOut / 2) - 1000, 1);
        resetSend = true;
      }
    } else {
      currentFadeOutFlower = 0;
      resetSend = false;
    }

    if (now > startMillis + timerLength) {
      //if the current time is longer than the start time plus the total timer time
      //we have ended the time for this timer
      println("Timer ended!");
      //flip fade out
      fadeOut = !fadeOut;

      //change the timerlength according to whether we are fading out or not
      timerLength = (fadeOut) ? timerLengthFadeOut : timerLengthDefault;

      //change the color of the loading bar
      currentColor = (fadeOut) ? fadeOutColor : defaultColor;

      //if are not about to fade out, show the next bee
      if (!fadeOut) nextBee();

      //restart the timer
      restart();
    }
  }
}
