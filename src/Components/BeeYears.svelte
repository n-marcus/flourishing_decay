<script>
    export let currentBeeObject;
  </script>
  
  <div class="container-fluid">
    <div class="row">
        <div class="col">
            <div class="row">
              <h1>
                2003: {currentBeeObject.data_2003}
              </h1>
            </div>
            <div class="row">
              <h1>
                2018: {currentBeeObject.data_2018}
              </h1>
            </div>
        </div>
        <div class="col">
            <h1> {currentBeeObject.trend_percentage}%</h1>
        </div>
    </div>
  </div>
  