<script>
  import { onMount } from "svelte";
  import { currentBeeIndex } from "../stores.js";
  import bees from "../bees.json";
  import Jumbotron from "../Components/Jumbotron.svelte";
  let beeArray = bees.bees;
  let currentBeeObject;
  onMount(() => {
    console.log(beeArray);
  });

  function nextBeeButtonClicked() {
    $currentBeeIndex += 1;
    $currentBeeIndex %= beeArray.length;
  }
</script>

<Jumbotron />



<div class="debug">
  {JSON.stringify(beeArray[$currentBeeIndex])}

  Current Bee:
  <br />
  {$currentBeeIndex}
</div>

<button class="btn btn-primary" on:click={nextBeeButtonClicked}> Next Bee</button>
