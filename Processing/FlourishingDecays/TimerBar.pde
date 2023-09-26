class TimerBar {
  //Creating a stopwatch to keep time

  int timerLengthFadeOut = 2000;
  int timerLengthDefault = 5000;
  int timerLength = timerLengthDefault;
  int startMillis;
  int endMillis;
  float percentage = 0.0;

  color defaultColor = color(255, 255, 255);
  color fadeOutColor = color(100, 50, 2);
  color currentColor = defaultColor;

  boolean fadeOut = false;

  TimerBar() {
    startMillis = millis();
    //endMillis =startMillis + timerLength;
  }

  void restart() {
    startMillis = millis();
    percentage = 0.0;
  }

  void draw() {
    int now = millis();

    percentage = float(now - startMillis) / float(timerLength);


    fill(currentColor);
    noStroke();
    rectMode(CORNER);
    rect(0, height, percentage * width, -10);

    if (now > startMillis + timerLength) {
      //if the current time is longer than the start time plus the total timer time
      println("Timer ended!");
      //flip fade out
      fadeOut = !fadeOut;

      //change the timerlength according to whether we are fading out or not
      timerLength = (fadeOut) ? timerLengthFadeOut : timerLengthDefault;

      //change the color of the loading bar
      currentColor = (fadeOut) ? fadeOutColor : defaultColor;
      
      //if are not about to fade out, show the next bee
      if (!fadeOut) nextBee();
      
      if (fadeOut) fadeOutStarted();

      //restart the timer
      restart();
    }
  }
}
