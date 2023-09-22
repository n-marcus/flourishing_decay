<script>
  import { currentBeeIndex } from "../stores";
  import bees from "../bees.json";
  //get the bee array from the bee json
  let beeArray = bees.bees;
  let percentage = 50;
  //number of ms per bee
  let timePerBee = 10000;

  let startTime, endTime;

  function timerEnded() {
    //when user clicks the button for the next bee
    $currentBeeIndex += 1;
    $currentBeeIndex %= beeArray.length;
    console.log("Now looking at bee " + $currentBeeIndex);
    
    //start the new timer
    startTimer();
  }

  function startTimer() {
    startTime = new Date();

    //add the timer per bee to the current time, this is the moment in time in which we will switch to the next bee
    endTime = new Date(startTime.getTime() + timePerBee);
    console.log("Waiting from " + startTime + " till " + endTime);

    //start a timer
    const timer = setInterval(() => {
      let now = new Date();
      if (now >= endTime) {
        //stop the timer if we reached the target
        console.log("Reached end of timer!");
        clearInterval(timer);
        timerEnded();
        return;
      }

      //calculate the time difference between now and the time for the new bee
      let msDifference = endTime.getTime() - now.getTime();
      //calculate the percentage we're at for the current bee
      percentage = 1.0 - msDifference / timePerBee;
      //   console.log("Still waiting for: " + msDifference + " perc " + percentage);
    }, 15); //every x ms
  }

  startTimer();
</script>

<div class="container-fluid m-0 p-0">
  <div class="timer-bar p-0 m-0" style="width:{percentage * 100}vw;" />
</div>

<style>
  .timer-bar {
    background-color: white;
    height: 2px;
  }
</style>
