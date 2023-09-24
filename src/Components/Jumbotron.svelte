<script>
  import { currentBeeIndex } from "../stores";
  export let currentBeeObject;
  let blurValue = 50;
  let initBlurValue = 50;

  currentBeeIndex.subscribe(() => {
    blurValue = initBlurValue;
    //start a timer
    const timer = setInterval(() => {
      if (blurValue <= 0) {
        //stop the timer if we reached the target
        clearInterval(timer);
        return;
      }
      blurValue -= 1;
    //   console.log(blurValue)
    }, 25); //every x ms
  });

</script>

<div
  class="jumbotron"
  style="height:50vh; 
  background-color:black; 
  filter: blur({blurValue}px);
  -webkit-filter: blur({blurValue}px);
  background-size:contain; background-position: center; background-repeat:no-repeat; background-image:url('./imgs/{currentBeeObject.picture_url}')"
/>
