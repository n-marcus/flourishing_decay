<script>
  import { currentBeeIndex } from "../stores";

  export let startingValue = 0;
  export let targetValue = 1000;
//   export let time = 2000;
  let currentValue = startingValue;



  currentBeeIndex.subscribe(() => {
    // console.log("Countup says bee index has changed")
    currentValue = startingValue;
    const timer = setInterval(() => {
    if (currentValue >= targetValue) {
      clearInterval(timer);
      return;
    }

    currentValue += 1;
    // Execute the function
  }, 50);
  })
</script>

<span>
  {currentValue}
</span>
