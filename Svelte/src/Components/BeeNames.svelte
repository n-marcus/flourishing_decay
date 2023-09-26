<script>
  export let currentBeeObject;
  import { beePercentage } from "../stores";
  import { fade } from "svelte/transition";
</script>

<div class="container-fluid">
  <div class="row">
    <h1>
      {currentBeeObject.name_dutch} 
    </h1>
  </div>
  <div class="row">
    {#if $beePercentage > 0.2}
    <h2 transition:fade={{ delay: 0, duration: 300 }} class="px-4">
      {currentBeeObject.name_latin}
    </h2>
    {/if}
  </div>
</div>
