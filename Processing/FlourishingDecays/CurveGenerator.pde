class CurveGenerator {
  float currentVal = 0;
  //float progress = 0;
  float steepness = 1;
  int startMillis = 0;
  int curveLength = 0;

  CurveGenerator() {
    ;
  }

  void reset(float startVal, float endVal) {
    currentVal = startVal;
    startMillis = millis();
    
  }

  float currentVal(float progress) {
    //use an easing function to calculate the current value
    //source: https://easings.net/#easeInOutSine (added the power to make it more steep towards the end)
    currentVal = -(cos(PI * (pow(progress, steepness))) - 1.0) /2.0;
    return currentVal;
  }
}
