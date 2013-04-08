var d3, $; // sublime-text-2

function draw(data) {
    'use strict';

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
