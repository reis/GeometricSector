using Toybox.Graphics;
using Toybox.Math;

module Sectors {

    function drawDialSector(dc) {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var center_x = width / 2;
        var center_y = height / 2;
        var screenCenterPoint = [ center_x, center_y ];
        var hour_radius =  width/2; 
        var maxRad = hour_radius;
        var r1 = hour_radius * 0.72;
        var deflec1 = 0.25;

        var alpha = Math.PI;
        var hand;
        var i;

        // Fill the entire background with Black.
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

        var colour = {
            0  => Graphics.COLOR_RED,
            3  => Graphics.COLOR_RED,
            6  => Graphics.COLOR_RED,
            9  => Graphics.COLOR_RED,
            1  => Graphics.COLOR_YELLOW,
            4  => Graphics.COLOR_YELLOW,
            7  => Graphics.COLOR_YELLOW,
            10 => Graphics.COLOR_YELLOW,
            2  => Graphics.COLOR_BLUE,
            5  => Graphics.COLOR_BLUE,
            8  => Graphics.COLOR_BLUE,
            11 => Graphics.COLOR_BLUE
        };

        for (i=0; i<12; i+=1) {
            alpha = Math.PI/6*(0.5+i);
            hand =  [
                [center_x+r1*Math.sin(alpha-deflec1),center_y-r1*Math.cos(alpha-deflec1)],
                [center_x+maxRad*Math.sin(alpha),center_y-maxRad*Math.cos(alpha)],
                [center_x+r1*Math.sin(alpha+deflec1),center_y-r1*Math.cos(alpha+deflec1)]
            ];
            dc.setPenWidth(2);
            dc.setColor(colour[i], Graphics.COLOR_TRANSPARENT);
            dc.fillPolygon(hand);
        }
    }




}