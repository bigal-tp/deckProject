<!doctype html>
<html lang="en">
  <head>
<cfset lorcanaInstance = createObject("component", "lorcana")>
<cfset cardData = "#lorcanaInstance.getLorcanaData()#">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script>
/*var cardData = [];
$(document).ready(function() {
      
      $.ajax({
        url: "https://api.lorcana-api.com/cards/all",
        method: "GET",
        dataType: "json",
        success: function(data) {
          cardData = data;
        },
        error: function(xhr, status, error) {
          console.error("Error fetching Lorcana cards:", error);
        }
      });
  });*/
  const cardData = <cfoutput>#cardData#</cfoutput>
 let collectionCardNumber = [];
 let collectionSetNum = [];   
</script>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Loracana Analytics</title>
    
  </head>
  <body style="background-color: darkgreen;">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<div class="container">
  <div class="row">
    <div class="col-md-8 offset-md-2">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title">Lorcana Analytics</h5>
          <p class="card-text">
            <select id="setSelect" onchange="filter()" class="form-select"  multiple>
                  <option>Set</option>
                  <option value="1">The First Chapter</option>
                  <option value="2">Rise of the Floodborn</option>
                  <option value="3">Into the Inklands</option>
            </select>
            <select id="inkColorSelect" onchange="filter()" multiple  class="form-select">
                  <option>Ink Color</option>
                  <option value="Amber">Amber</option>
                  <option value="Amethyst">Amethyst</option>
                  <option value="Emerald">Emerald</option>
                  <option value="Ruby">Ruby</option>
                  <option value="Sapphire">Sapphire</option>
                  <option value="Steel">Steel</option>
            </select>
            <select id="typeSelect" onchange="filter()" multiple  class="form-select">
                  <option>Card Type</option>
                  <option value="Character">Character</option>
                  <option value="Action">Action</option>
                  <option value="Action - Song">Action - Song</option>
                  <option value="Object">Object</option>
                  <option value="Location">Location</option>
            </select>
            <select id="costSelect" onchange="filter()" multiple  class="form-select">
                  <option>Card Cost</option>
                  <option value="1">1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                  <option value="4">4</option>
                  <option value="5">5</option>
                  <option value="6">6</option>
                  <option value="7">7</option>
                  <option value="8">8</option>
                  <option value="9">9</option>
                  <option value="10">10</option>
            </select>
            <select id="loreSelect" onchange="filter()" multiple  class="form-select">
                  <option>Lore</option>
                  <option value="1">1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                  <option value="4">4</option>
            </select>
            </p>
        </div>
       
        <div id='dataDisplay' class="card-text"></div>
      </div>
    </div>
  </div>
</div>
   
  </body>
</html>
 

