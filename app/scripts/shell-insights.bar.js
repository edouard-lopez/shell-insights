var d3, $; // sublime-text-2

function draw(data) {
    'use strict';

    // canvas properties
    var margin = {top: 20, right: 20, bottom: 30, left: 40},
    width = data.length*10 - (margin.left + margin.right),
    height = 500 - (margin.top + margin.bottom);

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
