<script>
  import { currentBeeIndex, crossFading, beePercentage } from "../stores";
  import bees from "../bees.json";
  //get the bee array from the bee json
  let beeArray = bees.bees;
  // let percentage = 0;
  //number of ms per bee
  let timePerBee = 5000;
  let fadeOuttime = 2000;

  let timer;
  let startTime, endTime;

  currentBeeIndex.subscribe(() => { 
    $beePercentage = 0;
    $crossFading = false;
    console.log("Timer bar says current bee index changed " + $currentBeeIndex)
    startTimer(timePerBee);
  })

  function timerEnded() {
    if ($crossFading) { 
      //if the timer ended  and we were are coming from a crossfade
      $crossFading = false;
      //update to the next bee
      $currentBeeIndex += 1;
      $currentBeeIndex %= beeArray.length;
      startTimer(timePerBee);
    } else {
      $crossFading = true;
      startTimer(fadeOuttime);
    }
  }

  function startTimer(waitingTime) {
    //try to find running timers and kill them
    //the subscribe function will retrigger this timer when the timer ends... 
    //I mean to only trigger this function from subscribe when the user has pressed a button for the next bee...
    try { 
      clearInterval(timer);
      console.log("Cleared zombie timer")
    } catch(e) {
      console.log("No timer to clear so all good")
    }
    startTime = new Date();
    console.log("Waiting for " + waitingTime)
    //add the timer per bee to the current time, this is the moment in time in which we will switch to the next bee
    endTime = new Date(startTime.getTime() + waitingTime);
    // console.log("Waiting from " + startTime.getTime() + " till " + endTime.getTime());

    //start a timer
    timer = setInterval(() => {
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
      $beePercentage = 1.0 - msDifference / waitingTime;
    }, 15); //every x ms
  }
</script>

  <div
    class="timer-bar p-0 m-0 {$crossFading ? 'bg-warning' : 'bg-white'}"
    style="width:{$beePercentage * 100}vw; "
  />

<style>
  .timer-bar {
    height: 5px;
  }
</style>
