JSONObject json;

void loadJSON() {
  json = loadJSONObject("bees.json");

  JSONArray beeData = json.getJSONArray("bees");

  // The size of the array of Bubble objects is determined by the total XML elements named "bubble"
  bees = new BeeInformation[beeData.size()];
  println("Found " + beeData.size() + " bees in JSON");

  for (int i = 0; i < beeData.size(); i++) {
    // Get each object in the array
    JSONObject bee = beeData.getJSONObject(i);
    println("Loading bee: " + i); 


    //make new bee info object for every bee in the json list
    bees[i] = new BeeInformation();
    bees[i].nameDutch = bee.getString("name_dutch");
    bees[i].nameLatin = bee.getString("name_latin");
    bees[i].status = bee.getString("status");
    bees[i].img = loadImage("./imgs/" + bee.getString("picture_url"));
    //bees[i].trendPercentage = bee.getFloat("trend_percentage");
    bees[i].flowerSpecialism = bee.getInt("flower_specialism");
    bees[i].nestingMethod = bee.getInt("nesting_method");
    bees[i].data_2003 = bee.getInt("data_2003");
    bees[i].data_2018 = bee.getInt("data_2018");
    bees[i].atlas_areas = bee.getInt("atlas_areas");
    bees[i].social = bee.getBoolean("social");
    bees[i].area = bee.getString("area");
   
    
    //bees[i].countupTest.restartCount(int(random(100)), 4);

    //bees[i].reshow();
    
    bees[i].preSaveImages();
    println("Loaded bee " + i);
    println(bees[i]);
  }
}
