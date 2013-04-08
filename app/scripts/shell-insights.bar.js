var d3, $; // sublime-text-2

function draw(data) {
    'use strict';

    // canvas properties
    var margin = {top: 20, right: 20, bottom: 30, left: 40},
    width = data.length*10 - (margin.left + margin.right),
    height = 500 - (margin.top + margin.bottom);


    // Scales declaration
    var x = d3.scale.ordinal()
        .rangeRoundBands([0, width], 0.25)
        .domain(
            data.map(function(d) { return d.cmd; })
        );

    var y = d3.scale.linear()
                     .range([height, margin.top])
                     .domain([0, d3.max(data, function (d) { return d.size; })]);


    // Axis declaration
    var xAxis = d3.svg.axis()
        .scale(x)
        .orient('bottom');

    var yAxis = d3.svg.axis()
        .scale(y)
        .orient('left')
        .tickFormat(occurencesFormat);

}


$(document).ready(function (){
    'use strict';
    var url = '/data/output.json';
    d3.json(url, function (error, data) {
        if (error) {
            return console.warn(error); // quit on error
        } else {
            draw(data);
        }
    });
});
