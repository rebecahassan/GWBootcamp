
// Console.log the UFO data from data.js
console.log(data);

// D3 selector
var tbody = d3.select("tbody");
var submit = d3.select("#filter-btn");


// Update table with a new dataset
function updateTable(dataset) {
  tbody.html('');
  dataset.forEach((toBeDefined) => {
    var row = tbody.append("tr");
    Object.entries(toBeDefined).forEach(([key,value]) => {
      var cell = tbody.append("td");
      cell.text(value);
    });
  });
}

// Filter date function 
function filterByDate(dataset) {
    var filteredData = dataset.filter(function (d) {
      return d.datetime === $('#datetime').val();
    });
    return filteredData;
}

// First update table of original data
updateTable(data); 
submit.on("click", function() {
    d3.event.preventDefault();

    var result = filterByDate(data);
  updateTable(result);
});
