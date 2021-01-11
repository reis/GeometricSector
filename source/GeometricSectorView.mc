using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time;
using Toybox.ActivityMonitor as ActMonitor;
using Toybox.Activity as Act;
using Toybox.Application as App;

enum {
  LAT,
  LON
}

enum {
	NIGHT_END,
	NAUTICAL_DAWN,
	DAWN,
	BLUE_HOUR_AM,
	SUNRISE,
	SUNRISE_END,
	GOLDEN_HOUR_AM,
	NOON,
	GOLDEN_HOUR_PM,
	SUNSET_START,
	SUNSET,
	BLUE_HOUR_PM,
	DUSK,
	NAUTICAL_DUSK,
	NIGHT,
	NUM_RESULTS
}

class GeometricSectorView extends WatchUi.WatchFace {

    var screenCenterPoint;
    var center_x;
    var center_y;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        // setLayout(Rez.Layouts.WatchFace(dc));
        screenCenterPoint = [ dc.getWidth() / 2, dc.getHeight() / 2 ];
        center_x = dc.getWidth() / 2;
        center_y = dc.getHeight() / 2;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Get and show the current time
        //var clockTime = System.getClockTime();
        //var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        //var view = View.findDrawableById("TimeLabel");
        //view.setText(timeString);

        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
        var width = dc.getWidth();
        var height = dc.getHeight();


        Sectors.drawDialSector(dc);




        var gregorianInfo = Time.Gregorian.info(Time.now(), Time.FORMAT_LONG);
        Fields.drawDay(dc, gregorianInfo);
        var gregorianShort = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var moonAge = Moon.getmoonage(gregorianShort.day.toNumber(), gregorianShort.month.toNumber(), gregorianShort.year.toNumber());
        Fields.drawMoonAge(dc, moonAge);
        var steps = ActMonitor.getInfo().steps;
        Fields.drawSteps(dc, steps);
        var battery = (System.getSystemStats().battery + 0.5).toNumber().toString();
        Fields.drawBattery(dc, battery);

        var loc = Act.getActivityInfo().currentLocation;
        var lat;
        var lon;
        if (loc == null) {
            lat = App.getApp().getProperty(LAT);
            lon = App.getApp().getProperty(LON);
        } else {
            lat = loc.toDegrees()[0] * Math.PI / 180.0;
            App.getApp().setProperty(LAT, lat);
            lon = loc.toDegrees()[1] * Math.PI / 180.0;
            App.getApp().setProperty(LON, lon);
        }
        if (lat == null) {
            lat = 51.627240 * Math.PI / 180.0;
        }
        if (lon == null) {
            lon = 0.049870 * Math.PI / 180.0;
        }
        var now = new Time.Moment(Time.now().value());
        var oneDay = new Time.Duration(Time.Gregorian.SECONDS_PER_DAY);
        var sunrise = Sun.getsuntime(now, lat, lon, SUNRISE);
        var sunset = Sun.getsuntime(now, lat, lon, SUNSET);

        Fields.drawsun(dc, sunrise, Graphics.COLOR_YELLOW);
        Fields.drawsun(dc, sunset, Graphics.COLOR_RED);

        Hands.drawHands(dc);
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
