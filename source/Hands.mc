using Toybox.Math;
using Toybox.System;
using Toybox.Graphics;

module Hands{
    // This function is used to generate the coordinates of the 4 corners of the
    // polygon used to draw a watch hand. The coordinates are generated with
    // specified length, tail length, and width and rotated around the center
    // point at the provided angle. 0 degrees is at the 12 o'clock position, and
    // increases in the clockwise direction.
    function generateHandCoordinates(centerPoint, angle, handLength, tailLength,
                                    width) {
        // Map out the coordinates of the watch hand
        var coords = [
            [ -(width / 2), tailLength ], [ -(width / 2), -handLength ],
            [ width / 2, -handLength ], [ width / 2, tailLength ]
            ];
        var result = new[4];
        var cos = Math.cos(angle);
        var sin = Math.sin(angle);

        // Transform the coordinates
        for (var i = 0; i < 4; i += 1) {
        var x = (coords[i][0] * cos) - (coords[i][1] * sin) + 0.5;
        var y = (coords[i][0] * sin) + (coords[i][1] * cos) + 0.5;

        result[i] = [ centerPoint[0] + x, centerPoint[1] + y ];
        }

        return result;
    }

    function drawMinuteHand(dc) {
        var clockTime = System.getClockTime();
        var minuteHandAngle = (clockTime.min / 60.0) * Math.PI * 2;
        var width = dc.getWidth();
        var height = dc.getHeight();
        var center_x = width / 2;
        var center_y = height / 2;
        var screenCenterPoint = [ center_x, center_y ];
        var minuteHandCoordinates =
            Hands.generateHandCoordinates(screenCenterPoint, minuteHandAngle, center_x, 0, 3);

        dc.setPenWidth(1);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.fillPolygon(minuteHandCoordinates);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(minuteHandCoordinates[0][0], minuteHandCoordinates[0][1], minuteHandCoordinates[1][0], minuteHandCoordinates[1][1]);
        /*dc.drawLine(minuteHandCoordinates[1][0], minuteHandCoordinates[1][1], minuteHandCoordinates[2][0], minuteHandCoordinates[2][1]);
        dc.drawLine(minuteHandCoordinates[2][0], minuteHandCoordinates[2][1], minuteHandCoordinates[3][0], minuteHandCoordinates[3][1]);
        dc.drawLine(minuteHandCoordinates[3][0], minuteHandCoordinates[3][1], minuteHandCoordinates[0][0], minuteHandCoordinates[0][1]);*/
    }

    function drawHourHand(dc) {
        var clockTime = System.getClockTime();
        var width = dc.getWidth();
        var height = dc.getHeight();
        var center_x = width / 2;
        var center_y = height / 2;
        var screenCenterPoint = [ center_x, center_y ];


        var hour_radius =  width/2 * 0.85; 
        var alpha = Math.PI/6*(1.0*clockTime.hour+clockTime.min/60.0);
        var maxRad = hour_radius;
        var r1 = hour_radius * 0.85;
        var r2 = hour_radius * 0.77;
        var deflec1 = 0.06; //wide of middle part
        var hand =  [[center_x+r1*Math.sin(alpha-deflec1),center_y-r1*Math.cos(alpha-deflec1)],
                [center_x+maxRad*Math.sin(alpha),center_y-maxRad*Math.cos(alpha)],
                [center_x+r1*Math.sin(alpha+deflec1),center_y-r1*Math.cos(alpha+deflec1)]   ];

        dc.setPenWidth(1);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(center_x+r2*Math.sin(alpha),center_y-r2*Math.cos(alpha),8);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawCircle(center_x+r2*Math.sin(alpha),center_y-r2*Math.cos(alpha),8);

        var hourHandCoordinates =
            Hands.generateHandCoordinates(screenCenterPoint, alpha, center_x * 0.8, 0, 3);

        dc.setPenWidth(1);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.fillPolygon(hourHandCoordinates);
        /*dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(hourHandCoordinates[0][0], hourHandCoordinates[0][1], hourHandCoordinates[1][0], hourHandCoordinates[1][1]);
        dc.drawLine(hourHandCoordinates[1][0], hourHandCoordinates[1][1], hourHandCoordinates[2][0], hourHandCoordinates[2][1]);
        dc.drawLine(hourHandCoordinates[2][0], hourHandCoordinates[2][1], hourHandCoordinates[3][0], hourHandCoordinates[3][1]);
        dc.drawLine(hourHandCoordinates[3][0], hourHandCoordinates[3][1], hourHandCoordinates[0][0], hourHandCoordinates[0][1]);*/
        
        dc.setPenWidth(1);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.fillPolygon(hand);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(hand[0][0], hand[0][1], hand[1][0], hand[1][1]);
        /*dc.drawLine(hand[1][0], hand[1][1], hand[2][0], hand[2][1]);
        dc.drawLine(hand[2][0], hand[2][1], hand[0][0], hand[0][1]);*/
    }
}