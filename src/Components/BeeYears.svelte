<script>
  import Countup from "./Countup.svelte";

  export let currentBeeObject;
</script>

<div class="container-fluid">
  <div class="row">
    <div class="col">
      <div class="row">
        <h1>
          2003: 
          <Countup
          startingValue={0}
          targetValue={currentBeeObject.data_2003}
        />
        </h1>
      </div>
      <div class="row">
        <h1>
          2018:         <Countup
          startingValue={0}
          targetValue={currentBeeObject.data_2018}
        />
        </h1>
      </div>
    </div>
    <div class="col">
      <h1>
        <!-- {currentBeeObject.trend_percentage} -->
        <Countup
          startingValue={0}
          targetValue={currentBeeObject.trend_percentage}
        />
        %
      </h1>
    </div>
  </div>
</div>
