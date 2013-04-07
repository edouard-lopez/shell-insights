var d3, $; // sublime-text-2

function draw(data) {
    'use strict';
    // viewport properties
    var   vpMargin = 50,
            vpWidth = 700,
            vpHeight = 300;
    var   barWidth = 10;

 // x.domain(data.map(function(d) { return d.letter; }));
// y.domain([0, d3.max(data, function(d) { return d.frequency; })]);

    // max & min values of data
    var   yExtent = d3.extent(data, function (d) { return d.size; });

    // Scales
    var x = d3.scale.ordinal()
                .rangeRoundBands([ 0, vpWidth], 0.1 )
                .domain(data.map(function (d) { return d.cmd; }));
     var y = d3.scale.linear()
                     .range([vpHeight - vpMargin, vpMargin])
                     .domain([0, d3.max(data, function (d) { return d.size; })]);
console.log("x: ", x)
console.log("y: ", y)
    // Axis
     var xAxis = d3.svg.axis()
                     .scale(x)
                     .orient('bottom');
     var yAxis = d3.svg.axis()
                     .scale(y)
                     .orient('left');
                     //.ticks();

     var svg = d3.select('#insights')
                     .append('svg')
                     .attr('id', 'chart')
                     .attr('width', vpWidth)
                     .attr('height', vpHeight);

    // X axis
    svg.append('g')
        .attr('class', 'x axis')
        .attr('transform', 'translate(0,' + vpHeight + ')')
        .call(xAxis);

    // Y axis
    svg.append("g")
        .attr('class', 'y axis')
        .call(yAxis)
            .append('text')
            .attr('transform', 'rotate(-90)')
            .attr('y', 6)
            .attr('dy', '.71em')
            .style('text-anchor', 'end')
            .text('Frequency');

    xAxis = d3.svg.axis()
                    .scale(x)
                    .orient('bottom');
    yAxis = d3.svg.axis()
                    .scale(y)
                    .orient('left');

    // bars area
    svg.append('g').attr('id', 'bars');

    svg.select('#bars').selectAll('rect.cmd')
        .data(data)
        .enter()
        .append('rect')
            .attr('class', 'cmd')
            .attr('x', function (d) { return x(d.cmd); })
            .attr('y', function (d) { return y(d.size * 10); })
            .attr('width', barWidth )
            .attr('height', function (d) { return vpHeight - y(d.size * 10); })
            .text(function (d) { return d.cmd; });


}


$(document).ready(function (){
    'use strict';
    var url = '/data/output.json';
    d3.json(url, function (error, data) {
      if (error) return console.warn(error);
      draw(data);
    // histograph(json.data, '#insights');
    });
});
