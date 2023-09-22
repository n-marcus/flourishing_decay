<script>
    import { currentBeeIndex} from "../stores";
    import bees from "../bees.json";
</script>

<div class="jumbotron" style="height:50vh; background-color:black; background-size:contain; background-position: center; background-repeat:no-repeat; background-image:url('./imgs/{bees.bees[$currentBeeIndex].picture_url}')">
</div>
