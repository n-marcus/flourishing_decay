<script>
  import { currentBeeIndex } from "../stores";

  export let startingValue = 0;
  export let targetValue = 1000;
  //   export let time = 2000;
  let currentValue = startingValue;

  currentBeeIndex.subscribe(() => {
    // console.log("Countup says bee index has changed")
    //start from 0 again
    currentValue = startingValue;

    //start a timer
    const timer = setInterval(() => {
      if (currentValue >= targetValue) {
        //stop the timer if we reached the target
        clearInterval(timer);
        return;
      }

      //increment the actual value
      currentValue += 1;
    }, 50); //every x ms
  });
</script>

<span>
  {currentValue}
</span>
