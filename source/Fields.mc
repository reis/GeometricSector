using Toybox.Graphics;
using Toybox.Math as Math;
using Toybox.Lang;
using Toybox.Time;

module Fields {

    function drawDay(dc, gregorianInfo) {
        var width = dc.getWidth();
        var height = dc.getHeight();

        var position2 = Hands.generateHandCoordinates([width/2, height/2], Math.PI/6*(2), (width/2)*0.88, 0, 1);
        var position3 = Hands.generateHandCoordinates([width/2, height/2], Math.PI/6*(3), (width/2)*0.88, 0, 1);
        
        //[ info.day_of_week, info.day, info.month, steps, batt ]);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(position3[1][0], position3[1][1], Graphics.FONT_MEDIUM, gregorianInfo.day,
                    Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(position2[1][0], position2[1][1], Graphics.FONT_XTINY, gregorianInfo.day_of_week.substring(0,2).toUpper(),
                    Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function drawMoonAge (dc, moonage) {
        var width = dc.getWidth();
        var height = dc.getHeight();

        var position12 = Hands.generateHandCoordinates([width/2, height/2], Math.PI/6*(12), (width/2)*0.9, 0, 1);

        dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(position12[1][0], position12[1][1], 12);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(position12[1][0], position12[1][1], Graphics.FONT_SMALL, moonage,
                    Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function drawSteps (dc, steps) {
        var width = dc.getWidth();
        var height = dc.getHeight();

        var position6 = Hands.generateHandCoordinates([width/2, height/2], Math.PI/6*(6), (width/2)*0.9, 0, 1);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(position6[1][0], position6[1][1], Graphics.FONT_TINY, Lang.format("$1$", [(1.0*steps/1000).format("%.1f")]),
                    Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function drawBattery (dc, battery) {
        var width = dc.getWidth();
        var height = dc.getHeight();

        var position9 = Hands.generateHandCoordinates([width/2, height/2], Math.PI/6*(9), (width/2)*0.9, 0, 1);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText( position9[1][0], position9[1][1] , Graphics.FONT_SMALL, battery,
                    Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }


    function drawsun(dc, moment0, color) {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var screenCenterPoint = [width/2, height/2];
        var moment = Time.Gregorian.info(moment0 , Time.FORMAT_SHORT);
        var delta = new Time.Duration(-30*60);
        var moment_before = moment0.add(delta);
        var moment2 = Time.Gregorian.info(moment_before, Time.FORMAT_SHORT);

        var hourAngle  = Math.PI/6*(1.0*moment.hour +moment.min /60.0);
        var hourAngle2 = Math.PI/6*(1.0*moment2.hour+moment2.min/60.0);
        var minuteAngle = (moment.min / 60.0) * Math.PI * 2;
        
        var hourCoordinates = Hands.generateHandCoordinates(
            screenCenterPoint, hourAngle, dc.getWidth() / 2 * 0.65, 0, 1);
        var hourCoordinates2 = Hands.generateHandCoordinates(
            screenCenterPoint, hourAngle2, dc.getWidth() / 2 * 0.65, 0, 1);
        var minuteCoordinates = Hands.generateHandCoordinates(
            screenCenterPoint, minuteAngle, dc.getWidth() / 2 - 1, 0, 1);
        
        dc.setPenWidth(10);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.drawLine(hourCoordinates[1][0], hourCoordinates[1][1],
                    hourCoordinates2[1][0], hourCoordinates2[1][1] );
        
        dc.setPenWidth(8);
        dc.setColor(color, color);
        dc.drawLine(hourCoordinates[1][0], hourCoordinates[1][1],
                    hourCoordinates2[1][0], hourCoordinates2[1][1] );        
        
        dc.setPenWidth(2);
        dc.fillCircle(minuteCoordinates[1][0], minuteCoordinates[1][1], 5);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.drawCircle(minuteCoordinates[1][0],
                      minuteCoordinates[1][1], 5);
    }

}