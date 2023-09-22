<script>
  import { onMount } from "svelte";
  import { currentBeeIndex } from "../stores.js";
  import bees from "../bees.json";
  import Jumbotron from "../Components/Jumbotron.svelte";
  import BeeYears from "../Components/BeeYears.svelte";
  import BeeNames from "../Components/BeeNames.svelte";
  import TimerBar from "../Components/TimerBar.svelte";

  //get the bee array from the bee json
  let beeArray = bees.bees;

  let currentBeeObject = beeArray[0];

  onMount(() => {
    // console.log(beeArray);
    //save the current bee object
    currentBeeObject = beeArray[$currentBeeIndex];
  });

  function nextBeeButtonClicked() {
    //when user clicks the button for the next bee
    $currentBeeIndex += 1;
    $currentBeeIndex %= beeArray.length;
    currentBeeObject = beeArray[$currentBeeIndex];
    console.log("Now looking at bee " + $currentBeeIndex)
  }

  currentBeeIndex.subscribe(() => { 
    currentBeeObject = beeArray[$currentBeeIndex];
  })
</script>

<Jumbotron {currentBeeObject}/>

<BeeNames {currentBeeObject} />

<div class="mt-3"></div>

<BeeYears {currentBeeObject} />


<div class="debug fixed-bottom">
    <TimerBar></TimerBar>
    <!-- <div class="row">
        {JSON.stringify(currentBeeObject)}
    </div> -->

  <div class="row">
      <button class="btn btn-primary" on:click={nextBeeButtonClicked}> Next Bee</button>
  </div>
</div>

