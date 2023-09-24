<script>
  import { onMount } from "svelte";
  import { currentBeeIndex, crossFading } from "../stores.js";
  import bees from "../bees.json";
  import Jumbotron from "../Components/Jumbotron.svelte";
  import BeeYears from "../Components/BeeYears.svelte";
  import BeeNames from "../Components/BeeNames.svelte";
  import TimerBar from "../Components/TimerBar.svelte";

  import { fade } from "svelte/transition";

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
    console.log("Now looking at bee " + $currentBeeIndex);
  }

  currentBeeIndex.subscribe(() => {
    currentBeeObject = beeArray[$currentBeeIndex];
  });
</script>

<Jumbotron {currentBeeObject} />
<!-- 
<div class="container-fluid">
  <div class="row">
    {#if !$crossFading}
      <div transition:fade={{ delay: 0, duration: 300 }}>
        <h1>
          {currentBeeObject.name_dutch}
        </h1>
      </div>
    {/if}
  </div>
  <div class="row">
    {#if !$crossFading}
    <div transition:fade={{ delay: 1000, duration: 300 }}>
      <h2 class="px-3">
        {currentBeeObject.name_latin}
      </h2>
    </div>
  {/if}
  </div>
</div> -->
<BeeNames {currentBeeObject} />

<div class="mt-3" />

<BeeYears {currentBeeObject} />

<div class="debug fixed-bottom">
  <TimerBar />
  <!-- <div class="row">
        {JSON.stringify(currentBeeObject)}
    </div> -->

  <div class="row">
    <button class="btn btn-primary" on:click={nextBeeButtonClicked}>
      Next Bee</button
    >
  </div>
</div>