<script>
    function getFormData(){
        formData = {};
        setIDstring = $('#setSelect option:selected').toArray().map(item => item.value);
        formData.inkColor  = $('#inkColorSelect option:selected').toArray().map(item => item.value);
        formData.type  = $('#typeSelect option:selected').toArray().map(item => item.value);
        costPre  = $('#costSelect option:selected').toArray().map(item => item.value);
        lorePre  = $('#loreSelect option:selected').toArray().map(item => item.value);
        setID = [];
        cost =[];
        lore =[];
        for (let i = 0; i < setIDstring.length; i++) {
            setID.push(parseInt(setIDstring[i]));
        }
        formData.setID = setID;
        for (let i = 0; i < costPre.length; i++) {
            formData.cost.push(parseInt(costPre[i]));
        }
        formData.cost = cost;
        for (let i = 0; i < lorePre.length; i++) {
            formData.lore.push(parseInt(lorePre[i]));
        }
        formData.lore = lore;
        return formData;

    }
    function filter(){
        t="";
        input = getFormData();
        filterString = '';
       
        if ((input.inkColor && input.inkColor.length)){
            
            filterString += 'input.inkColor.includes(card.Color) && ';
        }
        if ((input.setID && input.setID.length)){
            
            filterString += 'input.setID.includes(card.Set_Num)  && ';
        }
        if ((input.type && input.type.length)){
            
            filterString += 'input.type.includes(card.Type)  && ';
        }
        if ((input.cost && input.cost.length)){
            
            filterString += 'input.cost.includes(card.Cost)  && ';
        }
        if ((input.lore && input.lore.length)){
            
            filterString += 'input.lore.includes(card.Lore)  && ';
        }
        //fixethis one later
        if ((collectionCardNumber && collectionCardNumber.length)){
            
            filterString += 'collectionCardNumber.includes(card.Card_Num)  && ';
        }
        filterString = filterString.substring(0, filterString.length-3);
        
        displayValues = cardData.filter((card) => eval(filterString));
           
          $.each(displayValues, function (key, value) {
            
            switch(displayValues[key].Color){
              case "Amber":
                setClass = 'style="background-color: #DAA520"';
                break;
              case 'Amethyst':
                setClass = 'style="background-color: #9370DB"';
                break;
              case 'Emerald':
                setClass = 'style="background-color: lightgreen"';
                break;
              case 'Ruby':
                setClass = 'style="background-color: #E0115F"';
                break;
              case 'Sapphire':
                setClass = 'style="background-color: aqua"';
                break;
              case 'Steel':
                setClass = 'style="background-color: #808080"';
                break;          
            }
            
            t +='<p '+setClass+'><strong>'+value.Name+'</strong></p>';
          });
        $('#dataDisplay').html(t);
        return displayValues;
    }

    function rateCard(inakable, cost, ability, lorcana, strength, willpower) {
    // Define the maximum values for each attribute
    const maxValues = { inakable: 1, cost: 10, ability: 10, lorcana: 10, strength: 10, willpower: 10 };
    
    // Calculate the score for each attribute
    const inakableScore = inakable / maxValues.inakable;
    const costScore = (maxValues.cost - cost + 1) / maxValues.cost;  
    const abilityScore = ability / maxValues.ability;
    const lorcanaScore = lorcana / maxValues.lorcana;
    const strengthScore = strength / maxValues.strength;
    const willpowerScore = willpower / maxValues.willpower;
    
    // Calculate the weighted average of the scores
    // You can adjust the weights according to the importance of each attribute
    const weights = { inakable: .5, cost: 3, ability: 5, lorcana: 3, strength: 2, willpower: 1 };
    const totalWeight = Object.values(weights).reduce((a, b) => a + b, 0);
    
    const weightedAverage = (
        (inakableScore * weights.inakable) +
        (costScore * weights.cost) +
        (abilityScore * weights.ability) +
        (lorcanaScore * weights.lorcana) +
        (strengthScore * weights.strength) +
        (willpowerScore * weights.willpower)
    ) / totalWeight;
    
    // Scale the weighted average to a 1-10 scale
    const cardRating = Math.round(weightedAverage * 10 * 10) / 10;  // Rounded to one decimal place
    
    return cardRating;
}

// Example usage:
// Assuming the card has the following attributes:
// Inakable: 7, Cost: 3, Ability: 6, Lorcana: 8, Strength: 5, Willpower: 9
const cardRating = rateCard(7, 3, 6, 8, 5, 9);
console.log(`The card rating is: ${cardRating}`);
    function executeChart(){
      //filteredData = filter();
      //createChart(filteredData);
      return true;
    }
      /* function createChart(filteredData){
      input = getFormData();
      console.log(filteredData);
      
   $.each(displayValues, function (key, value) {

      });

      const ctx = document.getElementById('myChart');

      new Chart(ctx, {
        type: 'line',
        data: {
          labels: ['1', '2', '3', '4', '5', '6', '7'],
          datasets: [{
            label: '# of Votes',
            data: input.cost,
            borderWidth: 1
          }]
        },
        options: {
          scales: {
            y: {
              beginAtZero: true
            }
          }
        }
      });
    }*/
 </script>       
        
       





<br><br><br>To Do:
<ol>
    <li>Data Model Cards</li>
    <li>Build Graphs Ask Trcia about visulization types.</li>
    <li>Add additional Filters</li>
    <li>Card Value Number</li>    
    <li>Collection Tables</li>
    <li>Set Datasource</li>
    <li>CRUD user cards</li>
    <li>Auto Decks</li>
    <li>Images</li>
    <li>Styles</li>
    <li>Users</li>
    <li>Logins</li>
</ol>



